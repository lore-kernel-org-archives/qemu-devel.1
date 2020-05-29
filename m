Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F81C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 20:54:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B878B208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 20:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B878B208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jem1i-0006Co-Sx
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 16:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1jelyn-00019x-3d
 for qemu-devel@nongnu.org; Fri, 29 May 2020 16:51:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28728
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1jelym-0001vo-4o
 for qemu-devel@nongnu.org; Fri, 29 May 2020 16:51:48 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04TKViAG000927
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 16:51:47 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31as1e5uct-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 16:51:46 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04TKWufw004510
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 16:51:46 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31as1e5uch-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 May 2020 16:51:46 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04TKp2JP022322;
 Fri, 29 May 2020 20:51:46 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma02dal.us.ibm.com with ESMTP id 316ufbscv6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 May 2020 20:51:45 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04TKphpc28967358
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 May 2020 20:51:43 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B5AD36A04D;
 Fri, 29 May 2020 20:51:44 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D3E666A047;
 Fri, 29 May 2020 20:51:43 +0000 (GMT)
Received: from Buonos-Thinkpad-X1.ibm.com (unknown [9.65.226.57])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri, 29 May 2020 20:51:43 +0000 (GMT)
From: Daniele Buono <dbuono@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/4] coroutine: support SafeStack in ucontext backend
Date: Fri, 29 May 2020 16:51:19 -0400
Message-Id: <20200529205122.714-2-dbuono@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200529205122.714-1-dbuono@linux.vnet.ibm.com>
References: <20200529205122.714-1-dbuono@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-05-29_10:2020-05-28,
 2020-05-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 cotscore=-2147483648 phishscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=3 adultscore=0
 mlxscore=0 clxscore=1015 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005290148
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=dbuono@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 15:28:52
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
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

LLVM's SafeStack instrumentation does not yet support programs that make
use of the APIs in ucontext.h
With the current implementation of coroutine-ucontext, the resulting
binary is incorrect, with different coroutines sharing the same unsafe
stack and producing undefined behavior at runtime.
This fix allocates an additional unsafe stack area for each coroutine,
and sets the new unsafe stack pointer before calling swapcontext() in
qemu_coroutine_new.
This is the only place where the pointer needs to be manually updated,
since sigsetjmp/siglongjmp are already instrumented by LLVM to properly
support SafeStack.
The additional stack is then freed in qemu_coroutine_delete.

Signed-off-by: Daniele Buono <dbuono@linux.vnet.ibm.com>
---
 include/qemu/coroutine_int.h |  5 +++++
 util/coroutine-ucontext.c    | 26 ++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/qemu/coroutine_int.h b/include/qemu/coroutine_int.h
index bd6b0468e1..1da148552f 100644
--- a/include/qemu/coroutine_int.h
+++ b/include/qemu/coroutine_int.h
@@ -28,6 +28,11 @@
 #include "qemu/queue.h"
 #include "qemu/coroutine.h"
 
+#ifdef CONFIG_SAFESTACK
+/* Pointer to the unsafe stack, defined by the compiler */
+extern __thread void *__safestack_unsafe_stack_ptr;
+#endif
+
 #define COROUTINE_STACK_SIZE (1 << 20)
 
 typedef enum {
diff --git a/util/coroutine-ucontext.c b/util/coroutine-ucontext.c
index bd593e61bc..9108eb1294 100644
--- a/util/coroutine-ucontext.c
+++ b/util/coroutine-ucontext.c
@@ -41,6 +41,11 @@ typedef struct {
     Coroutine base;
     void *stack;
     size_t stack_size;
+#ifdef CONFIG_SAFESTACK
+    /* Need an unsafe stack for each coroutine */
+    void *unsafe_stack;
+    size_t unsafe_stack_size;
+#endif
     sigjmp_buf env;
 
 #ifdef CONFIG_VALGRIND_H
@@ -140,6 +145,10 @@ Coroutine *qemu_coroutine_new(void)
     co = g_malloc0(sizeof(*co));
     co->stack_size = COROUTINE_STACK_SIZE;
     co->stack = qemu_alloc_stack(&co->stack_size);
+#ifdef CONFIG_SAFESTACK
+    co->unsafe_stack_size = COROUTINE_STACK_SIZE;
+    co->unsafe_stack = qemu_alloc_stack(&co->unsafe_stack_size);
+#endif
     co->base.entry_arg = &old_env; /* stash away our jmp_buf */
 
     uc.uc_link = &old_uc;
@@ -160,6 +169,20 @@ Coroutine *qemu_coroutine_new(void)
     /* swapcontext() in, siglongjmp() back out */
     if (!sigsetjmp(old_env, 0)) {
         start_switch_fiber(&fake_stack_save, co->stack, co->stack_size);
+#ifdef CONFIG_SAFESTACK
+        /*
+         * Before we swap the context, set the new unsafe stack
+         * The unsafe stack grows just like the normal stack, so start from
+         * the last usable location of the memory area.
+         * NOTE: we don't have to re-set the usp afterwards because we are
+         * coming back to this context through a siglongjmp.
+         * The compiler already wrapped the corresponding sigsetjmp call with
+         * code that saves the usp on the (safe) stack before the call, and
+         * restores it right after (which is where we return with siglongjmp).
+         */
+        void *usp = co->unsafe_stack + co->unsafe_stack_size;
+        __safestack_unsafe_stack_ptr = usp;
+#endif
         swapcontext(&old_uc, &uc);
     }
 
@@ -192,6 +215,9 @@ void qemu_coroutine_delete(Coroutine *co_)
 #endif
 
     qemu_free_stack(co->stack, co->stack_size);
+#ifdef CONFIG_SAFESTACK
+    qemu_free_stack(co->unsafe_stack, co->unsafe_stack_size);
+#endif
     g_free(co);
 }
 
-- 
2.26.2


