Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537D8C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 13:07:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 230E220674
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 13:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="a1HBFNgc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 230E220674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg6df-0008JM-C4
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 09:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jg5UN-0000Ta-Vq
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 07:53:51 -0400
Received: from mail-db8eur05on2098.outbound.protection.outlook.com
 ([40.107.20.98]:20705 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jg5UM-0000f1-8p
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 07:53:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g43R9V5ivuHZVMWxB1V58cG2i5daayqAiSsreByhMpBRiuUTJaFPHOxscssA75QrkVAB0y4Olk8LrLZRGf9O/hMtVjOFmmaHXizBnNbb5sZCJXRkXZloI1TCHiTpR70SYFp/y0ySWnxpBw2lhVDi4RF8KoyrRkTjmLku9R17czlBHixAdjp8rZ+E4U/0XVa0Qzt+Gk/tvvIpHf9coxwJQt1fWMKR1Uz8rjCDILaR1ItdwH1EeYFEPbv6ZVFLHQfVs447V+5pTRdQtM6sGaC0jYfvAfmgmdhYHnIuPdG/9TY0l3PEte4Copyfa/HKBnv3YLlVu/2/8AaG+7KkFoepKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TY44iFpp45jA4aUldAT2cU45SX6PumUBvKPAEPX4oBE=;
 b=S2k+Ao59VEhLVLe0YVOd398pLMAQzKpYCCDNjZ0WAWqHEEmYmgh6ouhzPt1DgpY8VjMNnfdB11vAAiZr6let/VdLtt8tBKTsYMGmw+wIj73dxTdzozPpdqvXhXdJLeJA2MuqdBSOQEZs9bGlEIBeJrFCjhuQ72j13A7ZG2/SjesNm4S0XqLFMz5D/m9fqqV32PD6rVaq3MBpbziy+5VCshanH0MoJwXTGZSBqOLzpW05Uigff2C8HKofeOARyqxHmUI+lXyem9SFxIw9B9YUfiI9RzbKyZDqj94EVtAd3XbCeRStyMRuBaO08jiagtdMEWdUavGuTt2FR8UTQqEYeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TY44iFpp45jA4aUldAT2cU45SX6PumUBvKPAEPX4oBE=;
 b=a1HBFNgc2ZOSYinITR0a0H/PdfiaAPHCAVlSUiBNMWIHLcqdRZ7/4+Bx03z/N88dm1pR4USTftg3YXByZy+ql3I51KIUzSRra58gF16oF5kHkCtNytInEyZUqjOn+1yhc+2U43K2pngiqccNgTdSOPBx2jt2l41ovRKFWMYdej4=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB4022.eurprd03.prod.outlook.com (2603:10a6:20b:22::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.22; Tue, 2 Jun
 2020 11:53:45 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::7935:50dd:e879:bca8]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::7935:50dd:e879:bca8%7]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 11:53:45 +0000
From: Filip Bozuta <filip.bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/5] linux-user: Add strace support for printing arguments of
 lseek()
Date: Tue,  2 Jun 2020 13:53:29 +0200
Message-Id: <20200602115331.1659-4-filip.bozuta@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200602115331.1659-1-filip.bozuta@syrmia.com>
References: <20200602115331.1659-1-filip.bozuta@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0116.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::32) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bozuta-ubuntu-18.syrmia.com (46.240.135.226) by
 LO2P265CA0116.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:c::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19 via Frontend Transport; Tue, 2 Jun 2020 11:53:45 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [46.240.135.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ff77803-ffb1-48d1-c095-08d806eb9a9d
X-MS-TrafficTypeDiagnostic: AM6PR03MB4022:
X-Microsoft-Antispam-PRVS: <AM6PR03MB402250E78E9FCA995A233880EB8B0@AM6PR03MB4022.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0422860ED4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mqBxfN3cH2/KL2b3sbGbDDM9TTgJ6YEWc9iDPMo4I+whjvVTwSSaFtAGLDHrpUEh9IU6iTnJus6ejhk2A/vBpxtuX/TgdPUM0p75ztU75WDZB3rhT4andeLEwe8quoJNzgfYPaatpKzPeiY/NibwyutxgLNoNToYU+QZIWZV+TpzXvU72ZG4HZJlCDsZyJp4yFHtkPMEpJYor4wP+glDRD8FW65Ws2uaYZ3NmFoykAE/mL4k4QHy4dyNOWJQ18Gj1jxTU6DQ7Wyd2Uhgrg+6D2p7eZGWV9I4MlVHvGuhOzFkxvw9jS2k8uqI/Qevh0PTfyj4LFVOR3gFmI7zTpW6mG8IgL9jrpAzVhxc8K/m19W2cq6UvNT95tEmRLReTdGyrsIczTxHn7+lGu6CFsDvWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(366004)(376002)(346002)(39830400003)(136003)(396003)(966005)(44832011)(956004)(2906002)(4326008)(36756003)(2616005)(86362001)(508600001)(66556008)(66476007)(7696005)(66946007)(26005)(8676002)(52116002)(6666004)(6916009)(8936002)(316002)(1076003)(5660300002)(16526019)(83380400001)(186003)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: MVdfOyOCc8H+oDkAELDIVokZcsgcQGWKMqQYG1mCfMjDEyafCHRAepTF3eGsQKUCNFrpMU1GcofznuUwL6TOez6Gv9lyLn9P6m1lqpRX633DdfZyqG4X3P1PdQS3dsXDbYYa98zolfBN5JclDyUENBcxVI4MI2L1H3PJ4IOHF6Zty74GgecKMudQ4UoKu6wuok4VGE/WhAEn+nxVp1wpq5E+f6TeUjeqZX4Rq5fJ00tjG54Dy13HaPaYwPOxkVD5k2Ig6EMb7oIGQ1jKcP0m4R1wBKyDNq7zhp6kdo1k2wLsYsp2/cDhX6SsMjhElLIW9TpPXXQOlsjv7E0JCrqes3i2TcC8B+LAHhuRQeNGppzEu+A7EexXEulIh4R4/GqzLdnqAzvxPNygwSnVjKJ/ddn9hV6PFiiobj4roSNfcLdy7BCGyRr0WLFX6SO3LqrSiweWMXMaaZX+cr/6ORawWn0nyRI2eMkC+knU+bF56Ko=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff77803-ffb1-48d1-c095-08d806eb9a9d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2020 11:53:45.6264 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oLTDXS0C7jrVwGlt7zS+Hqp75Gk5m4Q4TP+TTFe/r17PFeDML1ZhNVb9aA5e5hwDy7LgRYUB+faZOLZYkIhN+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4022
Received-SPF: pass client-ip=40.107.20.98;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 07:53:45
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 02 Jun 2020 09:04:50 -0400
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
---
 linux-user/strace.c    | 32 ++++++++++++++++++++++++++++++++
 linux-user/strace.list |  2 +-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 5cf419989c..b7f012f1b5 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1768,6 +1768,38 @@ print__llseek(const struct syscallname *name,
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
+    print_raw_param("%ld", arg1, 0);
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
+        qemu_log(" /* SEEK_??? */");
+    }
+    print_syscall_epilogue(name);
+}
+#endif
+
 #if defined(TARGET_NR_socket)
 static void
 print_socket(const struct syscallname *name,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 8d51c54bca..5a56212532 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -513,7 +513,7 @@
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


