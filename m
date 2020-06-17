Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73B0C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 10:32:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF7FF208B3
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 10:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mysuse.onmicrosoft.com header.i=@mysuse.onmicrosoft.com header.b="e4t7aQUQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF7FF208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlVMw-00031o-Vm
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 06:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <LMa@suse.com>) id 1jlVLw-0002BW-Te
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 06:31:32 -0400
Received: from mail-vi1eur05on2061.outbound.protection.outlook.com
 ([40.107.21.61]:46817 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <LMa@suse.com>) id 1jlVLu-0008PW-6q
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 06:31:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWmpHCFpOsYLNcuqCSrW5U4Acrd3I1R60WClWiEdL4GOZnJm45JRQF/fOR1+avvmc6al3LzvGV+aNsy/jrdDLDvcnK8gF7LoTC+yz29iOMHxG1eazof3knMI1/tuGnKuurV/Q+jXdslHfLg1aZV0yuHe+gAuin0QBRnEwEHNvJbp3fgvPvn681IrRy9SDknqP7L/9jtfaOyHxdpyLP3quIXhAp25oTBLx/BDrCJcyW4XeG9mobWoLrMmGmY/OQurh0byYOG5zwLU6XnYOHe6/ar2/arybfati8xRDIKKGJ3loM12wfyNtvntbGi426BTpleqcd/BIW18xhb9NhLoTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7gMfFneSO/Ae8TX5Q3DAdZgAzg15N6pZkYHdPwFk3Y=;
 b=lX9VRsWHQdiBYMlNucoaLCEqskwD0YbK/WM/Y5+9IBmNR03gCqivbK2GlXS3s5UIQGBCOjC9OZAi3fOrOav2j0LMnds8ffsG3Cl77K55x0fcUrdiy1/AusLSVRvxIw/7SedWaXe5wxbiWiyiknk8tEFMBbFD6ITn8L0wlaeDnTlSkZ44vYObcG/dZ2wrmyjW1bHA3fZuCDzszEQYeem2S951J5sNGxShrpyd4GwtWYYBSkC7XHAExJrcNzavVZrpstjGgZHhcZTjKXEMOb/n+UC8IxObEaICamEwWixJfSTea4BBv9/75CJmBfvLvQGV0RMj9hcd56f9+vp2dUb7aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mysuse.onmicrosoft.com; s=selector1-mysuse-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7gMfFneSO/Ae8TX5Q3DAdZgAzg15N6pZkYHdPwFk3Y=;
 b=e4t7aQUQygR+xLWZoLdvvlpm7f+cSoXoZkBAE0HTs6X7oq4OXrIeUCr4bzK/Y8S2aoPBP6m0C8qgVmhxC7q1vqcozmBdzgKB3ZrT1gPMlMSbBfeGADKop8f1DL825grA7+FsiWnWXiuU6YRXpKRLeNx0hwL0VNA0wk/ZSCEqtYc+D7gC64KJ9CwTDCH8C433O/Z4rsV5/K5jY91diM1I1pCEEh/SQCM5EQy5pJxFnT8Z9KhWSpwQ2VLHW6ZNRmw9YTPWVDmu6lfpKXos7u0dE+/U+zdud9EJ0ubW/9y1dpKq4GUDxCr9tFBseppeW5AU3WhwahoVpBH/aSpfH44cNA==
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=suse.com;
Received: from AM6PR04MB5782.eurprd04.prod.outlook.com (2603:10a6:20b:aa::17)
 by AM6PR04MB5815.eurprd04.prod.outlook.com (2603:10a6:20b:b0::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Wed, 17 Jun
 2020 10:30:49 +0000
Received: from AM6PR04MB5782.eurprd04.prod.outlook.com
 ([fe80::d848:9dea:7742:a55]) by AM6PR04MB5782.eurprd04.prod.outlook.com
 ([fe80::d848:9dea:7742:a55%4]) with mapi id 15.20.3088.029; Wed, 17 Jun 2020
 10:30:49 +0000
From: Lin Ma <lma@suse.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/3] block: Add GET LBA STATUS support
Date: Wed, 17 Jun 2020 18:30:17 +0800
Message-Id: <20200617103018.18026-3-lma@suse.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200617103018.18026-1-lma@suse.com>
References: <20200617103018.18026-1-lma@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0107.apcprd03.prod.outlook.com
 (2603:1096:203:b0::23) To AM6PR04MB5782.eurprd04.prod.outlook.com
 (2603:10a6:20b:aa::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (114.255.249.163) by
 HK0PR03CA0107.apcprd03.prod.outlook.com (2603:1096:203:b0::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.21 via Frontend Transport; Wed, 17 Jun 2020 10:30:47 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [114.255.249.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea1e02a8-c9b0-4eef-c52c-08d812a980b6
X-MS-TrafficTypeDiagnostic: AM6PR04MB5815:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB5815D9158C9BFFD26254C592C59A0@AM6PR04MB5815.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-Forefront-PRVS: 04371797A5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i5tomDSBSqXaT/V/8+oWoXuhY00Ato7mC6jYgOP91HI9B7D9U7GsUhWhlLn4QbdA4cFuZ7jRDG3QzLUiHAw60edEQTx6+2bfTDr5OBk/eVF8x1hLWzZeIZKc4AinizpyR16okYOnHlS0JDCO1+sdAEvnoIVXnpjiVbm2NMTa9BjJ4unECAV+c9DJQyCAXIpd5qFKiisfbe7x7AcipW92QnvC40EKLoUzwCNafCQ5bqxKT0J/BF8pbm5pFZyaLCynB46ac55nd2QWy1IZMzMaMUFZTKJtrM18xlm2ESWinYCULCipkksGb2AbF3UWW56ZSl0/EgI4mjY4dpi4ZPK7Ob5QrL41mEdEfvyZO6CoFi30dXoFLI9fUk7KLDhwUR+t
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR04MB5782.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(136003)(376002)(366004)(346002)(396003)(39860400002)(5660300002)(52116002)(6916009)(66556008)(478600001)(6486002)(8936002)(26005)(8676002)(2906002)(66476007)(66946007)(6506007)(4326008)(316002)(36756003)(6666004)(6512007)(86362001)(107886003)(2616005)(956004)(186003)(1076003)(16526019)(83380400001)(69590400007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: xZI2XIzp84Q2W4ixr16zH/Uaaquu+GAzSsuIYjpzwhXF7Dsa65c0LLrnRKDSmxFfP2X7IrbREvtQt5gWIs+/8uNBDUjGLsSST8+zN2NHIwMGhzOULefGjLSo8c7rDU5+boRG0pYIzYnRghWqtNFUpceNlNAtr6pizpWaS/FMCIw4LMivuLh8jRtA0ORkQMZ0QgCgr5i3MblExzeKtU69xBGhjOB9b/uzwZqDK964zjO7D/gb01NBpixgYzXyWoyjPLF1xmT21KKZNP4buxzZ8wCtrKH/zerIUuCcAm6sIqvO79LID8GP99D8Q5oop28M+Q6hIgx3kuGfmlP0VvZJin2SBVS9l+FGH1nT69js2WBXwscDl3Z6jeghO0Dg7ltecrpB/YzXnQFnmHNrTXeIC7Sa6LLRGvG85lpS8b1W0MgOe60rPfgXJBLu2nzjwJvLZb+yFtkohX2zSivlFuLwbe62AX8dCKoA6UM6VJ6Doic=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea1e02a8-c9b0-4eef-c52c-08d812a980b6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2020 10:30:49.4228 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 00Yl6TCCPtQ2Rlr3ql3Ll5nbKXGMVq4H62aD8GSJxHTyMcuTnmaT8smW6iSS/W9q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5815
Received-SPF: pass client-ip=40.107.21.61; envelope-from=LMa@suse.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 06:31:19
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
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
Cc: fam@euphon.net, kwolf@redhat.com, mreitz@redhat.com, stefanha@redhat.com,
 Lin Ma <lma@suse.com>, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Lin Ma <lma@suse.com>
---
 block/block-backend.c          | 38 ++++++++++++++++++++++++++++++++++
 include/sysemu/block-backend.h |  2 ++
 2 files changed, 40 insertions(+)

diff --git a/block/block-backend.c b/block/block-backend.c
index 6936b25c83..6d08dd5e0d 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1650,6 +1650,44 @@ int blk_pdiscard(BlockBackend *blk, int64_t offset, int bytes)
     return blk_prw(blk, offset, NULL, bytes, blk_pdiscard_entry, 0);
 }
 
+static int coroutine_fn
+blk_do_get_lba_status(BlockBackend *blk, int64_t offset, int bytes,
+                      uint32_t *num_blocks, uint32_t *is_deallocated)
+{
+    int ret;
+
+    blk_wait_while_drained(blk);
+
+    ret = blk_check_byte_request(blk, offset, bytes);
+    if (ret < 0) {
+        return ret;
+    }
+
+    return bdrv_co_get_lba_status(blk->root, offset, bytes, num_blocks,
+                                  is_deallocated);
+}
+
+static void blk_aio_get_lba_status_entry(void *opaque)
+{
+    BlkAioEmAIOCB *acb = opaque;
+    BlkRwCo *rwco = &acb->rwco;
+
+    void *data = acb->common.opaque;
+    uint32_t *num_blocks = (uint32_t *)data;
+    uint32_t *is_deallocated = (uint32_t *)(data + sizeof(uint32_t));
+
+    rwco->ret = blk_do_get_lba_status(rwco->blk, rwco->offset, acb->bytes,
+                                      num_blocks, is_deallocated);
+    blk_aio_complete(acb);
+}
+
+BlockAIOCB *blk_aio_get_lba_status(BlockBackend *blk, int64_t offset, int bytes,
+                                   BlockCompletionFunc *cb, void *opaque)
+{
+    return blk_aio_prwv(blk, offset, bytes, NULL, blk_aio_get_lba_status_entry,
+                        0, cb, opaque);
+}
+
 /* To be called between exactly one pair of blk_inc/dec_in_flight() */
 static int coroutine_fn blk_do_flush(BlockBackend *blk)
 {
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 8203d7f6f9..cd527ec0c9 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -171,6 +171,8 @@ BlockAIOCB *blk_aio_flush(BlockBackend *blk,
                           BlockCompletionFunc *cb, void *opaque);
 BlockAIOCB *blk_aio_pdiscard(BlockBackend *blk, int64_t offset, int bytes,
                              BlockCompletionFunc *cb, void *opaque);
+BlockAIOCB *blk_aio_get_lba_status(BlockBackend *blk, int64_t offset, int bytes,
+                                   BlockCompletionFunc *cb, void *opaque);
 void blk_aio_cancel(BlockAIOCB *acb);
 void blk_aio_cancel_async(BlockAIOCB *acb);
 int blk_ioctl(BlockBackend *blk, unsigned long int req, void *buf);
-- 
2.26.0


