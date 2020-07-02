Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21460C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 10:43:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70A282073E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 10:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="bBhMvrGN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70A282073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqwh6-00066w-Gx
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 06:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jqwgW-0005Ws-Mm
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 06:43:16 -0400
Received: from mail-eopbgr20139.outbound.protection.outlook.com
 ([40.107.2.139]:17190 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jqwgT-0007AN-Kj
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 06:43:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f04EIzhhszTrhEh2tNPTbIZZ0vNJLs5f1YHZmzSKYkDjpX/6r1rRWEttXKTfnrqHtS49/2qPc0510TBJacKTh1XCbdjMxd6fJLlx6pls7xjuIdX1QFcZFqNEGV8mjVmudr16VEfPm50CGFhMuswas32ZQaudhdJE0CnQzXAnGPnK0EyFmRF4LYF4POzJtjKe8uEPBJC/j+GFmGCVAU+Rq6wsRB5iTLeTlOpLsbrC+r4qECmlQmrN9ohrShB4MwZXHvlniBuOC1EKdYYHS/TjSfjoZwfGNkc+uOchrp4NUSrDD+H2iBnhHPhB+FiL+VbimdsbKB7UziJAwzEJbVW8hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSTWLXdS3w6MmeryU01K+PD9fcbYcZZss6p7jn705Cw=;
 b=nQoVrOVBf7LeTLrbjzE1fhwHMkRTExM+hqdtrL52hwGubstlCIwAU3Uhrtf7NlRUek2OqD34Z4bX2XXWAbua5HrkpMEp9LCQO3VRAHU1xRbdVM0PT3QgqGGgNaij/cpEaNasuPR8BExIUStsCcRxefL9z9X5Gu6SGS+ttw2qPQ53BlP2fFqSzkUfYgIRwbXlkJwMjWi8VWuUy5O3md8IP7QmPgOkLkYr4JwYrEj6rtjQxEps8XNMqbDnz5/wtRlhuGn5raQ2WsI0T0sNlYJP1RqoNPqtp7EMvrMWIv7qaynoXFGYPq7IFEa9A8k/5gaymkQ7ui8dn1IsAG352bzxIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSTWLXdS3w6MmeryU01K+PD9fcbYcZZss6p7jn705Cw=;
 b=bBhMvrGNyN02ty7Kabek19/kW/cxyxgumGtYiLa4HhYtSh55w96hSFHO/tajnE1VnXfJXpEQC9nPigz0M4yFVxgm7K5g+TN48rqCoMjFe0QjROEu1HeSjDq/cRj6rYHiBlB+kqnAYx7rGbUDwMFA36HIbPkrKY6h+IXhQVPTT/c=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR0302MB3221.eurprd03.prod.outlook.com (2603:10a6:209:16::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.24; Thu, 2 Jul
 2020 10:28:06 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3153.023; Thu, 2 Jul 2020
 10:28:06 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] linux-user: Fix "print_fdset()" in "strace.c" to not print ",
 " after last value
Date: Thu,  2 Jul 2020 12:27:49 +0200
Message-Id: <20200702102749.22178-1-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0015.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::25) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.235) by
 ZR0P278CA0015.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.20 via Frontend Transport; Thu, 2 Jul 2020 10:28:05 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [147.91.217.235]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d8242ee-dacd-417f-7c2c-08d81e729bda
X-MS-TrafficTypeDiagnostic: AM6PR0302MB3221:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR0302MB3221527DB0F15E76A23EEB63EB6D0@AM6PR0302MB3221.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ASnhvNaagnr1ylbZtomzyzmPqwdF5nXRnzC406tsjke12nyoaE69yem2ky63DPjmBDhNfdfMzo+F3e+IRhGNmkfEsNUsMqU5puuk1219ZZ5C8gUMkVdfIrvR8AInHFS6epAQnmIgiCx+secNVDvrOiY96XcNXabgt/Z2pbOnFDBkJJ7z3Es+u0IvY3pBu7pDrGCp3EOogMfyKgqCY/+c5LbX6qwOZBknJDCoVWZqmMnTz5KzGovNig9ZQg+J+7E4cwYFS17ZMrkR45D2RZOJdwGlTuN5CPqZp3R7SgViAiT+RWYEbvuSu7x1lMmD8TWNMQFb/YH297wF86V1ItB5b7YmaJyd4kovrKvx9GsyCiJDxDuhZzTdP7xdUdBL8oqE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(136003)(396003)(346002)(366004)(376002)(39830400003)(66556008)(66946007)(107886003)(36756003)(5660300002)(2906002)(186003)(16526019)(6512007)(86362001)(8936002)(956004)(26005)(2616005)(54906003)(69590400007)(316002)(66476007)(8676002)(6916009)(6506007)(4326008)(52116002)(6486002)(83380400001)(1076003)(508600001)(6666004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: lMlLQcqWMbDuULIUss9BRs6oT8SiXJ7hlR6XyNFo5uG4nj9N19zw4LACKcTyOjNOjpNnJTiQA7c+Hp6pXn9PHJL1z6j5JkFNHLsTiqZlKKSUGsIrhqQugzTeSlp3S3gfURNgR0aoVZ7blZ43iQmFtEFfo1G4dIDyynfvlUB5TrjCxm9rjsWU7wUmhdkX8n4vSu+JhRf1Uv0Y+FJYK6/cWcijftG+RBGJvBYxLEPXT/KiHmEf0K1geu4CNhNw0q8LvK3fdxsQRB+Xy78hpVu7yF1ay0qzcRVTxKAfuB0ZtgZ2lwAF4n31Eajlp9EzRv5KlXXrqCVqZGdgH3MDBHHc2VioSeaUf3ClCidMXBBd36dGPYo7RcrJe1fOflN6CkqFACqdsiCAj93kh3CYZQS0NvHdhmu9PbU1wnI6kctvyYNBsV8ogmSIw6Z77+MXCbXXz/Y0bydG7tZCi+B6923DQA0EdNrHrW1OgUe2+d/kbZ0=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d8242ee-dacd-417f-7c2c-08d81e729bda
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 10:28:06.5735 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Os4J+3T6fRUzoxktdDUhIKhkoL4a+cOEeSFwZB7WA+ARhoPS7RKn9iin2GMApFk9b+fX/G38U9/EZzDdDo2GsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0302MB3221
Received-SPF: pass client-ip=40.107.2.139;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 06:43:11
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Function "print_fdset()" in "strace.c" is used to print the file descriptor
values in "print__newselect()" which prints arguments of syscall _newselect().
Until changes from this patch, this function was printing "," even after the
last value of the fd_set argument. This was changed in this patch by removing
this unnecessary "," after the last fd value and thus improving the estetics of
the _newselect() "-strace" print.

Implementation notes:

   The printing fix was made possible by using an existing function "get_comma()"
   which returns a "," or an empty string "" based on its argument (0 for "," and
   other for "").
---
 linux-user/strace.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 6044c66954..23ca5d88c8 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -541,6 +541,7 @@ static void
 print_fdset(int n, abi_ulong target_fds_addr)
 {
     int i;
+    int first = 1;
 
     qemu_log("[");
     if( target_fds_addr ) {
@@ -555,9 +556,12 @@ print_fdset(int n, abi_ulong target_fds_addr)
             return;
 
         for (i=n; i>=0; i--) {
-            if ((tswapal(target_fds[i / TARGET_ABI_BITS]) >> (i & (TARGET_ABI_BITS - 1))) & 1)
-                qemu_log("%d,", i);
+            if ((tswapal(target_fds[i / TARGET_ABI_BITS]) >>
+                (i & (TARGET_ABI_BITS - 1))) & 1) {
+                qemu_log("%s%d", get_comma(first), i);
+                first = 0;
             }
+        }
         unlock_user(target_fds, target_fds_addr, 0);
     }
     qemu_log("]");
-- 
2.17.1


