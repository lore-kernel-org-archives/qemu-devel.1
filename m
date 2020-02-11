Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A9DC35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:52:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40CDD206D6
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="RaAKgF9S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40CDD206D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1cWb-0003Nr-FQ
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 15:52:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35340)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1j1cG2-0006cw-OT
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1j1cG1-00007C-2G
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:46 -0500
Received: from mail-eopbgr690106.outbound.protection.outlook.com
 ([40.107.69.106]:43233 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1j1cG0-0008My-My
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akZwbhjTYhu/2fl/EwxayXEyMKQZ6jiLrCL9MngfuGIyItaw25ACDWFrZ11QuNmhn3Sxvq/a5bL+kvUHzZleM5MwiQulGrm096TWpdElQGSUg7dtdpGim7YrF4KH3yGhrLI5rJS4HwKDnWHCeFb7LBctyJ0qYbGGtmbKJwOa8ljvtmp5BkrLxS6VZKa6ACPFs3R6Yg0VWoA4k2pfwOGRUYBEtd2Z7kcA3bBYo7MsvEUrzoPwgeOm1GA1BiSYjMvrWdiOe4BpkRL8CpymTy4sIFYe1hd4onX/H3SiIyeKBoWGABVAlIP4G5WPj/0B5FRpTeIAzrpQiaQdxoauIJ12yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qEoOG0s+esv4vMARQiW1Asy+2QVle7snAp3psZBg58=;
 b=ZJzL0Ncx5Imti42IMcOGtoQsRDoA4woWAXDOnJdvOyMzc2FJXi2sfn83eEDGpfERmBSqUgVpPcTWTG9YCw1Bsn8zaYix6RcKJPo9kSMexTeM3Syx1wJetkq0NNnAQKv8hlLHWa95tE1KEon1AVPZsESZfVbJ66n7QpLUqMUlTqA7JaG15jY8cXgz4vAcBKD4dDvdjMcZwI2aMcR34JN0QgQ5r4mVDhuisTEnLNsi+Y2j1ypamyBEiG+8yaKXlxx2s9xav+hbC3xQNby31r6jj3EKns1BA0YJ/X+6vrupmOpHIjlj/PKOQ2ZphGj1Hi4TxYu9SOOT6RI7Fo8Xj/cUAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qEoOG0s+esv4vMARQiW1Asy+2QVle7snAp3psZBg58=;
 b=RaAKgF9Sqrz755LhWub+AnPPwsiRGz6hkOmUqZsm7mbVnV7+ceSNtvqqhyQkgY0EGDzweuH+GSCjaFdncMQ2ycaNUSB/o5FX3QSdYQTQZhPpGy4OIehnrJHRyQp3tZaed98n+/PPjnysqzsGQcprDSs9KP5nA5BrT373pLpXYb8=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB4336.namprd03.prod.outlook.com (20.177.254.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.27; Tue, 11 Feb 2020 20:35:39 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 20:35:39 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 19/23] fuzz: add configure flag --enable-fuzzing
Date: Tue, 11 Feb 2020 15:35:06 -0500
Message-ID: <20200211203510.3534-20-alxndr@bu.edu>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211203510.3534-1-alxndr@bu.edu>
References: <20200211203510.3534-1-alxndr@bu.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL0PR02CA0124.namprd02.prod.outlook.com
 (2603:10b6:208:35::29) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR02CA0124.namprd02.prod.outlook.com (2603:10b6:208:35::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23 via Frontend Transport; Tue, 11 Feb 2020 20:35:38 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52874143-0f0a-4584-fbc8-08d7af31f493
X-MS-TrafficTypeDiagnostic: SN6PR03MB4336:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB433626ECCD5AA3E5517404B0BA180@SN6PR03MB4336.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-Forefront-PRVS: 0310C78181
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(199004)(189003)(16526019)(6666004)(1076003)(5660300002)(86362001)(316002)(186003)(786003)(66556008)(54906003)(6916009)(66476007)(6486002)(66946007)(8936002)(478600001)(4326008)(7696005)(52116002)(36756003)(75432002)(2616005)(2906002)(956004)(8676002)(26005)(81166006)(81156014);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB4336;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cvRnkXmdq7DgkkKjt1TvLP6CiuWpH925BSaK04J33xyl2PLfBS20HRh0P52cvyP79JvCKitE+srgo+nLCoQDNKm387FiL/rsW1wHJId0jUE7ZYBlSQW51l+egyXgyDBFTEHUI/ojkaqt1oC8syhl9xBgoYhOEEzAjUC9+Ug+vqJkn90SVQDIF4qu0qDO+HFgfb07MErXjDaVF3gEUKmwIUgVSHqLxdG12gcvjIKUdSwd5mYj3YYOrEmba0OjD+am00x5hFzY0b7guepFtEG4NrME0zLVR5MGJLfxinPyKssvESYsAtfF0yrTltrM7aVgnSHMGrnCvtmsI0RD3j3lb5FHm4LFR4krxXx+2nMpfKE6IAgY8BDGkk1LjVM5/ht365k7lFk0NsvT0XaWv/3KG4FqEE0exaPrSRguj0HfRVBEUkiecnqWNZJcUAF25s0v
X-MS-Exchange-AntiSpam-MessageData: HtEPQpzKwfEg4bK7+rqZTn8KPKgy/ye6s0SEQT8vt3bmRw1XrHnbLW2uZvhVu96TZxkFal86m+o8uFB3I/dDim/ecN7aqYTkMbdEwiICmufWyTsnr8zu97TigeLBfzZlgKe+wWwIUalQX6sWTy3sRQ==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 52874143-0f0a-4584-fbc8-08d7af31f493
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 20:35:39.1439 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G9l1UoA/CQhINIQw3N+TxCFJNilv3k3kjr33gsucdSoJSIu8IJaerJo6TglXVvWA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4336
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Received-From: 40.107.69.106
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


