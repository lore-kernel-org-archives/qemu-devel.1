Received: from eggs.gnu.org ([2001:4830:134:3::10]:34843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXsIZ-0001F8-3h
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 12:58:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXsIY-0006J5-2u
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 12:58:07 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:34916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dXsIX-0006It-S5
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 12:58:06 -0400
Received: by mail-wm0-x235.google.com with SMTP id w126so4346876wme.0
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 09:58:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170719044522.21114-1-rth@twiddle.net>
References: <20170719044522.21114-1-rth@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 19 Jul 2017 17:57:44 +0100
Message-ID: <CAFEAcA_rx1UyVBrS1WaE6FZMvQPsb=RJJCZgnfS2AjWR+hsFsg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/8] target/alpha cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 19 July 2017 at 05:45, Richard Henderson <rth@twiddle.net> wrote:
> The new title holder for perf top is helper_lookup_tb_ptr.
> Those targets that have a complicated cpu_get_tb_cpu_state
> function are going to regret that.

Yeah, Paolo's pointed out (and had some patches for)
ARM's rather complicated cpu_get_tb_cpu_state(). My
issue with his suggested fixes was that they were
pretty fragile in terms of not having any guarantee
that the change always produced the right tb cpu
state flags answer...

(I'm processing the pullreq, this just seemed like an
interesting digression.)

thanks
-- PMM
