Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4B4C35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:49:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C5B220659
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="GnSS/sns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C5B220659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1cSw-0000Ro-QU
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 15:49:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35395)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1j1cG3-0006fG-U8
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1j1cFz-0008S9-06
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:47 -0500
Received: from mail-eopbgr690106.outbound.protection.outlook.com
 ([40.107.69.106]:43233 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1j1cFy-0008My-D5
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A32sUcqgl70YUsuFqn4vC4ciNpXt2rwQpzz5L8X7n2KuIwGxChU8Rn/kZ7qifV9DXiWpnX+f7HFHHqcfWLjy3W2+yxkEW/9+1RYqlR75I0Y5yOagE+wUdW0MqvtCo0vExZyM+byqJyNp2+gOrrcoHJjfVTwEHZvDS5fbOLoF0AICXg0nvq1NU1JlzKEcGIuOnk/ZNs4NDAMvLuRqTUSRn27on6GOvxNSTPbZ2rwMpD7FkKt3ecl4XGfiVnjVm3pou+3yTdri9Rru+IN80DuHv6cKyzflL9EXQYEOWKP7f/7zn8T1L2BfWlTyiosF/BZM0uxeljPuD8OE0VVby8u6Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hkh/R5nFd6Ghtc/QkVgwC9wl0JQAJ14dD2v8bKKRHCk=;
 b=eFNa7iOwLkfs18sHqlFZ3k+8rCQRNIF/wmhUBUoJ5iFi7xz1lkFDH6saW2yXYOxa2MgD3JOPMp29b0VDB8tJ9vOx0+mrk7KbXmoe9xjpsi/QoBgRPdSjMVorn5n1Q2DH4IiOpbnzpJe1HEM0L3bXotxV3XQZAiWUVIkGa7W2nlbpcLfw3wiLRYHJplQBQcdyEQZHIOAdMtiWhURZaE4xxc2m8GNZlTlckzRIJNVeCHZQU5GJIY9trHN2H2WhXXz94iIpdph03sW1POqsc60inCTV+DZTj6jIiHcGZTzAc1Ak6oiwRtnRIUq3023V0UjojJRCDXpCnqnsa73svskYkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hkh/R5nFd6Ghtc/QkVgwC9wl0JQAJ14dD2v8bKKRHCk=;
 b=GnSS/snsc3fhLWzj+Nw1cG+T0UCvPU84xLMvAmtiSTixNv3uiVYHnYaSGUa5E0A2icqnBCe961vR4Ulusyz8mOGkctIkLCXT191aRoXSqgZXsK1FBsuj04+eNB+AZJdGi4S45lPYHPHNrk7zw5Hpi6lMBNZwEHh0xVaeCmLutRc=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB4336.namprd03.prod.outlook.com (20.177.254.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.27; Tue, 11 Feb 2020 20:35:35 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 20:35:35 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 14/23] exec: keep ram block across fork when using qtest
Date: Tue, 11 Feb 2020 15:35:01 -0500
Message-ID: <20200211203510.3534-15-alxndr@bu.edu>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211203510.3534-1-alxndr@bu.edu>
References: <20200211203510.3534-1-alxndr@bu.edu>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0124.namprd02.prod.outlook.com
 (2603:10b6:208:35::29) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR02CA0124.namprd02.prod.outlook.com (2603:10b6:208:35::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23 via Frontend Transport; Tue, 11 Feb 2020 20:35:34 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0173771-a8c6-4832-50db-08d7af31f203
X-MS-TrafficTypeDiagnostic: SN6PR03MB4336:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB4336C6C8AF5800666743F026BA180@SN6PR03MB4336.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0310C78181
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(199004)(189003)(16526019)(6666004)(1076003)(5660300002)(86362001)(316002)(186003)(786003)(66556008)(54906003)(6916009)(66476007)(6486002)(66946007)(8936002)(478600001)(4326008)(7696005)(52116002)(36756003)(75432002)(2616005)(2906002)(956004)(8676002)(26005)(81166006)(81156014);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB4336;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xuWn+4fz7KJML0kDpUa3ouvfTEEpV32UqHBzMCdrM37BMSpoXR/MeXWBpXAaLjmfcPIPlqDsiDMjsWzh8VXTJRi6VLHeHv3NcKcZgmJtbPWJc9Opc/7OjO4bWfqXOPMGu5qwfiF1jFI8F9UIc0B1KRJi+TMeA5x0+eeE4rh48Kk8toYa6g3CHsgHVqBhdpjKYf9zzFcy6q+0dEhKJNWS38r68pNXUA3qmHe/unj/gXjU0oKyIvoV1Ej7aHnxssZALXYrx+qbV9HXng+0JvfkfsF2UWq66ueND7jly6bdvMOKxZYRl4+ZIhYlLx915BbYld3qt8D0G4CDcU+vEx1sxyDWbXTb5NqqC+1UovhZZZ9WW2jypW5S6B2fQUrue0dJJdLC8HGeyCXElOWtBEHipJwLKWLQzReKk6IzXvUok4RkxRm6LbEqhs7Nhvv8OFKn
X-MS-Exchange-AntiSpam-MessageData: F0V16MIrff4w54i4cQ4NPASk2/CtXZvCnfAfv/F1cT/rdIo1jB+qd8UIvgWre4B6nNNAhRxfB8ACBIyTy5QKA9wTKZKhlTL6/q1YwQJ/TgHLTcpDoxLtUTh8GYfkV6ZbPedW9UGOwhIkbwUrLApifQ==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: e0173771-a8c6-4832-50db-08d7af31f203
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 20:35:34.6305 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qn/E0UyFvjrD7WZA/0/M7vRx96d6yhAsMvE+WuzJvWtQUqro17dAvvzJ4FDdAJHb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4336
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Received-From: 40.107.69.106
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
Cc: darren.kenny@oracle.com, Alexander Bulekov <alxndr@bu.edu>, bsd@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ram blocks were marked MADV_DONTFORK breaking fuzzing-tests which
execute each test-input in a forked process.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
---
 exec.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/exec.c b/exec.c
index 67e520d18e..43f6659d12 100644
--- a/exec.c
+++ b/exec.c
@@ -35,6 +35,7 @@
 #include "sysemu/kvm.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/tcg.h"
+#include "sysemu/qtest.h"
 #include "qemu/timer.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
@@ -2306,8 +2307,15 @@ static void ram_block_add(RAMBlock *new_block, Error=
 **errp, bool shared)
     if (new_block->host) {
         qemu_ram_setup_dump(new_block->host, new_block->max_length);
         qemu_madvise(new_block->host, new_block->max_length, QEMU_MADV_HUG=
EPAGE);
-        /* MADV_DONTFORK is also needed by KVM in absence of synchronous M=
MU */
-        qemu_madvise(new_block->host, new_block->max_length, QEMU_MADV_DON=
TFORK);
+        /*
+         * MADV_DONTFORK is also needed by KVM in absence of synchronous M=
MU
+         * Configure it unless the machine is a qtest server, in which cas=
e
+         * KVM is not used and it may be forked (eg for fuzzing purposes).
+         */
+        if (!qtest_enabled()) {
+            qemu_madvise(new_block->host, new_block->max_length,
+                         QEMU_MADV_DONTFORK);
+        }
         ram_block_notify_add(new_block->host, new_block->max_length);
     }
 }
--=20
2.25.0


