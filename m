Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94919C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 10:54:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 636A8208B3
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 10:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QdClOHom"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 636A8208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlVhv-0007EM-M6
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 06:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jlVcT-0006Sp-UP
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 06:48:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54230
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jlVcS-0002ud-DT
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 06:48:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592390915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VUh0mr1P9mZSkUxn2oYjU1nMgrZe8p4Tg21WDHvSANw=;
 b=QdClOHomcgmpNWorBf2p3f2AZbU9b07dUqWgEIITEbjPXvQiF30K+rerlZe7LX1OepRAMd
 9AuJfukoTUUCtOravEnDuCly1tYUTiMbqP9MNOV8k69Pl/J/fqA7iMtpl89L1mqp5H6/VO
 ADBs2lkTIUR1oPlfSeO2yxm3lz3Dzck=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-SuumrJGtMaqxHs5GKPZcFw-1; Wed, 17 Jun 2020 06:48:33 -0400
X-MC-Unique: SuumrJGtMaqxHs5GKPZcFw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E10AE10A86D0;
 Wed, 17 Jun 2020 10:48:32 +0000 (UTC)
Received: from localhost (ovpn-113-111.ams2.redhat.com [10.36.113.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 809E979316;
 Wed, 17 Jun 2020 10:48:32 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 4/5] iotests/229: data_file is unsupported
Date: Wed, 17 Jun 2020 12:48:21 +0200
Message-Id: <20200617104822.27525-5-mreitz@redhat.com>
In-Reply-To: <20200617104822.27525-1-mreitz@redhat.com>
References: <20200617104822.27525-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:42:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixes: d89ac3cf305b28c024a76805a84d75c0ee1e786f
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/229 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/qemu-iotests/229 b/tests/qemu-iotests/229
index 99acb55ebb..89a5359f32 100755
--- a/tests/qemu-iotests/229
+++ b/tests/qemu-iotests/229
@@ -46,6 +46,9 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2 qed
 _supported_proto file
 _supported_os Linux
+# blkdebug can only inject errors on bs->file, so external data files
+# do not work with this test
+_unsupported_imgopts data_file
 
 
 DEST_IMG="$TEST_DIR/d.$IMGFMT"
-- 
2.26.2


