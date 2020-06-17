Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14F9C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 08:26:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 804DF20679
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 08:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bt.com header.i=@bt.com header.b="e8VZlG8O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 804DF20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlTOZ-0007Il-OR
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 04:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasper.lowell@bt.com>)
 id 1jlTNS-0005Mk-50
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 04:24:58 -0400
Received: from smtpe1.intersmtp.com ([213.121.35.73]:15740)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasper.lowell@bt.com>)
 id 1jlTNQ-0003yB-Aa
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 04:24:57 -0400
Received: from tpw09926dag09e.domain1.systemhost.net (10.9.202.36) by
 BWP09926078.bt.com (10.36.82.109) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1713.5; Wed, 17
 Jun 2020 09:24:53 +0100
Received: from tpw09926dag13g.domain1.systemhost.net (10.9.212.29) by
 tpw09926dag09e.domain1.systemhost.net (10.9.202.36) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Wed, 17 Jun 2020 09:24:54 +0100
Received: from RDW083A009ED65.bt.com (10.187.98.35) by
 tpw09926dag13g.domain1.systemhost.net (10.9.212.29) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4 via Frontend Transport; Wed, 17 Jun 2020 09:24:54
 +0100
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (104.47.21.55) by
 smtpe1.intersmtp.com (62.239.224.236) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Wed, 17 Jun 2020 09:17:34 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ec8sp+TpAU3PPp1Bncrwib3ZnGmKlwdZ+191bMaaTEop8tguAqVCHrjiOL/AU7Jv4KAjqKC0ft7Df4Au8AOmTkObBkfs3a+jwY9xMyxXW4GP780FeeXQckRNMjMCh5GW9zIFUQfooGlZD1f5FhBwLCdRdhz9uPSd3j+FJjtKXma/WCntnYji1S0JoubRbhC4w4V4943zgqrOnL+PyR0dN4QcXRc+i0xY7QTPqHMg3tmx2NM2hR0OoQgeVZZ6tjx31ZSUFMt9wcLiDjkaDJPvyH712/H6cD2D0XAxcgA/BuiMGiFqDpXcYNpbvgTPP6T0gIiUvklMF008wksjiYEpBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqY795SHa5LvjdJJsmQpzi1P1mXybkWBqzdRbmwLBZg=;
 b=fPkSKgjHUqXv8/OOiMjJYjtRPXRheOyFtiHQTgD0Auh3/B4sUhWLGsLZZnOfWp9ghNJ5FdxMOAYGUCNipWVTF/IV1zx7Y0IxGW6Oll3YXz1uPQofxjHQU3of+xzuK2UzNWVOGQw0tUXoarNjs8B7EqeRXOlwByS3vET80ddzwgBOCCVW62OGy3w35JE0LdgAS3ADETM4a1urNNHCEkVx3KHuBBwJvDZJF3+uoFntQ7SpE5VR2tjQZUfmnqcOVksHvCNOqydnIT0tirU1DbuiE3Z3yYQHzOLEwNCxtrjli6yyijWK+XVzbxkvvZuId6wZ0Oth6AkB4+gDmFQXQFdr2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bt.com; dmarc=pass action=none header.from=bt.com; dkim=pass
 header.d=bt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bt.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqY795SHa5LvjdJJsmQpzi1P1mXybkWBqzdRbmwLBZg=;
 b=e8VZlG8OQYnIAQwEJ355pXeD9uDXV6JR2aaMK0FNhl18CsRXrtu0MyzhMoJbKYfOPBuNOCN+dP8iQcIuhhZRcnhW5XVR6KvQBGhwuRUzA2QVZQ1KpdFDuAQMqh87z2jSxPfPfKfdt21Q/7wcg/4memEmY9LYDXaBws561d04614=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bt.com;
Received: from CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:7b::18)
 by CWXP123MB3255.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:43::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Wed, 17 Jun
 2020 08:24:52 +0000
Received: from CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e098:8c50:5b1e:6a1b]) by CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e098:8c50:5b1e:6a1b%7]) with mapi id 15.20.3109.021; Wed, 17 Jun 2020
 08:24:52 +0000
From: Jasper Lowell <jasper.lowell@bt.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 8/8] hw/char/escc2: Add XRES command
Date: Wed, 17 Jun 2020 18:24:02 +1000
Message-ID: <20200617082402.242631-9-jasper.lowell@bt.com>
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
 15.20.3109.21 via Frontend Transport; Wed, 17 Jun 2020 08:24:49 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [185.128.24.45]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f955b25-44d6-4232-165e-08d81297e886
X-MS-TrafficTypeDiagnostic: CWXP123MB3255:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CWXP123MB32553EBC2805E6E82DDCB817839A0@CWXP123MB3255.GBRP123.PROD.OUTLOOK.COM>
X-Antispam-2: 1
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 04371797A5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AfaU8NC+LKDs7EZtE8Euv7TIQ5S4mykkeMJyfJWHxEk/zmRpvufvpc0hVu2zpjTxWM0XeebmQBapH583nBsGSVZaVx3CXx24/WZM+RPHUXguAIhli3qqjAKXnkqnxTi2Pq4+S73qRgQZ/IwHHBw9yqpVmyTyhN4KBkL3E01IVThbc2w7is/OLK+D9hLGJI7Ogu5X1IowlBHpCoq5Fo6YVErMi+WPZH/EDYxqqHty0vv4aksZDDmnf9yDZGddIkBlXTiNWc5ZgHBnb6p4C5YwCZGacDLqWhlQmQQKQF39k/cbs/mcD906j9DRv4WTJz2JV2Dw4AfBai4njFfONJ01Vap9p0bchUtZPzPDWJys6nfVm7Z4EF4i8WjyWiSi8e9k
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(44832011)(1076003)(8676002)(2616005)(316002)(4744005)(8936002)(6666004)(6486002)(956004)(2906002)(5660300002)(6506007)(69590400007)(26005)(6512007)(36756003)(6916009)(186003)(16526019)(478600001)(52116002)(66556008)(66476007)(4326008)(66946007)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 8xjfmnbWlh+Q4QOloiXMQiLFEgTFKh0mauVbiQK6eQwkJwl+khcowq+K3eMkQWJQiAF+PJ1LjrKzUVP3U/xgw5q4CClgSHnHwRfhqz6Jtt+JlOOTMbo0HrNxtVqr/5EPEAk3FL3oLskNfZyGUM672/eD5YHgnkd9z27raoamRbZJMzyf42J2CgzxO5Apf11M7SMHS4fE6ZhuO/HUU6Vy7L/tW6nzP/om2cTSrV7TkMGR/48cBvaXrEIOjb4YBXjn3R+tWW3h+lQWWa0ejt+o9J5Ki16DIlu9NyKP66h4S3soHe9hlrnzMrOAsL5qeP0ozZ13K6awGM+pNvVtGy8rMKTBmUzzHPbqXv5JfscwmjANwIhWNN/2nvLbJsRJt+mL4yjj2+zmXO1MZFwv8WWeEz4HITi3sSJk+5xynAeoYxswACAP6+CfiR6Tr5vuZAbdmhmu+KidT8b0lEVzRimTUSChv36rhnIDi6OiUBUg3Qc=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f955b25-44d6-4232-165e-08d81297e886
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2020 08:24:52.7466 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a7f35688-9c00-4d5e-ba41-29f146377ab0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DLZIYZtE57ZH1UYmeQvPFDN2T9c8a9ygJjHIciqicm0qWbodRiuDJjaST8pxgesFt19I3xtGQBKvakSVe4XDzw==
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

The Transmitter Reset (XRES) command is used for clearing the the
transmit FIFO of any data. When the controller has completed the
command, an XPR interrupt is generated (if this interrupt is enabled).

Signed-off-by: Jasper Lowell <jasper.lowell@bt.com>
---
 hw/char/escc2.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/char/escc2.c b/hw/char/escc2.c
index 3bacdfaa7c..a40731b836 100644
--- a/hw/char/escc2.c
+++ b/hw/char/escc2.c
@@ -790,6 +790,11 @@ static void escc2_channel_command(ESCC2ChannelState *channel)
          */
         command &= REGISTER_CMDR_XRES;
     }
+
+    if (command & REGISTER_CMDR_XRES) {
+        memset(channel->fifo_transmit, 0, sizeof(channel->fifo_transmit));
+        escc2_channel_irq_event(channel, REGISTER_ISR1, REGISTER_ISR1_XPR);
+    }
 }
 
 static void escc2_mem_write(void *opaque, hwaddr addr, uint64_t value,
-- 
2.26.2


