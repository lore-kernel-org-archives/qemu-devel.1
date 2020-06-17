Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4F3C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 08:31:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4966220C09
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 08:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bt.com header.i=@bt.com header.b="ZY7p2ijx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4966220C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlTU7-0005ZJ-Hy
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 04:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasper.lowell@bt.com>)
 id 1jlTNN-0005Ep-Ij
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 04:24:53 -0400
Received: from smtpe1.intersmtp.com ([213.121.35.73]:15731)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasper.lowell@bt.com>)
 id 1jlTNL-0003xW-NA
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 04:24:53 -0400
Received: from tpw09926dag14f.domain1.systemhost.net (10.9.212.22) by
 BWP09926078.bt.com (10.36.82.109) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1713.5; Wed, 17
 Jun 2020 09:24:49 +0100
Received: from tpw09926dag13h.domain1.systemhost.net (10.9.212.37) by
 tpw09926dag14f.domain1.systemhost.net (10.9.212.22) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Wed, 17 Jun 2020 09:24:49 +0100
Received: from RDW083A009ED65.bt.com (10.187.98.35) by
 tpw09926dag13h.domain1.systemhost.net (10.9.212.37) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4 via Frontend Transport; Wed, 17 Jun 2020 09:24:49
 +0100
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (104.47.20.51) by
 smtpe1.intersmtp.com (62.239.224.236) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Wed, 17 Jun 2020 09:17:29 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUoQPGxPOo6otQYc1vcFEtaQm8QS3xLY2qomrxXXIcOHIBZQbnEW1Xh6VSEOv+7h0yLYBr0ZmdUv84yUBHVI47jJ2IX2xWx+lFE2OdHJnVl4OZqZF6GH0fLmN71I8VQNwKSab82+GUVtapee3+AUNEyCgQNuf1egQq8R8GgatmRPqWlGHvpejgHY3A4kwJ8x1adUkh0S/YLjsWiQwcstwBKH6QReQFBb4Utcjs5za+/9b5LfNTiLdLME5xb7MOB0Jxfu32oKJJMI9PEPkrBhXjUkmb6JP9Sz0YrVjyqgH3pqMYp+dqfYw+TlcdN3LRHbxXm7rQlo9+OAkYYs3EA7XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmgtXvyDr97pNlNpk63wc1cNCm7h0AJPSiNXw17D3zo=;
 b=M8zNZJ55D7KkAwuMZf/DaT12w+OLSygzY1el2Lo7pBj1vZr2UUzG+sZpdQb/fnf9HF9uurAjSv+/xVMwH7rZhxdDc4JaS/bZ5ij07jkTpyfn+SikRK6qbgKM6e/n33BKNM2wTmepXsfgB2uc/My0QIXOZG0jVMKd00FUVBpYtcv7B3e8Fn/JEhjgDLhYdTHoQssM+b9Pn8N6B+conXCzyyqIgABd33Y+gdHNGfsqbzM+DmPKbXLt2MYdOTYyKEz65XJa09QgYMnrBNH+TXUp+iMTFbGC2ioWuOL5C35es2veh13vS5yJwwP2y5cjOzfHzL1xF7OlH71zbISP5fK0jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bt.com; dmarc=pass action=none header.from=bt.com; dkim=pass
 header.d=bt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bt.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmgtXvyDr97pNlNpk63wc1cNCm7h0AJPSiNXw17D3zo=;
 b=ZY7p2ijxA+L3NRAEkuyrRn3N0F6bxP2g89+L1qs4ADoV3TReIcO3R236QmGa717uikwMie9sKb0vid5ARBA4N3r0gDUsR+Zuk74DetzzYhaEWBkJnrdxFaJDBVFXwDA/HSyBBniCJFEQYmGaRsLz13imxBzSXW5wj4Lx9Pqwj54=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bt.com;
Received: from CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:7b::18)
 by CWXP123MB3255.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:43::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Wed, 17 Jun
 2020 08:24:45 +0000
Received: from CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e098:8c50:5b1e:6a1b]) by CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e098:8c50:5b1e:6a1b%7]) with mapi id 15.20.3109.021; Wed, 17 Jun 2020
 08:24:45 +0000
From: Jasper Lowell <jasper.lowell@bt.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 6/8] hw/char/escc2: Add RFRD command
Date: Wed, 17 Jun 2020 18:24:00 +1000
Message-ID: <20200617082402.242631-7-jasper.lowell@bt.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200617082402.242631-1-jasper.lowell@bt.com>
References: <20200617082402.242631-1-jasper.lowell@bt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:54::15) To CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:401:7b::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.128.24.45) by
 SG2PR02CA0051.apcprd02.prod.outlook.com (2603:1096:4:54::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.21 via Frontend Transport; Wed, 17 Jun 2020 08:24:42 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [185.128.24.45]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c962c92-5556-4f98-3673-08d81297e440
X-MS-TrafficTypeDiagnostic: CWXP123MB3255:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CWXP123MB3255FB822345F278BCC7BDCF839A0@CWXP123MB3255.GBRP123.PROD.OUTLOOK.COM>
X-Antispam-2: 1
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 04371797A5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eisOx9K/Wu9Qt4mtZKvXnBxc0Py9i3P+4sOfm5x50MNMdWsjeDXr7GmhRr3wQk5T74le6Q080HAK2G0eKAC89R2cyZMQqioUYyPhVX9r66P5oCL7FabQRaHHwj5d2VJ8LwS7Lod2MHtxJeMWy7RzNECr8YHVE3nuH61kfDesypca2DS6uw1IFziTQ5Ul5LxtfXvkUS3NZjO66ODhXYCL8Yo23jsoGfG/jYReIieWp152craSyxNvOe+gMMjdBIaguybxgBCwA29nKxjXhxxmhTMDNIkHoD8y4HdDYZF7GplSgWqL9jMpFjqfq4hwH9MemUY2UfSIH6xAjl092sr+8zkh9Knnt5kOHCp1iDvmaDGGNdGjrSSNK7FDxIQCkf04
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(44832011)(1076003)(8676002)(2616005)(316002)(8936002)(6666004)(6486002)(956004)(2906002)(5660300002)(83380400001)(6506007)(69590400007)(26005)(6512007)(36756003)(6916009)(186003)(16526019)(478600001)(52116002)(66556008)(66476007)(4326008)(66946007)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: aoF4bKunsFKuZ4nLVPFkiW79C3BEMA3eXzgFRSBbd841Hlop+119zqluCC3HY4fp3BrMjdvxUnk1BC1xEhpw89Jvp0A5cW3KP0GFdibZ2rqlNkdyv/dLDqxctYAuPpuOb+TYq86N/ZDyqk6TvTmwc8NNdtReqMKOlpMvmzIduQJSkp6y7YIAKtK72xyiNnNvPEcnDT6o9/nBg/xccaLO1h3zSkTM5ejMSgjQELGbi+LAhcajO70m48zPwZl7BMYvLY0cyd5vn8tjvs9p5ZILv0PQrSY/r9xE6x4bsnreGTHgxtdNW06nyqXdtTJQIV+V7t8TU588a38DbD1JEjWUrB1ld0DLUD+G/kUGgcRSR5jFpH6uy0I8xJkDIeFSFhqpKFhJTXWUbJXYYmL8N2bdYny4i+BHus3C69kJbN3aUbxzFibXUEdfa1nbOzWEUqs1EJDcyDw6O1MdidOkTfiFUskdEZvvMC3jYd8BtTwC2vU=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c962c92-5556-4f98-3673-08d81297e440
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2020 08:24:45.5568 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a7f35688-9c00-4d5e-ba41-29f146377ab0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Netl8WUMKwyaAvRs8xPnET78zEutz6F3ntDlwdgliYyrWDPz0UVRRkRll5yPqr60Nt3FNnsARpUzWj0YVWOuMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3255
X-OriginatorOrg: bt.com
Received-SPF: pass client-ip=213.121.35.73; envelope-from=jasper.lowell@bt.com;
 helo=smtpe1.intersmtp.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 04:24:50
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: tony.nguyen@bt.com, mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com,
 Jasper Lowell <jasper.lowell@bt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Receive FIFO Read Enable command is used to request access to the
receive FIFO. When the command is finished, the controller will issue a
TCD interrupt and the number of available bytes will be available in tthe
RBCL register. Given that the visible receive FIFO window is used to
store characters as they come in, the only action that needs to be taken
is to raise the TCD interrupt (if this interrupt is enabled).

Signed-off-by: Jasper Lowell <jasper.lowell@bt.com>
---
 hw/char/escc2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/char/escc2.c b/hw/char/escc2.c
index 5afb8aa6d9..8198b7fec3 100644
--- a/hw/char/escc2.c
+++ b/hw/char/escc2.c
@@ -762,6 +762,10 @@ static void escc2_channel_command(ESCC2ChannelState *channel)
         tmp &= ~(REGISTER_STAR_RFNE);
         REGISTER_WRITE(channel, REGISTER_STAR, tmp);
     }
+
+    if (command & REGISTER_CMDR_RFRD) {
+        escc2_channel_irq_event(channel, REGISTER_ISR0, REGISTER_ISR0_TCD);
+    }
 }
 
 static void escc2_mem_write(void *opaque, hwaddr addr, uint64_t value,
-- 
2.26.2


