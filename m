Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCE5C2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 16:43:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07D222498C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 16:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="PCPPCLvm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07D222498C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLUqZ-0005I6-69
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 12:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53392)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anthony.perard@citrix.com>) id 1jLUpz-0004oW-D5
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 12:43:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1jLUpy-0000RC-Cy
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 12:43:03 -0400
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:15479)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1jLUpy-00008Z-1p; Mon, 06 Apr 2020 12:43:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1586191381;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=V0pcs+DTT828lXmv+zTuLlbM/UljVqclagyv2mraHC4=;
 b=PCPPCLvmHtfBj52hUWNBt4BmIEcCoNNZoiW/tTUelzMM3gFUvpDpRMGb
 deaJ+UkXw+5rukrzdwWS8ZwTwg+K4JqQfZM2A6ti+RENDmC8X53Gf8VkS
 AvPFUH9edYvUIDwSXMmLXYvBbYEQBgvnvpViRKkYAQ5stdB3yIosduaBU c=;
Authentication-Results: esa6.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=anthony.perard@citrix.com;
 spf=Pass smtp.mailfrom=anthony.perard@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa6.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 anthony.perard@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa6.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible
Received-SPF: Pass (esa6.hc3370-68.iphmx.com: domain of
 anthony.perard@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa6.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
 ip4:168.245.78.127 ~all"
Received-SPF: None (esa6.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa6.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: GcdWCG7OfnvmLebgWzrPsAFm5ZmqvOKQ5DO+Eo4/ijuUCD7RxgrZCc3T+Sfol/kqgkVx7hPlMt
 KvzwoZ3n+mEu7vtQJaWDHZLCxDScLg1tGCiaUsRa4yOo9KskD2FFqsFp+QpVcIMh03y9S3gN/K
 o6ooAZVdlEAjGJPrYVvFhgqdtcYqP2vwKc9M1PGeakLa5vcJ6ID044Gap3v6zvuvTMxcCt02Nw
 mabpmtNqrOmOVJnZvJiuvpH6o1pXnQLOPuTNBisVZlXRFVkt6BIz1EbKyWrmVbHn+rOkz2eeDT
 AGY=
X-SBRS: 2.7
X-MesageID: 15654926
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.72,351,1580792400"; d="scan'208";a="15654926"
From: Anthony PERARD <anthony.perard@citrix.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH for-5.0] xen-block: Fix uninitialized variable
Date: Mon, 6 Apr 2020 17:42:07 +0100
Message-ID: <20200406164207.1446817-1-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.155.175
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 qemu-block@nongnu.org, Paul Durrant <paul@xen.org>,
 Max Reitz <mreitz@redhat.com>, Anthony PERARD <anthony.perard@citrix.com>,
 xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since 7f5d9b206d1e ("object-add: don't create return value if
failed"), qmp_object_add() don't write any value in 'ret_data', thus
has random data. Then qobject_unref() fails and abort().

Fix by initialising 'ret_data' properly.

Fixes: 5f07c4d60d09 ("qapi: Flatten object-add")
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/block/xen-block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 07bb32e22b51..99cb4c67cb09 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -860,7 +860,7 @@ static XenBlockIOThread *xen_block_iothread_create(const char *id,
     XenBlockIOThread *iothread = g_new(XenBlockIOThread, 1);
     Error *local_err = NULL;
     QDict *opts;
-    QObject *ret_data;
+    QObject *ret_data = NULL;
 
     iothread->id = g_strdup(id);
 
-- 
Anthony PERARD


