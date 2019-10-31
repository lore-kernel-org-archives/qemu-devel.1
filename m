Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE36ECA9EC3
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 04:11:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6E7A20859
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 04:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="DjsWHixn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E7A20859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQ1nc-0001wB-Pr
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 00:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58779)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar@xilinx.com>) id 1iQ1lP-0000f8-Vk
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 00:08:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar@xilinx.com>) id 1iQ1lP-0001IH-1h
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 00:08:47 -0400
Received: from mail-eopbgr800043.outbound.protection.outlook.com
 ([40.107.80.43]:14016 helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <edgar@xilinx.com>)
 id 1iQ1lM-000124-Hn; Thu, 31 Oct 2019 00:08:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Brg1DOljVuTJviUTY/03RFHYFTPo602NSiTqecPImzAo05FbW3RJCgPnY/+nZVXHxRYDYcdmjVr0DDaPzwlOfW2a7hLI6tyookgFNmPT7ywSmep7Nyt2almb8ZJRh+QmX6FoNXPBFXsuJkH6IXRNKFrydzIQVGSB4PwW9a3/TGeKkbWg7rlKRq6yXGq+MEgwqd4b7pEKTw9DCnzYFhC7Lap/0L19ao9rZxRFdRGgSMH7rXWht4E+KU8kW6WHXp284P0VlB+iC1AOkvUBLOqK2N0CNrguJpTk3n55LxrOx5VdSpcw3KFKl7aoezmrvnHzphAIJAd0AOUWe500HWLINQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOmClXhtyMiHcrnLMQUjKdU62BxVnSIwyNgO1KaHqy8=;
 b=CmjORyW2m/JvL5pinJvSg8vfbP3GS9JziLJqbUkddqUJcwNQgzc2MLKxRE9pxXeqUSTeAo7rAWQykaAeN59+OwB64Wvnhf1kYW8sG4f6ySTIcDZMumGgXgwSr47CXi+k9PCmwD5Fo97AZd5+qOAPHH9wNflzwknaMRakj2BSsN7vuqgKi8/mblkZtfoO17KbVKd3UIuwnoOjh9IPZprezArbNxioxchp9QC2DxkdgPiX6ZmBZUDqGQBf/nom2TFYfsaWv35PkazLnyyQdcE2sbN/mxUytNis3aP+H0/xQ4wbOdv2fSwrBrlstisjXX9pDKaWW3SzFLIr18lCg8X+AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOmClXhtyMiHcrnLMQUjKdU62BxVnSIwyNgO1KaHqy8=;
 b=DjsWHixnhpPfUZVfoK099/UPCIPyjl1sxA1Feq4VbmXbl4yC5uUR/w6Mi08SOpFhIj+2uLT3BR33I4hJXs6wBrmcHQPHakYZCBIbDnqjnQ/L0SrhmRXonjM6nCI6Jm1icB4xakm19om6SmVunCxe3nZ/W1y16+xDpgdNLU/C+Uw=
Received: from BL0PR02CA0096.namprd02.prod.outlook.com (2603:10b6:208:51::37)
 by BYAPR02MB5317.namprd02.prod.outlook.com (2603:10b6:a03:68::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.28; Thu, 31 Oct
 2019 04:08:39 +0000
Received: from SN1NAM02FT063.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by BL0PR02CA0096.outlook.office365.com
 (2603:10b6:208:51::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.20 via Frontend
 Transport; Thu, 31 Oct 2019 04:08:39 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT063.mail.protection.outlook.com (10.152.72.213) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2367.14
 via Frontend Transport; Thu, 31 Oct 2019 04:08:39 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1iQ1lG-0003bl-Qv; Wed, 30 Oct 2019 21:08:38 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1iQ1lB-0007Vn-NV; Wed, 30 Oct 2019 21:08:33 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x9V48Vwm029359; 
 Wed, 30 Oct 2019 21:08:31 -0700
Received: from [10.71.116.27] (helo=localhost)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1iQ1l9-0007VU-CZ; Wed, 30 Oct 2019 21:08:31 -0700
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v1 0/1] hw/arm/boot: Rebuild hflags when modifying CPUState at
 boot
Date: Thu, 31 Oct 2019 05:08:29 +0100
Message-ID: <20191031040830.18800-1-edgar.iglesias@xilinx.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(396003)(376002)(39860400002)(199004)(189003)(426003)(1076003)(47776003)(336012)(476003)(126002)(486006)(106002)(316002)(7416002)(305945005)(107886003)(4326008)(51416003)(48376002)(50466002)(2616005)(478600001)(26005)(57986006)(186003)(50226002)(8936002)(5660300002)(36756003)(9786002)(8676002)(81156014)(81166006)(4744005)(2906002)(70586007)(2870700001)(36386004)(70206006)(356004)(76506006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR02MB5317; H:xsj-pvapsmtpgw01; FPR:;
 SPF:Pass; LANG:en; PTR:unknown-60-83.xilinx.com; A:1; MX:1; 
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 825427a5-8f7a-4306-a14b-08d75db80287
X-MS-TrafficTypeDiagnostic: BYAPR02MB5317:
X-Microsoft-Antispam-PRVS: <BYAPR02MB531795353F0411650BC4B2D5C2630@BYAPR02MB5317.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 02070414A1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pO0cK7j0VRQXEcgHnjXfnCLdYHW8LPoRhXA2d0I0pERB6J8ojmW0M6rckAyZoAeOFLozxvvXAGXPxkC6D3OZfproI/GMwqcWqMLPRltxQZkSKCgMinvEoB+GUGKG9vBwLVC+vT96Krr8D4MwK80GY7NVFhyAVVkD5iQiv709wzyr4o1NOCxup1zjLWm01++nrVq1YoKtJLSWphw1HktDt5yNwhMhoD6kAAqlMHWVV1GXcvMw0nujjMkG0KKOESCXSwKfcYymBRoiGyzevfbo6ocApi8DU5d9aANEVkPeFUlMawrfVp6xx+kQBgTxAi+1MJr9Iv26ewdE7hag88vWxJTBAcghTBA6VlZ08NqZOvvTnBQ3rsL21FoLJJaB5JmCuLKmIbBp+eEUpoWODgnZkHq+Nxs8Am6qPvMxMut9LBkni2XT+sUXwhtarXHcsQsK
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2019 04:08:39.2892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 825427a5-8f7a-4306-a14b-08d75db80287
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5317
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.80.43
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

I'm seeing asserts with missmatching hflags when doing direct boots
on versal. This patch fixes the problem for me, rebuilding hflags
after boot code modifes the state.

Cheers,
Edgar

Edgar E. Iglesias (1):
  hw/arm/boot: Rebuild hflags when modifying CPUState at boot

 hw/arm/boot.c | 1 +
 1 file changed, 1 insertion(+)

--=20
2.19.1


