Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACCFC83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 19:48:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B03AB206D6
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 19:48:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B03AB206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTshE-0000ki-1R
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 15:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dbuono@linux.vnet.ibm.com>) id 1jTsfq-0006om-Oj
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 15:47:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dbuono@linux.vnet.ibm.com>) id 1jTsdb-0000lB-Ok
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 15:47:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38502)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1jTsdb-0000kv-8W
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 15:44:55 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03TJW7rv025519
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 15:44:53 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30mggw3786-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 15:44:53 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03TJW9vG025848
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 15:44:53 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30mggw377u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2020 15:44:53 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03TJUWIg004962;
 Wed, 29 Apr 2020 19:44:52 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by ppma02dal.us.ibm.com with ESMTP id 30mcu71914-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2020 19:44:52 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 03TJioGN52363542
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Apr 2020 19:44:50 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A744E6A04D;
 Wed, 29 Apr 2020 19:44:50 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E40C36A047;
 Wed, 29 Apr 2020 19:44:49 +0000 (GMT)
Received: from Buonos-Thinkpad-X1.ibm.com (unknown [9.160.84.167])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 29 Apr 2020 19:44:49 +0000 (GMT)
From: Daniele Buono <dbuono@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] coroutine: support SafeStack in ucontext backend
Date: Wed, 29 Apr 2020 15:44:17 -0400
Message-Id: <20200429194420.21147-2-dbuono@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200429194420.21147-1-dbuono@linux.vnet.ibm.com>
References: <20200429194420.21147-1-dbuono@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-29_09:2020-04-29,
 2020-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0
 suspectscore=3 mlxscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004290143
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
 include/qemu/coroutine_int.h |  6 ++++++
 util/coroutine-ucontext.c    | 25 +++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/qemu/coroutine_int.h b/include/qemu/coroutine_int.h
index bd6b0468e1..2ffd75ddbe 100644
--- a/include/qemu/coroutine_int.h
+++ b/include/qemu/coroutine_int.h
@@ -28,6 +28,12 @@
 #include "qemu/queue.h"
 #include "qemu/coroutine.h"
 
+#if defined(__has_feature) && __has_feature(safe_stack)
+#define CONFIG_SAFESTACK 1
+/* Pointer to the unsafe stack, defined by the compiler */
+extern __thread void *__safestack_unsafe_stack_ptr;
+#endif
+
 #define COROUTINE_STACK_SIZE (1 << 20)
 
 typedef enum {
diff --git a/util/coroutine-ucontext.c b/util/coroutine-ucontext.c
index bd593e61bc..b79e9df9eb 100644
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
@@ -160,6 +169,19 @@ Coroutine *qemu_coroutine_new(void)
     /* swapcontext() in, siglongjmp() back out */
     if (!sigsetjmp(old_env, 0)) {
         start_switch_fiber(&fake_stack_save, co->stack, co->stack_size);
+#ifdef CONFIG_SAFESTACK
+        /*
+         * Before we swap the context, set the new unsafe stack
+         * The unsafe stack grows just like the normal stack, so start from
+         * the last usable location of the memory area.
+         * NOTE: we don't have to re-set it afterwards because sigsetjmp was
+         * called with the original usp. Since we are not coming back with a
+         * swapcontext, but with a siglongjmp, when we are back here we
+         * already have usp restored to the valid one for this function
+         */
+        void *usp = co->unsafe_stack + co->unsafe_stack_size;
+        __safestack_unsafe_stack_ptr = usp;
+#endif
         swapcontext(&old_uc, &uc);
     }
 
@@ -192,6 +214,9 @@ void qemu_coroutine_delete(Coroutine *co_)
 #endif
 
     qemu_free_stack(co->stack, co->stack_size);
+#ifdef CONFIG_SAFESTACK
+    qemu_free_stack(co->unsafe_stack, co->unsafe_stack_size);
+#endif
     g_free(co);
 }
 
-- 
2.26.2


