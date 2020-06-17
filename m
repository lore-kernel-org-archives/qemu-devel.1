Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4523EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 10:34:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EF7920DD4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 10:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mysuse.onmicrosoft.com header.i=@mysuse.onmicrosoft.com header.b="VquGpf8e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EF7920DD4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlVP3-0005kv-CZ
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 06:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <LMa@suse.com>) id 1jlVLz-0002Dc-9i
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 06:31:35 -0400
Received: from mail-vi1eur05on2061.outbound.protection.outlook.com
 ([40.107.21.61]:46817 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <LMa@suse.com>) id 1jlVLx-0008PW-90
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 06:31:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ml9iElFlPUml3cXZEI3bmHyltNnjKiyuJib1kVwOkG78AyzNoE8KEK+vTA5OK4yDZ4PwHc9D3RZL4txdOcAgQHZ2fAi6b10LmqPsnW9yoT5XFfsbaxdyM4m+amrR2/4gpqeacxXC3yt9Yfv++jmiVTzUb7WmLSgOH2WOYKApGEFJIyyja1WLrAuFRMDlUbWMUcnTCJQVqEFm+Uw1lSqQfTZg8O23xVthPIOidu5BpbWSYOu/0M87YzwS4XF47lhEZmpuDTOcE29PaWKJAtQRUFjSvmCWTtJxwa+iGIxVn0nL8a2m5dKcGkKPNIUtM3fcK8g+smh76ZL2AdNLKuJCbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUKfX9FVfthy2w7tRAPEyZ1a9rIxVPHgzXPclsOOFbo=;
 b=nGXlrZZhVQNKYCgRVXI3hrHyW8eXed+AjHyA1YMzv1zZXVFGEQbPCWAyfeXwBOcFNDriZdxnet523F8KqTGzfmrzpjQvfHQqnziBKBu+pyZHCkKz76sa47wNhUNMFkceicobD63IWCDRuGuq9/S8xE71uRm8Gg5cLpmFf1t/3XCfq9I6PHsHhSEQlmfJ6+2F8pMid+nFo1nX9epjRZWn0/hiRgkRaKlS/Xhz5mhdPONxBL3Wn3Q8SZJp0s4PoAhNBTnWEiLCs8MaCDeZeIyptPMihz2KwnE2saUY1FhYJhuk9RBKvRprWX9lFuUbKbt5i0lt8u6Gc/ysEgS1gRLLlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mysuse.onmicrosoft.com; s=selector1-mysuse-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUKfX9FVfthy2w7tRAPEyZ1a9rIxVPHgzXPclsOOFbo=;
 b=VquGpf8eKu9bCX96WolpitU6Mym6aMoIKw657jF2QCEosDD6QQK9yW+BXpYRXcMqwPEz1a+wgSjVFCLAGttc6FIjMFPLyrAK2SoRTPSO0Pup7b0MRlfZt9dxN3ajttAO8aWK4nBgkaJ8cCZ5dWVZU29vW4dyLidSM83bSw7lpzEWdS8MuXC2RefiJzp3NZnoXvsvcSoFEFzpqLeKHvslyQyLnp/Ly6hXrs6MWcGps8yx3jzQGYhrT1HM9hkTm8Gyaf7p8mBWdBbxKyfEnUt4+TAO7cz4wOpHgRw4mWB/T27uEc9CLtjZZUvWEAblB/dyyO1X5/aeOImIOb0zJEFlhw==
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=suse.com;
Received: from AM6PR04MB5782.eurprd04.prod.outlook.com (2603:10a6:20b:aa::17)
 by AM6PR04MB5815.eurprd04.prod.outlook.com (2603:10a6:20b:b0::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Wed, 17 Jun
 2020 10:30:52 +0000
Received: from AM6PR04MB5782.eurprd04.prod.outlook.com
 ([fe80::d848:9dea:7742:a55]) by AM6PR04MB5782.eurprd04.prod.outlook.com
 ([fe80::d848:9dea:7742:a55%4]) with mapi id 15.20.3088.029; Wed, 17 Jun 2020
 10:30:52 +0000
From: Lin Ma <lma@suse.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/3] scsi-disk: Add support for the GET LBA STATUS 16
 command
Date: Wed, 17 Jun 2020 18:30:18 +0800
Message-Id: <20200617103018.18026-4-lma@suse.com>
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
 15.20.3109.21 via Frontend Transport; Wed, 17 Jun 2020 10:30:49 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [114.255.249.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6865d581-2e01-41ae-7863-08d812a98258
X-MS-TrafficTypeDiagnostic: AM6PR04MB5815:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB58158B2F27587C9C1979D46BC59A0@AM6PR04MB5815.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:156;
X-Forefront-PRVS: 04371797A5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rqTie2uj2B0EBnQHYlWSIZV0u4J6/N1zJE9ILbq/1yLwrxiK0j8Yi6rLPhEGfhUa2D7OzwcUZ2QiOytUVWqY5KQsLF7twthFLXsJ7rhhDvoqWmpNV60/pf9ThNzdL+14/MOYhuzUhG/gu1dyzrXIcZrXxex3QSUfOh6nyT9CoxsWSsZi6RDjzU4wpq35ISXnyZ1Y+L29gfTQW/zYb5SOQ6u53KYkr5lY1LUbSvbG21kRbrncH9kWQapozTFidPjkVMBuVS1aguT6TfGpThIiyBDj6bVhmk0RColyjvdj6WOxy8jgKkuwGmXHdHHHCvrARO+swFTvhCbWILPKVk3cRh3cL0jOJ1LieFN1Ci6daElxS/6JEn8End9RFraklDSS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR04MB5782.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(136003)(376002)(366004)(346002)(396003)(39860400002)(5660300002)(52116002)(6916009)(66556008)(478600001)(6486002)(8936002)(26005)(8676002)(2906002)(66476007)(66946007)(6506007)(4326008)(316002)(36756003)(6666004)(6512007)(86362001)(107886003)(2616005)(956004)(186003)(1076003)(16526019)(83380400001)(69590400007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Xa42W8n0rOjYWBG7WlX7dRxhAlJXnEkQzp/Kx4PLc48HKL9rENX79OVk+cuLaxu0UWKUTz6X3PQOD4KH91Kvk8fL5urzYl+SrZur3szGfakmZVPJdoy/5gXN/s7OlS9Fx7gJtCBSIzB6rVxb0KoBZywLGXZkbvf7U+FY9IzUdSvSSXlr6TyScRNWDE4u69pBi2gM8FoVm8oXN5bnCBtEwd9+NQxM6sbJAzHw1SZM5Do276GPQOa2bNJ8NjLFNKQ5749uwIM9BZCjEGoKM5+uvJ4iHjhglsIKVVVC1t+smKPU1rlQtTtwwOQRNPa0AZvIaJa/wVN9o4/LuEk5v8J5T3WQ6Lv/GzsJyz55EYoGvj51Cn4qSLHfIksu3MvhjrjXF1/6+I28LAxSRtvOrEZUqdpHcCnvul/Keag2sZNmwGvVLL1rDFAB/kV0eRUOTf1On9oAAJMxWiaxIHVZLGHfvWaVZAB9tfPM9M8kR9Hjsmo=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6865d581-2e01-41ae-7863-08d812a98258
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2020 10:30:51.9703 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4UqeLKzzLWYMj0923od1u5YkavHC4i5pf6buKaaH7MTKlWF7GecrA38lyl+7svUu
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
 hw/scsi/scsi-disk.c        | 90 ++++++++++++++++++++++++++++++++++++++
 include/block/accounting.h |  1 +
 include/scsi/constants.h   |  1 +
 3 files changed, 92 insertions(+)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 387503e11b..9e3002ddaf 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -1866,6 +1866,89 @@ static void scsi_disk_emulate_write_data(SCSIRequest *req)
     }
 }
 
+typedef struct GetLbaStatusCBData {
+    uint32_t num_blocks;
+    uint32_t is_deallocated;
+    SCSIDiskReq *r;
+} GetLbaStatusCBData;
+
+static void scsi_get_lba_status_complete(void *opaque, int ret);
+
+static void scsi_get_lba_status_complete_noio(GetLbaStatusCBData *data, int ret)
+{
+    SCSIDiskReq *r = data->r;
+    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
+
+    assert(r->req.aiocb == NULL);
+
+    block_acct_start(blk_get_stats(s->qdev.conf.blk), &r->acct,
+                     s->qdev.blocksize, BLOCK_ACCT_GET_LBA_STATUS);
+
+    r->req.aiocb = blk_aio_get_lba_status(s->qdev.conf.blk,
+                                          r->req.cmd.lba * s->qdev.blocksize,
+                                          s->qdev.blocksize,
+                                          scsi_get_lba_status_complete, data);
+}
+
+static void scsi_get_lba_status_complete(void *opaque, int ret)
+{
+    GetLbaStatusCBData *data = opaque;
+    SCSIDiskReq *r = data->r;
+    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
+
+    assert(r->req.aiocb != NULL);
+    r->req.aiocb = NULL;
+
+    aio_context_acquire(blk_get_aio_context(s->qdev.conf.blk));
+    if (scsi_disk_req_check_error(r, ret, true)) {
+        g_free(data);
+        goto done;
+    }
+
+    block_acct_done(blk_get_stats(s->qdev.conf.blk), &r->acct);
+    scsi_req_unref(&r->req);
+    g_free(data);
+
+done:
+    aio_context_release(blk_get_aio_context(s->qdev.conf.blk));
+}
+
+static void scsi_disk_emulate_get_lba_status(SCSIRequest *req, uint8_t *outbuf)
+{
+    SCSIDiskReq *r = DO_UPCAST(SCSIDiskReq, req, req);
+    GetLbaStatusCBData *data;
+    uint32_t *num_blocks;
+    uint32_t *is_deallocated;
+
+    data = g_new0(GetLbaStatusCBData, 1);
+    data->r = r;
+    num_blocks = &(data->num_blocks);
+    is_deallocated = &(data->is_deallocated);
+
+    scsi_req_ref(&r->req);
+    scsi_get_lba_status_complete_noio(data, 0);
+
+    /*
+     * 8 + 16 is the length in bytes of response header and
+     * one LBA status descriptor
+     */
+    memset(outbuf, 0, 8 + 16);
+    outbuf[3] = 20;
+    outbuf[8] = (req->cmd.lba >> 56) & 0xff;
+    outbuf[9] = (req->cmd.lba >> 48) & 0xff;
+    outbuf[10] = (req->cmd.lba >> 40) & 0xff;
+    outbuf[11] = (req->cmd.lba >> 32) & 0xff;
+    outbuf[12] = (req->cmd.lba >> 24) & 0xff;
+    outbuf[13] = (req->cmd.lba >> 16) & 0xff;
+    outbuf[14] = (req->cmd.lba >> 8) & 0xff;
+    outbuf[15] = req->cmd.lba & 0xff;
+    outbuf[16] = (*num_blocks >> 24) & 0xff;
+    outbuf[17] = (*num_blocks >> 16) & 0xff;
+    outbuf[18] = (*num_blocks >> 8) & 0xff;
+    outbuf[19] = *num_blocks & 0xff;
+    outbuf[20] = *is_deallocated ? 1 : 0;
+}
+
 static int32_t scsi_disk_emulate_command(SCSIRequest *req, uint8_t *buf)
 {
     SCSIDiskReq *r = DO_UPCAST(SCSIDiskReq, req, req);
@@ -2076,6 +2159,13 @@ static int32_t scsi_disk_emulate_command(SCSIRequest *req, uint8_t *buf)
 
             /* Protection, exponent and lowest lba field left blank. */
             break;
+        } else if ((req->cmd.buf[1] & 31) == SAI_GET_LBA_STATUS) {
+            if (req->cmd.lba > s->qdev.max_lba) {
+                goto illegal_lba;
+            }
+            scsi_disk_emulate_get_lba_status(req, outbuf);
+            r->iov.iov_len = req->cmd.xfer;
+            return r->iov.iov_len;
         }
         trace_scsi_disk_emulate_command_SAI_unsupported();
         goto illegal_request;
diff --git a/include/block/accounting.h b/include/block/accounting.h
index 878b4c3581..645014fb0b 100644
--- a/include/block/accounting.h
+++ b/include/block/accounting.h
@@ -38,6 +38,7 @@ enum BlockAcctType {
     BLOCK_ACCT_WRITE,
     BLOCK_ACCT_FLUSH,
     BLOCK_ACCT_UNMAP,
+    BLOCK_ACCT_GET_LBA_STATUS,
     BLOCK_MAX_IOTYPE,
 };
 
diff --git a/include/scsi/constants.h b/include/scsi/constants.h
index 874176019e..b18377b214 100644
--- a/include/scsi/constants.h
+++ b/include/scsi/constants.h
@@ -154,6 +154,7 @@
  * SERVICE ACTION IN subcodes
  */
 #define SAI_READ_CAPACITY_16  0x10
+#define SAI_GET_LBA_STATUS    0x12
 
 /*
  * READ POSITION service action codes
-- 
2.26.0


