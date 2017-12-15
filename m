Received: from eggs.gnu.org ([2001:4830:134:3::10]:44450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ePyLj-00038m-N9
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 17:21:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ePyLe-0001OO-PY
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 17:20:59 -0500
Received: from 18.mo4.mail-out.ovh.net ([188.165.54.143]:41861)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ePyLe-0001LS-HU
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 17:20:54 -0500
Received: from player694.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id A1F8911841A
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 23:20:51 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 15 Dec 2017 23:20:42 +0100
Message-ID: <151337644262.1825.7887859550366390814.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] 9pfs: make pdu_marshal() and pdu_unmarshal()
 static functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>

They're only used by the 9p core code.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.c |    4 ++--
 hw/9pfs/9p.h |    2 --
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
