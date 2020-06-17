Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FUZZY_XPILL,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26EEC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 08:26:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 695D420679
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 08:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bt.com header.i=@bt.com header.b="UkaE9aLX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 695D420679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlTOY-0007Gw-LE
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 04:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasper.lowell@bt.com>)
 id 1jlTNQ-0005KT-QO
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 04:24:56 -0400
Received: from smtpe1.intersmtp.com ([62.239.224.234]:29299)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasper.lowell@bt.com>)
 id 1jlTNO-0003y5-VM
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 04:24:56 -0400
Received: from tpw09926dag15h.domain1.systemhost.net (10.9.212.39) by
 RDW083A012ED68.bt.com (10.187.98.38) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 17 Jun 2020 09:21:30 +0100
Received: from tpw09926dag13h.domain1.systemhost.net (10.9.212.37) by
 tpw09926dag15h.domain1.systemhost.net (10.9.212.39) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Wed, 17 Jun 2020 09:24:51 +0100
Received: from RDW083A009ED65.bt.com (10.187.98.35) by
 tpw09926dag13h.domain1.systemhost.net (10.9.212.37) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4 via Frontend Transport; Wed, 17 Jun 2020 09:24:51
 +0100
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (104.47.20.51) by
 smtpe1.intersmtp.com (62.239.224.236) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Wed, 17 Jun 2020 09:17:31 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMo6IS0HS4r8DdcPE5+Oi0KIphH2ytTeb1+2JZE2dl2wFKXbNbPSUTFL9uGapYcIVnn+mM5XE85CG9lQCAknRvVZmOAZ/93P5VMDeYbDVA2gkFtKizTInlRZTMj4X0E5SqkHPThEL9/O0tmxWSV5WSIx2Mn06Ech9zCvjNRrNheml4Q01eJQaXbu5J9pvjGmuUQRAcPdqHjrLTSJG8qYEyGmpzWRZxCyAPme5WngRhrpp/fifyrkRSUN7rV03nSavjxZkr1Eh6k9EdmJQJ4J+JDRG3H7vyXEaaEYXgTaR0WqWUNmAKnAQVc1QHqIYB3F4fr4r33VPI+kRqRxMUQAAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBLNsCvC3ZFFfVobT9Df/7+Ndzt03Ahc+Gg/6OZAm+4=;
 b=RuuOtaLiShAWSNWXfXa/JONBZloK4av+6iGkGN8XKefRG96kXqp5lnJPSE6OyA6xGUS4OyMpHCtp5u26+ZHWE15oE5t0ny+LZynMvzwPxHZNeY/h4Kl65FCZ26R6UDo8wLszMNNy/heStfq+QPujlNWh45BNu0x+arR6ZT/1aOYQ5XUrgPi0UWYdwvq/EOzz8I5Z5XapFZvvMoUKlY4hoPvB7gMc9YP1FswSyYoNl3WJzWQsD8BLFDSeh9buKDamxTBjsLD/QBpOnzJdwNM1KXEsglOgWD4jJVfd/2iG4Xb7RmjW8aMIrmaWtjfCekZLK4Q189w+8h39cB/q6b6Ofg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bt.com; dmarc=pass action=none header.from=bt.com; dkim=pass
 header.d=bt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bt.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBLNsCvC3ZFFfVobT9Df/7+Ndzt03Ahc+Gg/6OZAm+4=;
 b=UkaE9aLXqS7/Tc3QczMn1QhUi5dlVGgKc8jyUg/g9dVw2rMOK0Zac6JlG0eopiWU10om0uZsYyEnAuiiDc9PT4fqptaMd2WxFFllnp8aZj1VoI1rZ6YNn1sNRaO5s424NFkMLgYRoV1E0rWPC3tXM0ZIy2E7xwYEXxu4C6/QqyE=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bt.com;
Received: from CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:7b::18)
 by CWXP123MB3255.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:43::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Wed, 17 Jun
 2020 08:24:49 +0000
Received: from CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e098:8c50:5b1e:6a1b]) by CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e098:8c50:5b1e:6a1b%7]) with mapi id 15.20.3109.021; Wed, 17 Jun 2020
 08:24:49 +0000
From: Jasper Lowell <jasper.lowell@bt.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 7/8] hw/char/escc2: Add Transmit Frame (XF) command
Date: Wed, 17 Jun 2020 18:24:01 +1000
Message-ID: <20200617082402.242631-8-jasper.lowell@bt.com>
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
 15.20.3109.21 via Frontend Transport; Wed, 17 Jun 2020 08:24:46 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [185.128.24.45]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f22ffab-3cf3-4f22-2eff-08d81297e682
X-MS-TrafficTypeDiagnostic: CWXP123MB3255:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CWXP123MB3255B5857BB12213ACCB48DE839A0@CWXP123MB3255.GBRP123.PROD.OUTLOOK.COM>
X-Antispam-2: 1
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 04371797A5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EGXztA3e5mh6Kd+E032T+N0u5JVI9khA+ghTpsUP2wJ0LUJlEymlNVQ5l3McjRn68z47x48A7aYdIaIy1lvC4iNVwSMKQFa1sjaWZrJuEq2hqX3ilYh8nMV7wmNAmlwdzpyjkDXxo+MccBQpdoOoFzFRwgTdGGjnumijaK9yJYT4jnse/tM1gHj5YXZhoTY1ZV0bX12Gc8omSwTjiMOMWdPLpglaIl5lDysn9fn/WExSJILF7YmiffNXlpED8cCMFcaHn9Io+sv3RRq6tnIxb/frsaDerEAntbeiNt6vG6cZ6+Q7RfGhEiEw4zmX/C0YxVWWM8XaKdbHq/GE7QUo6yAe10/YaMXjxCmNK95lAdoQl0NnBJIGIrAJmyXKI1bi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(44832011)(1076003)(8676002)(2616005)(316002)(8936002)(6666004)(6486002)(956004)(2906002)(5660300002)(6506007)(69590400007)(26005)(6512007)(36756003)(6916009)(186003)(16526019)(478600001)(52116002)(66556008)(66476007)(4326008)(66946007)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: gnGW6avl1Cs9OUK+bZy9k1J7XpGeLLXw8/HnpBMkgHLpqWNX8UiZe4bT7hs/2XyXmmXzR6e/MUNji4G4DiF+mudhRWqdLuQlkaNCVVW0a5+qCrIDSdyCjJ+surPPviAi5zEKQOjQfABeqdh6+HBcUmvkjzfpEzpOW9o1tDasR6q3VtFn0ob3G5MWXysRzZeE6uQUPpcZJZWwqJs9AHeJ9+HjufoCsg1u26+8eD7SNL3SdyMHMEGwO555OuKoj+YU5orON2wjkRP+WZWejqdKATDaE4XJilR16AxvPD2xffW9SdgPNMIStOgzXHxVOuuh6ccStU3+8FQdFn1A2Phx7mrVUb3i7I1YLt0X3ncUaB/od1MTGuZtUJPQUUD20vGDItQIzTzN5d74leBQLwNwJ3P3g72sWm0QegLBspunPLnfLILDYydEdRr1Nh/AxXq4Xfdn8tN5T8NlTTn9lZnSrqOuWOS4hbyTFpc5Qm3VPt0=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f22ffab-3cf3-4f22-2eff-08d81297e682
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2020 08:24:49.3026 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a7f35688-9c00-4d5e-ba41-29f146377ab0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BZb33HLn3Zv6Qj2Jzd9YciXrDC7AbOZZha+0pq32myQkmUF1iVlo0ayGqnJtzS7Kee//D9saHsa3wxccpscHSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3255
X-OriginatorOrg: bt.com
Received-SPF: pass client-ip=62.239.224.234; envelope-from=jasper.lowell@bt.com;
 helo=smtpe1.intersmtp.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 04:24:48
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FUZZY_XPILL=0.1,
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

The Transmit Frame (XF) command is an alternative to using the TIC
register for transmitting. This command allows the guest to transmit the
contents of the transmit FIFO rather than a single character.

Signed-off-by: Jasper Lowell <jasper.lowell@bt.com>
---
 hw/char/escc2.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/hw/char/escc2.c b/hw/char/escc2.c
index 8198b7fec3..3bacdfaa7c 100644
--- a/hw/char/escc2.c
+++ b/hw/char/escc2.c
@@ -207,6 +207,14 @@
 
 /* ISR1. */
 #define REGISTER_ISR1_OFFSET                    0x3b
+#define REGISTER_ISR1_BRK                       0x80
+#define REGISTER_ISR1_BRKT                      0x40
+#define REGISTER_ISR1_ALLS                      0x20
+#define REGISTER_ISR1_XOFF                      0x10
+#define REGISTER_ISR1_TIN                       0x8
+#define REGISTER_ISR1_CSC                       0x4
+#define REGISTER_ISR1_XON                       0x2
+#define REGISTER_ISR1_XPR                       0x1
 
 /* IMR1. */
 #define REGISTER_IMR1_OFFSET                    0x3b
@@ -749,6 +757,7 @@ static uint64_t escc2_mem_read(void *opaque, hwaddr addr, unsigned size)
 
 static void escc2_channel_command(ESCC2ChannelState *channel)
 {
+    unsigned int i;
     uint8_t tmp, command;
 
     command = REGISTER_READ(channel, REGISTER_CMDR);
@@ -766,6 +775,21 @@ static void escc2_channel_command(ESCC2ChannelState *channel)
     if (command & REGISTER_CMDR_RFRD) {
         escc2_channel_irq_event(channel, REGISTER_ISR0, REGISTER_ISR0_TCD);
     }
+
+    if (command & REGISTER_CMDR_XF) {
+        i = 0;
+        while (i < CHANNEL_FIFO_LENGTH && channel->fifo_transmit[i] != 0) {
+            i++;
+        }
+        qemu_chr_fe_write_all(&channel->chardev, channel->fifo_transmit, i);
+        escc2_channel_irq_event(channel, REGISTER_ISR1, REGISTER_ISR1_ALLS);
+
+        /*
+         * XFIFO is ready and ISR1_XPR should be generated. Fake the XRES
+         * command.
+         */
+        command &= REGISTER_CMDR_XRES;
+    }
 }
 
 static void escc2_mem_write(void *opaque, hwaddr addr, uint64_t value,
-- 
2.26.2


