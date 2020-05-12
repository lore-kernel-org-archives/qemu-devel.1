Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC682C2D0F7
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 20:19:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 839DF20740
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 20:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="sjO/PEua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 839DF20740
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYbNU-0004s9-OP
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 16:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1jYbKj-0002Qm-NK
 for qemu-devel@nongnu.org; Tue, 12 May 2020 16:16:59 -0400
Received: from mail-mw2nam12on2067.outbound.protection.outlook.com
 ([40.107.244.67]:36160 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1jYbKi-0003gG-IC
 for qemu-devel@nongnu.org; Tue, 12 May 2020 16:16:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=St234ZFwmRTKb9DQPj0cF4f6LltozUszUNHgWEe1J69gNOHngjet5NM/35FxWtJKEdkGo5iZkxfAJy2pg+kUBwyHlLLtABfNkSOZxagNoGEVHYIpQW5gboE6RdacCI9bCEddgMJF5pZGMAX0Zt4/vLZil0P5c9Z2zwbekiToEi4G72Ij+2q3mjRf2Ni8UL8xvl25fw8H0hL2ZkoHso8ymHdIIu/ANagknGYFPEyirAWHx/QWUHmdVMeXG5IcawmXzplNTJ6l2uVSUVnUTFKCS0T3f73erKEv2hbn44hYrhCXXxQS9uVIhdUzBlHFPf/h/wUR6vclSVCPwOUhIiDXyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0QO4C5oW/aan808kX0urBc5VeHCAlQxnRT8ntGtnUY=;
 b=D7nUsH0e8ruuOZA05hm0wjm2b72BtgW6bdtnMf0y6PWGYd9lPXe56jBPMwjEaIG3e4XbWq5R5N7MdQVORP8S7IzHQvm/7g7Yawr2zclhsRpUwubnBVjbBcbjyonH96ZWpg2HIJyBr/NDlBbOaQEa6b/MGrb/UHRH7EVwtT/h4CmU6U7+nLx9jLIOYTIIaFh/LZpvprDIBJcS428BgvJcWZ/d8JV3U6td/ZHi+jqJ+PDp+vOf31jIn9C0OOcNCC+f0I+iJhVNCreCRXkKb4xe06CtQWXRWu/gk/1h9bRVuBCdLgBjGsDd19piiwq3VoTcpfJnzl4olq0qqbhd8qL71w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0QO4C5oW/aan808kX0urBc5VeHCAlQxnRT8ntGtnUY=;
 b=sjO/PEuaBvS3MtYSy5Gte+RP/nMWvtkVCIzBpXBgscpmmmFNJuziwdlv+73a4PlsNyfu6+gfZwpegdiO0irTp4SBsvIXR9FgurTxdQrmjpAgoZLA34e2S734fnWv6CUG2sYD6a0q8Gs5Dc5CiPEO6GJUbswDk783QjnOVnATeAE=
Received: from SA9PR11CA0013.namprd11.prod.outlook.com (2603:10b6:806:6e::18)
 by BN8PR02MB5874.namprd02.prod.outlook.com (2603:10b6:408:b9::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Tue, 12 May
 2020 20:16:53 +0000
Received: from SN1NAM02FT042.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:6e:cafe::1f) by SA9PR11CA0013.outlook.office365.com
 (2603:10b6:806:6e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend
 Transport; Tue, 12 May 2020 20:16:53 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT042.mail.protection.outlook.com (10.152.73.149) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Tue, 12 May 2020 20:16:52
 +0000
Received: from [149.199.38.66] (port=35404 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <fnu.vikram@xilinx.com>) id 1jYbKN-0000VC-W2
 for qemu-devel@nongnu.org; Tue, 12 May 2020 13:16:35 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>) id 1jYbKe-0006Ax-Kk
 for qemu-devel@nongnu.org; Tue, 12 May 2020 13:16:52 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 04CKGkDf021618; 
 Tue, 12 May 2020 13:16:46 -0700
Received: from [172.19.2.115] (helo=xsjfnuv50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1jYbKY-0005zy-L7; Tue, 12 May 2020 13:16:46 -0700
From: Vikram Garhwal <fnu.vikram@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 4/4] MAINTAINERS: Add maintainer entry for Xilinx ZynqMP
 CAN controller
Date: Tue, 12 May 2020 13:15:52 -0700
Message-Id: <1589314552-1375-5-git-send-email-fnu.vikram@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589314552-1375-1-git-send-email-fnu.vikram@xilinx.com>
References: <1589314552-1375-1-git-send-email-fnu.vikram@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(346002)(376002)(136003)(396003)(39860400002)(46966005)(33430700001)(316002)(36756003)(70206006)(7696005)(6916009)(9786002)(82740400003)(82310400002)(478600001)(47076004)(70586007)(81166007)(356005)(33440700001)(2616005)(186003)(336012)(26005)(426003)(5660300002)(4744005)(8936002)(2906002)(107886003)(6666004)(8676002)(4326008);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86d1dead-231d-431f-64b0-08d7f6b1691b
X-MS-TrafficTypeDiagnostic: BN8PR02MB5874:
X-Microsoft-Antispam-PRVS: <BN8PR02MB58743561C1731A64B9A76E9FBCBE0@BN8PR02MB5874.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:331;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nWVVt0u5DFzfQC6ucFX0lBFxWB4Zpt3vRp99hC2+dWaWgnO26j9lYpUiI8jlcPujMvKXJ3zRGyfI3u96hN7Wv3PbtZkXrFTXLkDsYN+cSieNbr2QhuwY+3LWygQD3QgpyPb2z2NrPXpkjW23oEe882VgiMkRoffgPiQubuiMvSEYGiqJ7ekequZtEMx7T3ucpVu5xDJA1Czt/Otpioco/qD5m8XLdiqiWziSJ20ZBIcuH6e0covlp4WGHL1CZdPly0pp4Pmp/Swklsl3165FclvE5TRRfCCZDqzkMSHoLfczFeUGGGdyreTGGDKmthYQP84CZly+Oa+d0UgzGUbOf80gAJnPo0A7xYkfoNMpmgW3rygiGc12AoQlq4lFM4Qn4fLgPnBxIP26oXJ+MU7Qi8g4oZvK9gHUPMkaZswruaXdxR95e8R6v0ngBQQbKgeQSWj9xiHdwDlLlr19iL7Lv6bKM0NF1IVd/Fjr0AYyR/vOj5/K3D3uoPHP9aAw/i9g85caprggTeceNCikoSWC/n8NRd8f4oNwM9RGAZVHYVidW7AHhmupcP6DL72dBNv2AKlNGigkbo0EAJvj/sftBA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 20:16:52.9231 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d1dead-231d-431f-64b0-08d7f6b1691b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR02MB5874
Received-SPF: pass client-ip=40.107.244.67; envelope-from=fnuv@xilinx.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 16:16:55
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: francisco.iglesias@xilinx.com, Vikram Garhwal <fnu.vikram@xilinx.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Vikram Garhwal <fnu.vikram@xilinx.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8cbc1fa..b53d75e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1433,6 +1433,14 @@ F: hw/net/opencores_eth.c
 
 Devices
 -------
+Xilinx CAN
+M: Vikram Garhwal <fnu.vikram@xilinx.com>
+M: Francisco Iglesias <francisco.iglesias@xilinx.com>
+S: Maintained
+F: hw/net/can/xlnx-*
+F: include/hw/net/xlnx-*
+F: tests/qtest/xlnx-can-test*
+
 EDU
 M: Jiri Slaby <jslaby@suse.cz>
 S: Maintained
-- 
2.7.4


