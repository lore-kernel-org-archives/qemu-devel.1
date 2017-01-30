Received: from eggs.gnu.org ([2001:4830:134:3::10]:54416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cY9Np-0000yB-1o
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 05:40:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cY9Nl-00016l-42
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 05:40:25 -0500
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:36945)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cY9Nk-00014g-Se
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 05:40:21 -0500
Received: by mail-wm0-x22b.google.com with SMTP id v77so41377885wmv.0
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 02:40:20 -0800 (PST)
References: <1465026847-6744-1-git-send-email-rth@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1465026847-6744-1-git-send-email-rth@twiddle.net>
Date: Mon, 30 Jan 2017 10:40:17 +0000
Message-ID: <878tps7rvy.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/2] tcg/i386 guest_base improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org


Richard Henderson <rth@twiddle.net> writes:

> The first change does two things: (1) improve bsd-user so that it
> doesn't continually reload guest_base into a temp register and
> (2) extract the bulk of the guest_base logic to a routine that
> is run once at startup.
>
> The second change adds segmentation support to 32-bit linux.  There,
> if we're using a guest base, we can save 3 bytes per memory op by
> using a segment override.  In addition, if we're using a reserved_va,
> we can set up the segment such that guest memory references are
> constrained by the segment.
>
> Comments?

I'm not sure how to best review this given its fairly low level
x86 stuff. Do you have any numbers to show how this improves things?

>
>
> r~
>
>
> Richard Henderson (2):
>   tcg/i386: Reserve register for guest_base if a segment isn't available
>   tcg/i386: Use segment for 32-bit guest base on linux
>
>  tcg/i386/tcg-target.inc.c | 181 +++++++++++++++++++++++++---------------------
>  1 file changed, 100 insertions(+), 81 deletions(-)


--
Alex Bennée
