Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D1EC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:07:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FE9D23101
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fT+8YfYn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE9D23101
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6xme-0003rB-Hr
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 11:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@163.com>) id 1k6xlM-0002AJ-UM
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 11:06:28 -0400
Received: from mail-m9763.mail.163.com ([123.126.97.63]:41318)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@163.com>) id 1k6xlJ-0007SE-G0
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 11:06:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=W4LN/xZpHEZmo9POvK
 UpY0DPWTuEFUi8n4lDp6jU9qE=; b=fT+8YfYnQtTwQsd4DquO1va4bVxxURMoGu
 /MPWtaRamd3ubLj2Wkh0H8A3s96HvUUa1ua0DyX+bgsUlMu43t+0kct9w9cffvTy
 umbN4rILS3URTKlD3FXXXKl4RPxwGxL1JjzyehlBPh+RRJRVuaemumuG/XD5pfXU
 xUrICPwjs=
Received: from localhost.localdomain (unknown [115.204.244.155])
 by smtp1 (Coremail) with SMTP id GdxpCgA3w4MF7zdfSkGDAA--.134S5;
 Sat, 15 Aug 2020 22:20:00 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: hare@suse.com,
	pbonzini@redhat.com,
	fam@euphon.net
Subject: [PATCH 1/2] hw: megasas: return -1 when 'megasas_map_sgl' fails
Date: Sat, 15 Aug 2020 07:19:39 -0700
Message-Id: <20200815141940.44025-2-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200815141940.44025-1-liq3ea@163.com>
References: <20200815141940.44025-1-liq3ea@163.com>
X-CM-TRANSID: GdxpCgA3w4MF7zdfSkGDAA--.134S5
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF4DZrWrWrW8XrW3uryxuFg_yoWDuFc_Aw
 1093WkJr47Zr47J3sYqw1jyr12qwnrXFyDAr4aqasxAw13GasrGw4DX39rZFWkCw48urs8
 twnayrZxAws5WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1b18JUUUUU==
X-Originating-IP: [115.204.244.155]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/xtbBoRGBbVQHLOqJ+AAAs4
Received-SPF: pass client-ip=123.126.97.63; envelope-from=liq3ea@163.com;
 helo=mail-m9763.mail.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/15 03:37:13
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Li Qiang <liq3ea@163.com>, liq3ea@gmail.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The caller of 'megasas_map_sgl' will only check if the return
is zero or not. If it return 0 it means success, as in the next
patch we will consider 'iov_count=0' is an error, so let's
return -1 to indicate a failure.

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 hw/scsi/megasas.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 5cfd1bf22e..d6c9680c36 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -281,7 +281,7 @@ static int megasas_map_sgl(MegasasState *s, MegasasCmd *cmd, union mfi_sgl *sgl)
     if (iov_count > MEGASAS_MAX_SGE) {
         trace_megasas_iovec_sgl_overflow(cmd->index, iov_count,
                                          MEGASAS_MAX_SGE);
-        return iov_count;
+        return -1;
     }
     pci_dma_sglist_init(&cmd->qsg, PCI_DEVICE(s), iov_count);
     for (i = 0; i < iov_count; i++) {
@@ -311,7 +311,7 @@ static int megasas_map_sgl(MegasasState *s, MegasasCmd *cmd, union mfi_sgl *sgl)
     return 0;
 unmap:
     qemu_sglist_destroy(&cmd->qsg);
-    return iov_count - i;
+    return -1;
 }
 
 /*
-- 
2.17.1


