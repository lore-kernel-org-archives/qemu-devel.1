Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83E0C83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 19:52:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D447206D6
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 19:52:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D447206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTslD-0005I8-Ns
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 15:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48156)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dbuono@linux.vnet.ibm.com>) id 1jTsfr-0006on-5g
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 15:47:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dbuono@linux.vnet.ibm.com>) id 1jTsdf-0000ly-Tk
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 15:47:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18084)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1jTsdf-0000lr-Ct
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 15:44:59 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03TJaL9M012560
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 15:44:58 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30mguxgafr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 15:44:58 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03TJaMfP012570
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 15:44:57 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30mguxgaf4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2020 15:44:57 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03TJi47G008588;
 Wed, 29 Apr 2020 19:44:56 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma04wdc.us.ibm.com with ESMTP id 30mcu77ctg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2020 19:44:56 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 03TJitp627591030
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Apr 2020 19:44:55 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6CC496A04F;
 Wed, 29 Apr 2020 19:44:55 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AA7C16A051;
 Wed, 29 Apr 2020 19:44:54 +0000 (GMT)
Received: from Buonos-Thinkpad-X1.ibm.com (unknown [9.160.84.167])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 29 Apr 2020 19:44:54 +0000 (GMT)
From: Daniele Buono <dbuono@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] configure: add flag to enable SafeStack
Date: Wed, 29 Apr 2020 15:44:19 -0400
Message-Id: <20200429194420.21147-4-dbuono@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200429194420.21147-1-dbuono@linux.vnet.ibm.com>
References: <20200429194420.21147-1-dbuono@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-29_10:2020-04-29,
 2020-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=516 mlxscore=0 suspectscore=1
 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004290145
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=dbuono@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 15:44:54
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Received-From: 148.163.156.1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Tobin Feldman-Fitzthum <tobin@ibm.com>,
 Daniele Buono <dbuono@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds a flag to enable the SafeStack instrumentation provided
by LLVM.
The checks make sure that the compiler supports the flags, and that we
are using the proper coroutine implementation (coroutine-ucontext).
While SafeStack is supported only on Linux, NetBSD, FreeBSD and macOS,
we are not checking for the O.S. since this is already done by LLVM.

Signed-off-by: Daniele Buono <dbuono@linux.vnet.ibm.com>
---
 configure | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/configure b/configure
index 23b5e93752..f37e4ae0bd 100755
--- a/configure
+++ b/configure
@@ -302,6 +302,7 @@ audio_win_int=""
 libs_qga=""
 debug_info="yes"
 stack_protector=""
+safe_stack="no"
 use_containers="yes"
 gdb_bin=$(command -v "gdb")
 
@@ -1275,6 +1276,8 @@ for opt do
   ;;
   --disable-stack-protector) stack_protector="no"
   ;;
+  --enable-safe-stack) safe_stack="yes"
+  ;;
   --disable-curses) curses="no"
   ;;
   --enable-curses) curses="yes"
@@ -1774,6 +1777,8 @@ Advanced options (experts only):
   --with-coroutine=BACKEND coroutine backend. Supported options:
                            ucontext, sigaltstack, windows
   --enable-gcov            enable test coverage analysis with gcov
+  --enable-safe-stack      enable the SafeStack stack protection. Depends on
+                           clang/llvm >= 3.7 and coroutine backend ucontext.
   --gcov=GCOV              use specified gcov [$gcov_tool]
   --disable-blobs          disable installing provided firmware blobs
   --with-vss-sdk=SDK-path  enable Windows VSS support in QEMU Guest Agent
@@ -5501,6 +5506,29 @@ if test "$debug_stack_usage" = "yes"; then
   fi
 fi
 
+##################################################
+# Check if SafeStack is enabled and supported
+
+if test "$safe_stack" = "yes"; then
+  cat > $TMPC << EOF
+int main(int argc, char *argv[])
+{
+    return 0;
+}
+EOF
+  flag="-fsanitize=safe-stack"
+  # Check that safe-stack is supported.
+  if compile_prog "-Werror $flag" ""; then
+    # Flag needed both at compilation and at linking
+    QEMU_CFLAGS="$QEMU_CFLAGS $flag"
+    QEMU_LDFLAGS="$QEMU_LDFLAGS $flag"
+  else
+    error_exit "SafeStack not supported by your compiler"
+  fi
+  if test "$coroutine" != "ucontext"; then
+    error_exit "SafeStack is only supported by the coroutine backend ucontext"
+  fi
+fi
 
 ##########################################
 # check if we have open_by_handle_at
@@ -6595,6 +6623,7 @@ echo "sparse enabled    $sparse"
 echo "strip binaries    $strip_opt"
 echo "profiler          $profiler"
 echo "static build      $static"
+echo "safe stack        $safe_stack"
 if test "$darwin" = "yes" ; then
     echo "Cocoa support     $cocoa"
 fi
-- 
2.26.2


