Received: from eggs.gnu.org ([2001:4830:134:3::10]:59948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g1ZMG-0004Sh-9v
	for qemu-devel@nongnu.org; Sun, 16 Sep 2018 11:53:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g1ZMB-0005XV-Bu
	for qemu-devel@nongnu.org; Sun, 16 Sep 2018 11:53:12 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:36982)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g1ZMB-0005UY-6E
	for qemu-devel@nongnu.org; Sun, 16 Sep 2018 11:53:07 -0400
Received: by mail-pg1-x541.google.com with SMTP id 2-v6so6510438pgo.4
	for <qemu-devel@nongnu.org>; Sun, 16 Sep 2018 08:53:06 -0700 (PDT)
References: <20180915161738.25257-1-richard.henderson@linaro.org>
	<20180915161738.25257-2-richard.henderson@linaro.org>
	<CAFEAcA_e9i232hWsMCjQh6RHnNjEBj=Ng6nGuC2aNU4SSfiY-A@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <881b6194-237c-5797-794a-e8d4c415950a@linaro.org>
Date: Sun, 16 Sep 2018 08:53:01 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_e9i232hWsMCjQh6RHnNjEBj=Ng6nGuC2aNU4SSfiY-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/13] target/arm: Add ARM_FEATURE_SWP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 9/15/18 6:32 PM, Peter Maydell wrote:
> In the current scheme of doing things I'd look for whether
> we could say that some more generic thing implied SWP
> rather than setting it in a lot of initfns (eg v5-but-not-v7VE?),
> but maybe the later patches make that a bad approach
> (haven't looked at the meat of this series).

Perhaps.  But indeed this goes back to the main question
posed in the cover letter.

> We want to arrange to have SWP work anyway on linux-user,
> I think, since the kernel will typically trap-and-emulate
> it assuming it was built with CONFIG_SWP_EMULATE. (I don't
> know if those kernels will advertise swp in the hwcaps,
> but I guess not.)

Ah, I did not know about SWP_EMULATE.  It appears to be
specific to armv7+ (though we don't support the pre-v4
cpus for which it might otherwise be relevant).

It does appear that HWCAP_SWP is advertised anyway:

mm/proc-v7.S:	.long	HWCAP_SWP | HWCAP_HALF | HWCAP_THUMB | HWCAP_FAST_MULT


r~
