Received: from eggs.gnu.org ([2001:4830:134:3::10]:39182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=4248f5c51=Ian.Jackson@citrix.com>)
	id 1dsv4C-0000n1-8d
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 14:10:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=4248f5c51=Ian.Jackson@citrix.com>)
	id 1dsv4B-0006yW-96
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 14:10:16 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:59995)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=4248f5c51=Ian.Jackson@citrix.com>)
	id 1dsv4B-0006gP-39
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 14:10:15 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Fri, 15 Sep 2017 19:09:54 +0100
Message-ID: <1505498999-17427-2-git-send-email-ian.jackson@eu.citrix.com>
In-Reply-To: <1505498999-17427-1-git-send-email-ian.jackson@eu.citrix.com>
References: <1505498999-17427-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH RFC 1/6] xen: link against xentoolcore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@nongnu.org, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Ian Jackson <ian.jackson@eu.citrix.com>, Ian Jackson <Ian.Jackson@eu.citrix.com>

Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
---
 configure | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index fd7e3a5..c59a0c0 100755
--- a/configure
+++ b/configure
@@ -2072,14 +2072,14 @@ if test "$xen" != "no" ; then
       $($pkg_config --modversion xencontrol | sed 's/\./ /g') )"
     xen=yes
     xen_pc="xencontrol xenstore xenguest xenforeignmemory xengnttab"
-    xen_pc="$xen_pc xenevtchn xendevicemodel"
+    xen_pc="$xen_pc xenevtchn xendevicemodel xentoolcore"
     QEMU_CFLAGS="$QEMU_CFLAGS $($pkg_config --cflags $xen_pc)"
     libs_softmmu="$($pkg_config --libs $xen_pc) $libs_softmmu"
     LDFLAGS="$($pkg_config --libs $xen_pc) $LDFLAGS"
   else
 
     xen_libs="-lxenstore -lxenctrl -lxenguest"
-    xen_stable_libs="-lxenforeignmemory -lxengnttab -lxenevtchn"
+    xen_stable_libs="-lxenforeignmemory -lxengnttab -lxenevtchn -lxentoolcore"
 
     # First we test whether Xen headers and libraries are available.
     # If no, we are done and there is no Xen support.
-- 
2.1.4
