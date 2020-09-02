Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2F6C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:39:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A62FC207EA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="KtHlB0kB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A62FC207EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDWjU-0008AC-PH
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 13:39:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kDWhA-0005kA-C2
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:37:16 -0400
Received: from mail-mw2nam10on2114.outbound.protection.outlook.com
 ([40.107.94.114]:28257 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kDWh8-0004ye-Lh
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:37:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHBN5UU7XqMjsuO4unJYhHO3zhv1GhyG0tSjE0jkJd4aWPO366cAHQ69gg4G4uDhUfTNB0SChT+GRXkVXpFWGAMgkcxyU0gf5rXvPAmm+tr4BQ0JlOim+5GKTTBIHSYBBoLFuNEz1mbUyXvu2w38ULwLijIWWRNIiJIVctJGFmfet9NrOLeyiyejWVINPgwQwMQ/tX2GXp7j9uWH5vnztsGH8UJHL4zrefYnDYx2fsHor5loLeeCb5wyAT8HGxCAV+tpuCBmEyHcGGIYQkEUJw2FNeGXck6d01tLuYVh4T05ZhFXfpOMl1zpjhpv8p9P8noh9I0K0QlJhXuKoFQFKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLBtwK9WL4GX3FgpMjZU+7rJc0gMxZ5JMPQp6hfc6bo=;
 b=YodPu/AcVOUOux2dlhrW6Uv2+o0ezlOTz3LUnNsylF/3EE/CiNhFjBEzmA20rFTxmtsBrVVfUpdPbk6THZ12MIKiy7zxXfVWhNqQMTgwsWPS6zS7FzZesIK6vHKisasLsIj1e/lcj0L9H11uUWQJfUT1Sj2s/mLFbKEnoCDL9CEZl0p5R3z8n/ge9YqvZsn3AXu3jzUN7IicIbrvcqXckkNxm98zvsf6k8LoKn++u51OJAiKrtaPbqaMCtzR7FtinjzNDOUf7ae8rkErtR5hpZakyn459LyoVpRzB/gd43wxsYxRMrABprQ6S1l54SrVM0WWz+H3zIkfVvE20muZ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLBtwK9WL4GX3FgpMjZU+7rJc0gMxZ5JMPQp6hfc6bo=;
 b=KtHlB0kBq3vIB1WMA46sU0WiYpAyAuLiaon3wrqXhyQ0s+gniZ5ePTe4ORH4EsQPHgOD1agQS5SH2xtkjvij5vTQUqcrnVsrY/lUV7zddy1DxA2HbMvd3mFeDUjPQyaoKo+D5gI5ULXM52vJ9wCZD63D9AGV0SnjbLfSt5jj/oY=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.24; Wed, 2 Sep
 2020 17:37:08 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 17:37:08 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/3] fuzz: Add support for custom fuzzing library
Date: Wed,  2 Sep 2020 13:36:51 -0400
Message-Id: <20200902173652.307222-3-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902173652.307222-1-alxndr@bu.edu>
References: <20200902173652.307222-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0057.namprd05.prod.outlook.com
 (2603:10b6:208:236::26) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 MN2PR05CA0057.namprd05.prod.outlook.com (2603:10b6:208:236::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.7 via Frontend
 Transport; Wed, 2 Sep 2020 17:37:07 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [72.93.72.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a73989a-bc08-45ec-0c0e-08d84f66d100
X-MS-TrafficTypeDiagnostic: SN6PR03MB3871:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB3871783DEBEC3A8CE5117971BA2F0@SN6PR03MB3871.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WIvqcgKdi6tclU8pudKD5UDtXQN9RBlIHhrRglNVig1Uqu+ArYaCcX0DBRni6TFO5HdHQjKNNRSKcC2RTkd4IC9wIOt/aEwaupoGMGHVHP/7nXvkFYDJJ7prH84PA9S/hqepIqfHalANKCdZfqj3x3VGjQC8Vd4Pil9tbFmXImaXIAlAKKx5/knMlrXl43ouolYdr/NSkdqbY309StTZ8iDPPLxHqAu0hxM+vle3yjJBGjtw3sPEKLA3mzuQ+Fjh/12Vv03icerPlKEPplzvmmpFb93uLIqGbEEXOxb/pABm8LmDOZOBZzDrid1nhvx3c4XFAkfGxEMjccBYUMauSa0eyT6sWIFUHOKlLs/uZz+cyf03mU9hzPwl3pmZPJJ7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(6486002)(2616005)(1076003)(4326008)(86362001)(66946007)(956004)(36756003)(66476007)(5660300002)(16576012)(66556008)(83380400001)(316002)(8936002)(478600001)(54906003)(2906002)(52116002)(186003)(6666004)(8676002)(26005)(6916009)(75432002)(786003)(21314003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: b+fWf5MgavipYKTdvB2mmRtPfs3GswANVaNuuctYKOfitm7U1/5zkC0LxrAUEZrW2ORrzKGS3yUErqopIC8iDKg8yXk7k10+8cgcN+FkJyiE+xaSIYR/BHKS7p8TcITh3TJGs02+Y7Rs2U+g/Pa5NKbQtiGeB67JPoetg6On0ahg0+e3LMcTcFAbA/fnEP4AzHvOHG9liVbRHYYHTmwhKR1IYxRXr30hPyuG0YL2LC5gkHAgWufdgGFJvZQPdt1I5CwRHIJbE4T/FMXyk8AmwugWYF2z3XWR5m/Yk2wplSpvLhAFxzPTcbfmqajg5n1uNMAkxbL06FPc7wu3OlupUEQ6JsKMoz39F3B5bPNWBD+INrOp3UXRzIjwAi8oLMhid/Il0VTgHKBH/F/z4iwJwznNNWhOysXQ41bPT0OrmqzpSaTdz9d7jos9daKvp6OjKu5VQRKlrFZaE+RTS4YzBGWlxu4S7GZMp3X8wZfzNrDunKiaGA+8X7Zim4hKWjMFN9aMQo07C3hdekgK6zebbdzz2Ph6f7T9d/zb6Kz2YowB5oF7bgBoGoWM+DMk1LKrlVwF75+T9Iux+NWgRAG6k8xCsH1pqhbO83A14IE6a68dlPs1TnwHoIciAk+mfebcW5RxSsYX6NW2loF4AlEU/g==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a73989a-bc08-45ec-0c0e-08d84f66d100
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 17:37:08.6523 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HldGsBddSQrHrmiAyrk+LxdUIKWuUIFFgeCfCTLjd8mSZxzWxr4uJ185JWpsy6HF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3871
Received-SPF: pass client-ip=40.107.94.114; envelope-from=alxndr@bu.edu;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 13:37:08
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_ILLEGAL_IP=1.3, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On oss-fuzz, we must use the LIB_FUZZING_ENGINE and CFLAGS environment
variables, rather than -fsanitize=fuzzer. With this change, when
LIB_FUZZING_ENGINE is set, the --enable-fuzzing configure option will
use that environment variable during the linking stage, rather than
-fsanitize=fuzzer

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 configure                    | 12 ++++++++++--
 tests/qtest/fuzz/meson.build |  4 ++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/configure b/configure
index 6ecaff429b..15a283c64f 100755
--- a/configure
+++ b/configure
@@ -6165,7 +6165,7 @@ fi
 
 ##########################################
 # checks for fuzzer
-if test "$fuzzing" = "yes" ; then
+if test "$fuzzing" = "yes" && test -z "${LIB_FUZZING_ENGINE+xxx}"; then
   write_c_fuzzer_skeleton
   if compile_prog "$CPU_CFLAGS -Werror -fsanitize=fuzzer" ""; then
     have_fuzzer=yes
@@ -7505,7 +7505,14 @@ if test "$have_mlockall" = "yes" ; then
   echo "HAVE_MLOCKALL=y" >> $config_host_mak
 fi
 if test "$fuzzing" = "yes" ; then
-  QEMU_CFLAGS="$QEMU_CFLAGS -fsanitize=fuzzer-no-link"
+  # If LIB_FUZZING_ENGINE is set, assume we are running on OSS-Fuzz, and the
+  # needed CFLAGS have already been provided
+  if test -z "${LIB_FUZZING_ENGINE+xxx}" ; then
+    QEMU_CFLAGS="$QEMU_CFLAGS -fsanitize=fuzzer-no-link"
+    FUZZ_EXE_LDFLAGS="-fsanitize=fuzzer"
+  else
+    FUZZ_EXE_LDFLAGS="$LIB_FUZZING_ENGINE"
+  fi
 fi
 
 if test "$plugins" = "yes" ; then
@@ -7620,6 +7627,7 @@ fi
 if test "$fuzzing" != "no"; then
     echo "CONFIG_FUZZ=y" >> $config_host_mak
 fi
+echo "FUZZ_EXE_LDFLAGS=$FUZZ_EXE_LDFLAGS" >> $config_host_mak
 
 if test "$edk2_blobs" = "yes" ; then
   echo "DECOMPRESS_EDK2_BLOBS=y" >> $config_host_mak
diff --git a/tests/qtest/fuzz/meson.build b/tests/qtest/fuzz/meson.build
index bcc393828e..b31ace7d5a 100644
--- a/tests/qtest/fuzz/meson.build
+++ b/tests/qtest/fuzz/meson.build
@@ -7,8 +7,8 @@ specific_fuzz_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('virtio_net_fuzz.
 specific_fuzz_ss.add(when: 'CONFIG_VIRTIO_SCSI', if_true: files('virtio_scsi_fuzz.c'))
 
 fork_fuzz = declare_dependency(
-  link_args: ['-fsanitize=fuzzer',
-              '-Wl,-wrap,qtest_inb',
+  link_args: config_host['FUZZ_EXE_LDFLAGS'].split() +
+             ['-Wl,-wrap,qtest_inb',
               '-Wl,-wrap,qtest_inw',
               '-Wl,-wrap,qtest_inl',
               '-Wl,-wrap,qtest_outb',
-- 
2.28.0


