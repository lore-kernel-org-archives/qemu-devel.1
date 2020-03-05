Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37747C3F2D2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 21:06:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03558207FD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 21:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nonterra01.onmicrosoft.com header.i=@nonterra01.onmicrosoft.com header.b="ESEy+YC2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03558207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nonterra.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9xhm-0001Cd-5Q
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 16:06:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49743)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tobias.koch@nonterra.com>) id 1j9xgo-0000Ek-1X
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 16:05:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tobias.koch@nonterra.com>) id 1j9xgm-0003KJ-TK
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 16:05:53 -0500
Received: from mail-eopbgr140082.outbound.protection.outlook.com
 ([40.107.14.82]:10550 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tobias.koch@nonterra.com>)
 id 1j9xgm-0003IY-HQ
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 16:05:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gB5TABEBfEPr0167DljB5q62NZRalnweDn2Q9NQLMi2HX9A2aZ8wySaWZ+DAwJooC79rtjye39eMDEwbVJhT7ju8W48nVeV7ejojaa8JFBDw/8dcJaZPBFZeUMyUCkN0v/8z3BCBCB2kZKHc1/rKoWOQVHRFPyUSKX+yyTvbbvYWfnV1QlMIgsSN1z/ABIG5L1gX+8EDgpqN3jvIThxrhIpYsI7TTM1jqTFQxGUtvCoqbB6q24JAK+Xylp3WVAu2Le4LNcp2ePxMIZOEeyFkLTGVA7/vH2XLpdVm8w+Uo0us2rnYAPG2QXRhrJiCAYuf9edJyqsPIzGa6iSFPS7DNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A43n3iT9G7mx/l3hbMnLlq12aoiBdIOA6GYBMxcKIeU=;
 b=HnrMs9bf2zGlm5yzTUUJuZAAeYLSy/k24tVaz+pfLSykgdEVh9SeD0b4/UxE0UvaFlAyMWVxoi5idBbMgBCxHZ3TIPCwVH+5zeN1nRGmxu9mhMGChKcjiMIbt+Z54NNs1I0bAme29J+a2gV/X7vsGYRAxCUw6o+P3vo9vDfB1nxqR8hNQWxMDJAABVr1M7RR3dTOaf8plEDzYbrFQcZZ8zlDlhx70c0IcGnC0acAgYmPP/e8QhG7f8HvIsa39bvU/2tTxSd8lzNAhFTNZZy3Xofqx/hrpEFRWCiNnBRxCT5wzGjJex9V+1USGdOV3RJiNk0QXj8cpHPlwE1EMqe4VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nonterra.com; dmarc=pass action=none header.from=nonterra.com;
 dkim=pass header.d=nonterra.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nonterra01.onmicrosoft.com; s=selector2-nonterra01-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A43n3iT9G7mx/l3hbMnLlq12aoiBdIOA6GYBMxcKIeU=;
 b=ESEy+YC24q9fQdqn19gSEUzX/7Z7l4YYnum7oYjWi3FzE/hxZw1TtyuG0GYZj6Y/EY4THWfFN2TyOTOS6BQAlSbggrvID4bgvJMdI0l2pryr0SCJpzZyFhYkd+Ak68odqeOz/3WLJJ+YcFfB1WCIxb+9syobmRhsZhBOalnXcsI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=tobias.koch@nonterra.com; 
Received: from AM0PR08MB4273.eurprd08.prod.outlook.com (20.179.35.80) by
 AM0PR08MB5347.eurprd08.prod.outlook.com (52.132.212.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.16; Thu, 5 Mar 2020 21:05:49 +0000
Received: from AM0PR08MB4273.eurprd08.prod.outlook.com
 ([fe80::7163:372d:fd4c:812a]) by AM0PR08MB4273.eurprd08.prod.outlook.com
 ([fe80::7163:372d:fd4c:812a%5]) with mapi id 15.20.2772.019; Thu, 5 Mar 2020
 21:05:49 +0000
From: Tobias Koch <tobias.koch@nonterra.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] linux-user: mremap fails with EFAULT if address range
 overlaps with stack guard
Date: Thu,  5 Mar 2020 22:05:34 +0100
Message-ID: <20200305210534.28392-1-tobias.koch@nonterra.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0016.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::26)
 To AM0PR08MB4273.eurprd08.prod.outlook.com
 (2603:10a6:208:144::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from build.nonterra.com (46.4.103.172) by
 FRYP281CA0016.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.11 via Frontend Transport; Thu, 5 Mar 2020 21:05:49 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [46.4.103.172]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8684050e-41aa-4e8b-d8d5-08d7c148fb47
X-MS-TrafficTypeDiagnostic: AM0PR08MB5347:
X-Microsoft-Antispam-PRVS: <AM0PR08MB534733F5AE6AABE0C5B24A4C89E20@AM0PR08MB5347.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-Forefront-PRVS: 03333C607F
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(39830400003)(376002)(396003)(366004)(346002)(136003)(189003)(199004)(1076003)(508600001)(44832011)(86362001)(5660300002)(55236004)(956004)(2616005)(4326008)(52116002)(186003)(16526019)(26005)(316002)(6916009)(7696005)(6486002)(81166006)(81156014)(8676002)(2906002)(8936002)(6666004)(36756003)(66476007)(66946007)(66556008)(41780200001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR08MB5347;
 H:AM0PR08MB4273.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: nonterra.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ii8Ae43ReM7TQItU96S/tppnMjp93fsd50jID8Nbg/qIYHHOnzWb/gcrpYMyuq+5SuWK6aTwrE2h6a+Z0Ee073efhx2oFbpE7DCx6CFlNoVz4Zgr9rkoF3jVXufPcgIBksHy06rjZz3gVn33MGhygF6QLF52QQBVyyp/G7UvSAhexE7VjLlHg+op8Plcy4UY+RQ9grPI797PRB+nVIiL+1D1XQEkVrGlCYg6/zdzJS/2HPCKqL37b4cXwIKRxSIEI9gdJlJPBjEd7Y7Hg5XZzd82ge5ouphxgK8PONgrudfE/ank7XTImDfnze7ODfrN0Ix3PLwvZSBoGObxUtSGc5XzrPU63QAhR7jOCbgN52Wct+Avq6AUkDtJt5hxBwYOrsagYMHi9eNA7YPYDzJi1eGlgzq5wgyAaKoRevjT883rMo5jV6Z/KrgUycTxwGjtWCwjH7PGB/RoM8cVvjYQ3K308lTVbSQFMVQZ0csA5lcyfvRYV/+VlLlJLnsBTf1K
X-MS-Exchange-AntiSpam-MessageData: t/lP2P2T1SxKgL3HDk63e5WLc00MwLtzGUiHXUkB2RvgTLAm8v7EbMGwsMC3cNTWxkYZUcSyBtlEABZlNsrGqOXfpwix0OfXX60hCdZSec9c6+ZyKpHWsIHtpgyT3e8cGI68ywxmUIWEVAJPbvEJzg==
X-OriginatorOrg: nonterra.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8684050e-41aa-4e8b-d8d5-08d7c148fb47
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2020 21:05:49.6269 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 76ec9478-ab84-4eac-917c-c1a3242376a3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UqtgiianHCeqyK+tNwqLxmzcyBIAwUD3RCS5yQDIlffCDM0zcC7DKvIabwCxLRS6MYYfUzn6qu0MWmEcSc1peY1IHpBihgr/6NvUhrWgeOk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5347
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.14.82
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
Cc: riku.voipio@iki.fi
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If the address range starting at old_address overlaps with the stack guard =
it
is invalid and mremap must fail with EFAULT. The musl c library relies on t=
his
behavior to detect the stack size, which it does by doing consecutive mrema=
ps
until it hits the stack guard. Without this patch, software (such as the Ru=
by
interpreter) that calls pthread_getattr_np under musl will crash on 32 bit
targets emulated on a 64 bit host.

Signed-off-by: Tobias Koch <tobias.koch@nonterra.com>
---
 linux-user/mmap.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 8685f02e7e..62cddbd072 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -651,6 +651,12 @@ int target_munmap(abi_ulong start, abi_ulong len)
     return ret;
 }
=20
+#ifdef TARGET_HPPA
+#define STACK_GROWS_DOWN 0
+#else
+#define STACK_GROWS_DOWN 1
+#endif
+
 abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
                        abi_ulong new_size, unsigned long flags,
                        abi_ulong new_addr)
@@ -665,6 +671,26 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong o=
ld_size,
         return -1;
     }
=20
+    /* Check that we're not overlapping with the stack guard. */
+    if (reserved_va) {
+        abi_ulong guard_size, guard_start;
+
+        guard_size =3D TARGET_PAGE_SIZE < qemu_real_host_page_size ?
+            qemu_real_host_page_size : TARGET_PAGE_SIZE;
+
+        if (STACK_GROWS_DOWN) {
+            guard_start =3D reserved_va - guest_stack_size - guard_size;
+        } else {
+            guard_start =3D reserved_va - guard_size;
+        }
+
+        if (guard_start < old_addr + old_size &&
+             old_addr < guard_start + guard_size) {
+            errno =3D EFAULT;
+            return -1;
+        }
+    }
+
     mmap_lock();
=20
     if (flags & MREMAP_FIXED) {
--=20
2.20.1


