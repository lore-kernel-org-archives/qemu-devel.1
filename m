Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09560C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 18:23:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66C5020732
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 18:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M/+o7d0l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66C5020732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFLnf-0001kE-7F
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 14:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFLkw-0004vW-7J
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 14:20:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58317)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFLkk-0004RC-DC
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 14:20:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599502828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RJwQnNQfgn1Dahp+9NNjYHWschlU0g6Z9mmMwYCKbPU=;
 b=M/+o7d0leACpwwFFktFPlwjVEZzK555uHzcoSKnLdnaPa3QXFtmRZUcx3SkiS9O0plhpm8
 8JZPjey/kmshVYS8tE+Yuodu+rQQOSgCn+cuOuVoe/4tEKfuYPTAxj5SlCYAJXyBYsV+hl
 5Nt8k3Z8AO5tadQGgWKL4Krgo0e7UjE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-f-lfESy5PLinwGMfAXNk9A-1; Mon, 07 Sep 2020 14:20:26 -0400
X-MC-Unique: f-lfESy5PLinwGMfAXNk9A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3D6B1006701;
 Mon,  7 Sep 2020 18:20:25 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-154.ams2.redhat.com
 [10.36.114.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8B63B60BF3;
 Mon,  7 Sep 2020 18:20:24 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 01/29] nbd: Remove unused nbd_export_get_blockdev()
Date: Mon,  7 Sep 2020 20:19:43 +0200
Message-Id: <20200907182011.521007-2-kwolf@redhat.com>
In-Reply-To: <20200907182011.521007-1-kwolf@redhat.com>
References: <20200907182011.521007-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 13:43:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/block/nbd.h | 2 --
 nbd/server.c        | 5 -----
 2 files changed, 7 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 9bc3bfaeec..0451683d03 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -338,8 +338,6 @@ void nbd_export_remove(NBDExport *exp, NbdServerRemoveMode mode, Error **errp);
 void nbd_export_get(NBDExport *exp);
 void nbd_export_put(NBDExport *exp);
 
-BlockBackend *nbd_export_get_blockdev(NBDExport *exp);
-
 AioContext *nbd_export_aio_context(NBDExport *exp);
 NBDExport *nbd_export_find(const char *name);
 void nbd_export_close_all(void);
diff --git a/nbd/server.c b/nbd/server.c
index 982de67816..bd53f7baea 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1731,11 +1731,6 @@ void nbd_export_put(NBDExport *exp)
     }
 }
 
-BlockBackend *nbd_export_get_blockdev(NBDExport *exp)
-{
-    return exp->blk;
-}
-
 void nbd_export_close_all(void)
 {
     NBDExport *exp, *next;
-- 
2.25.4


