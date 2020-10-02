Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C639C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:09:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C54C206CA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CMKF5BsM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C54C206CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOMgf-00008R-FB
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 11:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Wei.Huang2@amd.com>)
 id 1kOMXO-0005Uw-EW
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 10:59:58 -0400
Received: from mail-bn7nam10on2077.outbound.protection.outlook.com
 ([40.107.92.77]:50528 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Wei.Huang2@amd.com>)
 id 1kOMXM-0006CI-NE
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 10:59:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IhaKZhMCt4h3h4Sb1cSX+pKEbWEBxWpj51scaTaN03vO7krs40VcciquSbqKaYxICN3XrW4q+fPM/ARW5OXlY2Qckq/QCi+XlThLIh6SPhoNYzBvWq+rpIx2JzT/I5XAkrC31jDHIW+2gXa4hPoOInNRjZbpPhon89RECAhUwzUeaaRO11F8U5Voz3y3NCw+mnuvc/UKbGUj4L3vEazKlaoHdZ6CZUs0UxJygRKlwDtCIpw5GvAotOXVp5i/1A0Q6i5CAVFqZGTY0iQUpQOGJh6Z1+D6/YKz9SdpN3u+u5p1F8xDKeijOTTGWtj2LqQW/v1qLqk8qUJ2cevoIjFdFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufXSfNLuDA+88ggWI+naxgMz3ft9A/R0XgNdIHw/Qlg=;
 b=ekp1KMfyjoJFzsfAtaIktFckQIg+WrewftldLnjoHljgg1IvMvWSh4xjD1mGcK6SQqb3VYz+Sl+ajSTCRqG54QURTWDFevEA8OtIC8vT2DTMQ6ldiJbcEmhll50mEguhhu5veopilZ4YVpGehmdkryBTvroQ1D4+40OYFNfD9r++0bG+wp1Wyh5zWREWZNzgdHT/ffXWs8DOJXqE0jOpqUSVN7h8tdIAgeAu6AGXb2KMjtuCXuIl0As5dDiscqtUqMAb0oN5Y6cFyL8OVxVVkFkNiemsjxWT189Hp4LhctZI972UNG2MFh+e/g5PqkI8zVEyabY188SsYQbtcAcj0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufXSfNLuDA+88ggWI+naxgMz3ft9A/R0XgNdIHw/Qlg=;
 b=CMKF5BsMXMhqhvNO/tSXFBzUN4u/ho76nSZCpWoXAt+zHPJPCmc2uYZSQ51JFHBHbl+DVzMfxBtsr8y+L1cYFAH4GK+LLK3ODF6v9p7f7PGzEA6XFw00YGpstURYBmXmg3NuVY7j3f1InBwmuTbPYKWPv6PG8gt9oivk4TuRdCo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1494.namprd12.prod.outlook.com (2603:10b6:910:f::22)
 by CY4PR1201MB0149.namprd12.prod.outlook.com (2603:10b6:910:1c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.39; Fri, 2 Oct
 2020 14:59:51 +0000
Received: from CY4PR12MB1494.namprd12.prod.outlook.com
 ([fe80::11f9:59c8:16c0:7718]) by CY4PR12MB1494.namprd12.prod.outlook.com
 ([fe80::11f9:59c8:16c0:7718%8]) with mapi id 15.20.3433.038; Fri, 2 Oct 2020
 14:59:51 +0000
From: Wei Huang <wei.huang2@amd.com>
To: qemu-devel@nongnu.org
Subject: [PATCH V2 3/3] amd-iommu: Fix amdvi_mmio_trace() to differentiate
 MMIO R/W
Date: Fri,  2 Oct 2020 09:59:07 -0500
Message-Id: <20201002145907.1294353-4-wei.huang2@amd.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20201002145907.1294353-1-wei.huang2@amd.com>
References: <20201002145907.1294353-1-wei.huang2@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: DM6PR03CA0046.namprd03.prod.outlook.com
 (2603:10b6:5:100::23) To CY4PR12MB1494.namprd12.prod.outlook.com
 (2603:10b6:910:f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx56bbhost.amd.com (165.204.78.2) by
 DM6PR03CA0046.namprd03.prod.outlook.com (2603:10b6:5:100::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.32 via Frontend Transport; Fri, 2 Oct 2020 14:59:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9b6917b8-6445-4767-d8c7-08d866e3d07b
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0149:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB01490158C44B64BC6A3B859FCF310@CY4PR1201MB0149.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:155;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Uw5A8UQl+64BoStkw/XKIHtDFE/w0LthRs3ggCIYgfaBzFksKA1yVwPjDKDmi95KGLa3bkIFFjkV79UHC3kA46lIRE4Qon74LSL2KrnDPOk2imA9tXibW+4wwog4mSwHEGrliyCzSG9dNTwjxj7yXnt2WZ+m4kHJ1cHzuuug01ZgBA2+DjcgtFbYjrPSGRTQcQGOJ5kmtcG09s8KE+fbW62eJrT/Fg/wFOcZ8/zOvm0x5jUj6hh0UbMFVFiY2swEvjnwVD8Hy7TaCHQgFpxK3NbYpAGAt90a1s2ubrr7Tf19ZR3JddKaXmjN/uVMn42tuAD4I9dnFxJSxKJZovwyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1494.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(66476007)(8936002)(66556008)(66946007)(956004)(8676002)(2616005)(316002)(83380400001)(4326008)(26005)(86362001)(52116002)(6666004)(1076003)(478600001)(186003)(36756003)(6486002)(2906002)(16526019)(5660300002)(6916009)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Tyvw+Qm19dG5zH9jL5OTdnTtZqxWNzZM6NSPo4uhFQd78Rkvw0wAveFaN45hhyAvJt3QijeTsLV0yAcT284s/Syy8s95rgClC6p4bmh2PY5nDhNaR9sLBwZ84+H8Pe9XfZx/iSlPuosM6CkD4XNQRfPSw3A3dYJ5yJ4Nxg8TOXAfreQEbTtGqjG3KNCdwnkqpEabU0b3Gj15Ya3yK+Bsmqcp88BO7AKQzQGSAfpG2HVo/p9zZbThiNoL/OOTyNgBesGGOITjqoIbciqCZIk2waAWRHQemYq1zUfUn0PohZeHNTf0sptXF0ldSs03JO08EMLFk8vxNJD4KJKF9gaavau7na14sMttXtgEMQiC/4sv/jG3oCsiDC22vY6dj+XuTcEZE3gVM9wv8tGBwZkr0w7mktTHnsJRBCc9Bur8GmhuI2RuNNSGRgscxOUWTzi4bzP3BgKIMJwbq1pzWBq+SH9TCwr4IgWoTEMb621+O2vBUr3EYRLaS0h6Tq+WtbOTpzcRbFJrV8K5kA0ooeUd8y93937LzRhpAjInPreuZBqFTUYqTHKZdkKjPsfojayC/dTGkIiWWjNzmpOFlrfs6SZ44vh7dQp+6OIo5pWm+vopKvIkLB7mWsVQ5+T4OqRg2MK29NicFP/bAbxj8jM/Tg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b6917b8-6445-4767-d8c7-08d866e3d07b
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2020 14:59:51.6620 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hyQ8qSXXd35P5+Thi2vvrtOpU2Nr/EL7vHdu+viKuDr7XQkpjtZDpb/ft5vwCCwe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0149
Received-SPF: none client-ip=40.107.92.77; envelope-from=Wei.Huang2@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 10:59:52
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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
Cc: ehabkost@redhat.com, mst@redhat.com, wei.huang2@amd.com, peterx@redhat.com,
 alex.williamson@redhat.com, pbonzini@redhat.com, Suravee.Suthikulpanit@amd.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

amd-iommu MMIO trace function does not differentiate MMIO writes from
reads. Let us extend it to support both types.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 hw/i386/amd_iommu.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 7ce68289d20c..914368f0e4b7 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -662,17 +662,28 @@ static void amdvi_cmdbuf_run(AMDVIState *s)
     }
 }
 
-static void amdvi_mmio_trace(hwaddr addr, unsigned size)
+static void amdvi_mmio_trace(hwaddr addr, unsigned size, bool iswrite,
+                             uint64_t val)
 {
     uint8_t index = (addr & ~0x2000) / 8;
 
     if ((addr & 0x2000)) {
         /* high table */
         index = index >= AMDVI_MMIO_REGS_HIGH ? AMDVI_MMIO_REGS_HIGH : index;
-        trace_amdvi_mmio_read(amdvi_mmio_high[index], addr, size, addr & ~0x07);
+        if (!iswrite)
+            trace_amdvi_mmio_read(amdvi_mmio_high[index], addr, size,
+                                  addr & ~0x07);
+        else
+            trace_amdvi_mmio_write(amdvi_mmio_high[index], addr, size, val,
+                                   addr & ~0x07);
     } else {
         index = index >= AMDVI_MMIO_REGS_LOW ? AMDVI_MMIO_REGS_LOW : index;
-        trace_amdvi_mmio_read(amdvi_mmio_low[index], addr, size, addr & ~0x07);
+        if (!iswrite)
+            trace_amdvi_mmio_read(amdvi_mmio_low[index], addr, size,
+                                  addr & ~0x07);
+        else
+            trace_amdvi_mmio_write(amdvi_mmio_low[index], addr, size, val,
+                                   addr & ~0x07);
     }
 }
 
@@ -693,7 +704,7 @@ static uint64_t amdvi_mmio_read(void *opaque, hwaddr addr, unsigned size)
     } else if (size == 8) {
         val = amdvi_readq(s, addr);
     }
-    amdvi_mmio_trace(addr, size);
+    amdvi_mmio_trace(addr, size, 0, val);
 
     return val;
 }
@@ -840,7 +851,7 @@ static void amdvi_mmio_write(void *opaque, hwaddr addr, uint64_t val,
         return;
     }
 
-    amdvi_mmio_trace(addr, size);
+    amdvi_mmio_trace(addr, size, 1, val);
     switch (addr & ~0x07) {
     case AMDVI_MMIO_CONTROL:
         amdvi_mmio_reg_write(s, size, val, addr);
-- 
2.25.2


