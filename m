Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7013C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:16:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25504208B6
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="5ICYjjYa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25504208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVynY-0005nO-4F
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 11:16:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVyg9-00043M-Qu
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:08:31 -0400
Received: from mail-bn7nam10on2131.outbound.protection.outlook.com
 ([40.107.92.131]:42497 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVyg7-0007Ao-IU
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:08:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZ/1m7MWnLKHq3A7WhDCMCtsEl/B+OMB6D87D/TaLeeDmt4OGC+va6/crNcZ+NNrxvjDyH25DlDOSprd6I9/fT1WqFFH2kdeU3QseTg0QptK91rmoJYMsM7wzngvuzTBDRE3Ms4jwS3Qn/RMx8aPyqDHgIgIP41moUf2xeYLK0S/ZS/06zIHgHKFwv+GOwjKctIF+X133HT5jOjv0qeXES/ynZizPXXqM7k8twlke1N4lX2z2ZnrKnG6lk+v0QD1om5vac5HmCAWDQQQQzxStu2x8i8Qm9vQJxmIrVE1kgX8CzDBS8qkq003GG3Vu9fEBPQADmeS8/yVWDr+sPYvcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqH9vnWqMAR2Mfmm/R7rEWV0ea8cuyiyLEoww1AqzTI=;
 b=KD/YxOzK+obl1nr8QMdBzB/2tIjwFoOpMAb7/TvOtpYZ6WPM5I+Fvby+gJvVdXvrZoeAUDrKnZpTJat2KoolBNp60LgJHwDW0otBSSUkNipAfy/wi+N3EmNj91c3s7AjlDBeY6MhnWmGChuKSqryAyl8rR4d1AtGP9vQW3s9gQrQzsj8R1N9juja5wZOcBVnw4k5jhzxeLmbNfJydEiZ5dyDAteYea8OIk4bdeT5Sys4/4cXWbdruci/B4dTD5sEAK5t0LLQuufBv1lyx+m9xS1vc7BYQHbonFSoxFo+tkC5gO4iL+D9OjQARkAFhuSlzVDK83BhNu37FDU2nQq9hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqH9vnWqMAR2Mfmm/R7rEWV0ea8cuyiyLEoww1AqzTI=;
 b=5ICYjjYavd6r62txFWFCpGNKK/7/VHnIIE/I8dK08/8mG/1pjgZhGjrAWtTByiqMI9KxkF96tyJFmYvmQ91AccqiUep4Obnslm+SJCU9xLEB3/lujSTg4uKiwSBcxpEMGJosI/9EYBon4Cs0/Q3VAVO6hi8gDymXDCxWT3U/5YU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SA0PR03MB5516.namprd03.prod.outlook.com (2603:10b6:806:bf::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Fri, 23 Oct
 2020 15:08:19 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3477.028; Fri, 23 Oct 2020
 15:08:19 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 17/17] scripts/oss-fuzz: ignore the generic-fuzz target
Date: Fri, 23 Oct 2020 11:07:46 -0400
Message-Id: <20201023150746.107063-18-alxndr@bu.edu>
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
 15.20.3499.18 via Frontend Transport; Fri, 23 Oct 2020 15:08:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1f8863b-7ca8-4e02-3494-08d877657a07
X-MS-TrafficTypeDiagnostic: SA0PR03MB5516:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR03MB55164DB667D004A02CD483B5BA1A0@SA0PR03MB5516.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BdC9CrylQOpoYnQqTXJ6Y1FinrO+sY18BOm01MG00tyV82CHyv8PHzwiE9CI3lLNN2yGqNHPDsY2NlHAGBXUSE5R282aummFAoy0DKtnulK0Y3027G5Xo2YkIA7WzmezBRWKX0AdcktWLV2byBWfA8J+k+MKKiOnpUzvN0wLlK0XJUunCvvZEQkbt9tn5QJVI40pCnvvS0h+xDdMWKfC9W7rGN8myJueHs0UzUtvPoZMSJP2hLQaP4i3NZtdhBYQIoiCd8j0+ld11/cLiXZ3KzMLCyi+A6hqX0rRqklwAHCsAjAJchjzWhgXk1AaM4wWAelb1W5yz74T3qr4JNNnVvjNY2/Q8HgnFGX+lqfd9m8fPJ1+18juM0eNzhIJMF2a
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(2616005)(4326008)(1076003)(6512007)(478600001)(5660300002)(83380400001)(8936002)(8676002)(86362001)(2906002)(956004)(36756003)(6506007)(66476007)(6916009)(786003)(66556008)(75432002)(66946007)(52116002)(6666004)(186003)(26005)(6486002)(316002)(16526019)(41533002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 5PE9Xl7cCx7AROr9W7bL5oelJa31T4QrTYsKFHLb8Qi5yAiKoCfjzrPOr3j8EKaYCyZJadWkr7JAcH3h7iafFy7cYgmROUaI+uqQPYSJeCUat2fBMbMzFTsO8rJreL1Odo2Qjme6rPMm7083jFuwWDkjCbj8551kZ3ZLllcDB1XFCU4y/8uGUROPHzPqLAr8q8F+SIQmYOdPKWBjNP+w8EUKIEWe9St7T5M5S61pfbmZVFb1ZjvkN11WND/sT3F+A5yMBhXI+nawL1+ZpMLUYfFyzEtajyQ6pxoxL4HpbqdJyLZKJj+j9jvpStFnsJlnD/ja4cdOD1+i40AV0T+HzzWnt8anQ5resq/NqLQMptYxsW7W2SCLndK8Nj0YlZo1fZZ9li3IV4wXnMnNP/llNisJfLvFfbfXbq8eOimhR4VXHjPtu0NFLi3UZCxJm0Xa/tQn0QbJ3OWM9WcPl5Dj3g2SCO6M8+gnvNu27Rvxc/2e0U2CQPFFp9Y6Wu5DX19Dtne/0Hzx1El3IdjdQ3LOlC+uIkwB/UzPeDfkHcBN6ojfMSoOhlStD/fP/ccDNCv+OOpdYk2agPgHE9OucviG6Jolea9XjCioG3utQtjGLR0EA+DUD9lZLfJ4Lfi5lVRfWVZgapVb31mUBhDpEO5aJQ==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f8863b-7ca8-4e02-3494-08d877657a07
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 15:08:19.6819 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5WJrsOkx4fZaYMjQ1YzI9xN/QiVYdtpMonaiJ0oworOCtfEHNtcCYLiSqkQvFuCa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5516
Received-SPF: pass client-ip=40.107.92.131; envelope-from=alxndr@bu.edu;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 11:08:19
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

generic-fuzz is not a standalone fuzzer - it requires some env variables
to be set. On oss-fuzz, we set these with some predefined
generic-fuzz-{...} targets, that are thin wrappers around generic-fuzz.
Do not make a link for the generic-fuzz from the oss-fuzz build, so
oss-fuzz does not treat it as a standalone fuzzer.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 scripts/oss-fuzz/build.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/scripts/oss-fuzz/build.sh b/scripts/oss-fuzz/build.sh
index 0ce2867732..40e15985cf 100755
--- a/scripts/oss-fuzz/build.sh
+++ b/scripts/oss-fuzz/build.sh
@@ -99,8 +99,14 @@ cp "./qemu-fuzz-i386" "$DEST_DIR/bin/"
 # executable name)
 for target in $(./qemu-fuzz-i386 | awk '$1 ~ /\*/  {print $2}');
 do
-    ln  "$DEST_DIR/bin/qemu-fuzz-i386" \
-        "$DEST_DIR/qemu-fuzz-i386-target-$target"
+    # Ignore the generic-fuzz target, as it requires some environment variables to
+    # be configured. We have some generic-fuzz-{pc-q35, floppy, ...} targets that
+    # are thin wrappers around this target that set the required environment
+    # variables according to predefined configs.
+    if [ "$target" != "generic-fuzz" ]; then
+        ln  "$DEST_DIR/bin/qemu-fuzz-i386" \
+            "$DEST_DIR/qemu-fuzz-i386-target-$target"
+    fi
 done
 
 echo "Done. The fuzzers are located in $DEST_DIR"
-- 
2.28.0


