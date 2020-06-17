Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED3FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 08:30:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECC49206E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 08:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bt.com header.i=@bt.com header.b="hWtFFV0H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECC49206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlTSX-0003hH-9d
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 04:30:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasper.lowell@bt.com>)
 id 1jlTNM-0005DS-OY
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 04:24:52 -0400
Received: from smtpe1.intersmtp.com ([62.239.224.235]:19688)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasper.lowell@bt.com>)
 id 1jlTNK-0003xN-QS
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 04:24:52 -0400
Received: from tpw09926dag13e.domain1.systemhost.net (10.9.212.13) by
 RDW083A011ED67.bt.com (10.187.98.37) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 17 Jun 2020 09:27:35 +0100
Received: from tpw09926dag13h.domain1.systemhost.net (10.9.212.37) by
 tpw09926dag13e.domain1.systemhost.net (10.9.212.13) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Wed, 17 Jun 2020 09:24:48 +0100
Received: from RDW083A009ED65.bt.com (10.187.98.35) by
 tpw09926dag13h.domain1.systemhost.net (10.9.212.37) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4 via Frontend Transport; Wed, 17 Jun 2020 09:24:48
 +0100
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (104.47.20.57) by
 smtpe1.intersmtp.com (62.239.224.236) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Wed, 17 Jun 2020 09:17:28 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtIKUuZn1/3EpvnLBoNl1PAM74sCK6/NfAYPZHrCizOeHpFGuUHNkfabWOgl3pnNrIqWt4qfpIq1mGf/ojCmfpcQEZXB5XLUC4QuXwPBOb7ddx+qDERU+WbKJ97ZilZiUsW4j4heFfAmaNCBkT72SXtc1nZDNlG0bO+p+eGq2SFxvE36g9Jj9v0dGg2ONv+VCCcTp9x9kUJRGvcQcHqFhoqWWiErxkBsHwRdNl0r+UDVEj2t4jRjnRXqVdVhO/gwa2YfKXgrq7DngWk/k9ApO62BgKKDrqtH3OwLR0/EYYUvSDthAISmeJ/Y6gi+b/CpzWGOZlxgCmMf8LUAbCtl8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Epn5UyQdf1Lw0Zh6v9NFROnbfoPOmhL5PCtfueV/us=;
 b=RcxYV2IOw/kupd08s8BuYtX4p7VfKplFsN2Mq6Onq4Z7F/gXylk0hifP1H6VFF4pPmEzPs7u5R6DaYpBEdiXOdNtnQXdIDnhmCW5PT+2SP6jDWIT1cBWKO49o53lu2QMg0NjLv9uGCZSwAlu6WTDec6Lyx24oeHhP4KCOfGwpc7FCv1l/Oi86CLic+8fuQ5AJp9fTCB4FAfjM6n+whG61RZGZWLltS5j11EcSTWl7QhzHWRlpc2KIcffLpnruRdEVUpyGvaEyMyIltKWp6xuV5YoYcGnRsUv/mGmVzOJ0ZJF8RgZn4M62YrVum2slA/7Z03ztPyqHJMLS0JKyMIq4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bt.com; dmarc=pass action=none header.from=bt.com; dkim=pass
 header.d=bt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bt.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Epn5UyQdf1Lw0Zh6v9NFROnbfoPOmhL5PCtfueV/us=;
 b=hWtFFV0HO+7uuYPyHezhkkmJ4FpZwh0UygQzExTAXLygkSt+bI+ItiXUom3efG7fCwq5hKSKfPymuOPva3nkiz5RNXnKrfY2gf3q3tvuPqtrvTjl8WOgoqNmgalOqxyKE0aIj3iTiO0LehCepI8OWbUZwNHbwDpUEWT/cuJCTFQ=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bt.com;
Received: from CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:7b::18)
 by CWXP123MB3255.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:43::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Wed, 17 Jun
 2020 08:24:41 +0000
Received: from CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e098:8c50:5b1e:6a1b]) by CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e098:8c50:5b1e:6a1b%7]) with mapi id 15.20.3109.021; Wed, 17 Jun 2020
 08:24:41 +0000
From: Jasper Lowell <jasper.lowell@bt.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 5/8] hw/char/escc2: Add Receiver Reset (RRES) command
Date: Wed, 17 Jun 2020 18:23:59 +1000
Message-ID: <20200617082402.242631-6-jasper.lowell@bt.com>
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
 15.20.3109.21 via Frontend Transport; Wed, 17 Jun 2020 08:24:38 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [185.128.24.45]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e1b0c13-505c-408c-16eb-08d81297e1fe
X-MS-TrafficTypeDiagnostic: CWXP123MB3255:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CWXP123MB3255A6BE038B37240BF92355839A0@CWXP123MB3255.GBRP123.PROD.OUTLOOK.COM>
X-Antispam-2: 1
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 04371797A5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d0BkMyMVd52Gy0lib0adiYlZPiM8KycdS0QZQkYZTu5Y85Kb/xOkoajuhIQ5XcdYDJO36bb9MlGtfzwxIEfSQ+FFSOsflJdTkskSth+C6eTtlSrnuGlRUazIHQ3j6dpG8NEfHZ+ZEBOdBu8J0iX6CL2sLeUWNAH+dvgjYD/6PjEvVQUUZsKCer/7HPAdEr/AdUZ2qD+AfG3JgItbwWoTPv75iNm2pz+OJ8byITNZl7/LA3kqk7Y0hOEQ+jUa21LqwNNx7FmVHYDBYADGwSOnpcOlGZU3mSc7YmiekA2oN1UU2Zx+FhO2wUsjpxs/qA26xswW1mzl/XuRayPPEjamxqqT7rNaexpa7eV9bWxLRHv+1a0g19LihZGd9ZeidbjF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(44832011)(1076003)(8676002)(2616005)(316002)(8936002)(6666004)(6486002)(956004)(2906002)(5660300002)(83380400001)(6506007)(69590400007)(26005)(6512007)(36756003)(6916009)(186003)(16526019)(478600001)(52116002)(66556008)(66476007)(4326008)(66946007)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: mk6WLnihyINqETpMZhMKcGlVmgH2iKf0cbIcINLTaMkYS6rWj+86q6nsucav3jEer70q5TE4grs2aS5frZl8WZWOSv8N9A5Exw4fD7tAqKxLFmGVz0bMu5sABZxUZuyUKLHGHzjmstrjP7padhkW057agCASJekwjs5CjsNS2JhJDH+K2wkuXOjE3OJUuIzZXZm+FU7g5A4yltnC2x+y/brd8xYKIvl/aMOjnZDvKn2UhIJV6VaqDkYGWx4vHm/NmtIy/jFv+RXeppcqYIbSFR+bIb77SZ7gIF7lfNquPDg8buAmB9K7ZwrIe4zpIBn69VskREZSi8GRyGeWizOqbur9E6dxdqb2/G3luG7//Ytborc2A5QSttTTtSOYkISd+2Sn0eSZFT0ZttMnAureJx9o57srp3A3VhYX5fD1uqSNoLfwdSpdorS7mMcDJWkavPPWIUGyVAM4CrXyAqdT/2yrSJGlByNljBw2ISzjbGM=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e1b0c13-505c-408c-16eb-08d81297e1fe
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2020 08:24:41.7390 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a7f35688-9c00-4d5e-ba41-29f146377ab0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QVlz67wh+La1oT4TD99dc+cqu8jVtOV9T4M5LESgP17QzI4mj9KeuD2GQgdNkLhLDR5wpQbp7orMIRnz2rXhNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3255
X-OriginatorOrg: bt.com
Received-SPF: pass client-ip=62.239.224.235; envelope-from=jasper.lowell@bt.com;
 helo=smtpe1.intersmtp.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 04:24:49
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01,
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

Commands are initiated by setting certain bits in the CMDR register. The
Receiver Reset (RRES) command clears the receiver FIFO (RFIFO).

Signed-off-by: Jasper Lowell <jasper.lowell@bt.com>
---
 hw/char/escc2.c      | 24 ++++++++++++++++++++++++
 hw/char/trace-events |  1 +
 2 files changed, 25 insertions(+)

diff --git a/hw/char/escc2.c b/hw/char/escc2.c
index 059e033089..5afb8aa6d9 100644
--- a/hw/char/escc2.c
+++ b/hw/char/escc2.c
@@ -29,6 +29,12 @@
 
 /* CMDR. */
 #define REGISTER_CMDR_OFFSET                    0x20
+#define REGISTER_CMDR_RMC                       0x80
+#define REGISTER_CMDR_RRES                      0x40
+#define REGISTER_CMDR_RFRD                      0x20
+#define REGISTER_CMDR_STI                       0x10
+#define REGISTER_CMDR_XF                        0x8
+#define REGISTER_CMDR_XRES                      0x1
 
 /* MODE. */
 #define REGISTER_MODE_OFFSET                    0x22
@@ -741,6 +747,23 @@ static uint64_t escc2_mem_read(void *opaque, hwaddr addr, unsigned size)
     return value;
 }
 
+static void escc2_channel_command(ESCC2ChannelState *channel)
+{
+    uint8_t tmp, command;
+
+    command = REGISTER_READ(channel, REGISTER_CMDR);
+    trace_escc2_channel_command(CHANNEL_CHAR(channel), command);
+
+    if (command & REGISTER_CMDR_RRES) {
+        memset(channel->fifo_receive, 0, sizeof(channel->fifo_receive));
+        REGISTER_WRITE(channel, REGISTER_RBCL, 0);
+
+        tmp = REGISTER_READ(channel, REGISTER_STAR);
+        tmp &= ~(REGISTER_STAR_RFNE);
+        REGISTER_WRITE(channel, REGISTER_STAR, tmp);
+    }
+}
+
 static void escc2_mem_write(void *opaque, hwaddr addr, uint64_t value,
         unsigned size)
 {
@@ -767,6 +790,7 @@ static void escc2_mem_write(void *opaque, hwaddr addr, uint64_t value,
         break;
     case REGISTER_CMDR_OFFSET:
         REGISTER_WRITE(channel, REGISTER_CMDR, value);
+        escc2_channel_command(channel);
         break;
     case REGISTER_MODE_OFFSET:
         REGISTER_WRITE(channel, REGISTER_MODE, value);
diff --git a/hw/char/trace-events b/hw/char/trace-events
index b4f4f30815..47b46b92c9 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -59,6 +59,7 @@ escc_sunmouse_event(int dx, int dy, int buttons_state) "dx=%d dy=%d buttons=0x%0
 # escc2.c
 escc2_irq_update(uint8_t gis) "value 0x%x"
 escc2_mem_read(char channel, uint32_t addr, uint8_t value) "channel %c addr 0x%x value 0x%x"
+escc2_channel_command(char channel, uint8_t command) "channel %c command 0x%x"
 escc2_mem_write(char channel, uint32_t addr, uint8_t value) "channel %c addr 0x%x value 0x%x"
 
 # pl011.c
-- 
2.26.2


