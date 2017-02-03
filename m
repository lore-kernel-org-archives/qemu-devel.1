Received: from eggs.gnu.org ([2001:4830:134:3::10]:36495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZbsE-0007eD-OY
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:17:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZbsD-0004tl-Ug
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:17:50 -0500
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:35805)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cZbsD-0004tE-O9
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:17:49 -0500
Received: by mail-wm0-x22a.google.com with SMTP id b65so23672738wmf.0
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 03:17:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170201150553.9381-22-alex.bennee@linaro.org>
References: <20170201150553.9381-1-alex.bennee@linaro.org>
	<20170201150553.9381-22-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Feb 2017 11:17:28 +0000
Message-ID: <CAFEAcA_TviTHP-WkppW342wSHRMHX8P9wqGd1UA6bdLG6n8_oQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v9 21/25] target-arm: don't generate
 WFE/YIELD calls for MTTCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: MTTCG Devel <mttcg@listserver.greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?S09OUkFEIEZyw6lkw6lyaWM=?= <fred.konrad@greensocs.com>, Alvise Rigo <a.rigo@virtualopensystems.com>, "Emilio G. Cota" <cota@braap.org>, Pranith Kumar <bobby.prani@gmail.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Mark Burton <mark.burton@greensocs.com>, Paolo Bonzini <pbonzini@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Fedorov Sergey <serge.fdrv@gmail.com>, Richard Henderson <rth@twiddle.net>, Bamvor Zhang Jian <bamvor.zhangjian@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

On 1 February 2017 at 15:05, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> The WFE and YIELD instructions are really only hints and in TCG's case
> they were useful to move the scheduling on from one vCPU to the next. In
> the parallel context (MTTCG) this just causes an unnecessary cpu_exit
> and contention of the BQL.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/arm/op_helper.c     |  7 +++++++
>  target/arm/translate-a64.c |  8 ++++++--
>  target/arm/translate.c     | 20 ++++++++++++++++----
>  3 files changed, 29 insertions(+), 6 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

though I'm not much of a fan of yet another global variable :-(

thanks
-- PMM
