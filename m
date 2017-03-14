Received: from eggs.gnu.org ([2001:4830:134:3::10]:52970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andreas@grapentin.org>) id 1cnjYV-00027q-DY
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:19:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andreas@grapentin.org>) id 1cnjYU-0004dz-Nh
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:19:51 -0400
From: Andreas Grapentin <andreas@grapentin.org>
Date: Tue, 14 Mar 2017 11:19:24 +0100
Message-Id: <20170314101925.16792-1-andreas@grapentin.org>
Subject: [Qemu-devel] [PATCH 0/1] major / minor macros are to be included
 from <sys/sysmacros.h>
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Andreas Grapentin <andreas@grapentin.org>

Building qemu fails with glibc-2.25 and gcc-6.3.1:

> qemu/qga/commands-posix.c:656:13: error: In the GNU C Library, "major" is defined
>  by <sys/sysmacros.h>. For historical compatibility, it is
>  currently defined by <sys/types.h> as well, but we plan to
>  remove this soon. To use "major", include <sys/sysmacros.h>
>  directly. If you did not intend to use a system-defined macro
>  "major", you should undefine it after including <sys/types.h>. [-Werror]
>          *devmajor = major(st.st_rdev);
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~

A trivial fix is to #include <sys/sysmacros.h> in the respective files.


Andreas Grapentin (1):
  major / minor macros are to be included from <sys/sysmacros.h>

 hw/9pfs/9p.c         | 1 +
 qga/commands-posix.c | 1 +
 2 files changed, 2 insertions(+)

-- 
2.12.0
