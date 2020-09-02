Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94C6C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 14:29:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9390520773
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 14:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="liQuzdFF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9390520773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDTky-00030u-NV
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 10:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kDTjx-0001AH-4P
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 10:27:57 -0400
Received: from mail-bn7nam10on2113.outbound.protection.outlook.com
 ([40.107.92.113]:63200 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kDTjt-0001XA-QG
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 10:27:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYmv+twJPFEay0Swk9IO10zfPb+5KTIlduUp6lAlEailIicsc2JjVYm+5lXU6veXU67JoyQlr6QTPLlwzmEweK2Ca3iMLgMy36R2FZoCnTRQALTLJumVVeQtmbQoX06ZdcthEcRGgjAtwgDYadCbIoVo9usWbcv/s4C68AwvdEXUfLRwPz/HjE2uf7AU0V+TLlPJh/mpXOsnza5sjllqV2GZF6c/9kmi4/Y3nJoW0dxWtFH3+89Ke8Y4wAtiMO+K+orJP+azIHtibF0UGu4D/OYUwM4fqbm7mnEHD7nPHRqfJrdKNhPLZrbD3mxSvcAO/hwmKZK8uJ80V77W5liEBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiV8fB+najyYA1wTgi2rqdLncmQNWPzZ8YcT+GqYsXs=;
 b=AQCyiimMgLZmypOHhiv7BYot1jI9jVwtjdRxSqlQufA3tMVDr7CuDXl8qTyhNejIyOPZNFQr929GoY0WO1T/JbvMcUU+ryYFav7j/M8X3oUoEQxBAFMJmPGEq5U8aug6DUVdtNt1vRI5EIOdWDFhVLgkM9VZ7JisT5i56u/pAelHKKBeg1+xeMlFjkDuDGpITetFDkwtvPXTB7c3DwUp971t8pDtspySRHcmDfmEoCpN5xOAJU0ganl2sjgIwNTEMq88pW/Nn0N6sqjEgEWOW264oan84wH4JfEXxkuql6bICudmALhxDKVQFCdedBLChuejKUlgWtqHp+bVtmknpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiV8fB+najyYA1wTgi2rqdLncmQNWPzZ8YcT+GqYsXs=;
 b=liQuzdFFcL/mU7ynBltH6UkkpIddir6ZTg5mMu03AZRsk+DiqRGeK5QJSlVOYd8lRD6bpJy/cJWeGBFjkVpS9CV2EWyUbt/4t7S4Zs12p94fCdGsWA4zNJ/Tmb/I/BbqyBQjWzoD4wnuO8cfJk53P0Sag3rkZcO6cMa1bInNPOA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SA0PR03MB5465.namprd03.prod.outlook.com (2603:10b6:806:b5::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 2 Sep
 2020 14:27:19 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 14:27:19 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] fuzz: Add support for custom fuzzing library
Date: Wed,  2 Sep 2020 10:26:56 -0400
Message-Id: <20200902142657.112879-2-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902142657.112879-1-alxndr@bu.edu>
References: <20200902142657.112879-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0029.namprd20.prod.outlook.com
 (2603:10b6:208:e8::42) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 MN2PR20CA0029.namprd20.prod.outlook.com (2603:10b6:208:e8::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15 via Frontend Transport; Wed, 2 Sep 2020 14:27:18 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [72.93.72.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1fb7432-76c5-4298-9238-08d84f4c4c66
X-MS-TrafficTypeDiagnostic: SA0PR03MB5465:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR03MB54650355996C631618C7F75CBA2F0@SA0PR03MB5465.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i0N+zsBn7HwkW7JMhCh95qm2sKumdUq1OmHK/kHmbhxai+HGWPBcTn9/ITrIj20jBcLZBTSaETkk8Px6orH33BAsCba5PhGwKYzPVTFPvVT74uOgjXkOFb8RiednBydIbafe8dEB9KVXTDck8O2oj7PSOohhdgvjtP2gs08pTClMGyLdwdjoXkROUhMVe0rlLycHictpJzhILq3p1OY+Ivfu+Y0VVn3yM0hEoLouw5KDfjFLpFZ2Xe6yfQc7PTx1knI56RPzfStAsM0EjpcgyBHdYA0ZRHOOoqn0gN0U+JNfO1vRvhMb3rl900/sfwSzFhb1q9mT5p0n1GifpiHdEmFmE4FX4CfkIpQgQSQs+MoR4Atg9F0RcqoUglOzB0BI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(1076003)(8676002)(66946007)(6916009)(66476007)(66556008)(54906003)(52116002)(6666004)(86362001)(4326008)(75432002)(5660300002)(6486002)(478600001)(83380400001)(8936002)(316002)(956004)(2616005)(786003)(36756003)(186003)(2906002)(16576012)(26005)(21314003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: CGrxOoge3PSSseM1OBHHX3bj6uLjzOUqaF/6d0QNHoY1rfurUoLQ1sARD/Csh0/ezQJERyrPKOxcNkml5aDgSLrjALumVVOWLEEYHAJqqIx/C7sLyEc1OKi0YUiflL1F8HO9JBlhczs/QZhre2zUF7jl6Nd6IxRi4dlLmQUAV4mFh1bBSOTcVd2Kn9IrKPkMh6k3oyWkdaXqYQZaFLO4MeZneBSkc+uNiDUbkzm197uXLklLNqvFrlav+TmHuO6Fm/va+w1TUQ6/5Zcx7S6eyuwsGiqC9HeG6esUgXuaspvU6mdiHMKLaZ6jK6fTAuZQQeIK4F99KD7X0XaRVFCnkictBK3Hly4NuOFncbr0qw2nQjsAuLqOUudoNLJkI8wFVyZMQDWveQJHANL2kljkTl0sfJz7gja03F0hQJC0jT3c2F82/o2erSqqw33LoBBUtLWuObhyQ6cWvGj7K5g7DMOvIoLjC70F5jkrcS8ALn3fBLo0YlmKESbSZitEo+xbHVw56VWdoO6NG3oCJDmIl6zVD8c66of4X0LJGK7vs/62DZXR6c0ehnZUPVOJl8KJqKni4md50gun8m9EcQeoWKFEN+vLPJbjzHFkwr4Jk107e1dujAWNNG/kzCnr9Uu2C9QLrwWfmatWqeyzYndA0w==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: d1fb7432-76c5-4298-9238-08d84f4c4c66
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 14:27:19.3932 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q4AXWg9X31NMHHAacCsLvj8Jcq2vDny9dD62DNPfqXQo5GdWOIiKqEzPN5fIaHWR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5465
Received-SPF: pass client-ip=40.107.92.113; envelope-from=alxndr@bu.edu;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 10:27:53
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
 Alexander Bulekov <alxndr@bu.edu>, bonzini@redhat.com, darren.kenny@oracle.com,
 bsd@redhat.com, stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
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
index 6ecaff429b..4182a88e75 100755
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
+    FUZZ_LINK_COMMAND="-fsanitize=fuzzer"
+  else
+    FUZZ_LINK_COMMAND="$LIB_FUZZING_ENGINE"
+  fi
 fi
 
 if test "$plugins" = "yes" ; then
@@ -7620,6 +7627,7 @@ fi
 if test "$fuzzing" != "no"; then
     echo "CONFIG_FUZZ=y" >> $config_host_mak
 fi
+echo "FUZZ_LINK_COMMAND=$FUZZ_LINK_COMMAND" >> $config_host_mak
 
 if test "$edk2_blobs" = "yes" ; then
   echo "DECOMPRESS_EDK2_BLOBS=y" >> $config_host_mak
diff --git a/tests/qtest/fuzz/meson.build b/tests/qtest/fuzz/meson.build
index 3432c3e7c3..59a630802a 100644
--- a/tests/qtest/fuzz/meson.build
+++ b/tests/qtest/fuzz/meson.build
@@ -9,8 +9,8 @@ specific_fuzz_ss.add(when: 'CONFIG_VIRTIO_SCSI', if_true: files('virtio_scsi_fuz
 # unfortunately declare_dependency does not support link_depends, so
 # this will be duplicated in meson.build
 fork_fuzz = declare_dependency(
-  link_args: ['-fsanitize=fuzzer',
-              '-Wl,-wrap,qtest_inb',
+  link_args: config_host['FUZZ_LINK_COMMAND'].split() +
+             ['-Wl,-wrap,qtest_inb',
               '-Wl,-wrap,qtest_inw',
               '-Wl,-wrap,qtest_inl',
               '-Wl,-wrap,qtest_outb',
-- 
2.28.0


