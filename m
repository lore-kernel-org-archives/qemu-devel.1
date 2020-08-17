Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C53C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:01:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFA4D20829
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="K7yYkUic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFA4D20829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7hZN-0006oy-RX
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 12:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k7hE5-00025C-U0
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 11:39:09 -0400
Received: from mail-eopbgr30138.outbound.protection.outlook.com
 ([40.107.3.138]:59478 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k7hE3-0006uE-In
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 11:39:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxfFsX1BOSQSp6bAScX9xcCMldyKOXzZbZkH2FBx99klH0SYdBtHB21Si5gY+JhcojFB9GCf5gKRTuZwiBZ0XVa57ps7XQ6dHHgqt7fqy0E8rbTlm2ThwMvjYajtjnIoyWxUYKYzNHIDEEfs/SbPJxDvQ4EnFpvnsg2lvGjcRR0e8U7b2JwNRg8SGuGttnlBeWYTOMqcj1HEQxQwVruG0hTZqoFencOuHhfjQAmrwoNWJFCOd/L57SN2w0iHsHHAhDJ0yHU+CumG0y0al3Vu48l71Zlrls7AULtseESC98D9r4li5x/PYqivpcYDNTVSHVOKDFmMtQM+xUr+idIH6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVpQaxT6ae9tOiOJH1O4FKrN83E/SD6xuYBM19lp1Pg=;
 b=RDMW/5HBS/CQQHWIyDK5qX3KfLNi/v5KvLdywQcYZ5PGtp/+P7fAobBj5yI4XgLOw/NdqqnN2NEru44ogKssr4jZnA434kle+lazBreausBMcEuLzMys9Eg7dxmcJrOuzQXC6JM6r0feSvtalSio45YyVs0wPg9eDyjZqZpgBdmGhqAXj0GQnQtGoxWsG0zqBTGZwamXx1GiqFWfNIYIpvuTiI+tS30Po2zS2PHRJdeYUkCiOq+RgzfOQalz2QZLNGGUabE0bvvBzbdQVniIvKQYkI4frIKNJkf5uobrYJiEi4MZGXqUrdni8ULYlfmuRdKagMTJiZhBNAYpvihH7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVpQaxT6ae9tOiOJH1O4FKrN83E/SD6xuYBM19lp1Pg=;
 b=K7yYkUicDl+NgSZvrxwUR0HRSJUqIOoeMvKmt5HSaXFnxQ4j6poHiPYHZ/eEz9nYBeylu8BxrHixW3hZwJD/xXwvDjfGUnu0vbrBzjVqA3XFnPONGvYmkoGPZ8LbrNq1Tox5ssIhsEV3B80UoDwoCwqsk3suYclIlSIuP+4jmKo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com (2603:10a6:802:a1::22)
 by VI1PR03MB4797.eurprd03.prod.outlook.com (2603:10a6:803:bf::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Mon, 17 Aug
 2020 15:24:00 +0000
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362]) by VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362%6]) with mapi id 15.20.3261.026; Mon, 17 Aug 2020
 15:24:00 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] linux-user: Fix 'semop()' and 'semtimedop()' implementation
Date: Mon, 17 Aug 2020 17:23:46 +0200
Message-Id: <20200817152346.32092-1-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0030.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::17) To VE1PR03MB5246.eurprd03.prod.outlook.com
 (2603:10a6:802:a1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.236) by
 ZR0P278CA0030.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16 via Frontend Transport; Mon, 17 Aug 2020 15:23:59 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.236]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbbc5986-3bbc-41b6-ce08-08d842c19112
X-MS-TrafficTypeDiagnostic: VI1PR03MB4797:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR03MB4797CFC222A4462A98D73A76EB5F0@VI1PR03MB4797.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NrNidV5k52fZhePqpWTrCN2U0lca5SRZj0WFKldw+mz0z+PrjLbd0WX04ryKCG3TU1K0zSLj9d2iB8aR/Lm58XzE5VnUgrC0GC/3PppTSf1BdFL/bB4rqLX+ft7NGFGUHXdHUhIq2dk0MdpQnfeKgDL6Pq2U1fj/thM3ZthHHJFcbBdCee2zFmd/ISeePDfgzRgg23b9+Dd0HGjvtYin5Iy0Agkl/zSzcOHUVlie2303sIPvuO9LX4t+6Udckt/wkEXqeTMYgiHo1oyc3ywNsIrCAjU/Ikv/luvhnjkvOGebRIvSv4sdveM23/3FbBw1Awwd2zSiB1nDcMcxr1XKneI/3o+g1CuI5UP6tSoRO9IKY++I5XJJGB1w5y72HNKp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(39830400003)(366004)(376002)(396003)(346002)(66476007)(66556008)(8936002)(107886003)(6486002)(8676002)(26005)(316002)(478600001)(5660300002)(54906003)(4326008)(86362001)(66946007)(83380400001)(52116002)(1076003)(36756003)(16526019)(186003)(6506007)(6666004)(69590400007)(2616005)(956004)(6916009)(2906002)(6512007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: D4xhxMUYrrSId1TaAW1OjnCP4t+KrsDCmBt0SA3QTfTBF2n3ikXGtOLkPT4mgUaHVpVJEgds5N2cv34qvEFOnk23y1hP+zRVVtC9nX0kQ5WXloKcmC52fkl5Z4nifGQEpZWrLGUZ0Cw+2YvtHtw0DoA5MH+AashDNFm+4HUC7wa+MiScHwgeEDpJtD032b06XYrqSVlyvsW/y+MCKJqT3d/0nlPVFEys/yXcMVYhVoiLI1Mzfim5HJqu7Ma8TO37D/uaAU9yNQ9ACuVhlgIOrFqgA1o6hjkLhtlkrTl8yTkq1ImKzNhuwiMwt2t3fo3WQTUeUFeDm0NzFb/UyQtNMoOakLqBwrTCXLIlMWQWJX4rQorI2kxe9sG8EbJ9qk+hALVI6Wo5W/ui3Jos96MdGU7LXx6QwQEM0YBRc7n4UXHLxSKfRNqGrUTm5oJ296KGFD5heN/RYkk5NdQhMAso5SLo9DehJ0s79gXwb16FleUbz6+O575UTldclWsnlTCJ/G8tFDW3uFkmZK/pxykpSjxOgbPEVJxezYvbZYSzqsqk/ck4SklvClCTXa17bkS0T/aeR3ebV5cXD7V+mT/Q3h8c4+Ak+mz4X7EeCdJ5Cgx3MjIbK2Lwzo3G/naK+TzFZMPDV6Yx3DdNKBKMVgDWug==
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbbc5986-3bbc-41b6-ce08-08d842c19112
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 15:24:00.4664 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EdGJfLk5IXFfg6Q0sVQzo7aBiu+0+nWF2JFgp/FRLWjZW0C3u1yFKdvPGb6DBOShZIwGvPmCBVnN9gjrZc+HMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB4797
Received-SPF: pass client-ip=40.107.3.138;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 11:39:05
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
 linux-user/syscall.c      | 12 ++++++++++--
 linux-user/syscall_defs.h |  2 ++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1211e759c2..70b172740c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -3904,7 +3904,7 @@ static inline abi_long do_semtimedop(int semid,
                                      unsigned nsops,
                                      abi_long timeout)
 {
-    struct sembuf sops[nsops];
+    struct sembuf *sops = NULL;
     struct timespec ts, *pts = NULL;
     abi_long ret;
 
@@ -3915,8 +3915,15 @@ static inline abi_long do_semtimedop(int semid,
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
         return -TARGET_EFAULT;
+    }
 
     ret = -TARGET_ENOSYS;
 #ifdef __NR_semtimedop
@@ -3928,6 +3935,7 @@ static inline abi_long do_semtimedop(int semid,
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


