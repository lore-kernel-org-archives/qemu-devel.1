Received: from eggs.gnu.org ([2001:4830:134:3::10]:33425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eYYQ7-0002sb-IY
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:29:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eYYQ4-00068z-Rc
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:28:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51762
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eYYQ4-00068j-My
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:28:56 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.21) with SMTP id
	w08ESqXO192274
	for <qemu-devel@nongnu.org>; Mon, 8 Jan 2018 09:28:56 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fc8cfpr6s-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 09:28:54 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 8 Jan 2018 14:28:50 -0000
From: Greg Kurz <groug@kaod.org>
Date: Mon,  8 Jan 2018 15:28:25 +0100
In-Reply-To: <20180108142831.6638-1-groug@kaod.org>
References: <20180108142831.6638-1-groug@kaod.org>
Message-Id: <20180108142831.6638-9-groug@kaod.org>
Subject: [Qemu-devel] [PULL 08/14] 9pfs: make pdu_marshal() and
 pdu_unmarshal() static functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>

They're only used by the 9p core code.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 hw/9pfs/9p.c | 4 ++--
 hw/9pfs/9p.h | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 558efb41defd..1e4ebbe57687 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -41,7 +41,7 @@ enum {
     Oappend = 0x80,
 };
 
-ssize_t pdu_marshal(V9fsPDU *pdu, size_t offset, const char *fmt, ...)
+static ssize_t pdu_marshal(V9fsPDU *pdu, size_t offset, const char *fmt, ...)
 {
     ssize_t ret;
     va_list ap;
@@ -53,7 +53,7 @@ ssize_t pdu_marshal(V9fsPDU *pdu, size_t offset, const char *fmt, ...)
     return ret;
 }
 
-ssize_t pdu_unmarshal(V9fsPDU *pdu, size_t offset, const char *fmt, ...)
+static ssize_t pdu_unmarshal(V9fsPDU *pdu, size_t offset, const char *fmt, ...)
 {
     ssize_t ret;
     va_list ap;
diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index 6e3b48391788..ffe658ab8975 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -349,8 +349,6 @@ int v9fs_name_to_path(V9fsState *s, V9fsPath *dirpath,
 int v9fs_device_realize_common(V9fsState *s, Error **errp);
 void v9fs_device_unrealize_common(V9fsState *s, Error **errp);
 
-ssize_t pdu_marshal(V9fsPDU *pdu, size_t offset, const char *fmt, ...);
-ssize_t pdu_unmarshal(V9fsPDU *pdu, size_t offset, const char *fmt, ...);
 V9fsPDU *pdu_alloc(V9fsState *s);
 void pdu_free(V9fsPDU *pdu);
 void pdu_submit(V9fsPDU *pdu, P9MsgHeader *hdr);
-- 
2.13.6
