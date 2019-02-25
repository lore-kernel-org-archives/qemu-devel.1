Received: from eggs.gnu.org ([209.51.188.92]:34227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gyDUw-0000ei-Da
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 05:28:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gyDUv-0006sS-Je
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 05:28:34 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:37624)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gyDUr-0006aK-VZ
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 05:28:31 -0500
Received: by mail-ot1-x342.google.com with SMTP id b3so7371423otp.4
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 02:28:26 -0800 (PST)
MIME-Version: 1.0
References: <20190225102433.22401-1-peter.maydell@linaro.org>
In-Reply-To: <20190225102433.22401-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Feb 2019 10:28:14 +0000
Message-ID: <CAFEAcA8+uQQ45=A1Lb6mxWmRtuZx27F9uanbEPJFOS1szvw7sg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 0/7] ui/cocoa: Use OSX's main loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: "patches@linaro.org" <patches@linaro.org>, BALATON Zoltan <balaton@eik.bme.hu>, John Arbuckle <programmingkidx@gmail.com>, Berkus Decker <berkus@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Ben Hekster <ben.hekster@foghorn.io>, Roman Bolshakov <r.bolshakov@yadro.com>

...oops, looks like I got Roman's email address wrong (I
cut-n-pasted it from the one reviewed-by tag that happened
to typo it :-( ). Sorry about that.

-- PMM

On Mon, 25 Feb 2019 at 10:24, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This set of patches rearranges how we handle events on
> the OSX Cocoa UI so that we use the main thread to run
> the OSX event loop, and we don't do a long blocking
> operation from the applicationDidFinishLaunching callback.
> Instead we create a second thread which runs qemu_main()
> and becomes the QEMU main-loop thread. The callbacks from
> QEMU into the cocoa code asynchronously dispatch their
> work to the main thread, and the main thread takes the
> iothread lock before calling into QEMU code.
>
> The changes from v2 to v3 are all minor, and all patches
> have now had review/test; I plan to apply this to master
> towards the end of the week, absent any further review
> comments.
>
>  * patch 1: add with_iothread_lock wrap to qmp_stop/qmp_cont calls
>  * patch 5: remove stray whitespace
>  * patch 7: remove unnecessary null check on cocoaView
>  * patch 7: make semaphore variables file-local
>  * patch 7: deref pixman_image in dealloc
>
> thanks
> -- PMM
