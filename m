Received: from eggs.gnu.org ([2001:4830:134:3::10]:50112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e1Xbm-0000FO-Nv
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 08:56:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e1Xbj-0000zi-2N
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 08:56:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e1Xbi-0000zL-T7
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 08:56:31 -0400
Message-ID: <1507553788.32088.12.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 09 Oct 2017 14:56:28 +0200
In-Reply-To: <e64a628c-3377-f3f5-0646-079a2a175354@vidbuchanan.co.uk>
References: <20170828122906.18993-1-kraxel@redhat.com>
	<e64a628c-3377-f3f5-0646-079a2a175354@vidbuchanan.co.uk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] vga: stop passing pointers to
 vga_draw_line* functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Buchanan <d@vidbuchanan.co.uk>, qemu-devel@nongnu.org
Cc: P J P <ppandit@redhat.com>

On Mon, 2017-10-09 at 12:55 +0100, David Buchanan wrote:
> I might be mistaken, but I don't think this patch actually fixes
> CVE-2017-13672. I tested the latest git repo (last commit 530049bc1d)
> against my initial reproducer, and QEMU still segfaults.

Hmm, no segfault here.  Tried gtk, sdl, vnc, spice.  How do you start
qemu?  Which user interface?

> I think this is because the actual OOB read occurs inside pixman,
> which
> of course is not affected by this patch. Perhaps bounds checks need
> to
> be applied to the arguments passed into pixman?

Hmm, 24bpp modes are typically not handled by pixman (at least not in a
way that qemu creates a pixman image backed by vga memory).

Have you seen a stacktrace with pixman in there?  Care to share it?

thanks,
  Gerd
