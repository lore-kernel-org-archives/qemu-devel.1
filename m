Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C2EC2D0F8
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 01:18:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EFA020675
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 01:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V3uVriHz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EFA020675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYg2O-0003HK-6j
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 21:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYg14-0000oS-0e
 for qemu-devel@nongnu.org; Tue, 12 May 2020 21:16:59 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27188
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYg12-0004Bj-3o
 for qemu-devel@nongnu.org; Tue, 12 May 2020 21:16:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589332614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qfzq08Le1zJf7CAaoM1AwB/IXH0chskOmrefaRv4knQ=;
 b=V3uVriHzyZNi6oc8vR9tuUYRVTAOkpe8lj4CJKYeDTGVlra0CEOibnTI92bCxZxrEdn6qE
 KOuewX8ZHUrtcHCe28AuubuNloxP43D0skxdAaal3pHZLnWFJgM6z68IHrTIBFCgfnCXNM
 9U5UNOwTs8HDlZJ5zV40ti0/qC3wyCs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-CTIk880YNc2xVbUx4x3dGg-1; Tue, 12 May 2020 21:16:52 -0400
X-MC-Unique: CTIk880YNc2xVbUx4x3dGg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0B831007B08;
 Wed, 13 May 2020 01:16:51 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-145.phx2.redhat.com [10.3.116.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2FC9E3A0;
 Wed, 13 May 2020 01:16:51 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 1/9] docs: Sort sections on qemu-img subcommand parameters
Date: Tue, 12 May 2020 20:16:40 -0500
Message-Id: <20200513011648.166876-2-eblake@redhat.com>
In-Reply-To: <20200513011648.166876-1-eblake@redhat.com>
References: <20200513011648.166876-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 21:16:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: kwolf@redhat.com, nsoffer@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We already list the subcommand summaries alphabetically, we should do
the same for the documentation related to subcommand-specific
parameters.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
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


