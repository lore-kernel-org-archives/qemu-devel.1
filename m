Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6415BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:42:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D4BE20767
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="Yz6XLp+8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D4BE20767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl930-0002bF-Ca
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 06:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jl90T-0006wM-5G
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 06:39:53 -0400
Received: from mail-db8eur05on2134.outbound.protection.outlook.com
 ([40.107.20.134]:62689 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jl90R-0002xj-EQ
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 06:39:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwTasGX//spULDwOFfCOJWyI1iWBoobQAnqLtRWMGoBly/g4ru0IyMT94+xHPtHFpQVwwVqRguIrzh2IaZ21irIi7kWpvFZAx0UOApzNnp5ERS9W9TUZcsU/yvgYa5yS3/00Pg7IDrRP23MSeTjZTcgVdU/xVlx9i/IunI076Kx3sXsVz0xy/0yD6qweA3wQm5TT6U+jOP/2UFaN3Y+Aa4iDpmDjVJVXPs2YjJc4FGq82l0UNOAIqTOaAO7r+0DpSYpQsIBbEq4J7JCNqq/ughx5Nh+h6gDjX2Xf/h3EiBADPnwU2gxupcQ/WOSmDf6rz8JUYbVAdO0o8y8OxnRYjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wAkJOpp4vVJfx2IroOpDJITNyxXboEoL4zNW1eRyqo=;
 b=Ve9iY54t3G4YajDCN/eTpULwtnGBgXst9d/LPrTi9wclquKShKHu0b+QYcqEJ4l20hyWsGM9hYa79tuhG9vdIjM5s7fJ3oym3pGOZpWWVmudp+WhWn3MvWllkhrwl/BjrH6U6YnBdrScaap9kSwTlYTSYxeaa7VEOhgv/nReYYKlMix2E8ZeSHwQnjhKjzYHYl/UMkPfhB9p4/7CIM31zeLxi4MTI/4UEMFukTGWA2x/ogbJPTuhWNNh6g6hRsjMjUaaL8qW9kTcvMnCdHgfnZJJ9CVh3ubTvUhTtHlc9JmKoi4rdV2P2KM9i8K6iiF2OxFA8qoZmY1kOfEsLc0ruQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wAkJOpp4vVJfx2IroOpDJITNyxXboEoL4zNW1eRyqo=;
 b=Yz6XLp+8X0Bi3Y0qmdvfN397giN+waxpit0q85/jwArzd2Yj0xkpsIlOyrTR5U8SctY3DwRB7h62h7rqdojts9D2eUOoHYIjtlRYE9dS+olQb4+/tlhC+vbOJzy6rhcwL8EQRAEz9b3MTWTtr9z6xiMoXZxn34igqbpyejk/sEI=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB3960.eurprd03.prod.outlook.com (2603:10a6:20b:25::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Tue, 16 Jun
 2020 10:39:42 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 10:39:43 +0000
From: Filip Bozuta <filip.bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 4/6] linux-user: Add strace support for printing arguments
 of lseek()
Date: Tue, 16 Jun 2020 12:39:25 +0200
Message-Id: <20200616103927.20222-5-filip.bozuta@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616103927.20222-1-filip.bozuta@syrmia.com>
References: <20200616103927.20222-1-filip.bozuta@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0046.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::15) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bozuta-ubuntu-18.syrmia.com (46.240.135.226) by
 ZR0P278CA0046.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.19 via Frontend Transport; Tue, 16 Jun 2020 10:39:42 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [46.240.135.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 029fc219-4f4c-4324-bc0f-08d811e19462
X-MS-TrafficTypeDiagnostic: AM6PR03MB3960:
X-Microsoft-Antispam-PRVS: <AM6PR03MB3960DDB858E4D8BB3DD704E6EB9D0@AM6PR03MB3960.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 04362AC73B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QL/OCHYyJokb+4EdOCxS/hy6qHgCBnVgWuGzEq71C/Tw+GvPh4n6UuSI/YBGSf5Vkz7w6+Yad82Tg1nsbU3W8yxZ7zGxtBsYyjaxtqLyKMgKrASYyh5Z9j7ns7nN+BgEqLh8sskPQvCYDd4jI5TJWCn7LUcWXfWsk0ylQZzIgo4ppuhyvE3Lk0d9JryxVEQMmp/AZLyGLdqqEE1USwyKXa98T6JMAs1k3yyfnVbS/q+78LZltcmDLazyShwkgnef5ENVxEW1K27mM9kJNvn19S9nbyJ2WcagcEXf3JWiXIjhmMVP4XaJmlVfQ26KYoSzxoCUJmgyelIZQ7+NDuT8ZWUkHUTyHZDbxSWNimiFaJyDyT0QHYTGzYyfYCyI7fkbb0xxtSGgbqHg0i8aQFtJ3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(396003)(346002)(366004)(39840400004)(376002)(136003)(966005)(5660300002)(83380400001)(86362001)(508600001)(8936002)(316002)(6666004)(66476007)(6916009)(7696005)(36756003)(2616005)(52116002)(66946007)(66556008)(956004)(44832011)(26005)(1076003)(2906002)(4326008)(16526019)(6486002)(186003)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: UpRdYPBq62NhlC5rZrX+km5WixIq84APBt+w8mkZ5nKD9ybp6IKjUhdqjAC9fHjjXdCokEbSl6UqJI6KKjaOMrhFKsCuKSFAyDg5izL9oenokx75pcxvGJ51Ue5j2J9zHoY8UgIXzeZ2ZvgoF5soI35cWGmG7gpNiA6aHhr9blmDrhZ4EQz1Xf8ztQRBjX8go66A6Irtpm4n57lG+vseIox8X2phb8KbnMwq+tONHu11KI1ma8ALcSHhOZD0Wraf3P/dyx3J5uaNr6MnGd2pc6vg5rUCpVd0raZBETA3pW1I5juKxriCpoPZvwOY7LgyolYHZ/kray1RRVinf0RhZu1eVT/tcJ3wWPrqoPJjcOd4zpAf8ASBuieUd4os6ByrO9vosgevqj8Wi/+dNszHmW9n6rgmGggGCvCNx0PploTc6sBooJJssjKvLCZ7E/u52CEqt5QXx4oIQDrQpQnVQXSSnJgXk5msvqVpZaOeB88=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 029fc219-4f4c-4324-bc0f-08d811e19462
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2020 10:39:42.8876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: byQe/7mgCKY6ta6OwwrxD6uqc6zwnSYVkx56RscCU+jMAvUKy5Lst71WkL5zuuRcLI3n7k/u0/TIC5fdt165ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB3960
Received-SPF: pass client-ip=40.107.20.134;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 06:39:47
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
index f76bbbc1ff..db561dc4c9 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1841,6 +1841,37 @@ print__llseek(const struct syscallname *name,
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
index af12b23276..905a9c395c 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -516,7 +516,7 @@
 { TARGET_NR_lremovexattr, "lremovexattr" , NULL, print_lremovexattr, NULL },
 #endif
 #ifdef TARGET_NR_lseek
-{ TARGET_NR_lseek, "lseek" , NULL, NULL, NULL },
+{ TARGET_NR_lseek, "lseek" , NULL, print_lseek, NULL },
 #endif
 #ifdef TARGET_NR_lsetxattr
 { TARGET_NR_lsetxattr, "lsetxattr" , NULL, NULL, NULL },
-- 
2.17.1


