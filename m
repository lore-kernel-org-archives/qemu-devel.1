Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F804C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 18:34:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1BA72078B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 18:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="Gur/KMph"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1BA72078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDB6r-0000yZ-6T
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 14:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kDB5x-0000WB-Sy
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 14:33:26 -0400
Received: from mail-mw2nam10on2126.outbound.protection.outlook.com
 ([40.107.94.126]:46072 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kDB5v-0007zX-TN
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 14:33:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYiyYo5MWy096PXGratcxe0Pu+fecLQ8U60wP9Iz26W9Z33DOyVz2ExB+bm/dIOMmH+mvF6JZ5lnsitIkgaZDFeA6ldiKu2tNTCXAUAlHCpLBmixMko3w32wMBqA7EjlUOUmIhwUOAoQU0DctggGp8xrhu/mZaz5BPMPcEgI1mNVdZvRBkg18kSr2agApv0SlTcxUMFDb1KtarVTsMw/zqs8g7klWHAufRlKjB+gKbAmz79QUP9pxArsIox4HL/3zoi9g86IylKT4LiXMtT99dn4NtfUCa1bthKFp+g/YlWiCJWRhuy2oZwOI4lhd3WZQA6BfxNIOuoceBWFlKc3Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKYCJPDuuNmjcoHzOd9k1+4sks/ENLm2Q7530ECIkEQ=;
 b=Lky9NTpS+0l7phBV+uR1w0HL8VFM5nbBshB9NPksdNlmzVhKqxeJ/RTHe9xReGYNDvce3kExZp5kYO4aE3k4vVxsQnlTYn2AZXSGAlmYakT9in9xXWfaz+B8K0WFhaWXBPkkvTJnFqsGW75n0I9Fm6Qh2tyhIZtB2hksChhaHFhZzGS2Fjg1OX5btRlkavnIwfw1HgpwvMsEphp7wYOMuSD6ZbDo5pI70rsG+n0qHbH3h6bIwQkghWzYACuTOr+F5ZVNJYoWedFW5yz9tiTogi+KBKaSbBMKoesFRIZ9NVQyBA9tOVt8wgTmeTXO+WUdmCyvK4uSVpJ6stuAhkstrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKYCJPDuuNmjcoHzOd9k1+4sks/ENLm2Q7530ECIkEQ=;
 b=Gur/KMphJzm2mA9ESkwFPe/TqkWU26Iw/EgbkMTfWzi81KB4d/gNL0SmEZiTYp9tjN/8dlEp9KeXtqFqBTP67nkgauZyTLHLJlAiPK1TStJUOImGbyGIijCMvtsZ+hopTggYweCNo6IZUqia1Juqaw8azayvwmbS+Okr3VEKSRw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3983.namprd03.prod.outlook.com (2603:10b6:805:6a::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Tue, 1 Sep
 2020 18:18:17 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 18:18:17 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH] fuzz: Add support for custom fuzzing library
Date: Tue,  1 Sep 2020 14:18:00 -0400
Message-Id: <20200901181800.326382-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <9dfe703d-5c78-36d0-bc15-17ff6f9179d7@redhat.com>
References: <9dfe703d-5c78-36d0-bc15-17ff6f9179d7@redhat.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR10CA0016.namprd10.prod.outlook.com
 (2603:10b6:208:120::29) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 MN2PR10CA0016.namprd10.prod.outlook.com (2603:10b6:208:120::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Tue, 1 Sep 2020 18:18:16 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [72.93.72.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f46034aa-2779-4d9a-0922-08d84ea365e9
X-MS-TrafficTypeDiagnostic: SN6PR03MB3983:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB3983AF254A75166997ADAF26BA2E0@SN6PR03MB3983.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fJ+/v6PAjEP5vUfYQZNezmelSiHIU68pvMZRTqFSSmBrRjfpSizVDimavTyBthz8K7ehNOSEovMv0EEIjFEcOUmFJYKP4t0DsYdi7JzKIWvyMWsC9LXlA0QRmNspUiySm/unAJKq5psYNIaiyh9mgofILy2yxkF2rQC/2o8JJdd+fAvYAlOKwShUZKmE8yzhJ+PNsZV4/yWV3mMcX0yzzYsVe3HPiS6bVZSiTUH9i7zqNuOD9KY0zOcJ5wjV8waX0goPRP2NGR/GpEmIrBAmhMtYwVYg4XFKZaELNp/wl/ASGHfxacfelZG64xtTlxf72D0V9RMCkRF/F3bEmXiZvbBb4jDSHaeC8kdv2ZcJZeCkhBFxH++l8m2aLfGC+04O
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(316002)(6916009)(16576012)(36756003)(1076003)(8936002)(478600001)(75432002)(8676002)(54906003)(5660300002)(83380400001)(86362001)(26005)(66476007)(66556008)(786003)(66946007)(6486002)(956004)(2616005)(6666004)(4326008)(52116002)(186003)(2906002)(21314003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: tX1DwKkLc/bgd8lEgoTCUCAT1Tz8n/c8I26NbVFujW6ZvPai+bKwbW1LAvp+Ij4DWNNMLggfv0TwvQi/R9Z9GkE1KL+AUQP5tjEVnJ/GMcAoKEMPpZGHVaeUp9zuAs4ywMUtFdw/vvsoWsKrYsRfFKHhJqIB2+i3IHx1rAyZT0MHlD2SW2TE0BUBNTudKsirW2HDOjal2U8XDuwXWt7hJLLiw/+woetwPCpbHrb7aXqtU7sKucpISWotm+UQN3MNmVq35Ix/K1Q7PkwK4HvKgFOl77fchmb27+ih0r/axNrja6MVEWAVMxka8kswxMDCJmKR4drBAtC+s5NEjoLAKyp3iu7VAcK5V6ZpsulZzC50V0U5JjueDsa9pIRK7KbSSfHJQURV+AVBM7nIl+1+2zXWGcJmrz/PrNYcsXPMqIIH9Q9kVrrNwp1cLJVyxWu+WCdNROiG+l+T7pahFAk7QBMrfu5UKQdPgmKiaexiwdoVLWcxtN6ktK4AqEhSM2qThH1RIv675BUyUy262yCU/gmVQ3bZw8In8N/6iFaV6JgElFr9n+0CdC5sp3m0vcxXoZeaA+60vpaiYcnRgrdnG1agoJxnw0UG3v4Lvxb+ajmQLn1oVGf+OordhgHb1k1cdQf3tjYqMlJGAvEaUyNZ4A==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: f46034aa-2779-4d9a-0922-08d84ea365e9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2020 18:18:17.3839 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k+62OU5BK6T2SaMJuVa5bxsxFh14GXLqqki60mwHoBWgmo9EvWqBV8CdFMcKlWf/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3983
Received-SPF: pass client-ip=40.107.94.126; envelope-from=alxndr@bu.edu;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 14:33:21
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

---
 configure                    | 12 ++++++++++--
 meson.build                  |  6 +++++-
 tests/qtest/fuzz/meson.build |  5 ++---
 3 files changed, 17 insertions(+), 6 deletions(-)


Hi Paolo,
Here I'm trying to specify the linker-script with
add_project_link_arguments. How I'm testing this:

$ CC=clang-10 CXX=clang++-10 ../configure --enable-fuzzing
$ make V=1 "-j$(nproc)" qemu-fuzz-i386

clang++-10  -o qemu-fuzz-i386 qemu-fuzz-i386.p/tests_qtest_fuzz_qtest_wrappers.c.o \
... libblock.fa chardev/libchardev.fa \
-Wl,--start-group tests/qtest/libqos/libqos.a -Wl,--no-whole-archive \
-Wl,-T,/home/alxndr/Development/qemu/tests/qtest/fuzz/fork_fuzz.ld \
... \
-Wl,-rpath-link,/home/alxndr/Development/qemu/build/ -lstdc++ -Wl,--end-group

Maybe if I can get the oss-fuzz LIB_FUZZING_ENGINE
(/usr/lib/libFuzzingEngine.a) into the --start-group, that could also
solve the issue... I'll take another look at exactly what the oss-fuzz
build container does.

-Alex

diff --git a/configure b/configure
index 6ecaff429b..d31b91850c 100755
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
@@ -7619,6 +7626,7 @@ if test "$libudev" != "no"; then
 fi
 if test "$fuzzing" != "no"; then
     echo "CONFIG_FUZZ=y" >> $config_host_mak
+    echo "FUZZ_LINK_COMMAND=$FUZZ_LINK_COMMAND" >> $config_host_mak
 fi
 
 if test "$edk2_blobs" = "yes" ; then
diff --git a/meson.build b/meson.build
index 74f8ea0c2e..3a5205040f 100644
--- a/meson.build
+++ b/meson.build
@@ -35,11 +35,16 @@ add_project_arguments(config_host['QEMU_CFLAGS'].split(),
                       native: false, language: ['c', 'objc'])
 add_project_arguments(config_host['QEMU_CXXFLAGS'].split(),
                       native: false, language: 'cpp')
+if 'CONFIG_FUZZ' in config_host
+   add_project_link_arguments(['-Wl,-T,' + (meson.current_source_dir() / 'tests/qtest/fuzz/fork_fuzz.ld')],
+   native: false, language: ['c', 'cpp', 'objc'])
+endif
 add_project_link_arguments(config_host['QEMU_LDFLAGS'].split(),
                            native: false, language: ['c', 'cpp', 'objc'])
 add_project_arguments(config_host['QEMU_INCLUDES'].split(),
                       language: ['c', 'cpp', 'objc'])
 
+
 python = import('python').find_installation()
 
 link_language = meson.get_external_property('link_language', 'cpp')
@@ -1019,7 +1024,6 @@ foreach target : target_dirs
         'gui': false,
         'sources': specific_fuzz.sources(),
         'dependencies': specific_fuzz.dependencies(),
-        'link_depends': [files('tests/qtest/fuzz/fork_fuzz.ld')],
       }]
     endif
   else
diff --git a/tests/qtest/fuzz/meson.build b/tests/qtest/fuzz/meson.build
index bb0a3f271d..c0accc8af9 100644
--- a/tests/qtest/fuzz/meson.build
+++ b/tests/qtest/fuzz/meson.build
@@ -9,9 +9,8 @@ specific_fuzz_ss.add(when: 'CONFIG_VIRTIO_SCSI', if_true: files('virtio_scsi_fuz
 # unfortunately declare_dependency does not support link_depends, so
 # this will be duplicated in meson.build
 fork_fuzz = declare_dependency(
-  link_args: ['-fsanitize=fuzzer',
-              '-Wl,-T,' + (meson.current_source_dir() / 'fork_fuzz.ld'),
-              '-Wl,-wrap,qtest_inb',
+  link_args: config_host['FUZZ_LINK_COMMAND'].split() +
+              ['-Wl,-wrap,qtest_inb',
               '-Wl,-wrap,qtest_inw',
               '-Wl,-wrap,qtest_inl',
               '-Wl,-wrap,qtest_outb',
-- 
2.28.0


