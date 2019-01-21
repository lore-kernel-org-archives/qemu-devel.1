Received: from eggs.gnu.org ([209.51.188.92]:42482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=917ecb37e=anthony.perard@citrix.com>)
	id 1gldIc-00032M-0h
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:23:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=917ecb37e=anthony.perard@citrix.com>)
	id 1gldIa-0007LF-2L
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:23:49 -0500
Received: from smtp03.citrix.com ([162.221.156.55]:56425)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=917ecb37e=anthony.perard@citrix.com>)
	id 1gldIY-0007C8-FA
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:23:47 -0500
Date: Mon, 21 Jan 2019 17:23:25 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20190121172324.GM1271@perard.uk.xensource.com>
References: <20181026101016.28584-1-olaf@aepfle.de>
	<20190121161635.GL1271@perard.uk.xensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190121161635.GL1271@perard.uk.xensource.com>
Subject: Re: [Qemu-devel] [PATCH v1] xen: preserve COMPAT in CFLAGS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Olaf Hering <olaf@aepfle.de>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, "open list:X86" <xen-devel@lists.xenproject.org>

On Mon, Jan 21, 2019 at 04:16:35PM +0000, Anthony PERARD wrote:
> As for https://lists.xenproject.org/archives/html/xen-devel/2018-10/msg01950.html
> It appear that the same QEMU 2.9.1 is used, but QEMU isn't supposed to
> use the function xc_map_foreign_bulk when built against Xen 4.12. That
> function is only supposed to be used when building against Xen 4.6 and
> earlier.  QEMU 2.9.1 knows about Xen up to 4.8, it should have used
> xenforeignmemory_map directly. So, this is probably an issue with
> ./configure.

You may want to backport that patch:
https://lists.nongnu.org/archive/html/qemu-devel/2019-01/msg05074.html
That should help with building older version of QEMU against Xen 4.12
and newer.

-- 
Anthony PERARD
