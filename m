Received: from eggs.gnu.org ([2001:4830:134:3::10]:47277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eGqVY-0003TQ-Jc
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 13:09:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eGqVX-00051m-Nw
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 13:09:24 -0500
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:34224)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eGqVX-00051G-H5
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 13:09:23 -0500
Received: by mail-wr0-x236.google.com with SMTP id k18so3952628wre.1
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 10:09:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <9c3820a5-f41d-f835-58bb-8dfb7233403b@twiddle.net>
References: <1511184421-23535-1-git-send-email-peter.maydell@linaro.org>
	<1511184421-23535-3-git-send-email-peter.maydell@linaro.org>
	<1aaf0a6f-c38b-d80d-b09a-1a54545c7660@twiddle.net>
	<CAFEAcA-RXwYtL7yjNjxdHmuBfHe61-mYNX6ytDJ4bETLyA3DHA@mail.gmail.com>
	<9c3820a5-f41d-f835-58bb-8dfb7233403b@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Nov 2017 18:09:01 +0000
Message-ID: <CAFEAcA8r-JGi4FTMP99c0M0mQ2E=z71uhi3FyFp0YN-eaW_rsA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.11 2/2] accel/tcg: Handle atomic
 accesses to notdirty memory correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Stuart Monteith <stuart.monteith@linaro.org>

On 20 November 2017 at 15:00, Richard Henderson <rth@twiddle.net> wrote:
> On 11/20/2017 03:47 PM, Peter Maydell wrote:
>> (Having NDI be "mostly opaque apart from this one thing" is a
>> little ugly, though.)
>
> Yeah, well... nothing else sensible is coming to mind.

I've just sent a v2 that takes this approach.

thanks
-- PMM
