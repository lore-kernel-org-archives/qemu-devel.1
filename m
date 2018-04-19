Received: from eggs.gnu.org ([2001:4830:134:3::10]:60684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=6403088e3=Ian.Jackson@citrix.com>)
	id 1f9Ch1-0002Iu-Ug
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:45:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=6403088e3=Ian.Jackson@citrix.com>)
	id 1f9Ch0-0006Ik-Di
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:45:55 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:53489)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=6403088e3=Ian.Jackson@citrix.com>)
	id 1f9Ch0-0006EO-0c
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:45:54 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Thu, 19 Apr 2018 17:45:19 +0100
Message-ID: <1524156319-11465-17-git-send-email-ian.jackson@eu.citrix.com>
In-Reply-To: <1524156319-11465-1-git-send-email-ian.jackson@eu.citrix.com>
References: <1524156319-11465-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 16/16] configure: do_compiler: Dump some extra
 info under bash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, Ian Jackson <ian.jackson@eu.citrix.com>, Ian Jackson <Ian.Jackson@eu.citrix.com>, "Kent R. Spillner" <kspillner@acm.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

This makes it much easier to find a particular thing in config.log.

The information may be lacking in other shells, resulting in harmless
empty output.  (This is why we don't use the proper ${FUNCNAME[*]}
array syntax - other shells will choke on that.)

The extra output is only printed if configure is run with bash.  On
systems where /bin/sh is not bash, it is necessary to say bash
./configure to get the extra debug info in the log.

Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
CC: Kent R. Spillner <kspillner@acm.org>
CC: Janosch Frank <frankja@linux.vnet.ibm.com>
CC: Thomas Huth <thuth@redhat.com>
CC: Peter Maydell <peter.maydell@linaro.org>
CC: Paolo Bonzini <pbonzini@redhat.com>
---
v6: Fix commit message wording.
v4: No longer tag this patch RFC.
---
 configure | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configure b/configure
index d5435ff..a4c5292 100755
--- a/configure
+++ b/configure
@@ -60,6 +60,10 @@ do_compiler() {
     # is compiler binary to execute.
     local compiler="$1"
     shift
+    echo >>config.log "
+funcs: ${FUNCNAME}
+lines: ${BASH_LINENO}
+files: ${BASH_SOURCE}"
     echo $compiler "$@" >> config.log
     $compiler "$@" >> config.log 2>&1 || return $?
     # Test passed. If this is an --enable-werror build, rerun
-- 
2.1.4
