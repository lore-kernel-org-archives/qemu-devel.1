Received: from eggs.gnu.org ([2001:4830:134:3::10]:50478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ciZXH-0006qL-9E
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 23:37:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ciZXG-0007TW-J7
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 23:37:15 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Mon, 27 Feb 2017 23:37:07 -0500
Message-Id: <20170228043707.23121-3-jcody@redhat.com>
In-Reply-To: <20170228043707.23121-1-jcody@redhat.com>
References: <20170228043707.23121-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 2/2] iscsi: add missing colons to the qapi docs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org

The missing colons make the iscsi part of the documentation not render
quite as nicely, so add those in.

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 qapi/block-core.json | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 5f82d35..cf24c04 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2625,29 +2625,29 @@
 ##
 # @BlockdevOptionsIscsi:
 #
-# @transport        The iscsi transport type
+# @transport:       The iscsi transport type
 #
-# @portal           The address of the iscsi portal
+# @portal:          The address of the iscsi portal
 #
-# @target           The target iqn name
+# @target:          The target iqn name
 #
-# @lun              #optional LUN to connect to. Defaults to 0.
+# @lun:             #optional LUN to connect to. Defaults to 0.
 #
-# @user             #optional User name to log in with. If omitted, no CHAP
+# @user:            #optional User name to log in with. If omitted, no CHAP
 #                   authentication is performed.
 #
-# @password-secret  #optional The ID of a QCryptoSecret object providing
+# @password-secret: #optional The ID of a QCryptoSecret object providing
 #                   the password for the login. This option is required if
 #                   @user is specified.
 #
-# @initiator-name   #optional The iqn name we want to identify to the target
+# @initiator-name:  #optional The iqn name we want to identify to the target
 #                   as. If this option is not specified, an initiator name is
 #                   generated automatically.
 #
-# @header-digest    #optional The desired header digest. Defaults to
+# @header-digest:   #optional The desired header digest. Defaults to
 #                   none-crc32c.
 #
-# @timeout          #optional Timeout in seconds after which a request will
+# @timeout:         #optional Timeout in seconds after which a request will
 #                   timeout. 0 means no timeout and is the default.
 #
 # Driver specific block device options for iscsi
-- 
2.9.3
