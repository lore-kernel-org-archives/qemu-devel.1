Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F683C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:14:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8616E20715
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eLV/gIXl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8616E20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKeNh-0001Kr-Cr
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 05:14:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kKeBT-0000Fs-SL
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 05:02:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42059)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kKeBQ-0002q0-7Z
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 05:01:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600765315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HAu7sKUVAWfS6dwqeNqX0De8VI1nzn5UujD2vHMT7ZI=;
 b=eLV/gIXlkBCn/ZbGjnaYUX9nExkM0gIMcErpKQg2PSnQEPTJSe7ZbccXxLgL6Nqn1jw0CJ
 zg/WzxUVzN8kYvFeTmAjv0KXCAvB2erzSPc0vbSYeNM7X0SdFwglsh8KPNcQnHRinUnF84
 GDvesFgLyg1FD0I/F41a/7xsyaMgBww=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-avGhvL9ENV2ggEMMsN8Jjw-1; Tue, 22 Sep 2020 05:01:53 -0400
X-MC-Unique: avGhvL9ENV2ggEMMsN8Jjw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 366F910A7AE6;
 Tue, 22 Sep 2020 09:01:52 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-114-64.ams2.redhat.com
 [10.36.114.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C714A5C1DC;
 Tue, 22 Sep 2020 09:01:50 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/1] block: drop moderated sheepdog mailing list from
 MAINTAINERS file
Date: Tue, 22 Sep 2020 10:01:47 +0100
Message-Id: <20200922090147.1993705-2-berrange@redhat.com>
In-Reply-To: <20200922090147.1993705-1-berrange@redhat.com>
References: <20200922090147.1993705-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Liu Yuan <namei.unix@gmail.com>, sheepdog@lists.wpkg.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The sheepdog mailing list is setup to stop and queue messages from
non-subscribers, pending moderator approval. Unfortunately it seems
that the moderation queue is not actively dealt with. Even when messages
are approved, the sender is never added to the whitelist, so every
future mail from the same sender continues to get stopped for moderation.

MAINTAINERS entries should be responsive and not uneccessarily block
mails from QEMU contributors, so drop the sheepdog mailing list.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3d17cad19a..8e8a4fb0a8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2852,7 +2852,6 @@ F: block/rbd.c
 Sheepdog
 M: Liu Yuan <namei.unix@gmail.com>
 L: qemu-block@nongnu.org
-L: sheepdog@lists.wpkg.org
 S: Odd Fixes
 F: block/sheepdog.c
 
-- 
2.26.2


