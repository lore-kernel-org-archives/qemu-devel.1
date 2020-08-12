Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A86C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 14:08:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FDBD20838
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 14:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="XM1/Nfl0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FDBD20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5rQd-0007MV-M5
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 10:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k5rPn-0006vo-Uw
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 10:07:39 -0400
Received: from mail-am6eur05on2132.outbound.protection.outlook.com
 ([40.107.22.132]:57569 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k5rPj-0000V7-6E
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 10:07:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5Q7gIuqixhd8+TxrbXUuGUIyv8x9dvAlobNz3Jc2pWnaKZ2ZZUU9ZuM6N17mAG2pLVOFIwScPDW58KgBKStBT/9nvLOL3elLv0u2m9kWMgZ92HvBMYx4AJWHnZm5wa6fKpUE+IeT0MA1CBkltvJVFrp1Ia3WZYdnCC7Xpy7LXhRd4tKMw4Ii5Ur+PxCsoDvbwSlG3dT/uKZCdAhWzi0oesIpsh75C+qJfO9fkLLme1U18aGbDoBvvDexcPdlOSPBYHIcOXWNnt/PwvYFZuMoTZsSuIt4KEhzro65pROnqBN24Xxhyj7dvXycieWFbD6AtySb6iaIvksu4eY3bWLrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7NN3tX4kUtnA6vcqOFhbcMSfroAT6sJnRW1/8Ojqp0=;
 b=hecjDkEsfH42wiiVMG8rrtTnDT8bF1VoyzcyOQsKzBKmURjXn/AyBVFB0N6zObp3lUK3UjbzyeYPjI5J3yldCH7LSkCBnu0FRm1z8Xq6W725Xhh6cy5pEU/jeJ63bDU/viOSGVNH8siR7EI0n5Obui+f1D2IFnSU+RarHtbgZTWYs6XD49GKSHvzpLlKmTGHxXmVZgQOIqYpy/JtzKc+ui039bxDRvvo0mVd9cmkHAIZBJLnjztDsmtlcU5LvZ5sKAwKrGmvNnZnlX8CXOJR0Oq+SdijWnMhvAIrdDIIpD2oKPA6n0hALmWtpXDFWEJZbME92Yr40ENkTAZjiCJnEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7NN3tX4kUtnA6vcqOFhbcMSfroAT6sJnRW1/8Ojqp0=;
 b=XM1/Nfl0JADvIKzF1kbvVFPcDdRx1/6pS27U21X9rdDQzQJmzuVup+M7z+UQYB2A1URzzCyck8go0MGVk8dfO6M+GDVKaSjTyW5uP01mjMJijuMC6m0vECZ71QPwjV/UwamSz47ImgTasFxDW4pmCfkvR3hf3i+tk0e+U0lNemA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com (2603:10a6:802:a1::22)
 by VE1PR03MB5520.eurprd03.prod.outlook.com (2603:10a6:803:119::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Wed, 12 Aug
 2020 14:07:28 +0000
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362]) by VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362%6]) with mapi id 15.20.3261.024; Wed, 12 Aug 2020
 14:07:27 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] linux-user: Fix 'semop()' and 'semtimedop()' implementation
Date: Wed, 12 Aug 2020 16:07:04 +0200
Message-Id: <20200812140704.46242-1-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0208.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::28) To VE1PR03MB5246.eurprd03.prod.outlook.com
 (2603:10a6:802:a1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.235) by
 LO2P265CA0208.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:9e::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15 via Frontend Transport; Wed, 12 Aug 2020 14:07:27 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.235]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 102dc633-817c-49b3-389b-08d83ec90ba5
X-MS-TrafficTypeDiagnostic: VE1PR03MB5520:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR03MB552014F2F8B9E5775D5DF8BBEB420@VE1PR03MB5520.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LhVt0F8li55ADaSTijX+QFEuw5p8iUECunCzjKX0a7cNsudNvWvYROP7gsB8WV7v0KvI65vWocKLX1F4cEjp4HMCCGGAUAMc0Dboj/e9QNYfsDo4JDEBAjT/9BtDuW7bhJBbK7JgY7ahT8SjxJi75MvH1arjVQ/XeITYwgnBFYyooLUd+xQTRdPre3AMD3/DKqen4Lv8+BWW3tXKfA8y/h+IcxEY4pPuqlNFzkSVNRn8Vu9ZEcL5M6I94q4UtaWdhnhgYEdEydIEoYHvk3coffIZ7srqM4uIbm/mZpAgAWrvQyU0A41dzBIIdNQPBUH7YBhiTUa7PKSe27zAtAn3NOG2VFd1BIgQuRMymHrQlP/SBFUGwvNSsmUVDORx5Rda
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(366004)(346002)(39830400003)(136003)(396003)(107886003)(6916009)(6512007)(1076003)(6486002)(8936002)(6666004)(69590400007)(54906003)(316002)(4326008)(6506007)(86362001)(36756003)(508600001)(956004)(83380400001)(2616005)(16526019)(186003)(5660300002)(26005)(52116002)(66476007)(66556008)(2906002)(8676002)(66946007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ZfRpzbLKgXIejDFccXmJAA0OqoDNpmBS67Zkm5lWqXEhdTo1QNAArCxwu0scTk5HySbV+pIBx5ebhlNxuCkQ455WX5dLpgyxGNLbpkH8oDVAtTau5ijotGM/RbueSqf+rjzjDeHUvaEKN05uKPE1XmYakKy0Q00Jxb4A0adEuFigz6ZZPsmNqx48qCI2qQF9hFvo1jBCm/7Af1LKW2X3nFWkbIIs6ZON2Cm4pcU9q6T6o1IcAY3JdWIK7Hs5HYIPztbvnUgNUf8FcEt2Mlram+O9eVUHo2ghjd43Fs0mVfuhLghubGKAXOL9BjMB9nA0jgu9VwaGg/Cule5V9jbMtTXrcI988rY0j1/f613mM8PSYS+tnMKl8IewNVgf/blSeKcR7tGPQ9KZeZ/rfdXMedsWUV1jFOitV4ObfriDJAnfgtqN3iUQ62b9OLbD1Bv4bkSpG9PpM2jfoKp7feuGastxrHqaVamik0T9ObQIYRUWF3etV9S7JfYDSc6a8pHPqM5ehtGoeuzzYfbLcuUnF63ek9xIdPJ3b4yr882eUqBv+xwZjOE4hG+kUcTLnBxnRkKeHMLPTxa8YJV8Xfv9Hy2XUcSvtks8uzr9u7RupBTwoHeCdto633FSDI3VOjLQRg8C93aZfZ+CiMmpkqe2oA==
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 102dc633-817c-49b3-389b-08d83ec90ba5
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2020 14:07:27.9649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l8e5V0UbcdzyQJqu+V1/iNq2eF7Xa9B3CMdGP1p3Vh4oi/doLQxazfLCVg3LZXisjsEfzhhR7Q9kjEqOtjFdUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR03MB5520
Received-SPF: pass client-ip=40.107.22.132;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 10:07:33
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
in this case since the conversion from target to host fails.

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
 linux-user/syscall.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1211e759c2..4743a5bef2 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -3899,6 +3899,8 @@ static inline abi_long target_to_host_sembuf(struct sembuf *host_sembuf,
   (__nsops), 0, (__sops), (__timeout)
 #endif
 
+#define TARGET_SEMOPM 500
+
 static inline abi_long do_semtimedop(int semid,
                                      abi_long ptr,
                                      unsigned nsops,
@@ -3915,8 +3917,13 @@ static inline abi_long do_semtimedop(int semid,
         }
     }
 
-    if (target_to_host_sembuf(sops, ptr, nsops))
+    if (nsops > TARGET_SEMOPM) {
+        return -TARGET_E2BIG;
+    }
+
+    if (target_to_host_sembuf(sops, ptr, nsops)) {
         return -TARGET_EFAULT;
+    }
 
     ret = -TARGET_ENOSYS;
 #ifdef __NR_semtimedop
-- 
2.25.1


