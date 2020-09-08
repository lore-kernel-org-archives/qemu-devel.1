Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809ABC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 06:57:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1917C2068D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 06:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A/xYLBcX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1917C2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFXZQ-0005S9-4T
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 02:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kFXWM-0001Ey-D9
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 02:54:26 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26482
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kFXWJ-0008CY-Lz
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 02:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599548062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TZT9ZHvTLeBts5ifAOnsBtSAoz+UEua1UY1aaCa7a7E=;
 b=A/xYLBcXolrD2JXgOqC02uK/T6RLfOWHWVNNnjTaj3BxeDDjF4CdmsHQTyJVDH5MnUbbMV
 EjnN161Zv1h7EHOnjwa2J/jKhKE9IOrfUcZhw3wCUOjNjtTT1tDY8JYIfIKatxsfk6ZKg/
 buQoeSJhMM/mL80TEegr2vPF1EHXjsM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-uj98bnktPKi5xH7AuOkjHA-1; Tue, 08 Sep 2020 02:54:20 -0400
X-MC-Unique: uj98bnktPKi5xH7AuOkjHA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEC5864083;
 Tue,  8 Sep 2020 06:54:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-68.ams2.redhat.com
 [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 52B835D9D3;
 Tue,  8 Sep 2020 06:54:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8D6F51132751; Tue,  8 Sep 2020 08:54:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/5] qapi/migration.json: Fix indentation
Date: Tue,  8 Sep 2020 08:54:15 +0200
Message-Id: <20200908065417.3158250-4-armbru@redhat.com>
In-Reply-To: <20200908065417.3158250-1-armbru@redhat.com>
References: <20200908065417.3158250-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 01:08:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
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
Cc: peter.maydell@linaro.org, Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

Commits 6a9ad1542065ca0bd54c6 and 9004db48c080632aef23 added some
new text to qapi/migration.json which doesn't fit the stricter
indentation requirements imposed by the rST documentation generator.
Reindent those lines to the new standard.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20200810195019.25427-2-peter.maydell@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/migration.json | 60 ++++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 5f6b06172c..115181f4a5 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -667,18 +667,18 @@
 #                       Defaults to none. (Since 5.0)
 #
 # @multifd-zlib-level: Set the compression level to be used in live
-#          migration, the compression level is an integer between 0
-#          and 9, where 0 means no compression, 1 means the best
-#          compression speed, and 9 means best compression ratio which
-#          will consume more CPU.
-#          Defaults to 1. (Since 5.0)
+#                      migration, the compression level is an integer between 0
+#                      and 9, where 0 means no compression, 1 means the best
+#                      compression speed, and 9 means best compression ratio which
+#                      will consume more CPU.
+#                      Defaults to 1. (Since 5.0)
 #
 # @multifd-zstd-level: Set the compression level to be used in live
-#          migration, the compression level is an integer between 0
-#          and 20, where 0 means no compression, 1 means the best
-#          compression speed, and 20 means best compression ratio which
-#          will consume more CPU.
-#          Defaults to 1. (Since 5.0)
+#                      migration, the compression level is an integer between 0
+#                      and 20, where 0 means no compression, 1 means the best
+#                      compression speed, and 20 means best compression ratio which
+#                      will consume more CPU.
+#                      Defaults to 1. (Since 5.0)
 #
 # @block-bitmap-mapping: Maps block nodes and bitmaps on them to
 #          aliases for the purpose of dirty bitmap migration.  Such
@@ -827,18 +827,18 @@
 #                       Defaults to none. (Since 5.0)
 #
 # @multifd-zlib-level: Set the compression level to be used in live
-#          migration, the compression level is an integer between 0
-#          and 9, where 0 means no compression, 1 means the best
-#          compression speed, and 9 means best compression ratio which
-#          will consume more CPU.
-#          Defaults to 1. (Since 5.0)
+#                      migration, the compression level is an integer between 0
+#                      and 9, where 0 means no compression, 1 means the best
+#                      compression speed, and 9 means best compression ratio which
+#                      will consume more CPU.
+#                      Defaults to 1. (Since 5.0)
 #
 # @multifd-zstd-level: Set the compression level to be used in live
-#          migration, the compression level is an integer between 0
-#          and 20, where 0 means no compression, 1 means the best
-#          compression speed, and 20 means best compression ratio which
-#          will consume more CPU.
-#          Defaults to 1. (Since 5.0)
+#                      migration, the compression level is an integer between 0
+#                      and 20, where 0 means no compression, 1 means the best
+#                      compression speed, and 20 means best compression ratio which
+#                      will consume more CPU.
+#                      Defaults to 1. (Since 5.0)
 #
 # @block-bitmap-mapping: Maps block nodes and bitmaps on them to
 #          aliases for the purpose of dirty bitmap migration.  Such
@@ -1023,18 +1023,18 @@
 #                       Defaults to none. (Since 5.0)
 #
 # @multifd-zlib-level: Set the compression level to be used in live
-#          migration, the compression level is an integer between 0
-#          and 9, where 0 means no compression, 1 means the best
-#          compression speed, and 9 means best compression ratio which
-#          will consume more CPU.
-#          Defaults to 1. (Since 5.0)
+#                      migration, the compression level is an integer between 0
+#                      and 9, where 0 means no compression, 1 means the best
+#                      compression speed, and 9 means best compression ratio which
+#                      will consume more CPU.
+#                      Defaults to 1. (Since 5.0)
 #
 # @multifd-zstd-level: Set the compression level to be used in live
-#          migration, the compression level is an integer between 0
-#          and 20, where 0 means no compression, 1 means the best
-#          compression speed, and 20 means best compression ratio which
-#          will consume more CPU.
-#          Defaults to 1. (Since 5.0)
+#                      migration, the compression level is an integer between 0
+#                      and 20, where 0 means no compression, 1 means the best
+#                      compression speed, and 20 means best compression ratio which
+#                      will consume more CPU.
+#                      Defaults to 1. (Since 5.0)
 #
 # @block-bitmap-mapping: Maps block nodes and bitmaps on them to
 #          aliases for the purpose of dirty bitmap migration.  Such
-- 
2.26.2


