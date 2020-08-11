Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2468C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 16:48:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B52642076B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 16:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="w6twi2Jb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B52642076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5XRa-0005z9-VD
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 12:48:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k5XPo-0003sz-Mu
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 12:46:20 -0400
Received: from mail-eopbgr50105.outbound.protection.outlook.com
 ([40.107.5.105]:15741 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k5XPm-0002xQ-Qj
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 12:46:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNeJS3Z6y70VVThCRSnEGqpoNHZlEPujMbYlJBC39ATVBDX+i56tEL8mEV8+pQUK7/QEE15yPLLmhN8niI6YpnPPjV3ODhIiMRekmquttK6jmFm//SE5512UsBR95/9ka9bTfb94Yd+QmAlemyp4JEhluEtE7An2wzlsfajrQkZOiLhrxW3YRXI46smU9T8kMR2noI8VT0vUPiWfts+gWIOsj5sAO/IoujhwTZmTPE0xTo5juNwtp+gzuEL12PWCdL87P6batZMVXYC8rfwigO5tZ8SMWRM7DKhQ+YLdDK9TBXpRpcDVE8e6tLkCBqsk0yDgXRj0bSGqyq/qdh/WvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxnDcxcgDKTF50IjaTRehSOoEG4aKIRSkscz2UcvKHE=;
 b=c0hNp9sBDNiVgi27KEjp5KkILZ2a6zipT8Smw9XfsI5YTPqwz7Hsh/+uSNVWEukXq2b47Fo3IXwI5w6dm3+lVwBkPmKpNsm9swJjgb+X8nmZK19wOBHj9W859S4SXr+5Z+fBdyBMiEtYXHJrQvg2Z47onJF+/+wKXmGJ967oD3uQj2zhbSJcPwdW8EwIE+KARasjPr/HwgPEYY6dxyVdKcS3rRRKi8i8YPvyBumNDnxn+UFfjgBK8EaSyr4Jn4wsIvcji56NI24mGchNWRyhQb97vzsjxwwJ1GZ1WHXD8rdHyAbK/FM1hDnvqjVyAGTBIVie94BpKV/O+a4epxSOSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxnDcxcgDKTF50IjaTRehSOoEG4aKIRSkscz2UcvKHE=;
 b=w6twi2Jby0AbQgQ1OdzjDzHjIOljP2Bu/frCOF+7pbcroh8BHUB6FHzOXFH9THY6JIG8EXrXD/4HHi/gUqy2+i5sX/dc0XFbXGAonFTXMBNIXNzomZu6LO30L6DeAiL0dE3iKsM/A447BjubHJHS6kV/OUUA5CraJ3aZipKBc5c=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com (2603:10a6:802:a1::22)
 by VI1PR03MB3662.eurprd03.prod.outlook.com (2603:10a6:803:3a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.22; Tue, 11 Aug
 2020 16:46:10 +0000
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362]) by VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362%6]) with mapi id 15.20.3261.024; Tue, 11 Aug 2020
 16:46:10 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 4/5] linux-user: Add an api to print enumareted argument
 values with strace
Date: Tue, 11 Aug 2020 18:45:52 +0200
Message-Id: <20200811164553.27713-5-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200811164553.27713-1-Filip.Bozuta@syrmia.com>
References: <20200811164553.27713-1-Filip.Bozuta@syrmia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P123CA0008.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::13) To VE1PR03MB5246.eurprd03.prod.outlook.com
 (2603:10a6:802:a1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.235) by
 LO3P123CA0008.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:ba::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.16 via Frontend Transport; Tue, 11 Aug 2020 16:46:09 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.235]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88d53055-376b-463e-eb4d-08d83e160d12
X-MS-TrafficTypeDiagnostic: VI1PR03MB3662:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR03MB36623BB24EC4341CF51254CAEB450@VI1PR03MB3662.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d5saxNUi6q36ME97BOLl0gIm4JxVQQKdsfjFBKQ0fr/rRrVCW56l7aETvkA54UjtTKeEuJUaHcDn3fyGKKhetgcUy0d8ReNWoW1DZAlRqhgWYGWd7JBjiw/PullOEv7lfqKgoghpw2wFo29neY8iuKFnYKyAXjcsmQcphJllSc3+EfpOUxjkRwku6tSy0fXy77NzAkfaVx9gt7SFNL+JfLsrT8aZHzokT7259Dl3eGuf/Y0whpAY++fIQRZ5sKH4/V5jPYpffPNQ/kWaQoQ+2LTP/jw+GEWV2kgnsIcolS3lkZ4LNbUhT+VttmdaSi8LM0VQRXXek+AzJAuhg4qQ/CqXn9bBegbJHEpG2c3P/nK2t8tn1m9pMdLeg1wHQXa5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(346002)(376002)(396003)(366004)(39830400003)(136003)(956004)(2906002)(508600001)(6512007)(186003)(52116002)(16526019)(66556008)(66946007)(26005)(6666004)(1076003)(66476007)(6506007)(86362001)(54906003)(8936002)(4326008)(107886003)(36756003)(316002)(6916009)(5660300002)(8676002)(6486002)(69590400007)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: mupOmZPT2XxVNb90ehTJXHk5IVtRqHE1rhKKYzQ//qOAhr44W6Faf9Po6wNuCgomsdfaNPGzuDkUd7XKJAN4KY8mbe9bh299dXTfrj6wSal9N8CZw38Au6RgHKmBadKzd+5/7VQ71eu1Suz9p8rCehlC6vytV0A2+PoCXjteWq5GbPjicnPhNKxxTy7Xb6tK+IqVm2YmQvzHNSDkDd5xHXRjhHKJz0Y/TMLa5VHCURzJHUlFr+Kwu5jmbP/aOvFKi1TWhI51wQ3rsDpQlsZ1VAPSxI0/SoCHMn8KtQtAeR66nhTG+VCDcNgxS0LCJF4Ewd8UBOQUiNaMNIV0GVY9B+U8SaGsiR1KAQ72ExQKCQzD/ZA1933GL+Li3N57VEOPbulKjbHxw950OJTnBKS/7p+1/qovtcd2Cc1QeSRtv4to1lsJcflWYBAWE5sd75fKvkOy/heD0dWUDUr+udiU1QEP/6dSb9jZ9PKmBQxQ7GoGiY5wa4ubxlcO/beKpKp+tgnRGr1u69Z0lGhayE+qpJgc7JNm9UKvRjuci9eBK0cP3JDtrg/cTZXHeJGOGe9r1Q/lIj3kPKmVY1gH9YFKffID2XI7k9tL/0Dyf2zvnIyoTHqDh4OWl2Wr6ZGLrwOyiqX94JOdBM/h4Iq9CcQTPA==
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d53055-376b-463e-eb4d-08d83e160d12
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 16:46:10.5209 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8kWwJTEt8lcBwLDTNT/OcGgn1PlZVeJMv8NB2ZCN/4drQUlm7jmFFljfXQTXxDCpFMXupR+/uXWSykrQZOAJHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB3662
Received-SPF: pass client-ip=40.107.5.105;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 12:46:08
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
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


