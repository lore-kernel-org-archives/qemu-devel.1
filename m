Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA085C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:44:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A58B7207D8
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="0ghwoCEN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A58B7207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhGOP-0007kG-UX
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 13:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jhGKz-00037b-6z
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:41:03 -0400
Received: from mail-mw2nam10on2122.outbound.protection.outlook.com
 ([40.107.94.122]:14561 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jhGKw-00058I-GB
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:41:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OgtJpafNfaZmsKIi5z3fzF00H4Afps1QnfPzmEVZPl2C+3IGRQc+goeAQGZBUr4SNJcP0xkbN+nEApQQG8PMiBMWOH6nWtZKj4fzirph707mEI3aKzbG58biFG8YA2IK7b3YqBVYAoyTroZX5ZyMCxpe5JmvD9aCSl4aleyF0p7vMGvfiyyRDz+odNgNhyptClTGbIYYOczswtyD9kLL8lHe8/bZKpM7eS6pAusCVyB/GjXrwd+v0hQz0VRBvhIGZs7UnMSoTl0vFjCephZ+Y9gPYHbnJQbZMjp6ViKqk7HQ6R3XTAAfZQVzZ2BsxoDhhwdZezphzJ9xi7GzUFFnbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VYswxgY+ak3lu5XH1yrLgaTA3w/NWFh+jihOSSZkMo=;
 b=Mql2958NVC+G2pjSKyb1wit6olts1J0oJa2F3/oOHcBfuu6S1O3dsWdPs1nYnnSlGOyMUh3m0v5/JnQ1D69BMStioukFgL87k6lTY8AIwTvDj7balNe2NzfXlU8+UJksKcUbqO9joIR9ew9bI74Bz0HkjspcN2sjUcMoT265a+SFAig4WWqiL4As/3tn2tO+vOfgkR08oQUyax/AsUh3XhXiXzIMrOGxNWTwszybflKehkOrKpTPutU6agRpaGr7JpvyT7fSkjsT6rjiWImg9TDyV2hziEEiSrajcSQKNzUZgBkin59NipkWf+5hIJ4h6+l1Rg8eIFvxC4yOqIhbyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VYswxgY+ak3lu5XH1yrLgaTA3w/NWFh+jihOSSZkMo=;
 b=0ghwoCENWydxXIxmccKQFJ4lxQDsdjcSLNvNIqF2OeIT/shN6Im95w3Qo28LP3vuYrEIRcE6FIlgSb16jdVbmnk+YY3xQXHkv5Yz+L9XUOF5NRq2Tn8d1k7bMTq2kmZ/Gy3oTBoKRt16ezGsXFG+q2qfc86CckUthgTtThQjAkY=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB4448.namprd03.prod.outlook.com (2603:10b6:805:f7::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Fri, 5 Jun
 2020 17:40:54 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b%7]) with mapi id 15.20.3066.018; Fri, 5 Jun 2020
 17:40:54 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH] fuzz: add oss-fuzz build.sh script
Date: Fri,  5 Jun 2020 13:40:36 -0400
Message-Id: <20200605174036.4527-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0025.namprd02.prod.outlook.com
 (2603:10b6:207:3c::38) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR02CA0025.namprd02.prod.outlook.com (2603:10b6:207:3c::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Fri, 5 Jun 2020 17:40:54 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ee907e1-816d-48ac-e4cf-08d809779909
X-MS-TrafficTypeDiagnostic: SN6PR03MB4448:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB444824B5D9ED775DB46EA2CFBA860@SN6PR03MB4448.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0425A67DEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pC+v4EszfzJgx6v0yiFrFPXxA7AKU8yB5w2RTX+9V2g6wPMERWfwxfzkq6vfMZlGdrLGaVRRuiAffhzkiSm/SZA/W4bNKqUn0GTfHtneHMG4UlvyldY/OyJuIgwiDoXSp/1zIu8NB790wH3G7JU2xxzDMV3AOHCjzVOIZq6ebN5Co7kaonQUi+psFUdx0br4HRductRDM1eYmv3CeluHlB4zUHkOfgrX96WCvJqcsbzi4b4oZkUGNllXXq1amo5W6Gm63IuGx1FxtQcYWaViW5TWQhM9uzUSKl7O6O2dNBKphfCmC/sAM4emqJyIIopdkydm6qBetVnIJ0ptV0W23A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(6486002)(52116002)(7696005)(8936002)(26005)(186003)(16526019)(86362001)(8676002)(478600001)(316002)(786003)(75432002)(36756003)(2906002)(6666004)(4326008)(66556008)(66476007)(6916009)(83380400001)(66946007)(5660300002)(1076003)(2616005)(956004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: q5w2apowNbzFP+zWtNk7UgYWfuZOWFpxtwyILh9MBHaEiECdE5vTbjR3pG2lCfskodidnuquBt05mgkv6jPJq0nL1/ZXkXcB6UzBU/wO72M9QBCPHlSeNMzFvsOwgIbihoqbAxksKzVSSJrIviXBPSlLhaX1YCUydpqRdNzXiBkf0pGwQ41pg8otTHGsQNLz4omehKX0d+qT3s1KftpMc/QiMqkVQltYLMNXeibuBv7JXeR1imM1yWIQTNvzynBxLK8N6/yeRsDKkatS8iWqQvMMaANaV3vAP55o96xGCUxtl59Y9tec3DHJdm7sAlAiqn+EzBCZX/avIUK0bDzGpi5Jl25KD5GSUHwDREyUXoL+EDXJUm7k31MBRkAydS5fDoVfU1XUMjOHiua7pSoJ0wFsS5yfqCvxyt4t4/aafwE+qPqeUCPus6YdbiuqtkQCF62/kE/5s/OpfLSrmxAMAVzW/NhqU/jcZVpKkd+EIVk=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee907e1-816d-48ac-e4cf-08d809779909
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2020 17:40:54.7804 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lv+LjEexMCgHJwqfGFi75Lr/BAcLfRI+wOKegQaY4GWNH1EYpFzz0N3uX2rJPwNR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4448
Received-SPF: pass client-ip=40.107.94.122; envelope-from=alxndr@bu.edu;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 13:40:56
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
 scripts/oss-fuzz/build.sh | 47 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100755 scripts/oss-fuzz/build.sh

diff --git a/scripts/oss-fuzz/build.sh b/scripts/oss-fuzz/build.sh
new file mode 100755
index 0000000000..7be6dcce4c
--- /dev/null
+++ b/scripts/oss-fuzz/build.sh
@@ -0,0 +1,47 @@
+#!/bin/sh
+#
+# Update syscall_nr.h files from linux headers asm-generic/unistd.h
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
+# Copy over the qemu-fuzz-i386, naming it according to each available fuzz
+# target (See 05509c8e6d fuzz: select fuzz target using executable name)
+for target in $(./i386-softmmu/qemu-fuzz-i386 | awk '$1 ~ /\*/  {print $2}');
+do
+    cp ./i386-softmmu/qemu-fuzz-i386 $OUT/qemu-fuzz-i386-target-$target
+done
-- 
2.26.2


