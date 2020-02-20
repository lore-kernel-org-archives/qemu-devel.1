Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AF6C34031
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 04:19:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 773522465D
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 04:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="KnKJPKCc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 773522465D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4dJX-0002gw-ML
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 23:19:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45190)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1j4dBs-0004qQ-Ax
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1j4dBr-0005zd-6m
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:56 -0500
Received: from mail-co1nam11on2112.outbound.protection.outlook.com
 ([40.107.220.112]:43264 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1j4dBq-0005yw-Vd
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gT1JJ4ILKqw/S/9Nh4cXJ/oAA92AAPt17C1XteS9+/v9qJBIk44muL5r8e/nrQ8Lp7JCZQNBXC9sr8GBUFRWPhvVrN6bI/IFgHp+EmGfmhFhVSbmmCFSqOaqXLO1sa+y2MCQMWLzBiGcrVRyAtXJLs1hqDAbqwTzxGDG3VQ59WJSOXwAZagKNv2FieLiHft0q+GrTfcYZpD5PUXNtBm44xhNYQrzLPaX3D/d4LEF1hwqonlMmMRQS8XZqwYWcUdNRSGaJ8Fyfry+JXLGajRrlhKuMcHrUHcJ7VrfoghJV6yQXBeIctCdLzrxqSPG76DIYgQ7wmGQDJQnJHu33tbc5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qEoOG0s+esv4vMARQiW1Asy+2QVle7snAp3psZBg58=;
 b=fQiCFcMmZu61sgvXM5u2mpaBH40Wf1w/LDRUk3v4Ncp+OAnDoL+3pp1UY5JdJIZUtqSqaf2VUj/CloLFBaXp2/WmXGb7Nr+befUtPebA8aGlb+3xN9Fzo653y2kaCygnl1dPTcDoegxQ9VjSafq8bQNqO4xXrzeFNayM3S8sOcUTbmNhRjhVMHh5lQ5S5MvF63yHtY7qohuPJUEQKNPlyb05+Kdiexj1NoPgZrjI+KlivFB0Acmy53ySa6XHAmDa10i9NqGzVvJC3uAuHW1mex8GjfNtMvBhAczQk2SELkM4LumGrySZ+C4/re6O616iNo0nBNfiAQIYYvZrSdfLyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qEoOG0s+esv4vMARQiW1Asy+2QVle7snAp3psZBg58=;
 b=KnKJPKCcT16nEoZD21zZPIiTX2UJzMa/gJY3Bnh/i+GfmkX69a/nOZxnPzir347G3U4OUMzzgIh77CbfXmpB5CV97JFbL+RgozgmD4E1HdBsqOKUAiQoed5I73/ochJzhM2kWtnDE0dO0mZBKm/nR0pzbAvjBw0AVKi19tTk1fA=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3807.namprd03.prod.outlook.com (2603:10b6:805:6a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22; Thu, 20 Feb
 2020 04:11:53 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2729.033; Thu, 20 Feb 2020
 04:11:53 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 18/22] fuzz: add configure flag --enable-fuzzing
Date: Wed, 19 Feb 2020 23:11:14 -0500
Message-ID: <20200220041118.23264-19-alxndr@bu.edu>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200220041118.23264-1-alxndr@bu.edu>
References: <20200220041118.23264-1-alxndr@bu.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL0PR0102CA0048.prod.exchangelabs.com
 (2603:10b6:208:25::25) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR0102CA0048.prod.exchangelabs.com (2603:10b6:208:25::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17 via Frontend Transport; Thu, 20 Feb 2020 04:11:52 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 262bf4e2-6009-410f-3671-08d7b5bb0464
X-MS-TrafficTypeDiagnostic: SN6PR03MB3807:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB3807ED5355D0EF21F63E1855BA130@SN6PR03MB3807.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-Forefront-PRVS: 031996B7EF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(199004)(189003)(36756003)(86362001)(81166006)(75432002)(8676002)(2616005)(478600001)(81156014)(8936002)(66476007)(5660300002)(6916009)(66556008)(66946007)(54906003)(956004)(316002)(786003)(6486002)(6666004)(7696005)(16526019)(186003)(26005)(4326008)(1076003)(2906002)(52116002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB3807;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e/jJNjp/CFSBRq+w0xgidfTyUPvTuyTsc0wQv2vsqqn+dCi/9qFLg3N5nQf0Gr00UrSAi6YnVW2YXNA2QkNJPa82jYXhXevCrcZ+5BqIP5eIsKUFuAT/78QfwRnjN7VlD7HKKsI+2CpT03FgDeuhfs0vtby56senuoEqWorsKyxnqJYDDcWc3f/KgSO/6OOOQmpqEg0vtVaH6TpPVn5DUmH76bh1Tv8cFggD3b0a9sf4CD8Ixv5tRC98iL14LaSTdpXiCVaM73QTONh+yVzD++q+KmXSmibaeWAPPvKSrwwhyRsfUNTS8tr19bX2IxvyJUbfq3i9MvycWQBXXSKycx09T505nUBpKfgU32PNIF6OLYrRriRuMkgnfpfX+BedBFL9HEou9oPlaWfmQwrPIIaZZVN1nbPZDLJd8l91PocmCXW9ORDBY1xWNS8zKa0u
X-MS-Exchange-AntiSpam-MessageData: 2NQaPO2fG7U25jzt3htZSI/0E5CIOvoVxuI3bUo0IXW3ZHbIudChRp+urdWEYRqKVCmeaYivxUNiQWi4CgFOLWr25ftXpaMjKzrKtctSMpgotS0BYLL3qD6LHx0gOrsMj2o4XxgTPXSSOHB4CkV5ow==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 262bf4e2-6009-410f-3671-08d7b5bb0464
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2020 04:11:53.5431 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ePOF4SaV9ZqseA0jkZB4Sd3C3HCSaCDwb9+ekD5AhHs6FBQhBDrtJT2S31tCGSJ8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3807
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.220.112
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
Cc: darren.kenny@oracle.com, Alexander Bulekov <alxndr@bu.edu>, bsd@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
---
 configure | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/configure b/configure
index 115dc38085..bd873177ad 100755
--- a/configure
+++ b/configure
@@ -505,6 +505,7 @@ debug_mutex=3D"no"
 libpmem=3D""
 default_devices=3D"yes"
 plugins=3D"no"
+fuzzing=3D"no"
=20
 supported_cpu=3D"no"
 supported_os=3D"no"
@@ -635,6 +636,15 @@ int main(void) { return 0; }
 EOF
 }
=20
+write_c_fuzzer_skeleton() {
+    cat > $TMPC <<EOF
+#include <stdint.h>
+#include <sys/types.h>
+int LLVMFuzzerTestOneInput(const uint8_t *Data, size_t Size);
+int LLVMFuzzerTestOneInput(const uint8_t *Data, size_t Size) { return 0; }
+EOF
+}
+
 if check_define __linux__ ; then
   targetos=3D"Linux"
 elif check_define _WIN32 ; then
@@ -1545,6 +1555,10 @@ for opt do
   ;;
   --disable-containers) use_containers=3D"no"
   ;;
+  --enable-fuzzing) fuzzing=3Dyes
+  ;;
+  --disable-fuzzing) fuzzing=3Dno
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -6035,6 +6049,15 @@ EOF
   fi
 fi
=20
+##########################################
+# checks for fuzzer
+if test "$fuzzing" =3D "yes" ; then
+  write_c_fuzzer_skeleton
+  if compile_prog "$CPU_CFLAGS -Werror -fsanitize=3Daddress,fuzzer" ""; th=
en
+      have_fuzzer=3Dyes
+  fi
+fi
+
 ##########################################
 # check for libpmem
=20
@@ -6621,6 +6644,7 @@ echo "libpmem support   $libpmem"
 echo "libudev           $libudev"
 echo "default devices   $default_devices"
 echo "plugin support    $plugins"
+echo "fuzzing support   $fuzzing"
=20
 if test "$supported_cpu" =3D "no"; then
     echo
@@ -7456,6 +7480,16 @@ fi
 if test "$sheepdog" =3D "yes" ; then
   echo "CONFIG_SHEEPDOG=3Dy" >> $config_host_mak
 fi
+if test "$fuzzing" =3D "yes" ; then
+  if test "$have_fuzzer" =3D "yes"; then
+    FUZZ_LDFLAGS=3D" -fsanitize=3Daddress,fuzzer"
+    FUZZ_CFLAGS=3D" -fsanitize=3Daddress,fuzzer"
+    CFLAGS=3D" -fsanitize=3Daddress,fuzzer-no-link"
+  else
+    error_exit "Your compiler doesn't support -fsanitize=3Daddress,fuzzer"
+    exit 1
+  fi
+fi
=20
 if test "$plugins" =3D "yes" ; then
     echo "CONFIG_PLUGIN=3Dy" >> $config_host_mak
@@ -7556,6 +7590,11 @@ if test "$libudev" !=3D "no"; then
     echo "CONFIG_LIBUDEV=3Dy" >> $config_host_mak
     echo "LIBUDEV_LIBS=3D$libudev_libs" >> $config_host_mak
 fi
+if test "$fuzzing" !=3D "no"; then
+    echo "CONFIG_FUZZ=3Dy" >> $config_host_mak
+    echo "FUZZ_CFLAGS=3D$FUZZ_CFLAGS" >> $config_host_mak
+    echo "FUZZ_LDFLAGS=3D$FUZZ_LDFLAGS" >> $config_host_mak
+fi
=20
 if test "$edk2_blobs" =3D "yes" ; then
   echo "DECOMPRESS_EDK2_BLOBS=3Dy" >> $config_host_mak
--=20
2.25.0


