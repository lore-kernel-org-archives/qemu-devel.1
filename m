Received: from eggs.gnu.org ([2001:4830:134:3::10]:41150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eHs2C-0007nY-4e
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:59:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eHs2B-0001eQ-HS
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:59:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eHs2B-0001dK-Bb
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:59:19 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 75F677EA8B
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 13:59:18 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Thu, 23 Nov 2017 21:59:06 +0800
Message-Id: <20171123135906.12852-3-famz@redhat.com>
In-Reply-To: <20171123135906.12852-1-famz@redhat.com>
References: <20171123135906.12852-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] qemu-options: Mention locking option of
 file driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, mreitz@redhat.com

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 qemu-options.hx | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index 3728e9b4dd..bcb7a88ec3 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -693,6 +693,9 @@ This is the protocol-level block driver for accessing regular files.
 The path to the image file in the local filesystem
 @item aio
 Specifies the AIO backend (threads/native, default: threads)
+@item locking
+Specifies whether the image file is protected with Linux OFD / POSIX locks.
+(auto/on/off, default: auto)
 @end table
 Example:
 @example
-- 
2.14.3
