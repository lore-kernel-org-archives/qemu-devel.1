Received: from eggs.gnu.org ([2001:4830:134:3::10]:48972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f3NH4-0002uA-CF
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 10:51:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f3NH3-0000Hm-Ey
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 10:51:02 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:37668)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f3NH3-0000HO-99
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 10:51:01 -0400
Received: by mail-ot0-x242.google.com with SMTP id y46-v6so19679659otd.4
	for <qemu-devel@nongnu.org>; Tue, 03 Apr 2018 07:51:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHNT7Nt4v1R27paaETG1=vjftL8+OjoWntiRSDB1Hn1DEyHNPg@mail.gmail.com>
References: <1522344417-60114-1-git-send-email-mjc@sifive.com>
	<CAHNT7Nvtx85EfQ6g_E1bL5XRvwZYoo=YoarMA6r9V4dER-O3Cw@mail.gmail.com>
	<20180401184956.GZ2787@redhat.com>
	<CAHNT7Nt4v1R27paaETG1=vjftL8+OjoWntiRSDB1Hn1DEyHNPg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Apr 2018 15:50:39 +0100
Message-ID: <CAFEAcA-RUFi5U1rc+K=jBSCXTz1KYaECJN0Vz+POh1pFr-mjXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] RISC-V: Critical fixes for QEMU 2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: "Richard W.M. Jones" <rjones@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, RISC-V Patches <patches@groups.riscv.org>

On 3 April 2018 at 03:43, Michael Clark <mjc@sifive.com> wrote:
> I submitted the pull request for your's/Stefan's workaround so that QEMU
> 2.12 has working FP context switching under Linux (always returning dirty or
> off is valid implementation choice according to the specification), given
> Richard Henderson had not made a PR for his more comprehensive fix, with the
> rationale that we could implement the comprehensive fix for QEMU 2.13

Given that riscv is your area as submaintainer I (and likely also
RTH) would expect RTH's patch to go in via a pull request from you,
not one directly from him. One of the things the submaintainer does
is evaluate what the right set of patches to go in for the area are,
if there are multiple proposed ways to fix something.

thanks
-- PMM
