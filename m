Received: from eggs.gnu.org ([2001:4830:134:3::10]:60287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ceiHI-0005GC-0P
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 08:08:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ceiHH-0006Ov-03
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 08:08:47 -0500
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:35962)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ceiHG-0006OP-Pv
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 08:08:46 -0500
Received: by mail-wm0-x22d.google.com with SMTP id c85so14532404wmi.1
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 05:08:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170213121017.12907-24-alex.bennee@linaro.org>
References: <20170213121017.12907-1-alex.bennee@linaro.org>
	<20170213121017.12907-24-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Feb 2017 13:08:25 +0000
Message-ID: <CAFEAcA_mGkf9Z=E-pYPKucgsZ7EA=MPkWG9Dt-Xs0rrqRNDp6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v12 23/24] hw/misc/imx6_src: defer clearing
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

On 13 February 2017 at 12:10, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> The arm_reset_cpu/set_cpu_on/set_cpu_off() functions do their work
> asynchronously in the target vCPUs context. As a result we need to
> ensure the SRC_SCR reset bits correctly report the reset status at the
> right time. To do this we defer the clearing of the bit with an async
> job which will run after the work queued by ARM powerctl functions.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
