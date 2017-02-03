Received: from eggs.gnu.org ([2001:4830:134:3::10]:52781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZatz-0001J8-5j
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 05:15:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZaty-0006ir-92
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 05:15:35 -0500
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:34861)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cZaty-0006i6-2T
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 05:15:34 -0500
Received: by mail-wm0-x229.google.com with SMTP id b65so21162153wmf.0
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 02:15:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170201150553.9381-17-alex.bennee@linaro.org>
References: <20170201150553.9381-1-alex.bennee@linaro.org>
	<20170201150553.9381-17-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Feb 2017 10:15:12 +0000
Message-ID: <CAFEAcA8pNB3HAFAeh8vjbD7KMD6d4MtHTASsKYazRuq_oaQtnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v9 16/25] cputlb and arm/sparc targets:
 convert mmuidx flushes from varg to bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: MTTCG Devel <mttcg@listserver.greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?S09OUkFEIEZyw6lkw6lyaWM=?= <fred.konrad@greensocs.com>, Alvise Rigo <a.rigo@virtualopensystems.com>, "Emilio G. Cota" <cota@braap.org>, Pranith Kumar <bobby.prani@gmail.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Mark Burton <mark.burton@greensocs.com>, Paolo Bonzini <pbonzini@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Fedorov Sergey <serge.fdrv@gmail.com>, Richard Henderson <rth@twiddle.net>, Bamvor Zhang Jian <bamvor.zhangjian@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, "open list:ARM" <qemu-arm@nongnu.org>

On 1 February 2017 at 15:05, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> While the vargs approach was flexible the original MTTCG ended up
> having munge the bits to a bitmap so the data could be used in
> deferred work helpers. Instead of hiding that in cputlb we push the
> change to the API to make it take a bitmap of MMU indexes instead.
>
> For ARM some the resulting flushes end up being quite long so to aid
> readability I've tended to move the index shifting to a new line so
> all the bits being or-ed together line up nicely, for example:
>
>     tlb_flush_page_by_mmuidx(other_cs, pageaddr,
>                              (1 << ARMMMUIdx_S1SE1) |
>                              (1 << ARMMMUIdx_S1SE0));
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> [AT: SPARC part only]
> Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>

ARM parts:
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
