Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C3FCA9EC3
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 04:10:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92AF920859
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 04:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="DJ9S0SIk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92AF920859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQ1nO-0001nL-H3
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 00:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58841)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar@xilinx.com>) id 1iQ1lY-0000iO-Nj
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 00:08:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar@xilinx.com>) id 1iQ1lX-0001pM-PW
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 00:08:56 -0400
Received: from mail-eopbgr800040.outbound.protection.outlook.com
 ([40.107.80.40]:34256 helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <edgar@xilinx.com>)
 id 1iQ1lV-0001ec-NJ; Thu, 31 Oct 2019 00:08:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLU/y7y/mMl2VDv4S4RnybIgtQhrWdfVWxFAgS5gJTrYTF3E+44c7V6M2bSSp69GPJCLqM2+2DZBMX3g07kj+Py8/Zv8OUmOjyOUrJunx5QauaIgRC+C/UjaBAl3NoFFKBv/49GXmp6Ov1omNVGON9dSiNBpNItKEeRNcgizf4C2jSdjRGVxqT9kzPycA0ZfsH5eObSBZHLv4tsuYvV0hSoseqIgwHBtsCiYBEH/ZqHVdYguxoHT8d6/Z0n3LTZhVXEl9M6x6AZl3gIftuAHT0iN7tQ/JeYFzStWJA143kJmB9MACeAkmvUf1XzPEwwAeonEqFYuMTOLetH+x3vDNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4p/6ZYQQWD852qSusOhdrvDuptbYfzVTqSpfuWY7xo4=;
 b=EeziwvJJEFd+r8yClAw9z52ribFlhSyZDkwzuaY7zh1yQCRBXekt0PKCMMi1k7djzlX6gfUXIOOGHwuU2B/e5Kz6OvYztHP66VbHKYAB1FGdjqMkEXSDH03uZY6IanM80QARoJmvSPK4knpzMpW/g1AeY2x1Sntehhe8V7g3Nnl86rYQnP6CJHtrCeGN/c7RNR4p8ZOH00zpDK4gOjqjQ8jhOe8+pZOCO0jDDLBOZFDL+FiMIsTROqUqIGjFjiaEVVdW+nv/RDH2/PmvRZt1tfZbGp+kStpVasjXS4lE5jqeVTdqwLm7xlM2Ph4pVptIE6lS441D43HSwmGFa8Z7mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4p/6ZYQQWD852qSusOhdrvDuptbYfzVTqSpfuWY7xo4=;
 b=DJ9S0SIk2wUB7T49oBX8/yBaqJnjU+/hcdzTlYGHZg89oGhJZ9dX4nSCLkVJmj4jiaQm+3jhBztzmnDBfXemtxMbJAWkno+XEhhy0bhl9IOCgrMe1tKK1+lbrS7Eb+Bqhmh3+qMMk178fy+ZwQG4Xo4P71s0yS2Ex/bQDNVw7+M=
Received: from BL0PR02CA0144.namprd02.prod.outlook.com (2603:10b6:208:35::49)
 by DM5PR02MB2297.namprd02.prod.outlook.com (2603:10b6:3:59::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.20; Thu, 31 Oct
 2019 04:08:51 +0000
Received: from CY1NAM02FT036.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::206) by BL0PR02CA0144.outlook.office365.com
 (2603:10b6:208:35::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2408.20 via Frontend
 Transport; Thu, 31 Oct 2019 04:08:51 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT036.mail.protection.outlook.com (10.152.75.124) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2387.20
 via Frontend Transport; Thu, 31 Oct 2019 04:08:49 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1iQ1lR-0003br-08; Wed, 30 Oct 2019 21:08:49 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1iQ1lL-0007WP-TJ; Wed, 30 Oct 2019 21:08:43 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x9V48XAe029365; 
 Wed, 30 Oct 2019 21:08:33 -0700
Received: from [10.71.116.27] (helo=localhost)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1iQ1lA-0007Va-PQ; Wed, 30 Oct 2019 21:08:32 -0700
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v1 1/1] hw/arm/boot: Rebuild hflags when modifying CPUState at
 boot
Date: Thu, 31 Oct 2019 05:08:30 +0100
Message-ID: <20191031040830.18800-2-edgar.iglesias@xilinx.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20191031040830.18800-1-edgar.iglesias@xilinx.com>
References: <20191031040830.18800-1-edgar.iglesias@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(39860400002)(396003)(376002)(189003)(199004)(36386004)(186003)(2906002)(2616005)(36756003)(426003)(9786002)(4326008)(76176011)(478600001)(1076003)(2870700001)(7416002)(70206006)(70586007)(48376002)(336012)(356004)(486006)(126002)(476003)(11346002)(446003)(316002)(57986006)(51416003)(26005)(50466002)(76506006)(50226002)(8936002)(107886003)(81156014)(47776003)(5660300002)(305945005)(8676002)(81166006)(4744005)(106002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR02MB2297; H:xsj-pvapsmtpgw01; FPR:;
 SPF:Pass; LANG:en; PTR:unknown-60-83.xilinx.com; MX:1; A:1; 
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 762d2dab-a1a9-488b-e59d-08d75db8089f
X-MS-TrafficTypeDiagnostic: DM5PR02MB2297:
X-Microsoft-Antispam-PRVS: <DM5PR02MB22975FBD749CB0EDB15E5D07C2630@DM5PR02MB2297.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:454;
X-Forefront-PRVS: 02070414A1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ESFOXOPBqQE7v9Ss43O0UMFjRJUA3Jw7SNOOJGwRjBxjyA5G3x3B19aNSMO/XROvtyzVXSDOs2dSZ4iB2LOsbA5KILz3I1FFUYl/72rMqh/hmR1ilnRH9EYDvo0Pj8U8MBMBczcwJCjsTXG72FheYyv5PjBpLX2n94ivfjw00+tcG2z94A1RCPvuC3A/sprk+N1TIqUa0R/4T9HdW1a8cct+hywCwFPQe8B2Lsp5rgUs8G5WvrO6Wy2ey2mFZ+OREY1FKyGc38InHDIk4+Dbv3uJf/5sgUIxkuqSm5gsrKcZz1ipCIqmsxKAuL5vga7D8IdK98g0t8yZK9CIaXNKHCF28gu/F6Tj1DGG9kaYugoK7wkMokvIXD+kQf5rVKSSLYui2zXvwfLzX8VvPzX5rX1kEBNeuy7ksL3kgfeUwGt3zenyakcA7737RU3iWXEp
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2019 04:08:49.4835 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 762d2dab-a1a9-488b-e59d-08d75db8089f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2297
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.80.40
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, philmd@redhat.com,
 luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rebuild hflags when modifying CPUState at boot.

Fixes: e979972a6a
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/arm/boot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index c264864c11..ef6724960c 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -786,6 +786,7 @@ static void do_cpu_reset(void *opaque)
                 info->secondary_cpu_reset_hook(cpu, info);
             }
         }
+        arm_rebuild_hflags(env);
     }
 }
=20
--=20
2.19.1


