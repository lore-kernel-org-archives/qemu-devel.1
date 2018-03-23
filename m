Received: from eggs.gnu.org ([2001:4830:134:3::10]:57771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ezNJk-00063T-Ts
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 10:05:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ezNJk-0003Me-1R
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 10:05:16 -0400
Received: from mail-ot0-x22c.google.com ([2607:f8b0:4003:c0f::22c]:42823)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ezNJj-0003Ly-Ro
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 10:05:15 -0400
Received: by mail-ot0-x22c.google.com with SMTP id v23-v6so13349242oth.9
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 07:05:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <173b1d18-720a-4f61-29cf-4f812b78cb2e@redhat.com>
References: <1521794165-31678-1-git-send-email-thuth@redhat.com>
	<CAFEAcA-KEnE9NKGC-vTnMByFC_LDPt2Ae8G7GfOxakfgMGH90w@mail.gmail.com>
	<6750673e-ffc3-578e-e867-332ac0790935@redhat.com>
	<CAFEAcA_u3cKF1aSHbrjW0Hc403G5GkNNom_9mqkJfregfqMymw@mail.gmail.com>
	<173b1d18-720a-4f61-29cf-4f812b78cb2e@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Mar 2018 14:04:54 +0000
Message-ID: <CAFEAcA_HaC6yjX7wW0MscxfiEafFT2uhMiWeN644NTYADhdEnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.12] hw/riscv: Fix crashes with
 "-nodefaults"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Michael Clark <mjc@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On 23 March 2018 at 14:02, Paolo Bonzini <pbonzini@redhat.com> wrote:

> However, if the machine is emulating a real-world board with a fixed SoC
> and fixed hardware in the SoC, it makes more sense to create a null backend.

That's a lot of duplicate code to say "oh, this is NULL, create the
null backend" in lots of different boards :-(

thanks
-- PMM
