Received: from eggs.gnu.org ([2001:4830:134:3::10]:48966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fvKXe-0008Cw-Kq
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 06:51:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fvKXa-0000Zd-Ks
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 06:51:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60810 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fvKXY-0000Z9-PQ
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 06:51:05 -0400
Date: Thu, 30 Aug 2018 12:51:02 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180830105102.mk3p4rnpge7f2n4h@sirius.home.kraxel.org>
References: <petKSachdmuxWMgY2EXHzES3PpUCAUwQacKEaIU9PHykNXfsah1sP3OaVuDLz0VBYJM7qtJsWSrv3U9bkb_2LT_itBxDbAYKIHlEJJXtEiE=@protonmail.com>
	<20180827101609.p2blhd7ka7gkqqtq@sirius.home.kraxel.org>
	<CSjEdwPfIMyBPsRNM1KZG7ugmTMLh2leLbHEBEQ2o0UjHftEBoh98TcX-xoHTgjDAW7Vn1psMATSN_4IS68-sdTWKkd32SL-HGN5A5-pqz0=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CSjEdwPfIMyBPsRNM1KZG7ugmTMLh2leLbHEBEQ2o0UjHftEBoh98TcX-xoHTgjDAW7Vn1psMATSN_4IS68-sdTWKkd32SL-HGN5A5-pqz0=@protonmail.com>
Subject: Re: [Qemu-devel] [PATCH] input-linux: toggle for lock keys
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ryan El Kochta <lightn1ngstr1ke@protonmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Mon, Aug 27, 2018 at 01:49:22PM +0000, Ryan El Kochta wrote:

> I personally use the Scroll Lock key. On Linux, Scroll Lock (along
> with all the other lock keys) is easy to disable with an xmodmap
> command. On Windows (or, I'd assume, other guests), it requires third
> party software, which is why it's likely easier to just filter them
> out from QEMU.

Ok, disable with xmodmap is a reasonable approach for that key.
I think it would be a good idea to document that.

I'd suggest to add a single option, to configure alternative toggle
key(s), with just a few hard-coded variants which actually make sense.
Something like grab-toggle={two-shift,scroll-lock}.  Not sure whenever
we need the other lock keys.  scroll lock is probably the
least-frequently used key and therefore the best choice for the
purpose.

In case scroll-lock is selected we can automatically ignore it, without
ignore_scroll_lock=off option.

cheers,
  Gerd
