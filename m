Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A024DC10F29
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 18:01:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 798EA208C3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 18:01:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 798EA208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=winhong.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBMit-0005NM-Ll
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 14:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51253)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yili@winhong.com>) id 1jBLOd-0007eC-M0
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 12:36:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yili@winhong.com>) id 1jBLOY-0003HC-5a
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 12:36:47 -0400
Received: from regular1.263xmail.com ([211.150.70.204]:58556)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yili@winhong.com>) id 1jBLOX-0003EJ-Mr
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 12:36:46 -0400
Received: from localhost (unknown [192.168.167.13])
 by regular1.263xmail.com (Postfix) with ESMTP id EE8F7229
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 00:36:29 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from localhost.localdomain (unknown [120.230.125.95])
 by smtp.263.net (postfix) whith ESMTP id
 P3519T140169525057280S1583771760157348_; 
 Tue, 10 Mar 2020 00:36:30 +0800 (CST)
X-UNIQUE-TAG: <2e81a7a9991f791b85135b35c91f0602>
X-RL-SENDER: yili@winhong.com
X-SENDER: yili@winhong.com
X-LOGIN-NAME: yili@winhong.com
X-FST-TO: qemu-devel@nongnu.org
X-SENDER-IP: 120.230.125.95
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From: Yi Li <yili@winhong.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] qcow2: remove QCowL2Meta parameter from handle_copied
Date: Tue, 10 Mar 2020 00:35:53 +0800
Message-Id: <20200309163553.39106-1-yili@winhong.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 211.150.70.204
X-Mailman-Approved-At: Mon, 09 Mar 2020 13:59:56 -0400
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
Cc: yili@winhong.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The QCowL2Meta **m parameter is not used

Signed-off-by: Yi Li <yili@winhong.com>
---
 block/qcow2-cluster.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 17f1363..db9efa5 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1154,7 +1154,7 @@ static int handle_dependencies(BlockDriverState *bs=
, uint64_t guest_offset,
  *  -errno: in error cases
  */
 static int handle_copied(BlockDriverState *bs, uint64_t guest_offset,
-    uint64_t *host_offset, uint64_t *bytes, QCowL2Meta **m)
+    uint64_t *host_offset, uint64_t *bytes)
 {
     BDRVQcow2State *s =3D bs->opaque;
     int l2_index;
@@ -1567,7 +1567,7 @@ again:
         /*
          * 2. Count contiguous COPIED clusters.
          */
-        ret =3D handle_copied(bs, start, &cluster_offset, &cur_bytes, m)=
;
+        ret =3D handle_copied(bs, start, &cluster_offset, &cur_bytes);
         if (ret < 0) {
             return ret;
         } else if (ret) {
--=20
2.7.5




