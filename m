Received: from eggs.gnu.org ([2001:4830:134:3::10]:33181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ccDDc-0001kS-P5
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 10:34:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ccDDb-00035a-Nc
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 10:34:40 -0500
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:37033)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ccDDb-00034t-G9
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 10:34:39 -0500
Received: by mail-wm0-x234.google.com with SMTP id v77so51324871wmv.0
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 07:34:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87tw82vzt6.fsf@linaro.org>
References: <20170209170904.5713-1-alex.bennee@linaro.org>
	<20170209170904.5713-24-alex.bennee@linaro.org>
	<CAFEAcA8_UNip6QooREop-T5RBpdo1me0piEAscJRC+G7tGcNrA@mail.gmail.com>
	<87tw82vzt6.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Feb 2017 15:34:17 +0000
Message-ID: <CAFEAcA-cwEAEq_upkAF49S7cbN43a7PPgs733DXD-Kykz--CUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v11 23/24] hw/misc/imx6_src: defer clearing
 of SRC_SCR reset bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Richard Henderson <rth@twiddle.net>, MTTCG Devel <mttcg@listserver.greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?S09OUkFEIEZyw6lkw6lyaWM=?= <fred.konrad@greensocs.com>, Alvise Rigo <a.rigo@virtualopensystems.com>, "Emilio G. Cota" <cota@braap.org>, Pranith Kumar <bobby.prani@gmail.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Mark Burton <mark.burton@greensocs.com>, Paolo Bonzini <pbonzini@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Fedorov Sergey <serge.fdrv@gmail.com>, Bamvor Zhang Jian <bamvor.zhangjian@linaro.org>, Peter Chubb <peter.chubb@nicta.com.au>, "open list:i.MX31" <qemu-arm@nongnu.org>

On 10 February 2017 at 15:19, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> Peter Maydell <peter.maydell@linaro.org> writes:
>> I guess a malloc-and-free is OK since the guest isn't going to be
>> bouncing CPUs through reset very often, though it's a bit ugly to
>> see in device code.
>
> Previous patches had expanded the run_on_cpu code to have things like
> CPUState and a single field to avoid malloc where we can. However I need
> the IMX6SRCState and I don't know if I can get that in the work
> function. Will there only ever be one on the system?

In practice there will be only one but I don't think we should
rely on that. malloc/free is probably better than overly
convoluted code at this point.

thanks
-- PMM
