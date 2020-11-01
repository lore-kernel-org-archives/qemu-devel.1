Return-Path: <SRS0=Dm/C=EH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,
	RCVD_DOTEDU_SUSP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BC3C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 21:38:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB54E21556
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 21:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="SDL/R5XW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB54E21556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZL3r-0000Hp-PW
	for qemu-devel@archiver.kernel.org; Sun, 01 Nov 2020 16:38:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kZL39-00086W-4T
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 16:38:07 -0500
Received: from mail-eopbgr750099.outbound.protection.outlook.com
 ([40.107.75.99]:53191 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kZL35-0001OC-5F
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 16:38:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aM/hYhUZUZlPxyQ0Jf4QCeQdkZ3jLHwsYAt0gVHDpamAZbw3h/4pbiVZ0CRZPy/GFpoLjAprBifDKsgzBOPKNP4O3o4D0/HXbVdMKg+avIbmGDnXOVL8yXBzYeZEGUJQaEUcIQe7Mnqj0UxUq2ii7rAwvIUdkhJ16Zj+y9PZhRzzRet8Jxf3vsSPEGiRxR3Ld3n6KWL/Qg8qinV8SBWPgCUAfkpR4P01FP5U37A1NZAO3oJCYbeqzSef14JCWZ1/VXB9eLZVfl9GvQuM7bylAmOpDT+fSKQaNPzcZPjVMOYY0IXtV2koZqh7STiPo2aYGuf+Fc4wdEn0BDMQvHl+WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MND5N+OIEphsm8jONd0Jy07kWzva0C9I99vt2c67DM=;
 b=KLzDJJh+CYGh6+fkMEUx4sgnuZzeB+3G870/+xS6ZfqJkNeoVdF6NGPII9VfatWIfVuBfwHPY8cJA+EYV2Cb2lQGzqjEfCC3mBDCh7wguL+pDiG1wKvWT7xvHRa+woA7AR0cHpBLbPKatPPRpuFXJevNolwnOWGwiab2DrX9lMwXk5kSpZp7ueeleqjo+x61bBn32W7rPSRAHWOkpFKex0o0HMogTlznfQguhjg2+WqUN+ikqQIWm8EEwaf5ecfubIUgLT732sCLqQqc98Ui3sY23pqCI3aGu4l18QgObyfqSXCrDf15z2gQeX6byWlpHM/NdVerwT91ZDyatuezaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MND5N+OIEphsm8jONd0Jy07kWzva0C9I99vt2c67DM=;
 b=SDL/R5XWQedkMiKMBk3AOOFOT66UJYL6X6DTOarPopVZMigqzktjiL4enP3gkdM+Qp6yyTn12buCFSA53PIDmnxkuFAgdKH5uNyRvjNpxiycPXRGFCkfSXkID6xe7SJaaCctwoXpKGvWi6S9tk5cuYmuO/IOuOtbJivPTr82PTY=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3934.namprd03.prod.outlook.com (2603:10b6:805:70::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Sun, 1 Nov
 2020 21:22:58 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3499.029; Sun, 1 Nov 2020
 21:22:57 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2] scripts/oss-fuzz: rename bin/qemu-fuzz-i386
Date: Sun,  1 Nov 2020 16:22:45 -0500
Message-Id: <20201101212245.185819-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [72.93.72.163]
X-ClientProxiedBy: BL1PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:208:256::28) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 BL1PR13CA0023.namprd13.prod.outlook.com (2603:10b6:208:256::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.10 via Frontend
 Transport; Sun, 1 Nov 2020 21:22:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9dccde64-67f6-4c9a-42ec-08d87eac4daa
X-MS-TrafficTypeDiagnostic: SN6PR03MB3934:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB39340837B728142D73ECC3D2BA130@SN6PR03MB3934.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 05CwxW8hMLPdrvFeIRNmZ/pvVUxrA/vRIiE2CMZOgNU/FOOcbKlVJ91/BcfXfthJZ/IjwBvQwLq4DitFk0PU9v5xh+rHbKvgZe6O0GWFCGWeeciHL6r5YauOqF+lq1DsQmVPXXRcZd6JSwg/lzXeYDxi4VfpLohGv4UkaXSV+8q9p6C6ctI+aN8EepvIKV1lNNpUsYKqXRwagfpbo0JVXLeoOWuhfdNK5qba5jye3gEFi2XTT9PfaTeKz9+GheogUGjdPyAzhaLIJbxEDxulTJPjxgGOYip5pqdcg726FzYb/w7vguDIZgCSqjB/08c69qMDNw8WQO6P5G2JiV6JQE1fd3O5SVdZKmx9MLG58oHBxPb4vp9tzg4qZ6uKvXc8mwKYP5B12oW4N4YLanuuXM4NZonfjRysnCQxR8azpxV+IL8IcbUUiU5vXQt8GJMB2zIsl+r/28y2fZjI5qryjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(786003)(66946007)(66476007)(66556008)(6486002)(316002)(8676002)(6666004)(4326008)(6512007)(5660300002)(2906002)(8936002)(6916009)(83380400001)(966005)(16526019)(186003)(956004)(2616005)(1076003)(86362001)(26005)(52116002)(36756003)(478600001)(6506007)(75432002)(460985005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: kHdvzdzJJgk1+DJg7yXWLeZXHqK4eh3IZZ1Sdau/Q3HLRPbenI0hvprxQUAkx+iphdSvG4NtACz7CuLmi1KFO/hkhAy6gE/QDQ3K7HPdtex9Pl5/piPU4T4SxoKCNGujw1xoftX6X0LeaQhV5F5tK9N7Op1gg26QR6SyZ1xLAXwW/t3GUKYovKU+g8WweusJj+6VSs+666nRPnqWuGkQeYP2W7ikphcOq8OhpYJlySER28R0WH7i8kyTV608itcdbDmbblWmVw5GSSYBTak05+Tyie0ER3lcLGWda7IO3oiL2WOjh7RiunsO4SZ1A/DPTaJyC9ZLKPLOP2YD2wi4JR1bcGdM0xoP2BhfHG49gJ0p9t7WlY5iPjoVpodR0A10eWknLeKYeRw15cQ85FgX4y0JYOGvPHkj5oJ2d5r1kohGdXDghtqVPzZi8eiiGmQW2NOexVfA+5L0/9AY8y/MxwxnzrSOqFy7sAZFUm0PVSzsHwn6bZlBGuLPXnqaB1kGeRQoNroruLzoEI2vc17IYuvxeuJJ0ABR/w76gPMMbComEWjB+ACsyv5oga9UJW4dGEVDlsR9gHLMlapZx+/lFyQKspdYDX1Yu7Ucq3D3NZjQPcL7ZyXawPt9HxiF059SEhkaAqlbB1XJ6UJt4ud1HQ==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dccde64-67f6-4c9a-42ec-08d87eac4daa
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2020 21:22:57.7622 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Cz48QG1WlAsfWX25FsuS28UbykCBtjHA4ti+HpwGMZPTdQrpXT+kC12lpqQHNKe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3934
Received-SPF: pass client-ip=40.107.75.99; envelope-from=alxndr@bu.edu;
 helo=NAM02-BL2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/01 16:38:01
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.375,
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
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

OSS-Fuzz changed the way it scans for fuzzers in $DEST_DIR. The new code
also scans subdirectories for fuzzers. This means that OSS-Fuzz is
considering bin/qemu-fuzz-i386 as an independent fuzzer (it is not - it
requires a --fuzz-target argument). This has led to coverage-build
failures and false crash reports. To work around this, we take advantage
of OSS-Fuzz' filename extension check - OSS-Fuzz will not run anything
that has an extension that is not ".exe":
https://github.com/google/oss-fuzz/blob/master/infra/utils.py#L115

Reported-by: OSS-Fuzz (Issue 26725)
Reported-by: OSS-Fuzz (Issue 26679)
Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---

Also, for context:
https://github.com/google/oss-fuzz/issues/4575

 scripts/oss-fuzz/build.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/oss-fuzz/build.sh b/scripts/oss-fuzz/build.sh
index fcae4a0c26..3b1c82b63d 100755
--- a/scripts/oss-fuzz/build.sh
+++ b/scripts/oss-fuzz/build.sh
@@ -91,7 +91,7 @@ make "-j$(nproc)" qemu-fuzz-i386 V=1
 # Copy over the datadir
 cp  -r ../pc-bios/ "$DEST_DIR/pc-bios"
 
-cp "./qemu-fuzz-i386" "$DEST_DIR/bin/"
+cp "./qemu-fuzz-i386" "$DEST_DIR/bin/qemu-fuzz-i386.base"
 
 # Run the fuzzer with no arguments, to print the help-string and get the list
 # of available fuzz-targets. Copy over the qemu-fuzz-i386, naming it according
@@ -104,7 +104,7 @@ do
     # that are thin wrappers around this target that set the required
     # environment variables according to predefined configs.
     if [ "$target" != "generic-fuzz" ]; then
-        ln  "$DEST_DIR/bin/qemu-fuzz-i386" \
+        ln  "$DEST_DIR/bin/qemu-fuzz-i386.base" \
             "$DEST_DIR/qemu-fuzz-i386-target-$target"
     fi
 done
-- 
2.28.0


