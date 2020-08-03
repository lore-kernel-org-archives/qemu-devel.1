Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BF3C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 09:14:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6555E206E2
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 09:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VM8Vqnnw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6555E206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2WXs-0001on-BY
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 05:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k2WUc-0005di-CN
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 05:10:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58100
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k2WUa-0003rR-Bl
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 05:10:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596445847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RrQEaxPOeVZseWSQXSdJ/uARN9jCT5zoOq48tnsCUS0=;
 b=VM8VqnnwOXw9X6UjDA41+dRppY3eMjZsEgexzJbTLYOTu3k1ltNW4xZXvEEEESbxyWjYTx
 tEUwrxpg7GbuXu3HNPUwPeJgzm9xtcfxMoRokKirneTYJHFBL7ZQQjKvcbSgVi3LScvzrZ
 N8eu2zkqv31/Or9ywVWOFJHuz50cP28=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-ukoDqsY3NHSyOGIvro0u6A-1; Mon, 03 Aug 2020 05:10:45 -0400
X-MC-Unique: ukoDqsY3NHSyOGIvro0u6A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47AE78017FB;
 Mon,  3 Aug 2020 09:10:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 192501001B0B;
 Mon,  3 Aug 2020 09:10:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A1D5F1132922; Mon,  3 Aug 2020 11:10:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/3] qapi: Delete unwanted indentation of top-level expressions
Date: Mon,  3 Aug 2020 11:10:41 +0200
Message-Id: <20200803091042.2920218-3-armbru@redhat.com>
In-Reply-To: <20200803091042.2920218-1-armbru@redhat.com>
References: <20200803091042.2920218-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 01:24:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200730091656.2633334-1-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[One more line de-indented]
---
 qapi/block-core.json | 26 +++++++++++++-------------
 qapi/ui.json         |  4 ++--
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index ab7bf3c612..49edb4fdae 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1847,9 +1847,9 @@
 #
 # Since: 4.0
 ##
-  { 'enum': 'BlockPermission',
-    'data': [ 'consistent-read', 'write', 'write-unchanged', 'resize',
-              'graph-mod' ] }
+{ 'enum': 'BlockPermission',
+  'data': [ 'consistent-read', 'write', 'write-unchanged', 'resize',
+            'graph-mod' ] }
 ##
 # @XDbgBlockGraphEdge:
 #
@@ -2155,8 +2155,8 @@
 # <- { "return": {} }
 #
 ##
-  { 'command': 'block-dirty-bitmap-enable',
-    'data': 'BlockDirtyBitmap' }
+{ 'command': 'block-dirty-bitmap-enable',
+  'data': 'BlockDirtyBitmap' }
 
 ##
 # @block-dirty-bitmap-disable:
@@ -2176,8 +2176,8 @@
 # <- { "return": {} }
 #
 ##
-    { 'command': 'block-dirty-bitmap-disable',
-      'data': 'BlockDirtyBitmap' }
+{ 'command': 'block-dirty-bitmap-disable',
+  'data': 'BlockDirtyBitmap' }
 
 ##
 # @block-dirty-bitmap-merge:
@@ -2208,8 +2208,8 @@
 # <- { "return": {} }
 #
 ##
-      { 'command': 'block-dirty-bitmap-merge',
-        'data': 'BlockDirtyBitmapMerge' }
+{ 'command': 'block-dirty-bitmap-merge',
+  'data': 'BlockDirtyBitmapMerge' }
 
 ##
 # @BlockDirtyBitmapSha256:
@@ -2220,8 +2220,8 @@
 #
 # Since: 2.10
 ##
-  { 'struct': 'BlockDirtyBitmapSha256',
-    'data': {'sha256': 'str'} }
+{ 'struct': 'BlockDirtyBitmapSha256',
+  'data': {'sha256': 'str'} }
 
 ##
 # @x-debug-block-dirty-bitmap-sha256:
@@ -2235,8 +2235,8 @@
 #
 # Since: 2.10
 ##
-  { 'command': 'x-debug-block-dirty-bitmap-sha256',
-    'data': 'BlockDirtyBitmap', 'returns': 'BlockDirtyBitmapSha256' }
+{ 'command': 'x-debug-block-dirty-bitmap-sha256',
+  'data': 'BlockDirtyBitmap', 'returns': 'BlockDirtyBitmapSha256' }
 
 ##
 # @blockdev-mirror:
diff --git a/qapi/ui.json b/qapi/ui.json
index e16e98a060..1568cfeaad 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1081,8 +1081,8 @@
  # Since: 3.0
  #
  ##
- { 'enum'    : 'DisplayGLMode',
-   'data'    : [ 'off', 'on', 'core', 'es' ] }
+{ 'enum'    : 'DisplayGLMode',
+  'data'    : [ 'off', 'on', 'core', 'es' ] }
 
 ##
 # @DisplayCurses:
-- 
2.26.2


