Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2F3C0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:05:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 843FF206E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cXJKiorF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 843FF206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsVYw-0007sf-PL
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 13:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57710)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hsVYN-0007Rt-Ee
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:04:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hsVYM-00089o-5O
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:04:47 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52939)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hsVYL-00089H-To
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:04:46 -0400
Received: by mail-wm1-x341.google.com with SMTP id s3so57845778wms.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 10:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=t+P+leOEkZK+KCHD9BHIO0iGLhtorr6w3hDIWFOC+JY=;
 b=cXJKiorFfGQ8OXFRZdyzcB0yxVVKRF5YyhZV6J9Fb5j+vxPIgoDhNE1SnjRuLNgKuJ
 zNOc3ql/fVKKn1KCWd7rzHUHCSN4d/fidFsUKvr0zSx/3p5mh7YcUJw2Efxfhstyj477
 GAihMqSyItzdrdl65tPRhTYULEaKcyCcOunKkeB+lY4qrZ1rC7w+c6jhb2Sw4+2lF7+/
 QN2PpgA6sfPOqQ0K1Gh2/CiaS+InNf3qqddfURK3qDuNEWJU2e2EzqEUHHmjRdqlJFxY
 UNe8zfi77EYs+UFNCs58o0hxNtf7nndKeLrXda2u1IJ7LksHI4IjNjbi2l8fpEi/zzAA
 BzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=t+P+leOEkZK+KCHD9BHIO0iGLhtorr6w3hDIWFOC+JY=;
 b=bE3XDE5vPzpy62/smPPnB6QnoOkfJakH9nWcadBirZ3qudlUU33B138xruw5AF+r+N
 klygluxcPmUfsFc8DgBE4WeScbByWCbzs6TOKM0OpgXxbekMzydBV9bEmlgcqs6LYvR1
 0xGiaiUdw1hRcCk/HSqXfNKH8L/ctPPIR+seMWYEvApRVvT0yy90lo8+0Z9hMPvtobkP
 58TLADxoairqZfAFJI+Mz81PlYiurx9bgoMLes9WydgFwpOWHgUQ9flxl8FL3TQovPGR
 s+AaRE+ShWgI8pwCQIR99FKVXET9Zrm+b184aW0iG1TtJqFwOdwpS1tt5qvBtjsGShTC
 UTxg==
X-Gm-Message-State: APjAAAVxN3Im9jIU1CvJ8Q60WLQ+7mZjZWGvU7CgU6EsJCrPLYWmdkgn
 xvCYHLCzTSvOd+3Pi0XVHT98/A==
X-Google-Smtp-Source: APXvYqyXatgpeCjQO061y73djicwBxX/xdaidn+tddR1YhBB9wEqk94Qm1M2kWqbmzXTgNZuwOtoPg==
X-Received: by 2002:a1c:c145:: with SMTP id
 r66mr106030494wmf.139.1564506284271; 
 Tue, 30 Jul 2019 10:04:44 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id f10sm52825566wrs.22.2019.07.30.10.04.43
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 30 Jul 2019 10:04:43 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4023F1FF87;
 Tue, 30 Jul 2019 18:04:43 +0100 (BST)
References: <20190614171200.21078-1-alex.bennee@linaro.org>
 <20190614171200.21078-26-alex.bennee@linaro.org>
 <bd131b16-2f38-4112-4e09-6a2f63908bf2@linaro.org>
 <87ftmnitjp.fsf@linaro.org>
 <67b32364-c3dd-ff0d-fba8-7737327fc1b5@linaro.org>
User-agent: mu4e 1.3.3; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
In-reply-to: <67b32364-c3dd-ff0d-fba8-7737327fc1b5@linaro.org>
Date: Tue, 30 Jul 2019 18:04:43 +0100
Message-ID: <87d0hrihck.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v3 25/50] translator: add translator_ld{ub,
 sw, uw, l, q}
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
Cc: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 7/30/19 5:41 AM, Alex Benn=C3=A9e wrote:
>> Do we ever need _code access that isn't part of the
>> translator loading instructions?
>
> We use it; I'm not sure that's the same as need.  ;-)
>
> Lots of the uses that I examined should use a mechanism
> like arm does for recording syndrome data in the unwind slots.
>
> Quite possibly the only legitimate use is sparc, where it
> has an alternate address space that reads with execute permission.
> We could probably find a different way to accomplish that
> if we removed the *_code helpers.

So far I've gone for deprecation, my current fixup patch looks like
this:

--8<---------------cut here---------------start------------->8---
fixup! translator: add translator_ld{ub,sw,uw,l,q}

4 files changed, 53 insertions(+), 7 deletions(-)
include/exec/cpu_ldst.h   | 11 +++++++++++
include/exec/translator.h | 42 +++++++++++++++++++++++++++++++++++-------
include/qemu/bswap.h      |  5 +++++
tcg/tcg.h                 |  2 ++

modified   include/exec/cpu_ldst.h
@@ -129,6 +129,11 @@ static inline void clear_helper_retaddr(void)
 #include "exec/cpu_ldst_useronly_template.h"
 #undef MEMSUFFIX

+/*
+ * Code access is deprecated in favour of translator_ld* functions
+ * (see translator.h). However there are still users that need to
+ * converted so for now these stay.
+ */
 #define MEMSUFFIX _code
 #define CODE_ACCESS
 #define DATA_SIZE 1
@@ -427,6 +432,12 @@ static inline CPUTLBEntry *tlb_entry(CPUArchState *env=
, uintptr_t mmu_idx,
 #undef CPU_MMU_INDEX
 #undef MEMSUFFIX

+/*
+ * Code access is deprecated in favour of translator_ld* functions
+ * (see translator.h). However there are still users that need to
+ * converted so for now these stay.
+ */
+
 #define CPU_MMU_INDEX (cpu_mmu_index(env, true))
 #define MEMSUFFIX _code
 #define SOFTMMU_CODE_ACCESS
modified   include/exec/translator.h
@@ -145,11 +145,39 @@ void translator_loop(const TranslatorOps *ops, DisasC=
ontextBase *db,

 void translator_loop_temp_check(DisasContextBase *db);

-#define GEN_TRANSLATOR_LD(fullname, name, type, swap_fn)                \
+/*
+ * Translator Load Functions
+ *
+ * These are intended to replace the old cpu_ld*_code functions and
+ * are mandatory for front-ends that have been migrated to the common
+ * translator_loop. These functions are only intended to be called
+ * from the translation stage and should not be called from helper
+ * functions. Those functions should be converted to encode the
+ * relevant at translation time.
+ */
+
+#ifdef CONFIG_USER_ONLY
+
+#define DO_LOAD(type, name, shift)               \
+    set_helper_retaddr(1);                       \
+    ret =3D name ## _p(g2h(pc));                   \
+    clear_helper_retaddr();
+
+#else
+
+#define DO_LOAD(type, name, shift)                   \
+    int mmu_idx =3D cpu_mmu_index(env, true);          \
+    TCGMemOpIdx oi =3D make_memop_idx(shift, mmu_idx); \
+    ret =3D helper_ret_ ## name ## _cmmu(env, pc, oi, 0);
+
+#endif
+
+#define GEN_TRANSLATOR_LD(fullname, name, type, shift, swap_fn)         \
     static inline type                                                  \
     fullname ## _swap(CPUArchState *env, abi_ptr pc, bool do_swap)      \
     {                                                                   \
-        type ret =3D cpu_ ## name ## _code(env, pc);                      \
+        type ret;                                                       \
+        DO_LOAD(type, name, shift)                                      \
                                                                         \
         if (do_swap) {                                                  \
             ret =3D swap_fn(ret);                                         \
@@ -163,11 +191,11 @@ void translator_loop_temp_check(DisasContextBase *db);
         return fullname ## _swap(env, pc, false);                       \
     }

-GEN_TRANSLATOR_LD(translator_ldub, ldub, uint8_t, /* no swap needed */)
-GEN_TRANSLATOR_LD(translator_ldsw, ldsw, int16_t, bswap16)
-GEN_TRANSLATOR_LD(translator_lduw, lduw, uint16_t, bswap16)
-GEN_TRANSLATOR_LD(translator_ldl, ldl, uint32_t, bswap32)
-GEN_TRANSLATOR_LD(translator_ldq, ldq, uint64_t, bswap64)
+GEN_TRANSLATOR_LD(translator_ldub, ldb, uint8_t, 1, /* no swap needed */)
+GEN_TRANSLATOR_LD(translator_ldsw, lduw, int16_t, 2, bswap16)
+GEN_TRANSLATOR_LD(translator_lduw, lduw, uint16_t, 2, bswap16)
+GEN_TRANSLATOR_LD(translator_ldl, ldl, uint32_t, 3, bswap32)
+GEN_TRANSLATOR_LD(translator_ldq, ldq, uint64_t, 4, bswap64)
 #undef GEN_TRANSLATOR_LD

 #endif  /* EXEC__TRANSLATOR_H */
modified   include/qemu/bswap.h
@@ -306,6 +306,11 @@ static inline int ldub_p(const void *ptr)
     return *(uint8_t *)ptr;
 }

+static inline int ldb_p(const void *ptr)
+{
+    return ldub_p(ptr);
+}
+
 static inline int ldsb_p(const void *ptr)
 {
     return *(int8_t *)ptr;
modified   tcg/tcg.h
@@ -1404,6 +1404,7 @@ uint64_t helper_be_ldq_cmmu(CPUArchState *env, target=
_ulong addr,
 # define helper_ret_stl_mmu   helper_be_stl_mmu
 # define helper_ret_stq_mmu   helper_be_stq_mmu
 # define helper_ret_ldw_cmmu  helper_be_ldw_cmmu
+# define helper_ret_lduw_cmmu helper_be_ldw_cmmu
 # define helper_ret_ldl_cmmu  helper_be_ldl_cmmu
 # define helper_ret_ldq_cmmu  helper_be_ldq_cmmu
 #else
@@ -1417,6 +1418,7 @@ uint64_t helper_be_ldq_cmmu(CPUArchState *env, target=
_ulong addr,
 # define helper_ret_stl_mmu   helper_le_stl_mmu
 # define helper_ret_stq_mmu   helper_le_stq_mmu
 # define helper_ret_ldw_cmmu  helper_le_ldw_cmmu
+# define helper_ret_lduw_cmmu helper_le_ldw_cmmu
 # define helper_ret_ldl_cmmu  helper_le_ldl_cmmu
 # define helper_ret_ldq_cmmu  helper_le_ldq_cmmu
 #endif
--8<---------------cut here---------------end--------------->8---

--
Alex Benn=C3=A9e

