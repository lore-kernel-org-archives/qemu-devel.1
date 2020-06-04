Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02886C433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 17:45:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE594204EF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 17:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="lgAU6sM6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE594204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgtvn-0000So-TG
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 13:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jgtsP-0003BK-BX; Thu, 04 Jun 2020 13:42:01 -0400
Received: from mail-eopbgr00103.outbound.protection.outlook.com
 ([40.107.0.103]:11696 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jgtsO-0005oK-Kc; Thu, 04 Jun 2020 13:42:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bww4OA/4008R7XEh3RHnPG0Vkx6nCDH4TpvIrj/pvRmP2Wx7j1BMC/9RucxMul++/QO+T719yrIJtsBlR39UsysZvSz6AfHPSrDwL3lVGJ43/Hl/i6bQ+Ags6Da91XGm83LrFtDWTIPVt6+3XXHnvtlwd3TiCo1wTvxQAV4ri5G2swm79OCPw5mlJAtttkEzh4ViqRURQHiBKVuITUTnUMCwzuG8c+SmG3VppIDioWUZPVmepACXLc5AZ0e6d+WjAnmdGBDjqwHMtfrWsnvTyI9tsDuQOeXTyBt3rpI1AnMMck66EniqX7beDsW4br8apX430or/8f0uhYuW/cMBsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGybkWWVF1Xcj5WVjNeBa1f3oW6ST2V+BjS3SgXIidE=;
 b=IgtaZA8IuWOob2oIJwafxonrGzcW7kH8Al1/AVb6fsn1TO1tdd3xGmnu38jyZANvjNoiL6s3hnEkU6ifCFP8qgsRC2WPJoLaTNEhQpyrNB1G0SsfF8HY2NQG4v3ZqfrKNaEblcYHG+O+SMRtI+zHncW0ae1fwrSF2BgWAxEJWro+dxW0PS1dYPNg03PLcJcusRH2QUUt1K8bjNem0+8pKLjoC3LQ7HhncUGGcO6VOZZQSBWjlIa/gjxRj3qcsGEFq/mZGqki9Elmm4fgHBWIiUZcQkMQexUD7miRANsqSqhWaETJP4AIr2eSjUpcQSltRoBYnJ9uGUaMeTgn6b6Yfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGybkWWVF1Xcj5WVjNeBa1f3oW6ST2V+BjS3SgXIidE=;
 b=lgAU6sM6Tq6CcnXhrBGLJ042mF5HVsLuFosIMj6MK5Tjuyg2bAP3Uq0j64fkYemXtzc+zhwU6o4Yi4QVn+t6aq0fNu0fJwpkT459viK8X+c2x+tx7URYSyWmTuUgiEGVoXEDVYy9jhleBHBPElzOToRU6Y1BpUuZz7bExq++kgU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5381.eurprd08.prod.outlook.com (2603:10a6:20b:105::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19; Thu, 4 Jun
 2020 17:41:53 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.018; Thu, 4 Jun 2020
 17:41:53 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 05/12] qcow2_format.py: use modern string formatting
Date: Thu,  4 Jun 2020 20:41:28 +0300
Message-Id: <20200604174135.11042-6-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200604174135.11042-1-vsementsov@virtuozzo.com>
References: <20200604174135.11042-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0101CA0049.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::17) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.190) by
 AM4PR0101CA0049.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19 via Frontend
 Transport; Thu, 4 Jun 2020 17:41:52 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.190]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9eea5338-ef77-4c9b-bb61-08d808ae915a
X-MS-TrafficTypeDiagnostic: AM7PR08MB5381:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5381F1D7F8A9EA03F84541E2C1890@AM7PR08MB5381.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:800;
X-Forefront-PRVS: 04244E0DC5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U9kUAZdM3lQhbHAFNtcWoHECwEnciYn0BdmEpoIBwU5pKfxKuwptzUqgWJlbdB0Jw3KyLKKjLWCGWra/AcmVMDc0BuwlL0Ie03ILWpQTnIAzxB+4NmUVF/fdZqmGbwZajAanwmN4qcMr9C3Er7N0pIienf0nCo6sBc/kp77sEzRgYti8dyxsWZZEdGFol3b1mrjBJhQZdrGYXox4at7fhcvf6DtnYsOkMwc3BqVI4i4f8jyeqpJgrt3xPgozxl640f4vr7BrxdYN8nvz6tiijBOiAZjFv4KmOhg49DpZN3y2Qo4CQaivAf1KCXtoQ94N6zNgg63NmUhKbnLKLKMlag==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(376002)(346002)(366004)(396003)(136003)(5660300002)(66556008)(26005)(66476007)(478600001)(2906002)(6916009)(107886003)(16526019)(4326008)(66946007)(1076003)(186003)(6666004)(36756003)(86362001)(2616005)(6506007)(83380400001)(316002)(956004)(8936002)(8676002)(52116002)(6512007)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: SJbDrFv01ay9sIdc2zPEnMLGmm4yZxnxduL5vsNv3+GsF6mnBZZ1oYgHeafk+UQkbKGRoiuhMkX8a1UTvanSrM+5TL1lwtsTrJVKMMEWTd+ECpNLJmcNl7FA9c0m1WUhuupldeBrWuCp4OFtBEysHxjwhQUs2hMtyguGUyIFtIgqyG2kDmiWjrd17yMZKsyMG7D5rncWDvWBCKzCSlxC9qLg7eSKCc93R26QalF8tj8IKV+kOnV58WZh4IZmzfQ4wVwyLTVgO42MgONahZpJbHWdjQPe+EW1LMBMpDRFtZaRiHO3ipdlX0ztC1NeTinAO9mMJWaenElbB/RxzagueZDJApCZVTD018Ue1GCaKggoz3lMIKfLWx6T3BRQ1bQaHyE6C1+eesFmkYD+2VOWSHGPxfzKJpl0OdXFbp/VptVtL/hWxq3YIUY6MOKVQpOiPh8IOP5ykUx0yCFMy4WcYF1l/e/z98Hiyxj4umyVMlxiSorl1aWYvdUwjrB4ctKD
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eea5338-ef77-4c9b-bb61-08d808ae915a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2020 17:41:53.0661 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WSHbme0pSuHLqpgioW15he0JXqMeuakWAGWWT4eRrE2XtgxsTDaZO+zFMNoTwethtXYGxAEl/Wd0WF+NC7Jf/Gp0oi3UY3iIfqp15jRkTxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5381
Received-SPF: pass client-ip=40.107.0.103;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 13:41:50
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SBL_CSS=3.335,
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
---
 tests/qemu-iotests/qcow2_format.py | 54 +++++++++++++++---------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
index 5d242c4aa4..80e7c3f81d 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -7,7 +7,7 @@ class QcowHeaderExtension:
     def __init__(self, magic, length, data):
         if length % 8 != 0:
             padding = 8 - (length % 8)
-            data += b"\0" * padding
+            data += b'\0' * padding
 
         self.magic = magic
         self.length = length
@@ -25,26 +25,26 @@ class QcowHeader:
 
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
@@ -102,7 +102,7 @@ class QcowHeader:
 
         fd.seek(self.header_length)
         extensions = self.extensions
-        extensions.append(QcowHeaderExtension(0, 0, b""))
+        extensions.append(QcowHeaderExtension(0, 0, b''))
         for ex in extensions:
             buf = struct.pack('>II', ex.magic, ex.length)
             fd.write(buf)
@@ -113,7 +113,7 @@ class QcowHeader:
             fd.write(self.backing_file)
 
         if fd.tell() > self.cluster_size:
-            raise Exception("I think I just broke the image...")
+            raise Exception('I think I just broke the image...')
 
     def update(self, fd):
         header_bytes = self.header_length
@@ -136,21 +136,21 @@ class QcowHeader:
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


