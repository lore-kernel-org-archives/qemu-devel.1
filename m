Received: from eggs.gnu.org ([209.51.188.92]:54118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmDms-0002FT-Gu
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 03:21:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmDmr-0004aM-8z
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 03:21:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gmDmp-0004Xc-FF
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 03:21:28 -0500
Date: Wed, 23 Jan 2019 09:15:29 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190123081529.nft2b673rrdivymp@sirius.home.kraxel.org>
References: <20190122205627.10182-1-relkochta@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122205627.10182-1-relkochta@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] input-linux: customizable grab toggle keys
 v5
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ryan El Kochta <relkochta@gmail.com>
Cc: qemu-devel@nongnu.org

On Tue, Jan 22, 2019 at 03:56:27PM -0500, Ryan El Kochta wrote:
> Here is an updated version of my previous patch. Ctrl-Alt has been
> removed, as per your recommendation, and Ctrl-Scrolllock has been
> changed so as to trigger when either ctrl key is pressed, for a
> consistent naming scheme. I do agree that this is the best way forward.
> 
> Ctrl-Backtick is also gone.
> 
> I've tested these on a Windows and Linux guest and they all appear to
> work fine.

Almost there.  Code is fine now, but the commit message describes the v4
-> v5 changes instead of describing the patch.  The v4 message was much
better.

Can you grab the v4 commit message and adapt the text to the v5 code
changes?

A better place to list the changes is the patch series cover letter
(yes, you can send a cover letter with a single patch too).

Some people use "git notes" + "git format-patch --notes" for changelog
annotations.  That'll work too.

> Quick aside; I'm sorry if this e-mail isn't a reply to the old thread. I
> haven't quite figured that one out yet :-)

Starting a new thread is perfectly fine and in fact the preferred way to
send a new patch revision.

cheers,
  Gerd
