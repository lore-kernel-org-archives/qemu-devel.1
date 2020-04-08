Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CC1C2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 09:39:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BFA22051A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 09:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="A/jVqTe9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BFA22051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM7BN-0000oE-O1
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 05:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39575)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jM73L-0007pq-30
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 05:31:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jM73J-00060m-VF
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 05:31:22 -0400
Received: from mail-ve1eur01on0705.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::705]:64128
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jM73H-0005tu-70; Wed, 08 Apr 2020 05:31:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFOFb/1Mes5b0/xz+oGCoQGRufITgyIWDt1g5E709e6OXYKw3opEZRlYRkFEMKWeqEjwC7mKtXOKRMJiZyrhNR58dy/bHaZ7zBOK2gk+VzNzvkn596bi7YXL0/L++6wup/2gYDfVVcWFYwc/A0ttILf8sKwjSbadTYwalIJD5kapfhcuqyEAP6aw7f6+W5YgQ7MpJ2AjvCdpVyz4QG+U6ZcOnEb+tU6jy9wAJ84HpguOsUPJjLns8c9efxJoUefqqoiRvMqxWF6IbkENKYI17wwq8X8Qq4SmSA8X9xbefzpEze8lty82IcvgAOQL8MgF6akSIxw30IIYjqj44kLkDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4QTLo5SN/366n4bxRVU5Vb0x2bOsCCBOy8xcC3VaUM=;
 b=VOLYnHnFaoSSDCM9y0P7DXWIVQfe67Ui9icd4BSmFu/dwFEPd+cek9zOl4nmEoizWNTNuoSb1PohmeCOcWTDu9N2PITkL/3JuIWomgv4qPcaDwBVS6TAstnJW4+rh9DCxwjfoY8jhy3ubaXhiKERnCi3VSP5d+t2itrcXjbLw220BC5+LQQBuHfhnaf5UI7JgKMgotTJwt8LzvIimo4SHYZtc6hHAxGo+jbb6f1WM1CDqq7v5fhpTOxhA+ja3pXJGj1MWtwBIL5QaSWU0Wt8AD9FvKWFw2BEY9snEZSpQu0wEXFbIowAglHzP8pKlZiciCoq+7gEJrg2YNVDLl7sfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4QTLo5SN/366n4bxRVU5Vb0x2bOsCCBOy8xcC3VaUM=;
 b=A/jVqTe9vCCFXOpeCLsyYuMi1T+Ft3jGy3/IaRN9rQmLF88RbwEbn36S7cLBeq1OYUaSXkmhnCK+tnHwD2gh2onyL9V71X1OYZh0nuWepDsWLf8T0Ygz+MSm4dESMo6EQOelmykZ/SEep9G1KB2D0X9CnPLkp15T/vyUNliPbUc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5365.eurprd08.prod.outlook.com (10.141.173.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.16; Wed, 8 Apr 2020 09:31:13 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.021; Wed, 8 Apr 2020
 09:31:13 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 8/9] block/io: move bdrv_make_zero under block-status
Date: Wed,  8 Apr 2020 12:30:50 +0300
Message-ID: <20200408093051.9893-9-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200408093051.9893-1-vsementsov@virtuozzo.com>
References: <20200408093051.9893-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM6PR01CA0041.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::18) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.139) by
 AM6PR01CA0041.eurprd01.prod.exchangelabs.com (2603:10a6:20b:e0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend
 Transport; Wed, 8 Apr 2020 09:31:12 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.139]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 488737e6-49f9-4aeb-513f-08d7db9f942a
X-MS-TrafficTypeDiagnostic: AM7PR08MB5365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5365E020369A0347E124DD3CC1C00@AM7PR08MB5365.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0367A50BB1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(396003)(346002)(136003)(39840400004)(366004)(376002)(52116002)(6506007)(5660300002)(2906002)(6916009)(2616005)(956004)(478600001)(16526019)(186003)(26005)(86362001)(66946007)(66556008)(66476007)(1076003)(6512007)(6486002)(107886003)(4326008)(6666004)(36756003)(8676002)(316002)(8936002)(81156014)(81166007);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c/Ra5NLJ2xDJZBuum+Dkw60N6y+CVB8rA4M3AEoQCmJKHapH/oTcjEUcQ7J28tOzbavEaxcjwgDKSds+zSWT6wRQR4vINcakR9sI+eDdTqLfJ3wTtXqL0t1fClKp/uVwMjD3snuZHqY6k4gchgkJpVpGwK3QL8+mf8qdHFYvoGoEOQKz/lyRLezt5whJ548PgWypovZVBXZjik5p4xFAmlyr+8gc+OwbK5m0hsKT48JMnNn/pzI+QS4DFXv8fjicFJgOI7BPqsSsHDUzkcxFGlDl1TV2Wpla4FK6t58QBLinp6ObrV5Vat82nGmiMZ2dM+BHRAdaUlM3Yftswl5ACH8FEPozp0AbhtWB954aALzkuzzWgyGM+FzGhetvg0h6RKiyumD0CdMKtECoMYr260rXQD0d3ci+j7fgnEIh/grU8Mx8VklIJ1NOsKLGwk8r
X-MS-Exchange-AntiSpam-MessageData: OTlVxEv/FpepkTTJasEK/itXnYmTBfHVCR9IPHUbZT+XVeznVtpDDBtxXfzSKFo1y+99XkfXQvIPpbz8+uMzYDm0e4r8E2KQYTJQcy04U5+juDoBCfUhw8A4ovhz5eMnggn9fvWofZkGpdbFBM0oAQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 488737e6-49f9-4aeb-513f-08d7db9f942a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2020 09:31:12.9782 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e5bwYonACNvecXDLdSeSY3b2M1JnNhmA4FEggoGaHcbY6JHhS9kb+T2Otc7cKyblaSTH11KDWrpfeiwDF1w2kKVayPl/6rjuzikeg4ReOMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5365
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:111:f400:fe1f::705
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are going to use bdrv_co_block_status in bdrv_make_zero, so move it
now down.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/io.c | 82 +++++++++++++++++++++++++++---------------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/block/io.c b/block/io.c
index b1fc8b2367..d2ac9ac7b5 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2177,47 +2177,6 @@ int bdrv_pwrite_sync(BdrvChild *child, int64_t offse=
t,
     return 0;
 }
=20
-/*
- * Completely zero out a block device with the help of bdrv_pwrite_zeroes.
- * The operation is sped up by checking the block status and only writing
- * zeroes to the device if they currently do not return zeroes. Optional
- * flags are passed through to bdrv_pwrite_zeroes (e.g. BDRV_REQ_MAY_UNMAP=
,
- * BDRV_REQ_FUA).
- *
- * Returns < 0 on error, 0 on success. For error codes see bdrv_write().
- */
-int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags flags)
-{
-    int ret;
-    int64_t target_size, bytes, offset =3D 0;
-    BlockDriverState *bs =3D child->bs;
-
-    target_size =3D bdrv_getlength(bs);
-    if (target_size < 0) {
-        return target_size;
-    }
-
-    for (;;) {
-        bytes =3D MIN(target_size - offset, BDRV_REQUEST_MAX_BYTES);
-        if (bytes <=3D 0) {
-            return 0;
-        }
-        ret =3D bdrv_block_status(bs, offset, bytes, &bytes, NULL, NULL);
-        if (ret < 0) {
-            return ret;
-        }
-        if (ret & BDRV_BLOCK_ZERO) {
-            offset +=3D bytes;
-            continue;
-        }
-        ret =3D bdrv_pwrite_zeroes(child, offset, bytes, flags);
-        if (ret < 0) {
-            return ret;
-        }
-        offset +=3D bytes;
-    }
-}
-
 int bdrv_preadv(BdrvChild *child, int64_t offset, QEMUIOVector *qiov)
 {
     int ret;
@@ -2768,6 +2727,47 @@ bdrv_is_allocated_above(BlockDriverState *top, Block=
DriverState *base,
     return data.ret;
 }
=20
+/*
+ * Completely zero out a block device with the help of bdrv_pwrite_zeroes.
+ * The operation is sped up by checking the block status and only writing
+ * zeroes to the device if they currently do not return zeroes. Optional
+ * flags are passed through to bdrv_pwrite_zeroes (e.g. BDRV_REQ_MAY_UNMAP=
,
+ * BDRV_REQ_FUA).
+ *
+ * Returns < 0 on error, 0 on success. For error codes see bdrv_write().
+ */
+int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags flags)
+{
+    int ret;
+    int64_t target_size, bytes, offset =3D 0;
+    BlockDriverState *bs =3D child->bs;
+
+    target_size =3D bdrv_getlength(bs);
+    if (target_size < 0) {
+        return target_size;
+    }
+
+    for (;;) {
+        bytes =3D MIN(target_size - offset, BDRV_REQUEST_MAX_BYTES);
+        if (bytes <=3D 0) {
+            return 0;
+        }
+        ret =3D bdrv_block_status(bs, offset, bytes, &bytes, NULL, NULL);
+        if (ret < 0) {
+            return ret;
+        }
+        if (ret & BDRV_BLOCK_ZERO) {
+            offset +=3D bytes;
+            continue;
+        }
+        ret =3D bdrv_pwrite_zeroes(child, offset, bytes, flags);
+        if (ret < 0) {
+            return ret;
+        }
+        offset +=3D bytes;
+    }
+}
+
 typedef struct BdrvVmstateCo {
     BlockDriverState    *bs;
     QEMUIOVector        *qiov;
--=20
2.21.0


