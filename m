Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46295C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 08:19:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F4C2207DF
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 08:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FHLYaTFO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F4C2207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhU3N-0005UY-8A
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 04:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhU2K-0003F7-1L; Sat, 06 Jun 2020 04:18:40 -0400
Received: from mail-eopbgr80098.outbound.protection.outlook.com
 ([40.107.8.98]:10318 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhU2I-0000aF-Tf; Sat, 06 Jun 2020 04:18:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbcVBkx85I3AV41nepplgjkch3ypKhfPwLnLqB3RbaNcwVzV0VXoDLsZjN6ZCgJnaertshmtIgWgZfss17dFOSx07Y476HmNbD2f0HJT5IlrQOr9mNA+EJebhMSahfApMDYE6e1fmg8GqO2jPHi8AFLl142PJM7eBCSZI58sW/rwKlyHHPzXDYqJ7czhucqNQEq/Crz+md2bBKsKwiEFMC1VPsibOcqDp5OaNCBPjxBZXS+xMJercgdkHquEi/nrDN5YJlbiyxgOoTwgivHjuVzQYtOmKgvPloySb7dFhtadpRCQwwWm8rFOvtZ9AE1yMKnWVtBK2tFf0D4PnQnkdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/aK8s/ODvWILil7GJ9nAN9v1088qWMn2hHDPcFKLZA=;
 b=BoWle+YqDO8kW54q+qyk1K+iQw9vMu2jRF21RiksQ2LRvmaz2/m5LAj78Oi4/SC/15QtTX0pOHIekSJRL+Ck5JbyOABa5tHACxhJmZPSsNaXRvKgnQhK1QIwNraYOTYqzElcQJmZO1RPyKAe1wuzQXLrUDMsQ8U4NDVIhdpCHmrvPiK5Y9SBGINc5sBI4SGBiVn3RTitzzxofXXXXf+9L4MIwaHC2lCUciW8pd04eNYIfDvdE/5nNfidZRG1XMBrtzBxIYin2gaxUYCWzknK8rkgh+6HNz+CVX1Fsf/PeZAn9Wjt9adf+iSp7OeUyw+/zYm1+lRn9zFjr9Pb+yH1PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/aK8s/ODvWILil7GJ9nAN9v1088qWMn2hHDPcFKLZA=;
 b=FHLYaTFONlvOsNzZDDQ5pKFwmnvx06QxY/Dyt9wKiuxq2Wfe9drpx1xMctdXR/IH1pi6kLq5Co2K84H7nNk/XERVK5NpGSkQaH3hwkHnmkOvsT2BXGyDUngaFF4nTROcJLtpJPciImAgKSpTziejeRISzwYuWHtudZe17j3Uy0Y=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5480.eurprd08.prod.outlook.com (2603:10a6:20b:de::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Sat, 6 Jun
 2020 08:18:27 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Sat, 6 Jun 2020
 08:18:27 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v5 06/13] qcow2_format.py: use modern string formatting
Date: Sat,  6 Jun 2020 11:17:59 +0300
Message-Id: <20200606081806.23897-7-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200606081806.23897-1-vsementsov@virtuozzo.com>
References: <20200606081806.23897-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::23) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.130) by
 FR2P281CA0036.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Sat, 6 Jun 2020 08:18:26 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.130]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b1d8967-aa3e-49b5-248c-08d809f2305b
X-MS-TrafficTypeDiagnostic: AM7PR08MB5480:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54805D8C9A9DF59A1E4A9FA7C1870@AM7PR08MB5480.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:800;
X-Forefront-PRVS: 04267075BD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BcmnqHj57CMEFJUayqjtlJhR48/o6NmD6b4CXwTAFdusrMrK1aF/pHWOnIbrf16YYKkm/9RH9P4zh1thnLwwX2YTjEEJWKOGl5oQFeURU2T3oP4PF8+CKxbxrLAdoGwN1+OivTug9fICxHldzLQMdSeHf0zbhjZtdHOWG9QZQkWLxWeink8jTDlA2E6MpYFWUyJ1nJRM7wqtu6C75OSzB9CHUc1A+LjKQoh5jW9jv97su4mPLcwaMGsnYrvkBNuhcRNfkeObv6VtXzXVFRLd5r6npeDNIlc7G+YbZBrDBU3Wuy+V3VBeNN6zQMqGnJ3PULm7HsaUGQ6G9JcFWdseFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(39830400003)(376002)(346002)(396003)(107886003)(1076003)(4326008)(2906002)(36756003)(6512007)(66946007)(66556008)(66476007)(6486002)(5660300002)(83380400001)(478600001)(86362001)(2616005)(956004)(316002)(26005)(6506007)(52116002)(6666004)(8936002)(6916009)(16526019)(186003)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: JXqoL/wI+nwX8zPjIO4Qnu7ByKIAEM9UYqSrLoK5yJSAc6mb3uWE1GUVXSTo5MXp3Ma7wkRGFDlx6wruL97mgo5YM4trgoj3DvJ46vUCsZOie8rvPEI0dDybmj1rbhOoqLmUXZo5KvRtSaZaCBOnGj2J2pTCSie+6GZ+hb9tJT5Wm1Wz2S5isI+JdKQIMKIOwIXsaWXgaY+eIHILyWvY0fHWCIscULHaGHLUnbPVpXygzpY1FdFNDt2AU8w/8KgwIqlNBNqXe+eM/R6P+HcLHtleBrF1qSMkA/srkwKOkrYtOxfq5WwRkqu/z0xcDxP9cO/Y1tdnjvefO5DroMy3gVJMFPlfOI6KO+airvzwtrXiR4ZQ7xb88iZGwriDgv6LKRfutUgwUWur3kW0oIi51lcFTxV/AkCkOIWLahT4mrNF2SsiFqcVtWqX2q3ocWdpg5rtEKab8mqjTo3o5W7fAU3A0PtBVbByBwTzWx5mgMI=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1d8967-aa3e-49b5-248c-08d809f2305b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2020 08:18:27.2105 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JFf9XaBUqgPwHBUmmJZLknpuulR9g9XyUFvOwhCm/rlSmRMgHRVcrtHZYydLAOYEnoMkYB4YVJDM0udW6MyqO8Jnnv7bm5OLJ/lx8z5l6JI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5480
Received-SPF: pass client-ip=40.107.8.98;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/06 04:18:34
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, andrey.shinkevich@virtuozzo.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use .format and f-strings instead of old %style. Also, the file uses
both '' and "" quotes, for consistency let's use '', except for cases
when we need '' inside the string (use "" to avoid extra escaping).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/qcow2_format.py | 54 +++++++++++++++---------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
index e2f08ed691..da66df3408 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -23,7 +23,7 @@ class QcowHeaderExtension:
     def __init__(self, magic, length, data):
         if length % 8 != 0:
             padding = 8 - (length % 8)
-            data += b"\0" * padding
+            data += b'\0' * padding
 
         self.magic = magic
         self.length = length
@@ -41,26 +41,26 @@ class QcowHeader:
 
     fields = (
         # Version 2 header fields
-        (uint32_t, '%#x',  'magic'),
-        (uint32_t, '%d',   'version'),
-        (uint64_t, '%#x',  'backing_file_offset'),
-        (uint32_t, '%#x',  'backing_file_size'),
-        (uint32_t, '%d',   'cluster_bits'),
-        (uint64_t, '%d',   'size'),
-        (uint32_t, '%d',   'crypt_method'),
-        (uint32_t, '%d',   'l1_size'),
-        (uint64_t, '%#x',  'l1_table_offset'),
-        (uint64_t, '%#x',  'refcount_table_offset'),
-        (uint32_t, '%d',   'refcount_table_clusters'),
-        (uint32_t, '%d',   'nb_snapshots'),
-        (uint64_t, '%#x',  'snapshot_offset'),
+        (uint32_t, '{:#x}', 'magic'),
+        (uint32_t, '{}', 'version'),
+        (uint64_t, '{:#x}', 'backing_file_offset'),
+        (uint32_t, '{:#x}', 'backing_file_size'),
+        (uint32_t, '{}', 'cluster_bits'),
+        (uint64_t, '{}', 'size'),
+        (uint32_t, '{}', 'crypt_method'),
+        (uint32_t, '{}', 'l1_size'),
+        (uint64_t, '{:#x}', 'l1_table_offset'),
+        (uint64_t, '{:#x}', 'refcount_table_offset'),
+        (uint32_t, '{}', 'refcount_table_clusters'),
+        (uint32_t, '{}', 'nb_snapshots'),
+        (uint64_t, '{:#x}', 'snapshot_offset'),
 
         # Version 3 header fields
         (uint64_t, 'mask', 'incompatible_features'),
         (uint64_t, 'mask', 'compatible_features'),
         (uint64_t, 'mask', 'autoclear_features'),
-        (uint32_t, '%d',   'refcount_order'),
-        (uint32_t, '%d',   'header_length'),
+        (uint32_t, '{}', 'refcount_order'),
+        (uint32_t, '{}', 'header_length'),
     )
 
     fmt = '>' + ''.join(field[0] for field in fields)
@@ -118,7 +118,7 @@ class QcowHeader:
 
         fd.seek(self.header_length)
         extensions = self.extensions
-        extensions.append(QcowHeaderExtension(0, 0, b""))
+        extensions.append(QcowHeaderExtension(0, 0, b''))
         for ex in extensions:
             buf = struct.pack('>II', ex.magic, ex.length)
             fd.write(buf)
@@ -129,7 +129,7 @@ class QcowHeader:
             fd.write(self.backing_file)
 
         if fd.tell() > self.cluster_size:
-            raise Exception("I think I just broke the image...")
+            raise Exception('I think I just broke the image...')
 
     def update(self, fd):
         header_bytes = self.header_length
@@ -152,21 +152,21 @@ class QcowHeader:
                         bits.append(bit)
                 value_str = str(bits)
             else:
-                value_str = f[1] % value
+                value_str = f[1].format(value)
 
-            print("%-25s" % f[2], value_str)
+            print(f'{f[2]:<25} {value_str}')
 
     def dump_extensions(self):
         for ex in self.extensions:
 
             data = ex.data[:ex.length]
             if all(c in string.printable.encode('ascii') for c in data):
-                data = "'%s'" % data.decode('ascii')
+                data = f"'{ data.decode('ascii') }'"
             else:
-                data = "<binary>"
+                data = '<binary>'
 
-            print("Header extension:")
-            print("%-25s %#x" % ("magic", ex.magic))
-            print("%-25s %d" % ("length", ex.length))
-            print("%-25s %s" % ("data", data))
-            print("")
+            print('Header extension:')
+            print(f'{"magic":<25} {ex.magic:#x}')
+            print(f'{"length":<25} {ex.length}')
+            print(f'{"data":<25} {data}')
+            print()
-- 
2.21.0


