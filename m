Received: from eggs.gnu.org ([2001:4830:134:3::10]:53847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=4438c69fc=Ian.Jackson@citrix.com>)
	id 1dzmOK-0004bU-IR
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 12:19:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=4438c69fc=Ian.Jackson@citrix.com>)
	id 1dzmOJ-0004zy-1t
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 12:19:24 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:9557)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=4438c69fc=Ian.Jackson@citrix.com>)
	id 1dzmOI-0004yD-P5
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 12:19:22 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Wed, 4 Oct 2017 17:18:03 +0100
Message-ID: <1507133891-26013-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 0/*] xen: xen-domid-restrict improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>

(Resending this because 1. I got the CC for xen-devel wrong; 2. I got
the subject wrong: there are actually 8 patches; 3. I mangled
Anthony's name in theheaders.  Sorry for the noise.)

I have been working on trying to get qemu, when running as a Xen
device model, to _actually_ not have power equivalent to root.

I think I have achieved this, with some limitations (which will be
discussed in my series against xen.git.

However, there are changes to qemu needed.  In particular

 * The -xen-domid-restrict option does not work properly right now.
   It only restricts a small subset of the descriptors qemu has open.
   I am introducing a new library call in the Xen libraries for this,
   xentoolcore_restrict_all.

 * We need to call a different function on domain shutdown.

 * The restriction operation needs to be done at a slightly different
   time, necessitating a new hook.

 * Additionally, in the future, we intend to be able to set aside
   a uid range for these qemus to run in, and that involves being
   able to tell qemu to drop privilege by numeric uid and gid.

Thanks very much to Anthony Perard for his review of the first, RFC,
version, and for helping out with configure.

At least the first patch of this, "xen: link against xentoolcore",
will very likely be necessary, since the corresponding xen.git series
is likely to make Xen 4.10.

Ian.
