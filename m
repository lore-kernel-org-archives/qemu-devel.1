Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EEFC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 13:00:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA1062074D
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 13:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cs7REZ66"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA1062074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZZwY-0004FK-Ut
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 09:00:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZj9-0002m9-DL
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:46:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54425
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZj6-0002Iq-Q6
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:46:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589546767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LI8hWiVUlR+qR8sXUC4GxrhVDHxiB8nQBBhLhbUSF4M=;
 b=cs7REZ66ruZQ0VkAom78fEF/8IwKza2tKApwDLviaAqQLoQDcOTfD34yWjUy4JFfiJQmjd
 RlSiZ7CtcWGqYuMdzpUiNcAYvtqakyZ1lPg6fUdYowc79HB+rU6e7dQ6InttIJLexO21zK
 Abu/ioeiRWYqwvUQkGVa1/VV4mluQvs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-GSt4jjX3NUKeGUyNFOXrtQ-1; Fri, 15 May 2020 08:46:03 -0400
X-MC-Unique: GSt4jjX3NUKeGUyNFOXrtQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4711107ACCA;
 Fri, 15 May 2020 12:46:02 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-110.ams2.redhat.com
 [10.36.113.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BC2C62E047;
 Fri, 15 May 2020 12:46:01 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 21/51] block: Rename bdrv_inherited_options()
Date: Fri, 15 May 2020 14:44:51 +0200
Message-Id: <20200515124521.335403-22-kwolf@redhat.com>
In-Reply-To: <20200515124521.335403-1-kwolf@redhat.com>
References: <20200515124521.335403-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 23:27:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

The other two .inherit_options implementations specify exactly for what
case they are used in their name, so do it for this one as well.

(The actual intention behind this patch is to follow it up with a
generic bdrv_inherited_options() that works for all three cases.)

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200513110544.176672-10-mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block.c b/block.c
index b78e2dc141..a17c29f54b 100644
--- a/block.c
+++ b/block.c
@@ -1154,9 +1154,9 @@ static void bdrv_temp_snapshot_options(int *child_flags, QDict *child_options,
  * Returns the options and flags that bs->file should get if a protocol driver
  * is expected, based on the given options and flags for the parent BDS
  */
-static void bdrv_inherited_options(BdrvChildRole role, bool parent_is_format,
-                                   int *child_flags, QDict *child_options,
-                                   int parent_flags, QDict *parent_options)
+static void bdrv_protocol_options(BdrvChildRole role, bool parent_is_format,
+                                  int *child_flags, QDict *child_options,
+                                  int parent_flags, QDict *parent_options)
 {
     int flags = parent_flags;
 
@@ -1188,7 +1188,7 @@ static void bdrv_inherited_options(BdrvChildRole role, bool parent_is_format,
 const BdrvChildClass child_file = {
     .parent_is_bds   = true,
     .get_parent_desc = bdrv_child_get_parent_desc,
-    .inherit_options = bdrv_inherited_options,
+    .inherit_options = bdrv_protocol_options,
     .drained_begin   = bdrv_child_cb_drained_begin,
     .drained_poll    = bdrv_child_cb_drained_poll,
     .drained_end     = bdrv_child_cb_drained_end,
-- 
2.25.4


