Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30F3C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 20:55:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A93020756
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 20:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z67YcGdy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A93020756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jamnY-0000Zb-JS
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 16:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jammo-00080b-R7
 for qemu-devel@nongnu.org; Mon, 18 May 2020 16:54:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49463
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jammn-0006aM-TB
 for qemu-devel@nongnu.org; Mon, 18 May 2020 16:54:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589835297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DWpe5yds+5r+yYsEjkZ86ON2bKRBqsAmXMRLL9uPTrw=;
 b=Z67YcGdyqjefegqfhfiUJ+VA8+1koIahyhonFj5MO2IvvL+jnKXUhgSb8eg4cEwADtwHOK
 Ohs6BG9q3aDNXQnYyWJw1ePwokSofvgGujXQv1vEHe3QPaLW6BI6y3GcnT97NNPaaP32hG
 ZVTpZ8nbmtpUyy5TfQQd6FvMM5GGezk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-aVhckF0LNBGeLoFHGadcow-1; Mon, 18 May 2020 16:54:54 -0400
X-MC-Unique: aVhckF0LNBGeLoFHGadcow-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8A92835B44;
 Mon, 18 May 2020 20:54:53 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 14590795A2;
 Mon, 18 May 2020 20:54:52 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/7] docs: Sort sections on qemu-img subcommand parameters
Date: Mon, 18 May 2020 15:54:43 -0500
Message-Id: <20200518205448.690566-3-eblake@redhat.com>
In-Reply-To: <20200518205448.690566-1-eblake@redhat.com>
References: <20200518205448.690566-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 00:53:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We already list the subcommand summaries alphabetically, we should do
the same for the documentation related to subcommand-specific
parameters.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200513011648.166876-2-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 docs/tools/qemu-img.rst | 48 ++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
index 0080f83a76c9..7d08c48d308f 100644
--- a/docs/tools/qemu-img.rst
+++ b/docs/tools/qemu-img.rst
@@ -142,30 +142,6 @@ by the used format or see the format descriptions below for details.
   the documentation of the emulator's ``-drive cache=...`` option for allowed
   values.

-Parameters to snapshot subcommand:
-
-.. program:: qemu-img-snapshot
-
-.. option:: snapshot
-
-  Is the name of the snapshot to create, apply or delete
-
-.. option:: -a
-
-  Applies a snapshot (revert disk to saved state)
-
-.. option:: -c
-
-  Creates a snapshot
-
-.. option:: -d
-
-  Deletes a snapshot
-
-.. option:: -l
-
-  Lists all snapshots in the given image
-
 Parameters to compare subcommand:

 .. program:: qemu-img-compare
@@ -245,6 +221,30 @@ Parameters to dd subcommand:

   Sets the number of input blocks to skip

+Parameters to snapshot subcommand:
+
+.. program:: qemu-img-snapshot
+
+.. option:: snapshot
+
+  Is the name of the snapshot to create, apply or delete
+
+.. option:: -a
+
+  Applies a snapshot (revert disk to saved state)
+
+.. option:: -c
+
+  Creates a snapshot
+
+.. option:: -d
+
+  Deletes a snapshot
+
+.. option:: -l
+
+  Lists all snapshots in the given image
+
 Command description:

 .. program:: qemu-img-commands
-- 
2.26.2


