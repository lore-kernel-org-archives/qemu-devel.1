Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D1CC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:24:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4FF021D47
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="GlhiulRU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4FF021D47
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVyvq-0007QV-KD
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 11:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVyg5-00042O-WA
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:08:26 -0400
Received: from mail-bn7nam10on2139.outbound.protection.outlook.com
 ([40.107.92.139]:64992 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVyg4-0007AB-3A
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:08:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hxf5P4iphHjtV8lxPyQ9i+/SLatnFekwIII6sCX4z3LPstPtREJgpqhuviCvy8v5oT4IaNSyYyBA+Et/lCYLkPElyHK4c2Y1ib4Sz9JDx638rcMC2f6/v/+yMLglmAJoLvtq9+XYR51nlVaeaoNt2lEHaKn2Wym96XVWpLIll3rIvb/hPD8VScNXwMGKQyWDK3RX1c1AjNi/KBNMbJ11L1juR6DTXOVavZr9jOzVpIWLAB2FQNeJ1RSeKvYs8r1hCnYADO24FV/dQS+f7KXG3BnqxLn3UrKUNaawBhxjn8z7bUQkcWTDkzy+oSH2ye25neFSxY8T1KxHNihb/FAYAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMwZiaGn6GlPnRuClAbQ6TPmMCq0hfYdl1tadXQ67sE=;
 b=XLrjpbSCKDaFLogln74NegrzAyXGYD+04kibEI7onIyiFYi8Vyl05rt+AOXcfkAI/g+snwydm8Iwz/U7Nv65X9ZZjQPdMstjutNW2sS2QBafRdBlZlCslhA3ZQ58QFaoEHGqOdfO3NPd7XP16eY8xO2rBz1RBDecuORQIUZRYL6sF1ufq2nSoLEyx0aFBH1xYk77+Ie3t/yJSNJjNjOu7jDJoEBsWCgyjiT+5PTIQzPGh6fktTcI2C5HWREOsKqJSPdkGnzy+KNu/ft+Uz3mPY53tfzMk3K0z53UQPTxqHb1QAipqaX5fZn8/3QmBgvU0c85Tuolx2dW/IhVOtE8sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMwZiaGn6GlPnRuClAbQ6TPmMCq0hfYdl1tadXQ67sE=;
 b=GlhiulRUwt+wDoahxNqiq++GZk1RfX9P1HSHA+mu46qbt4ynOfy856R9CUBONLUyCynr8Z2yrU8AYjxiZiOsrzO/yTLr/HmgU9FAfYLBpB1Vq9iNluUGxNCS39QbXBkllS/rAR9SJtAQ8kpwx0aCDJKPAtJDnaPgkX7E3N1rYME=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SA0PR03MB5516.namprd03.prod.outlook.com (2603:10b6:806:bf::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Fri, 23 Oct
 2020 15:08:18 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3477.028; Fri, 23 Oct 2020
 15:08:18 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 16/17] scripts/oss-fuzz: use hardlinks instead of copying
Date: Fri, 23 Oct 2020 11:07:45 -0400
Message-Id: <20201023150746.107063-17-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201023150746.107063-1-alxndr@bu.edu>
References: <20201023150746.107063-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [72.93.72.163]
X-ClientProxiedBy: MN2PR01CA0065.prod.exchangelabs.com (2603:10b6:208:23f::34)
 To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 MN2PR01CA0065.prod.exchangelabs.com (2603:10b6:208:23f::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Fri, 23 Oct 2020 15:08:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65ecc236-3539-47e1-7066-08d877657958
X-MS-TrafficTypeDiagnostic: SA0PR03MB5516:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR03MB55166677B3EA6A407ECF3355BA1A0@SA0PR03MB5516.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6OTNfy69Thd2TmEEJiHWxAFjl1+abnGDclhujXk3mw2cBaKxGbBr7Y6PbSG1oKRdYRb7XAiqyiSe6aaw1yJMDG64xlnDsLRoYDUb14K7NWRB/Hi32g9npKois4YPd6N7nA4SV97kX63vpApx6cL27N39bmsJhX6ZoYsoCL9LlhO5POna7PPkjAj2TUej0A9zqimFYGGy63ldwxItSKdCQI9yTCEfrl7Epo6924K+FjugT69Cnc4wHEyLsWI8xPfqu2nRjT9T6k1+A1zP44bmoMCSsf5auQpD3PwWChrdmIlYJK9+kObMUiKwBHjTJLWG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(2616005)(4326008)(1076003)(6512007)(478600001)(5660300002)(83380400001)(8936002)(8676002)(86362001)(2906002)(956004)(36756003)(6506007)(66476007)(6916009)(786003)(66556008)(75432002)(66946007)(52116002)(6666004)(186003)(26005)(6486002)(316002)(16526019);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Blar1jZS4UNDngsiyhEK+Ijri+mmYlMSEL3fQUH4juyh4uNIGkVCglA6iRtaaCejcyR+O4w6z1hKOMlb65jkNxPFjqpaGhhidzFEoLYmUCqjP149uGKoSD8Nj5Xx7wm12Dbw46hZIxhrylLcApJJ0sKg7/0q2rmSYgRng6A2L+lKIakLs4QQEwCp2YRi8kshFPBHGH42HLJBy3u4SuaUc94tro8i99pxLHUecJbEYRc4kgWU0zDh4SH7nfM/+wCPI38ocprc6uIdFgeT5EwAve5PUlz3Op7qpukolX7qmHV+6PbzVlO3Ofh6ZCpNh9H9JU3ybxSweVq/GReVNxUgkhzNrmvSCNtyC7x6EkKYK79/aVx6ujWhdv4IKAUiYd7Nre9LeFsuV816o7pK4fqy/NE8ZFUmu2PygoAUYjD1887iVmLOVuutCpSfR/QbhcK2pETTGCar5eEBSdboqQkihBh2nd/SIUpwRqN6YrQdy+ngt5z5SGVY2iA0BMMn6i8R1b2D0LTazi/V08JUOnbh+O8q5U025GF20tynRN/ZjWrG1lAUvh25LwV4FDlSW5XmdvmlO9cUe37wMScuf4vsJm6liJyhqlBhjbyj+eaeXUcU19P7xX6ehIvrwd99w5RHOT1o7XfwtPyFZ8jrrz+pLQ==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ecc236-3539-47e1-7066-08d877657958
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 15:08:18.5585 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0K+7h/iLc0iyginXN3UrWCB5At0k6zLe1k/kGrMVscV6ZzT0XxyE0E5qR8/fP6oU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5516
Received-SPF: pass client-ip=40.107.92.139; envelope-from=alxndr@bu.edu;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 11:08:15
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.63,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: thuth@redhat.com, Alexander Bulekov <alxndr@bu.edu>, f4bug@amsat.org,
 darren.kenny@oracle.com, bsd@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, dimastep@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Prior to this, fuzzers in the output oss-fuzz directory were exactly
the same executable, with a different name to do argv[0]-based
fuzz-target selection. This is a waste of space, especially since these
binaries can weigh many MB.

Instead of copying, use hard links, to cut down on wasted space. We need
to place the primary copy of the executable into DEST_DIR, since this is
a separate file-system on oss-fuzz. We should not place it directly into
$DEST_DIR, since oss-fuzz will treat it as an independent fuzzer and try
to run it for fuzzing. Instead, we create a DEST_DIR/bin directory to
store the primary copy.

Suggested-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 scripts/oss-fuzz/build.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/scripts/oss-fuzz/build.sh b/scripts/oss-fuzz/build.sh
index 0c3ca9e06f..0ce2867732 100755
--- a/scripts/oss-fuzz/build.sh
+++ b/scripts/oss-fuzz/build.sh
@@ -62,6 +62,9 @@ fi
 
 mkdir -p "$DEST_DIR/lib/"  # Copy the shared libraries here
 
+mkdir -p "$DEST_DIR/bin/"  # Copy executables that shouldn't
+                           # be treated as fuzzers by oss-fuzz here
+
 # Build once to get the list of dynamic lib paths, and copy them over
 ../configure --disable-werror --cc="$CC" --cxx="$CXX" --enable-fuzzing \
     --prefix="$DEST_DIR" --bindir="$DEST_DIR" --datadir="$DEST_DIR/data/" \
@@ -88,13 +91,16 @@ make "-j$(nproc)" qemu-fuzz-i386 V=1
 # Copy over the datadir
 cp  -r ../pc-bios/ "$DEST_DIR/pc-bios"
 
+cp "./qemu-fuzz-i386" "$DEST_DIR/bin/"
+
 # Run the fuzzer with no arguments, to print the help-string and get the list
 # of available fuzz-targets. Copy over the qemu-fuzz-i386, naming it according
 # to each available fuzz target (See 05509c8e6d fuzz: select fuzz target using
 # executable name)
 for target in $(./qemu-fuzz-i386 | awk '$1 ~ /\*/  {print $2}');
 do
-    cp qemu-fuzz-i386 "$DEST_DIR/qemu-fuzz-i386-target-$target"
+    ln  "$DEST_DIR/bin/qemu-fuzz-i386" \
+        "$DEST_DIR/qemu-fuzz-i386-target-$target"
 done
 
 echo "Done. The fuzzers are located in $DEST_DIR"
-- 
2.28.0


