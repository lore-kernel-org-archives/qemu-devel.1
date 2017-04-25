Received: from eggs.gnu.org ([2001:4830:134:3::10]:40253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d2vX9-0003T1-0R
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 04:09:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d2vX2-0006eL-LL
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 04:09:14 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 25 Apr 2017 10:08:56 +0200
Message-Id: <1493107736-6608-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] Issue a deprecation warning if the user
 specifies the "-hdachs" option.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org

If the user needs to specify the disk geometry, the corresponding
parameters of the "-drive" option should be used instead. "-hdachs"
is considered as deprecated and might be removed soon.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 vl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/vl.c b/vl.c
index 0b4ed52..0980213 100644
--- a/vl.c
+++ b/vl.c
@@ -3230,6 +3230,8 @@ int main(int argc, char **argv, char **envp)
                         }
                     }
                 }
+                error_report("'-hdachs' is deprecated. Please use '-drive"
+                             " ...,cyls=c,heads=h,secs=s,trans=t' instead.");
                 break;
             case QEMU_OPTION_numa:
                 opts = qemu_opts_parse_noisily(qemu_find_opts("numa"),
-- 
1.8.3.1
