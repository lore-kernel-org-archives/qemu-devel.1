Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB2FC2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 08:13:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A7AE2071A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 08:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A7AE2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY34A-0008Gi-Dm
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 04:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d0u9.su@outlook.com>)
 id 1kY32Q-0007f3-D2
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 04:12:02 -0400
Received: from mail-dm6nam11olkn2016.outbound.protection.outlook.com
 ([40.92.19.16]:16736 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d0u9.su@outlook.com>)
 id 1kY32L-0001V4-Ef
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 04:12:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFXvsxr7HvKLzDw/9VNGi7+YOyy6aM9DVVovOBCe02f0B1hdkDYq6SyFQC0zQhpcHCgAGyqRdGoVFIQRWwZePfsZxn0MePMOzPcu+slfdozEAzRw573ApF7iXHZ2P1RLId/kaOXYKGu+u/ZmzsHL8hq59PZV1U3o6ASxhBENWXOOVRxEOPh7rHmJJecjqbc8MDNHnG6eogM6ZGJ34V0Qhrp+TJVWVzd7M9HwrUFnlP37eMzSWaAcDdoHBUKuiGFKbsvAi0NqO/sbgV14+l88pC8FyBOYFduLXh3ufjMEZh6VP0GAA0GtzH2tbI9Lq/4ZQdEJ08oLrE0M67AWYoe9eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtL3g4Lde5pKJ4YfPTLpLWxVrsqfo1BMpzvlNaD/mk0=;
 b=jg9PTdrFRwD+9JO3Dubkdj15M7kV8feRCwsmfJE5PZ6xWv5PXfguxaScWDmd2C2FOn0SM2wecpeDZWPcaQSAJ2BDm+fJqyBvDEM4sm+IlBGDNe1Tg0kt6R4vVajG310/eRDo/0+qXbSmcNLEKwdWwUn+fujzGf6cPpZS8ac0AuFL/h+98yflxd9wtiVD6df5T7HlAQ+mHV60H5PWuCZBq8QoIlYR15HlgSg/XaS0NvjYZnPnk/8mSCTcgsm4X1p8u2FLb4GspkJA+mEQKvtKHY9p3I3EVHm4b6zgbo3sRToFL6+oBSQZJ0/FDL3ZuZAbFHfgaCL93QskwoVymfTSOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtL3g4Lde5pKJ4YfPTLpLWxVrsqfo1BMpzvlNaD/mk0=;
 b=OWtfmRobm7ispJR52C24PrG+tOLJ1R+DOGoUiVVAlxEpVeRhZ5UhfTBPzS0Gtuv6gg0zHs3gSRPqMRN6XIx+ZURSHhznVpsZe3NbPN5sXlR1dzUM1Q9MjbkIWQdHPP4vhTaICKUZdaOcAERfh/AjFf30/Dka2Z49gqG4gkZ182lIqOtgqVwPmgfd38tN27lAv2EaO8wVERh0p1WrdtzAyBAM3+sBVE4MwRfGtH6SM1WOgYf06y/k2MwNKGyy+yR28vhLPw8Usq3dLnXtF/lsR+/8HwaV0yNzfUPpDRLUKALNIFEOmxnURGnQIlcrOrSkEZC87yfo7L4Jwzo4dkcqFg==
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:fc4d::42) by
 DM6NAM11HT009.eop-nam11.prod.protection.outlook.com (2a01:111:e400:fc4d::211)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Thu, 29 Oct
 2020 07:56:52 +0000
Received: from BYAPR11MB2664.namprd11.prod.outlook.com
 (2a01:111:e400:fc4d::52) by DM6NAM11FT067.mail.protection.outlook.com
 (2a01:111:e400:fc4d::76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Thu, 29 Oct 2020 07:56:52 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:A7EB75E783DE1D5A686E4D977B4464730EB15754A0B5F1B577F1CD803E7A8201;
 UpperCasedChecksum:21B980E3A8A827BBF7001E061F1238659CCD13518D81418D725A03B835A7A179;
 SizeAsReceived:7241; Count:45
Received: from BYAPR11MB2664.namprd11.prod.outlook.com
 ([fe80::2164:d6ba:9ca3:3090]) by BYAPR11MB2664.namprd11.prod.outlook.com
 ([fe80::2164:d6ba:9ca3:3090%4]) with mapi id 15.20.3477.034; Thu, 29 Oct 2020
 07:56:52 +0000
From: d0u9 <d0u9.su@outlook.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] Add PCI_CAP_ID_PM capability for educational PCI device.
Date: Thu, 29 Oct 2020 15:56:04 +0800
Message-ID: <BYAPR11MB2664EBDC4811C39D45CB6D54EC140@BYAPR11MB2664.namprd11.prod.outlook.com>
X-Mailer: git-send-email 2.24.2 (Apple Git-127)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [JZlwdimIU/N60f3qiF1h5vYmdlURLVHa]
X-ClientProxiedBy: HK2PR02CA0213.apcprd02.prod.outlook.com
 (2603:1096:201:20::25) To BYAPR11MB2664.namprd11.prod.outlook.com
 (2603:10b6:a02:c7::14)
X-Microsoft-Original-Message-ID: <20201029075604.61434-1-d0u9.su@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (42.120.72.77) by
 HK2PR02CA0213.apcprd02.prod.outlook.com (2603:1096:201:20::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.19 via Frontend Transport; Thu, 29 Oct 2020 07:56:50 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 45
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: db9bf014-e481-4bc7-7bfd-08d87be031c9
X-MS-TrafficTypeDiagnostic: DM6NAM11HT009:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ku0Q8PNVFigKd9lgvx8FGRCi/4+lgiNplBgH7UitPKA0KoxdXj1wha+zdgMWbRJZFrzoALMmjWebunJWz81q5K0AlosPtkhsvhIYa2h9FU4pGcM5r2xMczoJ1ZkaK9hlqnnKCbFpGWu1a85m7PpONGCOnDNNPxHdddcMIf7i3KWD2phNfN1j1R6il+nFavTFirKCvPH+2alXCTMzPz7xBw==
X-MS-Exchange-AntiSpam-MessageData: 6HIaPu/8Yvjib6zNmIoobI9NAVFhCTKCdKRMgOJ5UX9wXch2pwMehV+WpRLY8peOxSPTYbwUsOoNM4wOiLz8+XNVERbBFAC6xLGDng4dgGHxFAbAYqkpo75mk0R9RZQ9ctFuBrUepNPO1kZAvmqwRQ==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db9bf014-e481-4bc7-7bfd-08d87be031c9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2020 07:56:51.5321 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6NAM11HT009
Received-SPF: pass client-ip=40.92.19.16; envelope-from=d0u9.su@outlook.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 04:11:55
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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
Cc: jslaby@suse.cz
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Linux can't recognise device's MSI/MISX capability after a
load-reload operation on kernel module due to the fact that the Linux
sets PCI device's power state to `PCI_D0` and the device cannot
automatically wakeup itself when module reinitialize it.

In this patch, we add this `PCI_CAP_ID_PM` here to device's PCI
capabilities table to fix this problem.

Signed-off-by: d0u9 <d0u9.su@outlook.com>
---
 hw/misc/edu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index e935c418d4..7ce32a0f0b 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -365,6 +365,9 @@ static void pci_edu_realize(PCIDevice *pdev, Error **errp)
     uint8_t *pci_conf = pdev->config;
 
     pci_config_set_interrupt_pin(pci_conf, 1);
+    if (pci_add_capability(pdev, PCI_CAP_ID_PM, 0, PCI_PM_SIZEOF, errp) < 0) {
+        return;
+    }
 
     if (msi_init(pdev, 0, 1, true, false, errp)) {
         return;
-- 
2.24.2 (Apple Git-127)


