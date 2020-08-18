Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F78C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 18:23:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 732A920786
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 18:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="JCfy7zaF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 732A920786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k86Gi-0001xQ-MQ
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 14:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k86G1-0001Vb-6Y
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 14:22:49 -0400
Received: from mail-eopbgr60108.outbound.protection.outlook.com
 ([40.107.6.108]:25035 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k86Fz-0005pz-Bn
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 14:22:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXrTW8DFP1rToz5IHkfu5dyNLCdctD+3Q3m8eYCY8OZ/+ZSEYmog4Xgs9wmlw1rqBAtiOLFGMcnWO9IX6RaxiiWt+YnGBKHae+vZKdj7i8BSCUrJvXbhBsTgONREo+S3cCwMNb2vENOZNJARdJS3sSCB1xIm5KOES77YiL86T+RrOXA8hrmcx8AHP+WMoM2KsY2N5r0NbHF6uciwLH+7Mq8zg5CCg+CPQisDUJ/+0ANBwwgjHRlD0Ulm4+2GBR5YP6VwEn51O6GNVvlURwFaMTakVSUITMc12II2mvTTI2qWbYQQgaE+Fz7PGwbcUl6FyMKaNly5Sona1RWbepYGGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+FYmf/BjyxezQlZp8UrhVIrDoknkj+njQ1RNAkeIsOE=;
 b=ZprupNggex4PQ6ThqtwoQ84TeQ1vu7rl0poeBJosJ+PF/qMrSkDP31k9hny6FrYHNccMTNWTY24r7VDiORhuSv0cCyA+Vx8mCLrw5usRwFnMgBr4ZFN/14l/Quym46B4LhMPzotaB64AYQ8fzMqdcp6/lvD17Hfb4MoMSZAWJW0xywyquFA2LU9VbWa3DdWsAbM28YDQRYZJrbuBallJvyO+XHyv5+5hV3LMpi3N4NOFDrPPEzP/2ASSYjw0WcSUpjYJx2gTeuYxEq40l0oebOi6Bo2l6WAZKV0+6qeqia4/MDpu4/RuQP+zZtD5JnaMqM9W1uAXmmfWBddzUBWMeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+FYmf/BjyxezQlZp8UrhVIrDoknkj+njQ1RNAkeIsOE=;
 b=JCfy7zaF4rYnspmASNG+45h3p+Rb0Wyp9/UVO7ft72OgI7mHBXvmEnbv1+wudN/AXOAg67XOy6w5axiT6EjfNO+6Eahzr94TXRVMyf1CbIGj5gIp4aWw63p/z4PFO0jhi9sKm7Ud21wVDnU7he2exaocpJa9zODjE8k4xdtnocM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com (2603:10a6:802:a1::22)
 by VI1PR03MB6141.eurprd03.prod.outlook.com (2603:10a6:800:13b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Tue, 18 Aug
 2020 18:07:37 +0000
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362]) by VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362%6]) with mapi id 15.20.3261.026; Tue, 18 Aug 2020
 18:07:37 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3] linux-user: Fix 'semop()' and 'semtimedop()' implementation
Date: Tue, 18 Aug 2020 20:07:22 +0200
Message-Id: <20200818180722.45089-1-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVAP278CA0008.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:20::18) To VE1PR03MB5246.eurprd03.prod.outlook.com
 (2603:10a6:802:a1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.242) by
 GVAP278CA0008.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:20::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16 via Frontend Transport; Tue, 18 Aug 2020 18:07:36 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b38bfaa6-52fc-4360-2f92-08d843a1967d
X-MS-TrafficTypeDiagnostic: VI1PR03MB6141:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR03MB61412A100BDD9F86463F986AEB5C0@VI1PR03MB6141.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FQIdcNNL/lfL+SBNHvckhi5eIdo7EnH1rXqb9joWlq5//DqG7rSHGg3fW/3rKk632Yhj05miKn+jNxhys9UmhtjmZ6WNVqyiWAJ8rR5LoZynNpKkk8OxDSE/U+uCmiLxzB1BsL7Zj8R26bsOffX308T3rZ9iXpS/QBlDRRyKKthlEIymTt0nQJhzY6lj2S4+xNa+kSG3Bo7cbgUjXXdLK7XAc3A59jVdvZueVMx6Wln4Vf1abqo+Kk1dJ41bQ/0yuV0RrTaCuUO3RMDFVtMtc9kQtB8aw//ETUO7BMwjKwIc+1s1/bYbO5tjgNJe34jX425ukOKV48RizN09W3g3rmXiRrnDq1JngU8tTjpr5HlWIAEdHD81xHwNDgKFsW81
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(136003)(376002)(39830400003)(396003)(346002)(66946007)(54906003)(478600001)(107886003)(86362001)(6666004)(316002)(4326008)(83380400001)(36756003)(69590400007)(6512007)(6506007)(1076003)(66556008)(66476007)(16526019)(6916009)(52116002)(186003)(2616005)(2906002)(6486002)(26005)(8676002)(956004)(5660300002)(8936002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: /F3gFpTnQecY01FjEIg/0ozhODCBIq1XKTG0MJuQggiKfL/eLxQAAXmajpNrLAWxyktjKj6MDwnpOO3WqLGsPYTiBh3dkcPeKy6QSQLIyRrhd1QdamGQxhSKWchBNy2UpesuSsrUNsb3tXNOi3+a+E4tSLLDHNrTUxMjf/QFmeJJ82ijvPQDwVBEAkxuBVFvUImuFvs/smD4l3TkWB7wtRrbB8irsKCNQqTYmICrLc7taD8rKbIWwGgfYuhX4OTEkcmubxuIAKmi1ZVIu7MtVw0rLBJiEVCjtiJAcGr09/sq9Dxal39Ra/txTuFzbdKmzqiLJH+U27D8npM0QZt1qBs4mY2xrIr9LLYN7EOZVEElcGregLGiInf24woC4DXBjDXwwzHc8CIJVH6Kbsxmmdtz1XHWHwZx4YPjWsyZHmxlkfl3AOgZ6scnAzaRNmguYvaF3fLYgsmNqoiy6CqU+XY4Y2oWBnph0bxbdfTI0HmV+clyr48IUQmmPMLWgDbOw9p0WvqksnhEliI+Jps2oKt7dUvzT7QkYB2VipfyTUJ0M+mEFNKJ1Hl4My2BOq7NgY5zTslbDW+g9CHhhSUoyseRqnKckr/gNKF7emoONUHRn9PwPuPVWuAmdqMH50yn57OXPCWTQ0MLYpSmmdPvxA==
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b38bfaa6-52fc-4360-2f92-08d843a1967d
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2020 18:07:36.8945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3iAfGK0S35m9qPGXYC2bNZQY+GKGxgMVn1Po9q0iFQpLs3zrFI7BPfNOZXH5+tE2hvpkAovkKiDeYFBQ2Pmyxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB6141
Received-SPF: pass client-ip=40.107.6.108;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 14:22:45
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

The implementations of syscalls 'semop()' and 'semtimedop()' in
file 'syscall.c' use function 'target_to_host_sembuf()' to convert
values of 'struct sembuf' from host to target. However, before this
conversion it should be check whether the number of semaphore operations
'nsops' is not bigger than maximum allowed semaphor operations per
syscall: 'SEMOPM'. In these cases, errno 'E2BIG' ("Arg list too long")
should be set. But the implementation will set errno 'EFAULT' ("Bad address")
in this case since the conversion from target to host in this case fails.

This was confirmed with the LTP test for 'semop()' ('ipc/semop/semop02') in
test case where 'nsops' is greater than SEMOPM with unaproppriate errno EFAULT:

semop02.c:130: FAIL: semop failed unexpectedly; expected: E2BIG: EFAULT (14)

This patch changes this by adding a check whether 'nsops' is bigger than
'SEMOPM' before the conversion function 'target_to_host_sembuf()' is called.
After the changes from this patch, the test works fine along with the other
LTP testcases for 'semop()'):

semop02.c:126: PASS: semop failed as expected: E2BIG (7)

Implementation notes:

    A target value ('TARGET_SEMOPM') was added for 'SEMOPM' as to be sure
    in case the value is not available for some targets.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 linux-user/syscall.c      | 13 +++++++++++--
 linux-user/syscall_defs.h |  2 ++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1211e759c2..e4d12c29d3 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -3904,7 +3904,7 @@ static inline abi_long do_semtimedop(int semid,
                                      unsigned nsops,
                                      abi_long timeout)
 {
-    struct sembuf sops[nsops];
+    struct sembuf *sops;
     struct timespec ts, *pts = NULL;
     abi_long ret;
 
@@ -3915,8 +3915,16 @@ static inline abi_long do_semtimedop(int semid,
         }
     }
 
-    if (target_to_host_sembuf(sops, ptr, nsops))
+    if (nsops > TARGET_SEMOPM) {
+        return -TARGET_E2BIG;
+    }
+
+    sops = g_new(struct sembuf, nsops);
+
+    if (target_to_host_sembuf(sops, ptr, nsops)) {
+        g_free(sops);
         return -TARGET_EFAULT;
+    }
 
     ret = -TARGET_ENOSYS;
 #ifdef __NR_semtimedop
@@ -3928,6 +3936,7 @@ static inline abi_long do_semtimedop(int semid,
                                  SEMTIMEDOP_IPC_ARGS(nsops, sops, (long)pts)));
     }
 #endif
+    g_free(sops);
     return ret;
 }
 #endif
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 3c261cff0e..f7f77346be 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -46,6 +46,8 @@
 #define IPCOP_shmget		23
 #define IPCOP_shmctl		24
 
+#define TARGET_SEMOPM     500
+
 /*
  * The following is for compatibility across the various Linux
  * platforms.  The i386 ioctl numbering scheme doesn't really enforce
-- 
2.25.1


