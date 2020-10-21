Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB7DC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:44:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1051223C7
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="RXj+JM+/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1051223C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVLuC-0003ZX-Jk
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 17:44:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVLN7-00044D-R9
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 17:10:13 -0400
Received: from mail-eopbgr690121.outbound.protection.outlook.com
 ([40.107.69.121]:59894 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kVLN6-000854-8u
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 17:10:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMRhOEhUrEuPd3tcQirpDCX/hWbqbhrrYx3ZXop6Hi1eXuUzTYy4MmfXHpVOZyfBwYO/g8T/fRw4NmIvtPb5gcRqEURbrLQgvRXb6CQOKQKG9JdsP7Z4LCEkHazLFKdaA7HF846OnER/nmCqx5N0IeIa9E/IPDsLNjTOz/82ADfd1rQdFpANp65GbBlXByj35puMve8THlKYdaZMqYyMROoLkw3a2do4Cn6WpeQtXOiuLvspO3Ds6ASoEjCaAlWnUQoTTyW4DXaMdpIKpgIdrao5MRuCMGxAvZL67J4bAyb1Adb3oIFTfHR1gUx0Ygmtq3oE+9jYXEw5Lf78y2RHGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxtNA+rxOzB5Fcmwil+SAPPdrZJWlTXOFS/n4CRIGV0=;
 b=ZBqaRSBLAVDgkKJS2MDiSuCzsoHc31JcYlKNEyHB5YKmIvJZJ0oYjkq90jRlXoR89vqq1F5BxxMsNWC7k1HjpEnsMyVDBpOR2eLKf9p6zC6f5N+U1r8gY2Zp/l9LNnskVgXALHzy+28gI97EhFoEBNAE274jxMu3r3IGYro5Vb4Vh+a4U837Sewn41jgMdpb1o5Kohr2dC1LSaz50iYTqNAZqK1H3Wma4QP8kS/X+GuyNukBdkoxIMJrbZswdPeKuWuJdy6VKi5rJglmjwaCBB1wsRAYvySFXDJz68XHgIGaKb0t8rLooAEo4P8w8Cygr8PQ7pcAG7olLPXyNXkmfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxtNA+rxOzB5Fcmwil+SAPPdrZJWlTXOFS/n4CRIGV0=;
 b=RXj+JM+/oKZ4LgYzTZFyu/U+D5v4EAe3cr8b6fNsqYawrZNvh2aLt3Kzo7AyeMk5q47tUzOPthti9mfBNz27G2H5VvhLELBGbvO9MpRBomzDImsA3OTFa9Yj1awpjzijYfe+jpXu8XeKKKn6cBOw39VdPSW1y06ifYCJf3Uc/nY=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB4045.namprd03.prod.outlook.com (2603:10b6:805:b8::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Wed, 21 Oct
 2020 21:09:59 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 21:09:59 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 16/16] scripts/oss-fuzz: remove the generic-fuzz target
Date: Wed, 21 Oct 2020 17:09:22 -0400
Message-Id: <20201021210922.572955-17-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021210922.572955-1-alxndr@bu.edu>
References: <20201021210922.572955-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [72.93.72.163]
X-ClientProxiedBy: BL0PR0102CA0064.prod.exchangelabs.com
 (2603:10b6:208:25::41) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 BL0PR0102CA0064.prod.exchangelabs.com (2603:10b6:208:25::41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 21:09:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d923693-22ff-47c7-fbb2-08d87605ab26
X-MS-TrafficTypeDiagnostic: SN6PR03MB4045:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB4045CFEE13C377EDCD25B302BA1C0@SN6PR03MB4045.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OaBN8lY9n5jlppDxZjNCq7EGe8M87VtS7V+rcgHT6fjmUAMygRrssFXLdivb0GmzN2luKyiEsErK1oIO9Iw1vkkEE+lBjn266D9d9zJEmq9bc3GgQ8wVFoz9Vqhnq6rbXKRe7CQXhS14RX4jctYTeC1pj5iygQ5/ph1PwfHaXYIr7Lo5mss8NfgSV9jd8LP/Y2/6l4XHctMMpFEg/49pTjiD6TAIAhVry6tfDUJb3H1YAePnlFrwZ30b3VFrLOe0AtsZexn3+SdNZSw1YR7Kc7m/Yk/plore4C7hIZXLZp17lX2POg4rgk7oOrdGNxTSeBBEhaL2EvWgFaXuIpWwJOMXuSvdHzZYkQ0IuFqxxxQxEtFKwpCCZW0g8Z5hAMhe
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(86362001)(6506007)(956004)(6666004)(2616005)(52116002)(5660300002)(316002)(75432002)(54906003)(786003)(8936002)(6916009)(6512007)(16526019)(36756003)(26005)(186003)(478600001)(66946007)(6486002)(2906002)(4326008)(66476007)(1076003)(8676002)(66556008)(41533002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: hrgciy6vS0WAp0qyqmqW0DQo1vtElHZdqBJKRdUwu8Gf90wyPCNaq/Wa5fyP7cschVKfczE/MbnN/cBTibW9EkHlY6F/uBUptdJFuT4ECYQCKvF0a80pXDD3xjc4ppM88P2x60o6+kUB3hLB/8ij2wyJgyi2Jco9n1inGlevvg+dJXrjHeNMbwbLCuLSyxuw2iNFkBAp+JOCvPqoKjxBA7eqd3cTbOErEa8+rA7cmUmYej4cvMlWkTL6hqyGAnqYm31WVKTr/bhUqF4KConOehJLd+sSI15dgYn13pVPcXn+CNyJxh3GJZbb3d7uyI6+/oUHXkatSSU2NKJRwCFicPwRZCl5IydM5yU+ZdCA6rSdOtZUIErkMkULMkfFtAjnEZWCh1fvM+n6Q4SF+qrIJjO+ShuJvNxgHVKqsD0qpPggtllNPj+6xLSg8ob1GxGAjNuUEeD3HnwQ0MssjfX8Xbmou5SJTjxVPQhQw92U/x6thYmaPK7Q/x2B6xUYXuq6WkBHf9OUAXSVoGb5aGzo8pnkTAoRBkjk0YGywi5coZdbEMRvymlMBFckQRM9cAmRHqHc5SuW0AdNq/RFiqqY0HHY3uFHm9LIctymvf9MTpVppwiSoujh8neLyDWARBYYQe2vTx++MXlu/HExVFBzYQ==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d923693-22ff-47c7-fbb2-08d87605ab26
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 21:09:59.5795 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FICF+7mZk4Hf+M9yvyFG/NfE8ZCUCmWD8POpo2wGV1Son5HYregqSygcvw6UZ25b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4045
Received-SPF: pass client-ip=40.107.69.121; envelope-from=alxndr@bu.edu;
 helo=NAM04-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 17:09:54
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.454,
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
Cc: Thomas Huth <thuth@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 f4bug@amsat.org, darren.kenny@oracle.com, bsd@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, dimastep@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

generic-fuzz is not a standalone fuzzer - it requires some env variables
to be set. On oss-fuzz, we set these with some predefined
generic-fuzz-{...} targets, that are thin wrappers around generic-fuzz.
Remove generic-fuzz from the oss-fuzz build, so oss-fuzz does not treat
it as a standalone fuzzer.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 scripts/oss-fuzz/build.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/oss-fuzz/build.sh b/scripts/oss-fuzz/build.sh
index 0c3ca9e06f..37cd7f9e25 100755
--- a/scripts/oss-fuzz/build.sh
+++ b/scripts/oss-fuzz/build.sh
@@ -97,5 +97,11 @@ do
     cp qemu-fuzz-i386 "$DEST_DIR/qemu-fuzz-i386-target-$target"
 done
 
+# Remove the generic-fuzz target, as it requires some environment variables to
+# be configured. We have some generic-fuzz-{pc-q35, floppy, ...} targets that
+# are thin wrappers around this target that set the required environment
+# variables according to predefined configs.
+rm "$DEST_DIR/qemu-fuzz-i386-target-generic-fuzz"
+
 echo "Done. The fuzzers are located in $DEST_DIR"
 exit 0
-- 
2.28.0


