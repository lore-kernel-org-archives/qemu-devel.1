Received: from eggs.gnu.org ([2001:4830:134:3::10]:42954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1frZbJ-0002ug-Gv
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 22:07:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1frZbI-0006S4-UR
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 22:07:25 -0400
Date: Mon, 20 Aug 2018 10:07:15 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180820020715.GB10682@lemon.usersys.redhat.com>
References: <20180815025614.53588-1-eblake@redhat.com>
	<20180815025614.53588-3-eblake@redhat.com>
	<48010463-405e-bb08-f9c5-8263dcf3bb48@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48010463-405e-bb08-f9c5-8263dcf3bb48@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] qemu-img: Add dd seek= option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, fullmanet@gmail.com, qemu-block@nongnu.org

On Thu, 08/16 04:20, Max Reitz wrote:
> No, the real issue is that dd is still not implemented just as a
> frontend to convert.  Which it should be.  I'm not sure dd was a very
> good idea from the start, and now it should ideally be a frontend to
> convert.
> 
> (My full opinion on the matter: dd has a horrible interface.  I don't
> quite see why we replicated that inside qemu-img.  Also, if you want to
> use dd, why not use qemu-nbd + Linux nbd device + real dd?)

The intention is that dd is a familiar interface and allows for operating on
portions of images. It is much more convenient than "qemu-nbd + Linux nbd + dd"
and a bit more convenient than "booting a Linux VM, attaching the image as a
virtual disk, then use dd in the guest". More so when writing tests.

Fam
