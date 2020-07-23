Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADDBC433E4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 03:44:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2805520825
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 03:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="q9Znag9R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2805520825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jySA8-0004TQ-Dg
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 23:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jyS64-0004eI-N9
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 23:40:40 -0400
Received: from mail-mw2nam12on2114.outbound.protection.outlook.com
 ([40.107.244.114]:16939 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jyS63-0002Ew-5t
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 23:40:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lnSA5iUeOvjKeoYzK8vpA8jrMl7BTwfNCmv2cIvrh80EKEAYnk1w/Dz9muAloxIIgStPlevXvChu290no1lYTta5O3mOIJZZseysjDI1biRVEwkBatXiirzjoxOsHw2UHO4e3l2LsxOUv1CMNNlACxtosDQM4tFZ76wqzak5yI+tg15lDpoDNB54i8uWYNNrn4WPTKot/f+WHkBv8UsAtPB2jw+X+VDd+zFOyod7fzJMz2zo+Zfa3kq533L+3xILTY4xWZxvWTePXSj2GmIXQWJKH/aOkvCv/EuXEyeq9DSqRGGETdZXL15ebLDFWZ80afKGLWpRvlYXgqD96gSfFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILFm+jKTdjrdX8nkeEQ3xqWEJ12GQUk4+ZhBwAirD8k=;
 b=VVYIPcVFwJIVGsZXGHZKLx5H5BR0IuuWPgyLLs6TkZC21RyDf0r4xqRBnicY9dWBA76bxj6RISAYN2YdGbSkn7SAdYqab94OEGLMFYeZANaPJbTdjv1ozhrt4nJ4ZWARWRrjk88i80hcCLu6iwPgaebHoHEsd6ftqKsEJ51cLeH9JM0Z4RWhORdnoKYIHy7vl7ZKY6iZwS9PjPIUoorPopjBLEHr89opoY9M8VvZK5qPk99vlbxaj5DF3TVsaG+A0pQKtoc2ZSEDPSAGgCupqJ18yd/AN2e31XWdY+6GqjNv4eiupTSGIsOCzCQPw2FdFWmt2l/2RjTNiZ9YMbjVgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILFm+jKTdjrdX8nkeEQ3xqWEJ12GQUk4+ZhBwAirD8k=;
 b=q9Znag9RPbVMBoaDB1VMUdeO3hy0AO2u3suq5/4VA2d4+WJE5RB55eLjDUQwC8aIv/ElvG6FhCmZXSekJpAaVgnzMRN7V7v5C5di4gcKxpzxcRTXprNCDBQuhedEPPeHRa3nCoLIrWClhsPj2tX0/UpLvyszohLarbyu4mgaVNY=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3982.namprd03.prod.outlook.com (2603:10b6:805:67::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22; Thu, 23 Jul
 2020 03:40:22 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b%7]) with mapi id 15.20.3216.024; Thu, 23 Jul 2020
 03:40:22 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/12] scripts/oss-fuzz: build the general-fuzzer configs
Date: Wed, 22 Jul 2020 23:39:31 -0400
Message-Id: <20200723033933.21883-11-alxndr@bu.edu>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200723033933.21883-1-alxndr@bu.edu>
References: <20200723033933.21883-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0057.namprd16.prod.outlook.com
 (2603:10b6:208:234::26) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR16CA0057.namprd16.prod.outlook.com (2603:10b6:208:234::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend
 Transport; Thu, 23 Jul 2020 03:40:20 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91a1d0af-efbf-407a-0b4f-08d82eba2065
X-MS-TrafficTypeDiagnostic: SN6PR03MB3982:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB39829B93251EAB7AA4F3B244BA760@SN6PR03MB3982.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PVj4S5G9bYUH3GxbNfU+rNzjh7lTN6A1gTHJNW9ZFZTVNeXQ7Nz7BZKw6zhpWM9c4EuGKUX9weV5iVBKb5KnQkZvMJhV51WEYMzjU/V0f2Gq0FePI3H9GZ9IcaSCRB7H4eGDOpombX0FrT5hNvbj4jVFLsBh01atS4eVH1WdjPKk8cxs6ADJlWpqi2RDPZ1k7vvPWcUtFk80NyyjQGi1tYgcKTHPabC5vroNzfXcxSyMkAUuGMh8wcMSe1g4ojC8LHClr+D1Qj6dX0uekP21H5SihFdiIRUGWAp6yMGBfOfsOhNEcQcxtbT8qjNVz/Di
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(6916009)(4326008)(36756003)(478600001)(83380400001)(5660300002)(2616005)(956004)(6666004)(8936002)(52116002)(7696005)(66946007)(66556008)(66476007)(6486002)(75432002)(26005)(8676002)(16526019)(54906003)(86362001)(186003)(316002)(1076003)(786003)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: GbcEm2xy4bCGbmunm0crc7XxgstcLNKM5rwNPxtDvnvXMQ8fvZbuKRG6czw9zEj2BOtbdbRbdunnIJ2Vs4kJdY18hrd5gwcPzop1xM/+EaWS4IrX88QEoUqk6tdxiyRCwZ+PVrgUrdz3PPx4CdlKx5hSB8dL5uMv2jk1ZskDk/nppGj5QgvNp+S8JFn0epGM68CHZQRa0mKKVChfdTir/lbYa0TR4NBCXSNr6BMP+HSW6HEIpSN3OJjNov53sVSyn+RggBZAT6zwfdOj0RUB3sSku4/pknm6ElfDOJC1py83asfAn/Z/Aq4W4HaiargxGVNXslAwp3ZBs4lvcW0jL2lkwJM6v06mvsHcIOw5HX5VH8lr286LJ5WbGmBAwcv6pyAlWlOyBOxDtSM8bomBHbLogXSxiiU+/0iQvwoZMn1BWDlRyfkUJNe8SOuWAol4qg959MKT8f5suYXQCYL6byCcXInDhhd223E1VST/IqI=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a1d0af-efbf-407a-0b4f-08d82eba2065
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2020 03:40:22.1479 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dq4gBfPHivOaxzF9WLAFIqnYd4IVxeendFhzdmFRfbWQH3TEoPqibee/hkHeHbZQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3982
Received-SPF: pass client-ip=40.107.244.114; envelope-from=alxndr@bu.edu;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 23:40:15
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
 darren.kenny@oracle.com, bsd@redhat.com, dstepanov.src@gmail.com,
 stefanha@redhat.com, andrew@coatesdev.com, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Build general-fuzzer wrappers for each configuration defined in
general_fuzzer_configs.yml and move the actual general-fuzzer to a
subdirectory, so oss-fuzz doesn't treat it as a standalone fuzzer.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 scripts/oss-fuzz/build.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/scripts/oss-fuzz/build.sh b/scripts/oss-fuzz/build.sh
index a07b3022e8..2071e77ac2 100755
--- a/scripts/oss-fuzz/build.sh
+++ b/scripts/oss-fuzz/build.sh
@@ -38,7 +38,7 @@ OSS_FUZZ_BUILD_DIR="./build-oss-fuzz/"
 # remove it, resulting in an unresolved reference to qemu_build_not_reached
 # Undefine the __OPTIMIZE__ macro which compiler.h relies on to choose whether
 # to " #define qemu_build_not_reached()  g_assert_not_reached() "
-EXTRA_CFLAGS="$CFLAGS -U __OPTIMIZE__"
+EXTRA_CFLAGS="$CFLAGS -U __OPTIMIZE__ -DCONFIG_FUZZ=y"
 
 if ! { [ -e "./COPYING" ] &&
    [ -e "./MAINTAINERS" ] &&
@@ -101,5 +101,11 @@ do
     cp ./i386-softmmu/qemu-fuzz-i386 "$DEST_DIR/qemu-fuzz-i386-target-$target"
 done
 
+mkdir -p "$DEST_DIR/deps"
+mv "$DEST_DIR/qemu-fuzz-i386-target-general-fuzz" "$DEST_DIR/deps/"
+
+./scripts/oss-fuzz/build_general_fuzzers.py \
+    "./scripts/oss-fuzz/general_fuzzer_configs.yml" "$DEST_DIR/general-fuzz-"
+
 echo "Done. The fuzzers are located in $DEST_DIR"
 exit 0
-- 
2.27.0


