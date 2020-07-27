Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1C5C433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 20:57:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 093BB20809
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 20:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IUXqpYKe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 093BB20809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0ABs-0006xi-85
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 16:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0AAA-0004ry-PU
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 16:55:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56425
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0AA9-0004rb-3t
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 16:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595883356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AgJoIRjnTNwCL5kqvJULBm/tZVF2+MW/dtpEorcGLAQ=;
 b=IUXqpYKeECTiv4wyIXe6AyIksuqyBFSM/WjBhJYKFL4DhnWzHiWQquBzcTZyIWEoOQStrN
 fk/5ppxuhTTgSR2LBvke2ELt0s+6D7GfsnfAYDp3oZgqdG3H7wUNCRbU55Z4/IJOiws3f/
 Bld4Uov9ZblEV2NSBCnzYbgIDr8+70E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-QRd5DpwJOBOv9ILsjvUCjw-1; Mon, 27 Jul 2020 16:55:53 -0400
X-MC-Unique: QRd5DpwJOBOv9ILsjvUCjw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A90E4186A82A;
 Mon, 27 Jul 2020 20:55:52 +0000 (UTC)
Received: from blue.redhat.com (ovpn-118-248.rdu2.redhat.com [10.10.118.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C698119D82;
 Mon, 27 Jul 2020 20:55:51 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/24] qemu-iotests/199: drop extra constraints
Date: Mon, 27 Jul 2020 15:55:22 -0500
Message-Id: <20200727205543.206624-4-eblake@redhat.com>
In-Reply-To: <20200727205543.206624-1-eblake@redhat.com>
References: <20200727205543.206624-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 15:02:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

We don't need any specific format constraints here. Still keep qcow2
for two reasons:
1. No extra calls of format-unrelated test
2. Add some check around persistent bitmap in future (require qcow2)

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Tested-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200727194236.19551-3-vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/199 | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/199
index de9ba8d94c23..dda918450a8b 100755
--- a/tests/qemu-iotests/199
+++ b/tests/qemu-iotests/199
@@ -116,5 +116,4 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):


 if __name__ == '__main__':
-    iotests.main(supported_fmts=['qcow2'], supported_cache_modes=['none'],
-                 supported_protocols=['file'])
+    iotests.main(supported_fmts=['qcow2'])
-- 
2.27.0


