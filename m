Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACADC388F2
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 09:39:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23B48208FE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 09:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="HBfE4ENs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23B48208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kayDT-0007cr-2T
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 04:39:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <487729e9f667644ee0d6762b24269e7758ad2e5e@lizzy.crudebyte.com>)
 id 1kayCH-0006Fz-2E
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 04:38:17 -0500
Received: from lizzy.crudebyte.com ([91.194.90.13]:47391)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <487729e9f667644ee0d6762b24269e7758ad2e5e@lizzy.crudebyte.com>)
 id 1kayCF-0007Bu-Br
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 04:38:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=XoZ2XPXVmz9CcXaU4iZPp15B80jRxnBP0iossRIbCUw=; b=HBfE4
 ENsKNQMlNJXqX9jzHjtetWNfclHgdET/u1THEMiLMCp3NPwJnBu97qh6wh8CZIdIlxbsqz1jH87AO
 f4RRtiU7sdhmurpIKJT2DY7rpysu2CGERFaJiRbmoSgIYknGN23cYidsgfAu2RA+SMaNWNCjuf5eu
 2ulT+/VZRh0CGFOzNxN2BeQjhY56baTSA76u5xU31Ku2Oc0msqngcRBds2/vImvRiOkCswcxYEOo8
 zRr0qoKyjBm6o6RYU5caG0Dl/cgQSUae+/zq+6VkNo8ZVusKQCvu+95+Jp0IKRy0fTqCX8zri17gX
 Z8oMzuR+DvkBDrOceIhlneMmGjcSg==;
Message-Id: <487729e9f667644ee0d6762b24269e7758ad2e5e.1604653990.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1604653990.git.qemu_oss@crudebyte.com>
References: <cover.1604653990.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Fri, 06 Nov 2020 10:13:10 +0100
Subject: [PULL 2/4] hw/9pfs : open brace '{' following struct go on the same
 line
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>, Xinhao Zhang <zhangxinhao1@huawei.com>,
 Kai Deng <dengkai1@huawei.com>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=487729e9f667644ee0d6762b24269e7758ad2e5e@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 04:36:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Xinhao Zhang <zhangxinhao1@huawei.com>

Fix code style. Open braces for struct should go on the same line.

Signed-off-by: Xinhao Zhang <zhangxinhao1@huawei.com>
Signed-off-by: Kai Deng <dengkai1@huawei.com>
Reported-by: Euler Robot <euler.robot@huawei.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-Id: <20201030043515.1030223-2-zhangxinhao1@huawei.com>
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p.h | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index 3dd1b50b1a..32df81f360 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -143,8 +143,7 @@ typedef struct {
  */
 QEMU_BUILD_BUG_ON(sizeof(P9MsgHeader) != 7);
 
-struct V9fsPDU
-{
+struct V9fsPDU {
     uint32_t size;
     uint16_t tag;
     uint8_t id;
@@ -270,8 +269,7 @@ union V9fsFidOpenState {
     void *private;
 };
 
-struct V9fsFidState
-{
+struct V9fsFidState {
     int fid_type;
     int32_t fid;
     V9fsPath path;
@@ -338,8 +336,7 @@ typedef struct {
     uint64_t path;
 } QpfEntry;
 
-struct V9fsState
-{
+struct V9fsState {
     QLIST_HEAD(, V9fsPDU) free_list;
     QLIST_HEAD(, V9fsPDU) active_list;
     V9fsFidState *fid_list;
-- 
2.20.1


