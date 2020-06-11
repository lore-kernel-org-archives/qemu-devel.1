Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDD3C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 15:54:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A7EA206A4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 15:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="K3KEcX2f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A7EA206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjPXG-0000Sl-Vq
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 11:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jjPUR-0004Ye-67
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 11:51:39 -0400
Received: from mail-eopbgr60103.outbound.protection.outlook.com
 ([40.107.6.103]:37760 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jjPUP-0005xt-D3
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 11:51:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ch1xeJ4vQEZXERWIbKQFOSOqNRjSoRESAeB5gXOBv2dEtnA9chmDXF9YG5YQ3G9gUsrbisQ9oPnXqwwmUk8wwIYYenxPo89wzW5zFAtTS2Y9EJDWKob1TeFedUqJifOSrCqvZqNcRenf7K2nAbfaX0x3ucJm2P3IzAAhmXP9aKrrBGf7qnHwjwr1RLEjU9lYYiCU0Dz/vUkz6YnvOlM7PwnQvOfiLGR1Dg65VpKxR90Geq9N7yUyW1xoCz1t0PaRNXluog7lil4YN9iL5fCZlN2Wc8Diu5zocHgI0AE8UyJMc+8FEJ5EyKSHCQ2DIhLJcqkROrQIwO+LskYSQjB1Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJwOHN338pZzLJ05d1WjB1bWbrlpQSa4ZRzxeDnQWpc=;
 b=WyXgl/iekV3lO+2a6pYL982W7xV2AmEkAhB/6lSt5DbrCXERf57O+BIH8IxurnKX7O7a3FklMpEuwNR1aPOPEI5bHRWUvhe/nhQPziElzlPCDNNVqxSYkhxxYajSCI7mUSa22i1Fl3w8JuJUEnfX8FD41PGPoAoZuPA57cEIHajrnaf6bS/fGChczw4rUDXeJMS4fmC8kbYPX/KzFRwrWAKXpy5ql2cQm+t6wf5dQDugQCl221uzuMxtEga3AN77Vrbw0xB7Ag7RchwDaByyuRjgCH+Ehojgya6OulcBaMmWqLpxvJp0LIauX4LUJXM3+TEhIYkB4bb1wNXVRJj/YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJwOHN338pZzLJ05d1WjB1bWbrlpQSa4ZRzxeDnQWpc=;
 b=K3KEcX2fAgCESBdUm4PhYqkhT3vsCEQuTsKgIRgIxEyX/8zRdSga3vzLHlNmRmgKGWu6FU/RkasI4UQ4ghW4qH44JwVt0QCN4JSBZcCCS8GyJ0S+0+vsFRH/uaQIAScbChpi7TIVmtlZJF4MFuOZ18l1UBTThy1yYu8RsqVbr+k=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB6008.eurprd03.prod.outlook.com (2603:10a6:20b:ed::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19; Thu, 11 Jun
 2020 15:51:24 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3066.023; Thu, 11 Jun 2020
 15:51:24 +0000
From: Filip Bozuta <filip.bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/6] linux-user: Add strace support for printing arguments
 of lseek()
Date: Thu, 11 Jun 2020 17:51:07 +0200
Message-Id: <20200611155109.3648-5-filip.bozuta@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200611155109.3648-1-filip.bozuta@syrmia.com>
References: <20200611155109.3648-1-filip.bozuta@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0031.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::18) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bozuta-ubuntu-18.syrmia.com (46.240.135.226) by
 ZR0P278CA0031.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.21 via Frontend Transport; Thu, 11 Jun 2020 15:51:24 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [46.240.135.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e24c7622-61ef-4d8f-ef70-08d80e1f4b50
X-MS-TrafficTypeDiagnostic: AM6PR03MB6008:
X-Microsoft-Antispam-PRVS: <AM6PR03MB6008898E68F86C03398A35ECEB800@AM6PR03MB6008.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GiKYCegFy91WrSCoKuaurMHVLmCxbvD7105vMq41nZ2btbJo4gWguro56iNlsx3rNHyMPxCX8IudDXUtkVjKwPUm7QQWKyH0NJ6yfspWqcjpqETP9DdpzPZYay6QRmUWJGuvLCj/GG4/2gTq5g+GY4bhNUI+VIU7u7RYoVPTyvTckIA3w8KaNWK1HZExWsqQ3pa5tMIlvn39/WKT5StVvdhBOwleWntjGO5bLLUR5TSkBOT0AjBX+TfrRaMzP0SDXTP3vYJzBcLrFA9JqAEPGNnlzSt0UTnLeHBJyY5/g0AKwj2ByRt1iLFmwkbcv8/aZwN+xvdRZZ6atGWAhHMLjOIB3OyldwUUCObQCwqE/1buuPZTpokl4vUmDGCjtMERs1GDyQiTyALNEbxNiq0nUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(366004)(376002)(346002)(136003)(39830400003)(396003)(508600001)(7696005)(966005)(52116002)(316002)(83380400001)(8936002)(8676002)(956004)(2906002)(6916009)(6486002)(2616005)(4326008)(36756003)(186003)(44832011)(6666004)(16526019)(5660300002)(1076003)(86362001)(66556008)(66476007)(66946007)(26005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: qo+cwvyKl6U5pgW6eB11r2TynlnE8HH0LFQ3CF2n86tfjJrvuhrQjrVwv9iEfYHoC4EqnU7GNIjhBqhzzQvFE4FqrsVIXTSM5yr98hLsHxTeISyjYrxlM7oF2h0z5eONIJS/9sBzapxuheW5tzrxtD7boDhWYSRKjTVODPQW+MPmWOh/D1wyyv7VtIdta2M4GnTVIAJNXBCdtntPSDz/9Sl9Yweaqiz8bAtgDP2jzjSGwz35x04d4njl1zdrCdN9vb0EAneDVexNs5I8Zk2kNdK7vYdsOcsbw0wvHXPjrzVd099SRQzFPCN0S3NWjOyLMiBnaayStrDGfY2qQoeS6DbCIvKeKFLXsn0c53zXm75kdlzI8oJiJanjhMofD8dmq5ZQLe2/C8+CbpHToRG+39cKDp5XtA75V5ajf2yYxnfCkS0gJ4Gk03jk69Y7xlxs4Glb8bbyRDeZIrF0tc1EcX9Pz7RiUU8sVOOZ1hUmiNw=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e24c7622-61ef-4d8f-ef70-08d80e1f4b50
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 15:51:24.4744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sDfYVjuncR370puZke7WWL912P056d+fgle0OW7joHr/D9+OGO/4nYs6i39OCB6zuM9Hq+rWYjgV58Hh5c6tpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB6008
Received-SPF: pass client-ip=40.107.6.103;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 11:51:27
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Filip Bozuta <Filip.Bozuta@syrmia.com>

This patch implements strace argument printing functionality for syscall:

    *lseek - reposition read/write file offset

         off_t lseek(int fd, off_t offset, int whence)
         man page: https://www.man7.org/linux/man-pages/man2/lseek.2.html

Implementation notes:

    The syscall's third argument "whence" has predefined values:
    "SEEK_SET","SEEK_CUR","SEEK_END","SEEK_DATA","SEEK_HOLE"
    and thus a separate printing function "print_lseek" was stated
    in file "strace.list". This function is defined in "strace.c"
    by using an existing function "print_raw_param()" to print
    the first and second argument and a switch(case) statement
    for the predefined values of the third argument.
    Values "SEEK_DATA" and "SEEK_HOLE" are defined in kernel version 3.1.
    That is the reason why case statements for these values are
    enwrapped in #ifdef directive.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/strace.c    | 31 +++++++++++++++++++++++++++++++
 linux-user/strace.list |  2 +-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index a7c3ea8df3..ee73ff575c 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1815,6 +1815,37 @@ print__llseek(const struct syscallname *name,
 }
 #endif
 
+#ifdef TARGET_NR_lseek
+static void
+print_lseek(const struct syscallname *name,
+    abi_long arg0, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_raw_param("%d", arg0, 0);
+    print_raw_param(TARGET_ABI_FMT_ld, arg1, 0);
+    switch (arg2) {
+    case SEEK_SET:
+        qemu_log("SEEK_SET"); break;
+    case SEEK_CUR:
+        qemu_log("SEEK_CUR"); break;
+    case SEEK_END:
+        qemu_log("SEEK_END"); break;
+#ifdef SEEK_DATA
+    case SEEK_DATA:
+        qemu_log("SEEK_DATA"); break;
+#endif
+#ifdef SEEK_HOLE
+    case SEEK_HOLE:
+        qemu_log("SEEK_HOLE"); break;
+#endif
+    default:
+        print_raw_param("%#x", arg2, 1);
+    }
+    print_syscall_epilogue(name);
+}
+#endif
+
 #if defined(TARGET_NR_socket)
 static void
 print_socket(const struct syscallname *name,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 35c66e9fc8..63e150736e 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -516,7 +516,7 @@
 { TARGET_NR_lremovexattr, "lremovexattr" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_lseek
-{ TARGET_NR_lseek, "lseek" , NULL, NULL, NULL },
+{ TARGET_NR_lseek, "lseek" , NULL, print_lseek, NULL },
 #endif
 #ifdef TARGET_NR_lsetxattr
 { TARGET_NR_lsetxattr, "lsetxattr" , NULL, NULL, NULL },
-- 
2.17.1


