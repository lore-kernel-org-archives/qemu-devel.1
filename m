Received: from eggs.gnu.org ([2001:4830:134:3::10]:39153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=4248f5c51=Ian.Jackson@citrix.com>)
	id 1dsv49-0000lY-Ne
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 14:10:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=4248f5c51=Ian.Jackson@citrix.com>)
	id 1dsv44-0006lm-N2
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 14:10:13 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:59995)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=4248f5c51=Ian.Jackson@citrix.com>)
	id 1dsv44-0006gP-HS
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 14:10:08 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Fri, 15 Sep 2017 19:09:53 +0100
Message-ID: <1505498999-17427-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH RFC 0/6] xen: xen-domid-restrict improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@nongnu.org, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>

I have been working on trying to get qemu, when running as a Xen
device model, to _actually_ not have power equivalent to root.

I think I have achieved this, with some limitations (which will be
discussed in my series against xen.git, which I am about to post).

However, there are changes to qemu needed.  In particular

 * The -xen-domid-restrict option does not work properly right now.
   It only restricts a small subset of the descriptors qemu has open.
   I am introducing a new library call in the Xen libraries for this,
   xentoolcore_restrict_all.

 * We need to call a different function on domain shutdown.

 * Additionally, in the future, we intend to be able to set aside
   a uid range for these qemus to run in, and that involves being
   able to tell qemu to drop privilege by numeric uid and gid.

This series is only an RFC because right now it won't compile against
older versions of Xen.  There is "configure" work needed.  I would
appreciate some help and/or advice and have CC'd some people who
touched this area recently...

Thanks for your attention.

Ian.
