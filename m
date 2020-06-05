Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB724C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:51:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7A8F2074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="dR4A9ryr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A8F2074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhGVZ-0007ZL-1a
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 13:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jhGUP-0006FJ-VW
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:50:46 -0400
Received: from mail-dm6nam12on2096.outbound.protection.outlook.com
 ([40.107.243.96]:16864 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jhGUM-0006kY-VR
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:50:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAT9ZmE0j99TB4L4b/03hviYi/y8svIWUd6OFZbQT1t2E2Gk9GWf/N5JkOZhpUNNSROLW+jB3+s0bf/js/bImQGC3wptgvyq/Cg0ZzxSggmeHyTe3AQDuWCS1VbU7rrQZWsoulDfDOYg8M6B2iVjqVr+ZUZ4ehV/fw8hq5AYKLYJBs/fhzJG30YjKCWtgtBqZ8Du2YYj2rAF9LD0XjRDUF0QYOfF+1++TOjB9tqHZ0WT5SJ7MNRi/JQ9xczL7s2n7N+NOKVySt4rhGQHRx3F7vdrK905eLztXna8DE5liJFvLmIl4dc/SroaR4Anrj8/WpNlhepYz733tm4yi/aP+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vozygtF/wQKIc51ECFDDxs7WNS/qyXW8Lhyp7xoAvuk=;
 b=heNmYtjxwLQY786MKVFQOkRoAILj1dgvKfAMrgKlbxf1cqlS2gGLWM0sTPt4D79+WQIdi6qzLYPCJQ40cPJWsbIVmkffPzXLumwF4jLXz3Q3jRVv1nxOe2irSEVLvu1un2+WeCekrHpakjib3dwpycJXezpS8YvuxoQe36H7CPIDBxK4MLOagkYyp0kTL/bq5rp0tyjc26vTtE8g39d/HBKLNwdO8ypKapyViAlA0tY4K8hz/IPBNaReHs6368oA6uVYjRFicS2BL10MNYGY2KR5MagBkrOi2cItIytihQx+M0P2NSB5GUaIQ6gD2l74KXZad7uYl0nB4vp2DvKarw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vozygtF/wQKIc51ECFDDxs7WNS/qyXW8Lhyp7xoAvuk=;
 b=dR4A9ryrTYX1sZ3UIXjNmW+x4fWfKpf21MIMq7eXrYIZhP9kCL7JM5DHECOcTdg4kGLmf898RJxnXl+Rp5m1/I2zBo26ROr1AmlYQX9Di45aY3gUJ79+lozZLcxzeByRo+8uueiULq5s5AV8/b4uWh2K1TqJdTmNJFWF7NpiHXo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3837.namprd03.prod.outlook.com (2603:10b6:805:77::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Fri, 5 Jun
 2020 17:50:40 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b%7]) with mapi id 15.20.3066.018; Fri, 5 Jun 2020
 17:50:40 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] fuzz: add oss-fuzz build.sh script
Date: Fri,  5 Jun 2020 13:50:28 -0400
Message-Id: <20200605175028.5626-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0029.prod.exchangelabs.com
 (2603:10b6:207:18::42) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR0102CA0029.prod.exchangelabs.com (2603:10b6:207:18::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Fri, 5 Jun 2020 17:50:39 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6b08c57-09e7-499c-dccb-08d80978f5d5
X-MS-TrafficTypeDiagnostic: SN6PR03MB3837:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB3837E8BFDD7FF0790E2F0C5DBA860@SN6PR03MB3837.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0425A67DEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cer3H7pRD/rr1Vqin1/OjO7F+W0vxEYazbUMiBVGpb4NmTqFLiHkgdGqoLd9P4wLav7ORnuDIFdho3I6vVVARhGuRUajnVEs0ZZxzLcz3l8KXA+wvye0AlewHbLEn5IQr3eqJOwWSJFS+yVfFosO325dlL5sx8DvLEDzw2G6u8hLKe5tpcaCJnGCGlxvdxDQ3zbDt0ZpvCLn2xfUQHZcI3dNILFqe+Wcyq3nlNeSZpiXG1ek929Kx7H6PPHa7l2xl0SuULJNA0c3QD6Z3dzl76PxU/hFk1FtZmoRSyr3PnZ8dQyO/7Cs4AdOnPJbcYttbXFoBDMtn5xq63NlYgZH+Yeq2TiwFFVxzwZ+Bj5OszNR3vdUK2pE3I4T5YpWcMUluBsCzCnvM+MkwDvRoQPSYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(7696005)(786003)(186003)(66946007)(66556008)(66476007)(52116002)(8936002)(86362001)(8676002)(83080400001)(4326008)(6916009)(83380400001)(2906002)(316002)(75432002)(956004)(26005)(16526019)(6486002)(36756003)(6666004)(1076003)(966005)(5660300002)(2616005)(478600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: mGvQRKFbnGAq6KXQsEV/gWqHlcCo5+1f52XTrhOjl93dohGzJPvbrcFvvFYXrj3IXGa6CKsQvi56hFBXH+l6xnvRZW1nTWLDdGoru9xdlxE28PO+W0wam+k1q6qRopDjDCLkZrlaDVnegLDKbg6Ns7Wul+gpbT+seXZ+wN5l5HStfSIez/X+SQwovBfGzNilcc/y+mzs/ss4vCpOdQLFv0QN+9LdE8vvR1TxcL/+WQkwFwOK27/p6gQ6kpZ8vvvuKNXA72CnWWdBwJfO443urtrOuAk/UbPqfko4Pc7erirDe0niLlhAGUIoDk6cY/7FHvkGSNacJg+4mrJA5fWQmTJ60z8zsrdpSDahdbt3/9+20RKK28kFrQGaY1jTzu5BAIepw/UwtquygF7lhsjZD0pa9/Xq3SQVDcDQZbMUbzRyk84nhJeglqW69ffOHRMCPxgZt+mz7aXvMfbkTbIHao38u4u6hoAgkpzuI2yFxGI=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b08c57-09e7-499c-dccb-08d80978f5d5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2020 17:50:39.9463 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rrWFDZEPZcXGmfTwuR3EJ5ck+9JFlbQ934W9x+ShRL6GN503QDrf+XTLz4naKML2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3837
Received-SPF: pass client-ip=40.107.243.96; envelope-from=alxndr@bu.edu;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 13:50:41
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: darren.kenny@oracle.com, bsd@redhat.com, f4bug@amsat.org,
 stefanha@redhat.com, Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is neater to keep this in the QEMU repo, since any change that
requires an update to the oss-fuzz build configuration, can make the
necessary changes in the same series.

Suggested-by: Philippe Mathieu-Daude <f4bug@amsat.org>
Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---

v2 updates the script header comment.

 scripts/oss-fuzz/build.sh | 50 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100755 scripts/oss-fuzz/build.sh

diff --git a/scripts/oss-fuzz/build.sh b/scripts/oss-fuzz/build.sh
new file mode 100755
index 0000000000..e93d6f2e03
--- /dev/null
+++ b/scripts/oss-fuzz/build.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+#
+# OSS-Fuzz build script. See:
+# https://google.github.io/oss-fuzz/getting-started/new-project-guide/#buildsh
+#
+# This code is licensed under the GPL version 2 or later.  See
+# the COPYING file in the top-level directory.
+#
+
+# build project
+# e.g.
+# ./autogen.sh
+# ./configure
+# make -j$(nproc) all
+
+# build fuzzers
+# e.g.
+# $CXX $CXXFLAGS -std=c++11 -Iinclude \
+#     /path/to/name_of_fuzzer.cc -o $OUT/name_of_fuzzer \
+#     $LIB_FUZZING_ENGINE /path/to/library.a
+
+mkdir -p $OUT/lib/              # Shared libraries
+
+# Build once to get the list of dynamic lib paths, and copy them over
+./configure --datadir="./data/" --disable-werror --cc="$CC" --cxx="$CXX" \
+    --extra-cflags="$CFLAGS -U __OPTIMIZE__ "
+make CONFIG_FUZZ=y CFLAGS="$LIB_FUZZING_ENGINE" -j$(nproc) i386-softmmu/fuzz
+
+for i in $(ldd ./i386-softmmu/qemu-fuzz-i386  | cut -f3 -d' '); do 
+    cp $i $OUT/lib/
+done
+rm ./i386-softmmu/qemu-fuzz-i386
+
+# Build a second time to build the final binary with correct rpath
+./configure --datadir="./data/" --disable-werror --cc="$CC" --cxx="$CXX" \
+    --extra-cflags="$CFLAGS -U __OPTIMIZE__" \
+    --extra-ldflags="-Wl,-rpath,'\$\$ORIGIN/lib'"
+make CONFIG_FUZZ=y CFLAGS="$LIB_FUZZING_ENGINE" -j$(nproc) i386-softmmu/fuzz
+
+# Copy over the datadir
+cp  -r ./pc-bios/ $OUT/pc-bios
+
+# Run the fuzzer with no arguments, to print the help-string and get the list
+# of available fuzz-targets. Copy over the qemu-fuzz-i386, naming it according
+# to each available fuzz target (See 05509c8e6d fuzz: select fuzz target using
+# executable name)
+for target in $(./i386-softmmu/qemu-fuzz-i386 | awk '$1 ~ /\*/  {print $2}');
+do
+    cp ./i386-softmmu/qemu-fuzz-i386 $OUT/qemu-fuzz-i386-target-$target
+done
-- 
2.26.2


