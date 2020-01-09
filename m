Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C856C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 21:33:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 389A32067D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 21:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="neHdSYl2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 389A32067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipfQR-0006vW-8g
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 16:33:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44622)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tongh@xilinx.com>) id 1ipe8B-0004p4-BK
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 15:10:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tongh@xilinx.com>) id 1ipe88-0001mJ-VY
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 15:10:09 -0500
Received: from mail-bn8nam12on2063.outbound.protection.outlook.com
 ([40.107.237.63]:17594 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tongh@xilinx.com>) id 1ipe88-0001fK-Kw
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 15:10:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ei4QH6osrkBaKAI8m8AtawBGG4zszrmwlhhY0nCerHcUcH75MV7vPam9w65XIbxFWH2OAe6TnOTA5wMwFh7IV3ITUvkWQL3mgROK4KiIms0B3GyVuCcG7qWNFFigGnUnYOrGAAbPa1sTq/29+A2HvSSvCSRnZlrcpBohikxhGY8KumnGXL9GTAUocibYDk9xVE73Jb4IctU4G6CQ+Wv9LX6wGV5sbPq2mH2HFPdvxoup/HzApEUdtac5ZOBLs56di9+nk67C4f+MuC9CVmCn2jJE8Hd5mzkWFhobWLX2WloUXwNy1A1Lv2zl904gyERQzqP1ZB6mW889fee1ym9Hww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04qezzEP62Z37luar5KuKu1tJbrKUxZlJJRjIabZV/k=;
 b=MASi5BSD3xVLPF0g7FkigkYR4DYhWn75ekVEMVVDVntG0fqPMowdkU7JB3EiJss4gQsovJ5sV5ZmT5tYQZ2kqAl5zmKPI07AKqXSYWZXW2XIzOB1IQiD7BG2CRXpU6N+xeKfFTcsyLon+Hqc4v+Kwf3l8LeBTAS7z7OxCC0WoJGPDtddnI9jgjIAJq3ygkm7mt1BpKbNWbqCtfvkHhMSrT6hFi7HrQjfgBpUFTCtxeWm+/2IPwJo6RiqfBIHxsnEXB9wjIzQK7WymNk/MTutrj/Fv5q5B60SD9WMRRSF2ZAgxI51x2TDxudwctT228kEJP440CPQTuujw0j6vWthdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=redhat.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04qezzEP62Z37luar5KuKu1tJbrKUxZlJJRjIabZV/k=;
 b=neHdSYl2Op09t8lGVvdwqN1gsxeGbmMYwW7uHFyj57mcYZ+3dLZhp97PlGRvm0V8xaMna+nW6pmJ5aAagwBNUkyL4y61gm3lmDOlFfS0UkkUkDicPCTePQj2O4qUS06OqWupNlHC9kqgWEg+nDkptYqoEJoTB1vMPM0mNkprL+I=
Received: from BL0PR02CA0108.namprd02.prod.outlook.com (2603:10b6:208:51::49)
 by BN6PR02MB2321.namprd02.prod.outlook.com (2603:10b6:404:29::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9; Thu, 9 Jan
 2020 20:10:06 +0000
Received: from SN1NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by BL0PR02CA0108.outlook.office365.com
 (2603:10b6:208:51::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.11 via Frontend
 Transport; Thu, 9 Jan 2020 20:10:05 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT040.mail.protection.outlook.com (10.152.72.195) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2623.9
 via Frontend Transport; Thu, 9 Jan 2020 20:10:05 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
 (envelope-from <tong.ho@xilinx.com>)
 id 1ipe84-0001pp-GJ; Thu, 09 Jan 2020 12:10:04 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <tong.ho@xilinx.com>)
 id 1ipe7z-0001Y9-Ci; Thu, 09 Jan 2020 12:09:59 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 009K9wXF017826; 
 Thu, 9 Jan 2020 12:09:58 -0800
Received: from [172.19.2.40] (helo=xsjtongh40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <tong.ho@xilinx.com>)
 id 1ipe7y-0001Y6-Az; Thu, 09 Jan 2020 12:09:58 -0800
From: Tong Ho <tong.ho@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] crypto: fix getter of a QCryptoSecret's property
Date: Thu,  9 Jan 2020 12:09:58 -0800
Message-Id: <1578600598-335744-1-git-send-email-tong.ho@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(39860400002)(396003)(346002)(199004)(189003)(4744005)(81156014)(6916009)(4326008)(8676002)(81166006)(70586007)(70206006)(2906002)(36756003)(44832011)(8936002)(478600001)(426003)(316002)(2616005)(356004)(7696005)(5660300002)(336012)(26005)(186003)(9786002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR02MB2321; H:xsj-pvapsmtpgw01; FPR:;
 SPF:Pass; LANG:en; PTR:unknown-60-83.xilinx.com; A:1; MX:1; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a1b3f5a-2dca-4c1d-3dc9-08d7953feaf4
X-MS-TrafficTypeDiagnostic: BN6PR02MB2321:
X-Microsoft-Antispam-PRVS: <BN6PR02MB23219987A913438A5BEDE1C2CD390@BN6PR02MB2321.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-Forefront-PRVS: 02778BF158
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 52xZNjqvIiiD3KdTMvlBINFQ+LtKjlxZWsuRywk5IvJ4Ff1FxbHv2wM9HPNnqL/42YRXM65bpAsCv8FK3w5g0vQe/sVKcnbGKhcdQd2v6hDOXu+po3ljwW9KZlBoEbM7f8lU4cdlLrettJYpXmC2PDCMTK9TPWw6I87p4U29rxmrMm2Q+1n+TsUH4psF4eHDlBsq6u3vb8aQTChuGvNBdFEx80jlxlPnbiHp63aSvyliOdFaZ1tYBXONX9Tyg0Lpuu42WSPmt/+2b/hnkwhwVbBTzzR9lBCJOW14PNJxImYoJU4zG9FnJ0q3Hl3u6HsOdnZ4ql1UHjZFxxuDwdFRHxVXRik2b/W8F1TptzH6uaW3E02Kgh88bA02q7TVysjlAqs3tqXcbhxo4Z8ZMmPvC8zzIS/Pxl+bUWo4i4cSn8Miw6GcTq0B6glhN2UNmfTR
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2020 20:10:05.1626 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a1b3f5a-2dca-4c1d-3dc9-08d7953feaf4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2321
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.237.63
X-Mailman-Approved-At: Thu, 09 Jan 2020 16:32:05 -0500
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
Cc: berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This fixes the condition-check done by the "loaded" property
getter, such that the property returns true even when the
secret is loaded by the 'file' option.

Signed-off-by: Tong Ho <tong.ho@xilinx.com>
---
 Pre-existing getter returns true only when the secret is loaded
 by the 'data' option.

 crypto/secret.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/crypto/secret.c b/crypto/secret.c
index 1cf0ad0..5fb6bbe 100644
--- a/crypto/secret.c
+++ b/crypto/secret.c
@@ -221,6 +221,7 @@ qcrypto_secret_prop_set_loaded(Object *obj,
         secret->rawlen = inputlen;
     } else {
         g_free(secret->rawdata);
+        secret->rawdata = NULL;
         secret->rawlen = 0;
     }
 }
@@ -231,7 +232,7 @@ qcrypto_secret_prop_get_loaded(Object *obj,
                                Error **errp G_GNUC_UNUSED)
 {
     QCryptoSecret *secret = QCRYPTO_SECRET(obj);
-    return secret->data != NULL;
+    return secret->rawdata != NULL;
 }
 
 
-- 
2.7.4


