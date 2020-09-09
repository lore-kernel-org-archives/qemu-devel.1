Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E97CC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 18:41:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF7742080C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 18:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GnwYiCAS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF7742080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG52W-0006UC-1e
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 14:41:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kG51W-0005IQ-Lk
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 14:40:50 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33571
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kG51U-0007D6-Ue
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 14:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599676847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3hIuRlOch12nW25o6+lj0a/Akr3yOI37PrVQ6WMUZPo=;
 b=GnwYiCASqF+Fq/bN95AyMGOl/Ek0/6nsIdu5Vjt7gQ1J3iZD1bJmnnPVbdJIi/uKEycvQD
 cr9ML8sfk1HAi9r/ZGYvuOczWo6sshNjTqLer+Z/M+mk/+dEIJS7sjLH/HNQcoBz/tqYTB
 53PgCYvR/FIVVNNKG+skyCGOb5N4bSs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-zIz3GvgLPNW1qIpSQrAHbQ-1; Wed, 09 Sep 2020 14:40:45 -0400
X-MC-Unique: zIz3GvgLPNW1qIpSQrAHbQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AC211084C82
 for <qemu-devel@nongnu.org>; Wed,  9 Sep 2020 18:40:44 +0000 (UTC)
Received: from localhost (ovpn-113-94.ams2.redhat.com [10.36.113.94])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DCD6E7E8E3;
 Wed,  9 Sep 2020 18:40:37 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/8] linux/fuse.h: Pull in from Linux
Date: Wed,  9 Sep 2020 20:40:21 +0200
Message-Id: <20200909184028.262297-2-mreitz@redhat.com>
In-Reply-To: <20200909184028.262297-1-mreitz@redhat.com>
References: <20200909184028.262297-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 14:15:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: virtio-fs@redhat.com, Miklos Szeredi <mszeredi@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Update the linux/fuse.h standard header from the kernel development tree
that implements FUSE submounts.

This adds the fuse_attr.flags field, the FUSE_ATTR_FLAGS INIT flag, and
the FUSE_ATTR_SUBMOUNT flag for fuse_attr.flags.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/standard-headers/linux/fuse.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/standard-headers/linux/fuse.h b/include/standard-headers/linux/fuse.h
index f4df0a40f6..7dd7a3b992 100644
--- a/include/standard-headers/linux/fuse.h
+++ b/include/standard-headers/linux/fuse.h
@@ -227,7 +227,7 @@ struct fuse_attr {
 	uint32_t	gid;
 	uint32_t	rdev;
 	uint32_t	blksize;
-	uint32_t	padding;
+	uint32_t	flags;
 };
 
 struct fuse_kstatfs {
@@ -310,6 +310,7 @@ struct fuse_file_lock {
  * FUSE_NO_OPENDIR_SUPPORT: kernel supports zero-message opendir
  * FUSE_EXPLICIT_INVAL_DATA: only invalidate cached pages on explicit request
  * FUSE_MAP_ALIGNMENT: map_alignment field is valid
+ * FUSE_ATTR_FLAGS: fuse_attr.flags is present and valid
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -338,6 +339,7 @@ struct fuse_file_lock {
 #define FUSE_NO_OPENDIR_SUPPORT (1 << 24)
 #define FUSE_EXPLICIT_INVAL_DATA (1 << 25)
 #define FUSE_MAP_ALIGNMENT	(1 << 26)
+#define FUSE_ATTR_FLAGS		(1 << 27)
 
 /**
  * CUSE INIT request/reply flags
@@ -413,6 +415,13 @@ struct fuse_file_lock {
  */
 #define FUSE_FSYNC_FDATASYNC	(1 << 0)
 
+/**
+ * fuse_attr flags
+ *
+ * FUSE_ATTR_SUBMOUNT: File/directory is a submount point
+ */
+#define FUSE_ATTR_SUBMOUNT      (1 << 0)
+
 enum fuse_opcode {
 	FUSE_LOOKUP		= 1,
 	FUSE_FORGET		= 2,  /* no reply */
-- 
2.26.2


