Received: from eggs.gnu.org ([2001:4830:134:3::10]:46969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fM8YP-00018c-0t
	for qemu-devel@nongnu.org; Fri, 25 May 2018 04:58:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fM8YN-0004ND-Sx
	for qemu-devel@nongnu.org; Fri, 25 May 2018 04:58:29 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:34136)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fM8YN-0004Mr-Fl
	for qemu-devel@nongnu.org; Fri, 25 May 2018 04:58:27 -0400
Received: by mail-ot0-x241.google.com with SMTP id i5-v6so5271546otf.1
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 01:58:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHNT7Nvoz0z_vDGLhSmHahjFQqQTwDq3h8ay5qvUsT1mujuOjA@mail.gmail.com>
References: <78dbf5ad-a067-0e0e-a073-1b854109df7e@twiddle.net>
	<CAHNT7Nvoz0z_vDGLhSmHahjFQqQTwDq3h8ay5qvUsT1mujuOjA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 May 2018 09:58:06 +0100
Message-ID: <CAFEAcA_JHH3YonXkAY340-2n0ROXRcc=J=_-LHaKKE_zCr02nw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RISC-V] Coverity 1390849, Logically dead code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: Richard Henderson <rth@twiddle.net>, qemu-devel <qemu-devel@nongnu.org>

On 25 May 2018 at 07:18, Michael Clark <mjc@sifive.com> wrote:
> On Fri, May 25, 2018 at 9:54 AM, Richard Henderson <rth@twiddle.net> wrote:
>
>> In the latest Coverity scan, it reports

>> I believe the condition at op_helper.c:409 should be testing
>> CSR_MHPMCOUNTER3H
>> and CSR_MHPMCOUNTER31H.  Must run now, otherwise I'd also send the trivial
>> patch.
>
>
> Thanks! Yes indeed they should be the H versions.
>
> I will send the trivial patch...

You might like to sign up to our Coverity Scan project if
you aren't already:
https://scan.coverity.com/projects/qemu?tab=overview

It reports a couple of other riscv coverity nits (minor memory leaks).

thanks
-- PMM
