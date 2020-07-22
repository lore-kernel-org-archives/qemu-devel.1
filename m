Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02AAC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 20:07:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA42120771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 20:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="jWO+jxoS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA42120771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyL1M-0001df-V3
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 16:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jyKzB-0005wG-Cm
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 16:05:05 -0400
Received: from mail-eopbgr150133.outbound.protection.outlook.com
 ([40.107.15.133]:53875 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jyKz9-0002ER-Jx
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 16:05:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFQ2RZ6ULmc6VH7QUfRm2OstwHaT9dCLcWy8+2rzsZkk0JqZEg1lJMdqfqV4sSRSFeyQeKWBb2j74Q6yo/t2q27A1/vPz2SxS5FeKUp4V0Ivsi54+VJPslTojsB22DuDHYTJWb8vJEvDfBx7TMA4yxfnhEYM1cP+mIIh2VVa8mKFEMlkSxlBJIM/TfKLvOJMa3fzsLwDqhA2P7k/Dk19fBocFANlLFQRxqxfDRDSeb5gkAIzKnN8XmMilbBxC9DnPbG2aOjZylUHv5pxPxK3n4AF3vteTCsITLDT09t2vU67BzktBgMeU/ZQI6c28W34PDp8UEJklfkTuNnl0lQtMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7OIqO9CChWGnkvWcc/ALFlHMwEg4G/35BGJlwS/iAU=;
 b=EDcERq3GriuDgO/qMXPp00004bH2JWe61SX4h8tHpcaL8S8/74qGKeQL+LgSaHSp/6SLYCNIa1y2Ui59bmjSYrlPvedploWUta8W2iFqzfX8VnxurIDJmxk/psxKTUreOiNVWUxIxk2rGgwvEM6ix33069ceMiietlEe4M3+mcZx69SUsGqgdN1wYtsry5hgN6+K66N4NKcloThMLQja+3tdw43IwiZaJNxdq8Y9jqBCUiB8Kbrx8+Fxx0W+mxsaMPGVOgxay3gbu/dYw0b9VNrhFdTIh0P0Ydx+3c0CzMkNnfbYCvs4FbwZ8n8O+IgI/mcbQJ7xGbDKZlqeK147ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7OIqO9CChWGnkvWcc/ALFlHMwEg4G/35BGJlwS/iAU=;
 b=jWO+jxoSn9KQXHA5/c8U9TyjyHAE9tHUR+FimzQdAmCkVbOlpITjjTKb0XpIRcw/NrZKRA1GKVEzljPwdYZ/XJo9f5nDWz1V7ik3ScuZR02bVBZpGSyOBBEaNYSZqzAufRiTW1SUZeknWo/+Ma77hO/fZr+cZjxVFUyYqjWcXnc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM7PR03MB6563.eurprd03.prod.outlook.com (2603:10a6:20b:1c3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Wed, 22 Jul
 2020 20:04:56 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3216.022; Wed, 22 Jul 2020
 20:04:56 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/5] linux-user: Add an api to print enumareted argument
 values with strace
Date: Wed, 22 Jul 2020 22:04:36 +0200
Message-Id: <20200722200437.312767-5-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200722200437.312767-1-Filip.Bozuta@syrmia.com>
References: <20200722200437.312767-1-Filip.Bozuta@syrmia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0029.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::16) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.237) by
 ZR0P278CA0029.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.23 via Frontend Transport; Wed, 22 Jul 2020 20:04:55 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.237]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48e3f11c-1ae1-4993-9a41-08d82e7a8103
X-MS-TrafficTypeDiagnostic: AM7PR03MB6563:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR03MB6563CE8E9D21E52F47E14FF4EB790@AM7PR03MB6563.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SSjQRyKZu84/GPbkXGduLEE1YHZoohBY3BsvUuGRi0MXMiiaweWycUZZU2UK03dCYYjnXn4D9dqM3qFELR2giRpVYFuuiUW2xv8fwEshOouE6bQ818XHywefwoEJpndSHcO3TWlNGUMYYSn6SKEWlHQwuphW/2L5P64Wbmr/8hET1VTrrPQ+FXHuVQ6bmSYi4hzKarAUctsWc+JIlu3Oosa2MN8KY6yit+c2NaB5zFvfphEgLiJVEb94VKJizHw+WmVxbgJFV6CvASJ0FrRL4uujgg0mf1ilr1HJ/P4wpraltJX5AQS4m56LuPH2GZ3TqJ7gqNZSWx+AWb7CvnH7ZIvd2V6K2T+FZzsK7IhdYeRc6oLddUe/Cty7x4GQ5J5l
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(396003)(366004)(376002)(346002)(39830400003)(136003)(107886003)(956004)(54906003)(26005)(316002)(6666004)(2616005)(1076003)(69590400007)(8936002)(2906002)(86362001)(5660300002)(4326008)(66556008)(6486002)(6916009)(36756003)(6512007)(8676002)(186003)(16526019)(66946007)(508600001)(52116002)(66476007)(6506007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 6UwkXLJ39pGmexRwBxpJNV7T8siu8QGm3e9qcNFrPZD/bNuV2eoW+qfWEX0zaYgMZecSc72ilm5sGLP5peWuUIrY1Cq03rMRbSSvQayenESu7W9M27YXa6jJW1SUK7/m631GxmjV20iiOwQRFujwO8oFfL2ILGAot1eCFxJpNcDklkH58FmVaxI/pPfREny0xig45BY1uO7JzwpiCLfg+iOE17TcSvRv3jFQJiOJkxmgxfQAHGzcolI8j6Nw6wMbJBEaXH0S5TAEPbtredGgAsNX3FqoZVCDDFb/YCentz6i3XzDa0EXRoE3rqawA0Zto36ryixZDmgOocq+rQpkjiOBlW5ByoalHcF5kxlMSibolc14DWkVBhiQsLxVMPrrHprc/1b8og22wV0l/o0vNL/yNOqk4fU2TaLWJZKSpyr1qDQP8gnDKj0z2hhmH8fgSBvYmRqh5C0hqWmsRY3v0EufoRaPttWi6CDzgAanHEI=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e3f11c-1ae1-4993-9a41-08d82e7a8103
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2020 20:04:55.9579 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +OgIruhCrVAdTjHH9ikOusr/VkG5DTDlhS8EViP65gAIFXjPTKuGW6tS6E0ay+4ZElQ5vhLtUlYab6JsNRcH0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6563
Received-SPF: pass client-ip=40.107.15.133;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 16:04:53
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <laurent@vivier.eu>, Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch introduces a type 'struct enums' and function 'print_enums()'
that can be used to print enumerated argument values of some syscalls
in strace. This can be used in future strace implementations.

Also, macros 'ENUM_GENERIC()', 'ENUM_TARGET()' and 'ENUM_END', are
introduced to enable automatic generation of aproppriate enumarated
values and their repsective string representations (these macros are
exactly the same as 'FLAG_GENERIC()', 'FLAG_TARGET()' and 'FLAG_END').

Future patches are planned to modify all existing print functions in
'strace.c' that print arguments of syscalls with enumerated values to
use this new api.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 linux-user/strace.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 40f863c6e2..def92c4d73 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -52,9 +52,23 @@ struct flags {
 /* end of flags array */
 #define FLAG_END           { 0, NULL }
 
+/* Structure used to translate enumerated values into strings */
+struct enums {
+    abi_long    e_value;   /* enum value */
+    const char  *e_string; /* stringified enum */
+};
+
+/* common enums for all architectures */
+#define ENUM_GENERIC(name) { name, #name }
+/* target specific enums */
+#define ENUM_TARGET(name)  { TARGET_ ## name, #name }
+/* end of enums array */
+#define ENUM_END           { 0, NULL }
+
 UNUSED static const char *get_comma(int);
 UNUSED static void print_pointer(abi_long, int);
 UNUSED static void print_flags(const struct flags *, abi_long, int);
+UNUSED static void print_enums(const struct enums *, abi_long, int);
 UNUSED static void print_at_dirfd(abi_long, int);
 UNUSED static void print_file_mode(abi_long, int);
 UNUSED static void print_open_flags(abi_long, int);
@@ -1248,6 +1262,23 @@ print_flags(const struct flags *f, abi_long flags, int last)
     }
 }
 
+static void
+print_enums(const struct enums *e, abi_long enum_arg, int last)
+{
+    for (; e->e_string != NULL; e++) {
+        if (e->e_value == enum_arg) {
+            qemu_log("%s", e->e_string);
+            break;
+        }
+    }
+
+    if (e->e_string == NULL) {
+        qemu_log("%#x", (unsigned int)enum_arg);
+    }
+
+    qemu_log("%s", get_comma(last));
+}
+
 static void
 print_at_dirfd(abi_long dirfd, int last)
 {
-- 
2.25.1


