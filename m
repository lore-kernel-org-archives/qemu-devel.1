Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161F2C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 20:38:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80AC320725
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 20:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZB0nBtnW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80AC320725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLBWo-0007bW-VZ
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 16:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kLBW3-0006lD-Ua
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 16:37:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47685)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kLBW2-0007ju-51
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 16:37:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600893445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wHQHYqUjI9wcLEM8ZW7E1CqaYcgjF/cF21GUP/vPPAo=;
 b=ZB0nBtnW9x3y+p6wy5em3PZg4LpCX7T7il1itKIoBT7MW6AF2UKTEnio5U9jnsWZXPT81z
 KVknxXi06syXQBvH+IryEl+YQFyLHLs9S3g9JTEnA9mKR3wNUucfljqL39w+jjx0F1Inzp
 ef4/hZeoNycEyXUlT1VsaD20ONJgSs4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-u3bNlIUiNDSC00eqRCdXMQ-1; Wed, 23 Sep 2020 16:37:23 -0400
X-MC-Unique: u3bNlIUiNDSC00eqRCdXMQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84A2C425CE;
 Wed, 23 Sep 2020 20:37:22 +0000 (UTC)
Received: from blue.redhat.com (ovpn-114-2.phx2.redhat.com [10.3.114.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 29C2173668;
 Wed, 23 Sep 2020 20:37:22 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] docs: Better mention of qemu-img amend limitations
Date: Wed, 23 Sep 2020 15:37:19 -0500
Message-Id: <20200923203719.732958-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Missed during merge resolution of commit bc5ee6da71.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 docs/tools/qemu-img.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
index c35bd6482203..2b5891b54db7 100644
--- a/docs/tools/qemu-img.rst
+++ b/docs/tools/qemu-img.rst
@@ -265,6 +265,10 @@ Command description:
   --force allows some unsafe operations. Currently for -f luks, it allows to
   erase the last encryption key, and to overwrite an active encryption key.

+  The set of options that can be amended are dependent on the image
+  format, but note that amending the backing chain relationship should
+  instead be performed with ``qemu-img rebase``.
+
 .. option:: bench [-c COUNT] [-d DEPTH] [-f FMT] [--flush-interval=FLUSH_INTERVAL] [-i AIO] [-n] [--no-drain] [-o OFFSET] [--pattern=PATTERN] [-q] [-s BUFFER_SIZE] [-S STEP_SIZE] [-t CACHE] [-w] [-U] FILENAME

   Run a simple sequential I/O benchmark on the specified image. If ``-w`` is
-- 
2.28.0


