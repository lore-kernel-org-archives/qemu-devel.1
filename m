Received: from eggs.gnu.org ([2001:4830:134:3::10]:59785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d3HCG-0002YM-Dd
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:17:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d3HCF-000696-Tj
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:17:08 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 26 Apr 2017 09:16:59 +0200
Message-Id: <1493191019-32442-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2] Issue a deprecation warning if the user
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
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>

If the user needs to specify the disk geometry, the corresponding
parameters of the "-drive" option should be used instead. "-hdachs"
is considered as deprecated and might be removed soon.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Removed the trailing dot from the string as suggested by Eric

 vl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/vl.c b/vl.c
index 0b4ed52..478cfdd 100644
--- a/vl.c
+++ b/vl.c
@@ -3230,6 +3230,8 @@ int main(int argc, char **argv, char **envp)
                         }
                     }
                 }
+                error_report("'-hdachs' is deprecated, please use '-drive"
+                             " ...,cyls=c,heads=h,secs=s,trans=t' instead");
                 break;
             case QEMU_OPTION_numa:
                 opts = qemu_opts_parse_noisily(qemu_find_opts("numa"),
-- 
1.8.3.1
