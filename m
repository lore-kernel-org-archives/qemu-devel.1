Received: from eggs.gnu.org ([2001:4830:134:3::10]:56049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTqRQ-0004CM-CF
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:47:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTqRM-0000fD-Cr
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:47:24 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:43683)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gTqRM-0000eN-5O
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:47:20 -0500
Received: by mail-oi1-x244.google.com with SMTP id u18so11280034oie.10
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 07:47:20 -0800 (PST)
References: <20181201123056.432-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fc1c6621-ed1a-d53f-0b79-08fbab57205d@linaro.org>
Date: Mon, 3 Dec 2018 09:47:15 -0600
MIME-Version: 1.0
In-Reply-To: <20181201123056.432-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 0/5] ui/cocoa: Use OSX's main loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: John Arbuckle <programmingkidx@gmail.com>, Roman Bolshakov <r.bolshakov@yadro.com>, Berkus Decker <berkus@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, patches@linaro.org

On 12/1/18 6:30 AM, Peter Maydell wrote:
> Patchset structure:
>  * patch 1 does the "make sure we have the iothread lock for
>    calls into QEMU" (which is effectively a no-op initially
>    since we'll already be holding that lock when our refresh
>    etc callbacks are called)
>  * patch 2 makes switchSurface directly take the pixman image
>    (which is refcounted) rather than the DisplaySurface (which
>    is not), so we can make the calls to it asynchronous later
>  * patches 3 and 4 are just trivial code motion
>  * patch 5 does the bulk of the work (and can't really be split
>    further without the UI being broken at the intermediate point)

FWIW, this makes sense and is relatively easy to follow.
That said, I've never touched OSX at all, so can't even test.


r~
