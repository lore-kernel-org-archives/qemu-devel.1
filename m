Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30636C47253
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 18:29:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDA1F2073E
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 18:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ELvzdSMm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDA1F2073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verbum.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUaQ9-0007QZ-2G
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 14:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walters@verbum.org>)
 id 1jUaPK-0006rB-B5
 for qemu-devel@nongnu.org; Fri, 01 May 2020 14:29:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <walters@verbum.org>) id 1jUaMY-00038G-Rn
 for qemu-devel@nongnu.org; Fri, 01 May 2020 14:29:06 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:33285)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walters@verbum.org>)
 id 1jUaMY-0002wj-6I
 for qemu-devel@nongnu.org; Fri, 01 May 2020 14:26:14 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.west.internal (Postfix) with ESMTP id A5A6B7BD;
 Fri,  1 May 2020 14:26:10 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
 by compute1.internal (MEProxy); Fri, 01 May 2020 14:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:message-id
 :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; bh=qjPhLL07ti+2rtfeUC9T1YrxMEKHn
 3t7IxDxXG4FVss=; b=ELvzdSMmVygnRICQTEldK8HDDx+gRyZGo+4Nhb/U3YH8q
 9hlCm0+sYPqEqwrC8z77AovdLCDq8KRIIoeHNgCvBnjW/EcWmaPQWb8c9UxwHRRW
 fI7epvkidYXKCpGRzWEh53MwTZo0uBixgsNZ6W7BvXdiKWwoETcs3n/3wPVgfGWD
 1bArr0ZQq852yJsTje/smc6j5YyKhYSnL4WficTPEauISf8U052uIPFmpJW9KNJm
 TGNf0YEUI0v0gDkWJF/JxDgHvAAsBn2eBtMWHF5JNoLYjpy9kXGeSZ7/d8WB0qY/
 A+jIzsb1HonAEWwlpwCE/iE7hHfF9wR5h+C3P7P4A==
X-ME-Sender: <xms:wWmsXrX2XlR89YTiX0hBAz5DVq6Y58bKCoq4E4gby1M5GXipO5UJfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrieejgdduvddvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkfffhvffutgesthdtredtreertdenucfhrhhomhepfdevohhlihhn
 ucghrghlthgvrhhsfdcuoeifrghlthgvrhhssehvvghrsghumhdrohhrgheqnecuggftrf
 grthhtvghrnhepueefhfeiudelffefveefgfeiheffvdeujeekheejleetfeefhfettdeh
 udelffegnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiii
 gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeifrghlthgvrhhssehvvghrsghumhdr
 ohhrgh
X-ME-Proxy: <xmx:wWmsXs4Y34bXe4W3k1Ag8o1lZKGE2G0A5TSNd1JrMpwqR3hOn8RK5w>
 <xmx:wWmsXupypMWVxjjIPhRKyYC2BiClZiie_kFD098ju4u7yiQUlfVJfQ>
 <xmx:wWmsXnlIK1GAxXwr9fAECJj7BQk1PxkOikFqo2M6lQjwE1nHivWc_w>
 <xmx:wmmsXpSZPUniAcHDRDgotBZZA_NvcPZ3qUlOrzTjVSHYKF91nWpWkw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id C57A5660081; Fri,  1 May 2020 14:26:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-dev0-351-g9981f4f-fmstable-20200421v1
Mime-Version: 1.0
Message-Id: <348d4774-bd5f-4832-bd7e-a21491fdac8d@www.fastmail.com>
Date: Fri, 01 May 2020 14:25:48 -0400
From: "Colin Walters" <walters@verbum.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] virtiofsd: Use clone() and not unshare(), support non-root
Content-Type: text/plain
Received-SPF: none client-ip=64.147.123.21; envelope-from=walters@verbum.org;
 helo=wout5-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 14:26:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 64.147.123.21
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I'd like to make use of virtiofs as part of our tooling in
https://github.com/coreos/coreos-assembler
Most of the code runs as non-root today; qemu also runs as non-root.
We use 9p right now.

virtiofsd's builtin sandboxing effectively assumes it runs as
root.

First, change the code to use `clone()` and not `unshare()+fork()`.

Next, automatically use `CLONE_NEWUSER` if we're running as non root.

This is similar logic to that in https://github.com/containers/bubblewrap
(Which...BTW, it could make sense for virtiofs to depend on bubblewrap
 and re-exec itself rather than re-implementing the containerization
 itself)

Signed-off-by: Colin Walters <walters@verbum.org>
---
 tools/virtiofsd/passthrough_ll.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
index 4c35c95b25..468617f6d6 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -2530,6 +2530,21 @@ static void print_capabilities(void)
     printf("}\n");
 }
 
+/* Copied from bubblewrap */
+static int
+raw_clone(unsigned long flags, void *child_stack)
+{
+#if defined(__s390__) || defined(__CRIS__)
+  /*
+   * On s390 and cris the order of the first and second arguments
+   * of the raw clone() system call is reversed.
+   */
+    return (int) syscall(__NR_clone, child_stack, flags);
+#else
+    return (int) syscall(__NR_clone, flags, child_stack);
+#endif
+}
+
 /*
  * Move to a new mount, net, and pid namespaces to isolate this process.
  */
@@ -2547,14 +2562,15 @@ static void setup_namespaces(struct lo_data *lo, struct fuse_session *se)
      * an empty network namespace to prevent TCP/IP and other network
      * activity in case this process is compromised.
      */
-    if (unshare(CLONE_NEWPID | CLONE_NEWNS | CLONE_NEWNET) != 0) {
-        fuse_log(FUSE_LOG_ERR, "unshare(CLONE_NEWPID | CLONE_NEWNS): %m\n");
-        exit(1);
+    int clone_flags = SIGCHLD | CLONE_NEWPID | CLONE_NEWNS | CLONE_NEWNET;
+    /* If we're non root, we need a new user namespace */
+    if (getuid() != 0) {
+        clone_flags |= CLONE_NEWUSER;
     }
 
-    child = fork();
+    child = raw_clone(clone_flags, NULL);
     if (child < 0) {
-        fuse_log(FUSE_LOG_ERR, "fork() failed: %m\n");
+        fuse_log(FUSE_LOG_ERR, "clone() failed: %m\n");
         exit(1);
     }
     if (child > 0) {
-- 
2.24.1


