Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD246C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 17:43:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C7F22053B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 17:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="itYvDSVD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C7F22053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgttd-0004yP-Nf
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 13:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jgtsL-00037v-CZ; Thu, 04 Jun 2020 13:41:57 -0400
Received: from mail-eopbgr00103.outbound.protection.outlook.com
 ([40.107.0.103]:11696 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jgtsK-0005oK-Gz; Thu, 04 Jun 2020 13:41:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H65SVLYlr5+dC7YHikCBp56OjgdY7wus6K8DwxUCSOTjOtfVxFyV1PrySb0GFOZV8mt6ffnKbj/nxWqFWMteSoF92MJ341ekksMlzjbf0S9LUCXaLrIuDhcRt+1yEDqBLhuiVwD7p/tOyq0AL25yTldfXo6bwbDprAIJYGhkEY0SW2zBM9WfY/ATDpGl1kVNFd2n/mokUu7+cKSzdhOiwTfezGEsmYr/esXgYjUkzhspDV4ZdUgphJbalH0HkUTTeN6lsBe6B++bJ0ASTp8Hwo5cv+AFn1G5NOEIEwOzC64pBPc1mQM5rRXTzfZtsZ++vAVf4XWwYx1FWFqpC0G+Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWTw/mRr3TBGTaMkg+jXTYAn3cJHIMVJwfbsaPL4OpI=;
 b=SRF+vtSXGYFAUcgAtWIah7ORnpnCunG9WauAErxdClcbk2Cwpj3p+vni2bKMLyXSBRJoEKUQLnRW2FpkAcpSRdgC/Hm2OMxOsNxDO4+iCNi6SF0P0Ry1a6/iFgYH41uukzfDaHrhlZ5Z9fzYBHB2q5FC2+kmfTvHodRmUjiUvzcK+LP+UGXnt+dEbUjmut98uEs4eWmk5KPvMgmiarFmiS/w3umeJ8VQ51Nn9YTNSe37eSfs2gYprqBJsli61eaZ0U28oc/HH6USphqlYVM3OwDJiHfor5hM8kUd5o2uLUO0THe+EsEZWkCeg0VP2EgtMizQhECUqk+2Z92d+ZJf3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWTw/mRr3TBGTaMkg+jXTYAn3cJHIMVJwfbsaPL4OpI=;
 b=itYvDSVDvvrbRIP50EL2Pwo59siJRnSixokPf0kQukI0hXS6vieQn2Pb/4nL6TyPvpwLVWShVjLiF0m33pUAg6eeulcj5WPSwjxZAEYvCEzJVGVHXi0WqMmssQoth6LMN7zfhVkFCmLkzaT/jrC5+GQpqt5JTptf7YW8CJDeZXk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5381.eurprd08.prod.outlook.com (2603:10a6:20b:105::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19; Thu, 4 Jun
 2020 17:41:50 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.018; Thu, 4 Jun 2020
 17:41:50 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 01/12] qcow2.py: python style fixes
Date: Thu,  4 Jun 2020 20:41:24 +0300
Message-Id: <20200604174135.11042-2-vsementsov@virtuozzo.com>
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
 Transport; Thu, 4 Jun 2020 17:41:49 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.190]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14825470-21b0-4158-5ccb-08d808ae8f86
X-MS-TrafficTypeDiagnostic: AM7PR08MB5381:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5381E60641DC739CDEB0D7C3C1890@AM7PR08MB5381.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:741;
X-Forefront-PRVS: 04244E0DC5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UVh0SzIqQubTrJQH399s1mqjIyGbkIfKeq49OrAxs/5oLmLW+ZvQrtrLsJ0eFn5YGUJE8Oguilp93B0Ib4HpmcBd7XTsoOih02DABr/8rvlALLU8iXX9Jb8SCcPskPeQ+sSiYcLGzkz/NrmtDn7lZvBEfXNEtuHeG/bVVJh/sM0EmiN6dvJ4Qc7id3fzyRlRwbBxhTEt8ZnnXR8FYk1OiQQZ48X4jIstBNHoQBMDZEaR0rsGoM6qHII7oCHkDfbKNtgOIVre886mS6370bGcu5fq4tSKYSVEOA4eY6fUMrLk6JDxuIpzogYcVvvb7y/wDmP6pcYHwcqfvf/Urd7Jag==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(376002)(346002)(366004)(396003)(136003)(5660300002)(66556008)(26005)(66476007)(478600001)(2906002)(6916009)(107886003)(16526019)(4326008)(66946007)(1076003)(186003)(6666004)(36756003)(86362001)(2616005)(6506007)(83380400001)(316002)(956004)(8936002)(8676002)(52116002)(6512007)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: lDPxZT5TLIJG1gTth7llnzn9NxFQLxDgF6Vqf48APqQa4j55f/pkiHXvk8DROwzftSrMF4PWtdrHu0jp7wDL+gG6WP+TZWJrbmLdqbGxAOu3hXLRiASgIdEF2Md3k3Zj0ev+oVdMHrvZtFaMdII4j93rKRjJd3YQxk1o4MGhq/v45LzwBbxD1a0DLXaoYB3fCQcUsXNJRMoC246BwAMeafRqRCYk8cYGjqIP5PORyBKCOONzy7Y3WIT9ru5MVsp3H404C+BciB2MLHn/1bAHIvc25QogdzgMgaWOlZz346tb61yqGLzrrKen5oqFbG8taRUra4HRsVcCTMNIn82K+G8gLkKumlmCGMa5ejDZjZwRaUbAZ0RP4MvqkuJFNo0YVSVprHXmDVtUI3vdRd12DKbwUuZlvqJwl2SlxnYj+Vb/YyLWQst3ukXxOplSq3FdiiJPuSCSaRbxPoaOaGgbZVjzntseTKqH0dRA/bCjiHUR2Bkjccvh/1m24RiA8E3+
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14825470-21b0-4158-5ccb-08d808ae8f86
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2020 17:41:50.0135 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kTjGcpffW3Hx5Jp+vVqZes2wzA07Y2td6F7MnmeOiXk1NJCLO77ICwZwSelmsqfpbNi4k9TmJWjtBMNCvCthEVA+u1YH5J0HfOqk7eR13aM=
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

Fix flake8 complains. Leave the only chunk of lines over 79 characters:
initialization of cmds variable. Leave it for another day, when it
should be refactored to utilize argparse instead of hand-written
parsing.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/qcow2.py | 92 +++++++++++++++++++++----------------
 1 file changed, 53 insertions(+), 39 deletions(-)

diff --git a/tests/qemu-iotests/qcow2.py b/tests/qemu-iotests/qcow2.py
index 94a07b2f6f..539f5a186b 100755
--- a/tests/qemu-iotests/qcow2.py
+++ b/tests/qemu-iotests/qcow2.py
@@ -4,6 +4,7 @@ import sys
 import struct
 import string
 
+
 class QcowHeaderExtension:
 
     def __init__(self, magic, length, data):
@@ -11,14 +12,15 @@ class QcowHeaderExtension:
             padding = 8 - (length % 8)
             data += b"\0" * padding
 
-        self.magic  = magic
+        self.magic = magic
         self.length = length
-        self.data   = data
+        self.data = data
 
     @classmethod
     def create(cls, magic, data):
         return QcowHeaderExtension(magic, len(data), data)
 
+
 class QcowHeader:
 
     uint32_t = 'I'
@@ -26,27 +28,27 @@ class QcowHeader:
 
     fields = [
         # Version 2 header fields
-        [ uint32_t, '%#x',  'magic' ],
-        [ uint32_t, '%d',   'version' ],
-        [ uint64_t, '%#x',  'backing_file_offset' ],
-        [ uint32_t, '%#x',  'backing_file_size' ],
-        [ uint32_t, '%d',   'cluster_bits' ],
-        [ uint64_t, '%d',   'size' ],
-        [ uint32_t, '%d',   'crypt_method' ],
-        [ uint32_t, '%d',   'l1_size' ],
-        [ uint64_t, '%#x',  'l1_table_offset' ],
-        [ uint64_t, '%#x',  'refcount_table_offset' ],
-        [ uint32_t, '%d',   'refcount_table_clusters' ],
-        [ uint32_t, '%d',   'nb_snapshots' ],
-        [ uint64_t, '%#x',  'snapshot_offset' ],
+        [uint32_t, '%#x',  'magic'],
+        [uint32_t, '%d',   'version'],
+        [uint64_t, '%#x',  'backing_file_offset'],
+        [uint32_t, '%#x',  'backing_file_size'],
+        [uint32_t, '%d',   'cluster_bits'],
+        [uint64_t, '%d',   'size'],
+        [uint32_t, '%d',   'crypt_method'],
+        [uint32_t, '%d',   'l1_size'],
+        [uint64_t, '%#x',  'l1_table_offset'],
+        [uint64_t, '%#x',  'refcount_table_offset'],
+        [uint32_t, '%d',   'refcount_table_clusters'],
+        [uint32_t, '%d',   'nb_snapshots'],
+        [uint64_t, '%#x',  'snapshot_offset'],
 
         # Version 3 header fields
-        [ uint64_t, 'mask', 'incompatible_features' ],
-        [ uint64_t, 'mask', 'compatible_features' ],
-        [ uint64_t, 'mask', 'autoclear_features' ],
-        [ uint32_t, '%d',   'refcount_order' ],
-        [ uint32_t, '%d',   'header_length' ],
-    ];
+        [uint64_t, 'mask', 'incompatible_features'],
+        [uint64_t, 'mask', 'compatible_features'],
+        [uint64_t, 'mask', 'autoclear_features'],
+        [uint32_t, '%d',   'refcount_order'],
+        [uint32_t, '%d',   'header_length'],
+    ]
 
     fmt = '>' + ''.join(field[0] for field in fields)
 
@@ -59,7 +61,7 @@ class QcowHeader:
 
         header = struct.unpack(QcowHeader.fmt, buf)
         self.__dict__ = dict((field[2], header[i])
-            for i, field in enumerate(QcowHeader.fields))
+                             for i, field in enumerate(QcowHeader.fields))
 
         self.set_defaults()
         self.cluster_size = 1 << self.cluster_bits
@@ -96,7 +98,8 @@ class QcowHeader:
             else:
                 padded = (length + 7) & ~7
                 data = fd.read(padded)
-                self.extensions.append(QcowHeaderExtension(magic, length, data))
+                self.extensions.append(QcowHeaderExtension(magic, length,
+                                                           data))
 
     def update_extensions(self, fd):
 
@@ -108,14 +111,13 @@ class QcowHeader:
             fd.write(buf)
             fd.write(ex.data)
 
-        if self.backing_file != None:
+        if self.backing_file is not None:
             self.backing_file_offset = fd.tell()
             fd.write(self.backing_file)
 
         if fd.tell() > self.cluster_size:
             raise Exception("I think I just broke the image...")
 
-
     def update(self, fd):
         header_bytes = self.header_length
 
@@ -163,19 +165,21 @@ def cmd_dump_header(fd):
     h.dump()
     h.dump_extensions()
 
+
 def cmd_dump_header_exts(fd):
     h = QcowHeader(fd)
     h.dump_extensions()
 
+
 def cmd_set_header(fd, name, value):
     try:
         value = int(value, 0)
-    except:
+    except ValueError:
         print("'%s' is not a valid number" % value)
         sys.exit(1)
 
     fields = (field[2] for field in QcowHeader.fields)
-    if not name in fields:
+    if name not in fields:
         print("'%s' is not a known header field" % name)
         sys.exit(1)
 
@@ -183,25 +187,29 @@ def cmd_set_header(fd, name, value):
     h.__dict__[name] = value
     h.update(fd)
 
+
 def cmd_add_header_ext(fd, magic, data):
     try:
         magic = int(magic, 0)
-    except:
+    except ValueError:
         print("'%s' is not a valid magic number" % magic)
         sys.exit(1)
 
     h = QcowHeader(fd)
-    h.extensions.append(QcowHeaderExtension.create(magic, data.encode('ascii')))
+    h.extensions.append(QcowHeaderExtension.create(magic,
+                                                   data.encode('ascii')))
     h.update(fd)
 
+
 def cmd_add_header_ext_stdio(fd, magic):
     data = sys.stdin.read()
     cmd_add_header_ext(fd, magic, data)
 
+
 def cmd_del_header_ext(fd, magic):
     try:
         magic = int(magic, 0)
-    except:
+    except ValueError:
         print("'%s' is not a valid magic number" % magic)
         sys.exit(1)
 
@@ -219,12 +227,13 @@ def cmd_del_header_ext(fd, magic):
 
     h.update(fd)
 
+
 def cmd_set_feature_bit(fd, group, bit):
     try:
         bit = int(bit, 0)
         if bit < 0 or bit >= 64:
             raise ValueError
-    except:
+    except ValueError:
         print("'%s' is not a valid bit number in range [0, 64)" % bit)
         sys.exit(1)
 
@@ -236,21 +245,24 @@ def cmd_set_feature_bit(fd, group, bit):
     elif group == 'autoclear':
         h.autoclear_features |= 1 << bit
     else:
-        print("'%s' is not a valid group, try 'incompatible', 'compatible', or 'autoclear'" % group)
+        print("'%s' is not a valid group, try "
+              "'incompatible', 'compatible', or 'autoclear'" % group)
         sys.exit(1)
 
     h.update(fd)
 
+
 cmds = [
-    [ 'dump-header',          cmd_dump_header,          0, 'Dump image header and header extensions' ],
-    [ 'dump-header-exts',     cmd_dump_header_exts,     0, 'Dump image header extensions' ],
-    [ 'set-header',           cmd_set_header,           2, 'Set a field in the header'],
-    [ 'add-header-ext',       cmd_add_header_ext,       2, 'Add a header extension' ],
-    [ 'add-header-ext-stdio', cmd_add_header_ext_stdio, 1, 'Add a header extension, data from stdin' ],
-    [ 'del-header-ext',       cmd_del_header_ext,       1, 'Delete a header extension' ],
-    [ 'set-feature-bit',      cmd_set_feature_bit,      2, 'Set a feature bit'],
+    ['dump-header',          cmd_dump_header,          0, 'Dump image header and header extensions'],
+    ['dump-header-exts',     cmd_dump_header_exts,     0, 'Dump image header extensions'],
+    ['set-header',           cmd_set_header,           2, 'Set a field in the header'],
+    ['add-header-ext',       cmd_add_header_ext,       2, 'Add a header extension'],
+    ['add-header-ext-stdio', cmd_add_header_ext_stdio, 1, 'Add a header extension, data from stdin'],
+    ['del-header-ext',       cmd_del_header_ext,       1, 'Delete a header extension'],
+    ['set-feature-bit',      cmd_set_feature_bit,      2, 'Set a feature bit'],
 ]
 
+
 def main(filename, cmd, args):
     fd = open(filename, "r+b")
     try:
@@ -267,6 +279,7 @@ def main(filename, cmd, args):
     finally:
         fd.close()
 
+
 def usage():
     print("Usage: %s <file> <cmd> [<arg>, ...]" % sys.argv[0])
     print("")
@@ -274,6 +287,7 @@ def usage():
     for name, handler, num_args, desc in cmds:
         print("    %-20s - %s" % (name, desc))
 
+
 if __name__ == '__main__':
     if len(sys.argv) < 3:
         usage()
-- 
2.21.0


