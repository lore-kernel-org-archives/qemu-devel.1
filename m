Received: from eggs.gnu.org ([2001:4830:134:3::10]:45081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjhoupu@linux.vnet.ibm.com>) id 1dQY5D-0007jo-S3
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 07:58:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjhoupu@linux.vnet.ibm.com>) id 1dQY59-0007wm-Sw
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 07:58:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53755
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjhoupu@linux.vnet.ibm.com>)
	id 1dQY59-0007wV-Ng
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 07:57:59 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5TBrqho091540
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 07:57:58 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bd0ma96ja-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 07:57:58 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjhoupu@linux.vnet.ibm.com>;
	Thu, 29 Jun 2017 12:57:57 +0100
From: Pu Hou <bjhoupu@linux.vnet.ibm.com>
Date: Thu, 29 Jun 2017 13:57:51 +0200
Message-Id: <20170629115751.72337-1-bjhoupu@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] cryptodev: fix two typos in error message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, arei.gonglei@huawei.com
Cc: pasic@linux.vnet.ibm.com, BAGRAMOV@de.ibm.com, Pu Hou <bjhoupu@linux.vnet.ibm.com>

Currently we have the name of the backend 'cryptodev-builtin' misspelled
as 'cryptdov-builtin' in two potentially user facing error messages.
Let's fix this.

Furthermore The second mention of 'cryptodev-builtin' omits 'backend'.
Let's make things consistent by adding it.

Reported-by: Timur Bagramov <BAGRAMOV@de.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Signed-off-by: Pu Hou <bjhoupu@linux.vnet.ibm.com>
---
 backends/cryptodev-builtin.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/backends/cryptodev-builtin.c b/backends/cryptodev-builtin.c
index 657c0ba2f3..4e619dfca8 100644
--- a/backends/cryptodev-builtin.c
+++ b/backends/cryptodev-builtin.c
@@ -70,7 +70,7 @@ static void cryptodev_builtin_init(
 
     if (queues != 1) {
         error_setg(errp,
-                  "Only support one queue in cryptdov-builtin backend");
+                  "Only support one queue in cryptodev-builtin backend");
         return;
     }
 
@@ -314,7 +314,7 @@ static int cryptodev_builtin_sym_operation(
 
     if (op_info->op_type == VIRTIO_CRYPTO_SYM_OP_ALGORITHM_CHAINING) {
         error_setg(errp,
-               "Algorithm chain is unsupported for cryptdoev-builtin");
+               "Algorithm chain is unsupported for cryptodev-builtin backend");
         return -VIRTIO_CRYPTO_NOTSUPP;
     }
 
-- 
2.11.2
