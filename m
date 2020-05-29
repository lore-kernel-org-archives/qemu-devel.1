Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C62DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 20:54:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52EB6208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 20:54:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52EB6208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jem1m-0006Q2-Bs
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 16:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1jelyu-0001GN-2V
 for qemu-devel@nongnu.org; Fri, 29 May 2020 16:51:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46882)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1jelys-0002Ea-TE
 for qemu-devel@nongnu.org; Fri, 29 May 2020 16:51:55 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04TKb0CL056053
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 16:51:53 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31as1ewk28-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 16:51:53 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04TKdhlw061891
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 16:51:52 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31as1ewk21-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 May 2020 16:51:52 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04TKoIaL003992;
 Fri, 29 May 2020 20:51:51 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma03wdc.us.ibm.com with ESMTP id 316uf9wn83-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 May 2020 20:51:51 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04TKpn7I19988796
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 May 2020 20:51:49 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9AC0B6A057;
 Fri, 29 May 2020 20:51:50 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B37DE6A051;
 Fri, 29 May 2020 20:51:49 +0000 (GMT)
Received: from Buonos-Thinkpad-X1.ibm.com (unknown [9.65.226.57])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri, 29 May 2020 20:51:49 +0000 (GMT)
From: Daniele Buono <dbuono@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/4] configure: add flags to support SafeStack
Date: Fri, 29 May 2020 16:51:21 -0400
Message-Id: <20200529205122.714-4-dbuono@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200529205122.714-1-dbuono@linux.vnet.ibm.com>
References: <20200529205122.714-1-dbuono@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-05-29_10:2020-05-28,
 2020-05-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=3
 lowpriorityscore=0
 cotscore=-2147483648 malwarescore=0 clxscore=1015 mlxscore=3
 impostorscore=0 adultscore=0 spamscore=3 suspectscore=1 phishscore=0
 mlxlogscore=150 bulkscore=0 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005290150
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=dbuono@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 16:51:53
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 dbuono@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds a flag to enable/disable the SafeStack instrumentation
provided by LLVM.

On enable, make sure that the compiler supports the flags, and that we
are using the proper coroutine implementation (coroutine-ucontext).
On disable, explicitly disable the option if it was enabled by default.

While SafeStack is supported only on Linux, NetBSD, FreeBSD and macOS,
we are not checking for the O.S. since this is already done by LLVM.

Signed-off-by: Daniele Buono <dbuono@linux.vnet.ibm.com>
---
 configure | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/configure b/configure
index b969dee675..260772b2d5 100755
--- a/configure
+++ b/configure
@@ -302,6 +302,7 @@ audio_win_int=""
 libs_qga=""
 debug_info="yes"
 stack_protector=""
+safe_stack=""
 use_containers="yes"
 gdb_bin=$(command -v "gdb-multiarch" || command -v "gdb")
 
@@ -1275,6 +1276,10 @@ for opt do
   ;;
   --disable-stack-protector) stack_protector="no"
   ;;
+  --enable-safe-stack) safe_stack="yes"
+  ;;
+  --disable-safe-stack) safe_stack="no"
+  ;;
   --disable-curses) curses="no"
   ;;
   --enable-curses) curses="yes"
@@ -1804,6 +1809,8 @@ disabled with --disable-FEATURE, default is enabled if available:
   debug-tcg       TCG debugging (default is disabled)
   debug-info      debugging information
   sparse          sparse checker
+  safe-stack      SafeStack Stack Smash Protection. Depends on
+                  clang/llvm >= 3.7 and requires coroutine backend ucontext.
 
   gnutls          GNUTLS cryptography support
   nettle          nettle cryptography support
@@ -5517,6 +5524,67 @@ if test "$debug_stack_usage" = "yes"; then
   fi
 fi
 
+##################################################
+# SafeStack
+
+
+if test "$safe_stack" = "yes"; then
+cat > $TMPC << EOF
+int main(int argc, char *argv[])
+{
+#if ! __has_feature(safe_stack)
+#error SafeStack Disabled
+#endif
+    return 0;
+}
+EOF
+  flag="-fsanitize=safe-stack"
+  # Check that safe-stack is supported and enabled.
+  if compile_prog "-Werror $flag" "$flag"; then
+    # Flag needed both at compilation and at linking
+    QEMU_CFLAGS="$QEMU_CFLAGS $flag"
+    QEMU_LDFLAGS="$QEMU_LDFLAGS $flag"
+  else
+    error_exit "SafeStack not supported by your compiler"
+  fi
+  if test "$coroutine" != "ucontext"; then
+    error_exit "SafeStack is only supported by the coroutine backend ucontext"
+  fi
+else
+cat > $TMPC << EOF
+int main(int argc, char *argv[])
+{
+#if defined(__has_feature)
+#if __has_feature(safe_stack)
+#error SafeStack Enabled
+#endif
+#endif
+    return 0;
+}
+EOF
+if test "$safe_stack" = "no"; then
+  # Make sure that safe-stack is disabled
+  if ! compile_prog "-Werror" ""; then
+    # SafeStack was already enabled, try to explicitly remove the feature
+    flag="-fno-sanitize=safe-stack"
+    if ! compile_prog "-Werror $flag" "$flag"; then
+      error_exit "Configure cannot disable SafeStack"
+    fi
+    QEMU_CFLAGS="$QEMU_CFLAGS $flag"
+    QEMU_LDFLAGS="$QEMU_LDFLAGS $flag"
+  fi
+else # "$safe_stack" = ""
+  # Set safe_stack to yes or no based on pre-existing flags
+  if compile_prog "-Werror" ""; then
+    safe_stack="no"
+  else
+    safe_stack="yes"
+    if test "$coroutine" != "ucontext"; then
+      error_exit "SafeStack is only supported by the coroutine backend ucontext"
+    fi
+  fi
+fi
+fi
 
 ##########################################
 # check if we have open_by_handle_at
@@ -6611,6 +6679,7 @@ echo "sparse enabled    $sparse"
 echo "strip binaries    $strip_opt"
 echo "profiler          $profiler"
 echo "static build      $static"
+echo "safe stack        $safe_stack"
 if test "$darwin" = "yes" ; then
     echo "Cocoa support     $cocoa"
 fi
@@ -8195,6 +8264,10 @@ if test "$ccache_cpp2" = "yes"; then
   echo "export CCACHE_CPP2=y" >> $config_host_mak
 fi
 
+if test "$safe_stack" = "yes"; then
+  echo "CONFIG_SAFESTACK=y" >> $config_host_mak
+fi
+
 # If we're using a separate build tree, set it up now.
 # DIRS are directories which we simply mkdir in the build tree;
 # LINKS are things to symlink back into the source tree
-- 
2.26.2


