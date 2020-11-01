Return-Path: <SRS0=Dm/C=EH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFC1C388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 01:45:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0023922249
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 01:45:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0023922249
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZ2Qb-0006sh-F7
	for qemu-devel@archiver.kernel.org; Sat, 31 Oct 2020 21:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kZ2Ob-0006Hd-Gl
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 21:43:01 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:44275)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kZ2OZ-0002OD-IO
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 21:43:01 -0400
Received: by mail-il1-f195.google.com with SMTP id z2so9816288ilh.11
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2020 18:42:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+frozRTgby0L/aESmetp9LJ4gsW3L8lwVJhd+dlgcqU=;
 b=ot/cYQdUOZGFHoUlHPSMEazXPcJOZhZSz0IgpXBbPBkRUsTNrLvoVViA3XvAWF3sld
 Pej2QPD/Z7iQ6aBKRNY5dugn4bj+gIKlNyhWJzqHsr5CzBz/riCKmhLtdmkjrfNxrU1C
 s+FlITeTMoIO4qc6l8Iyae+m73M5lwaLDIv3rFdmio94vRRqeocifQpZEP1V05Ihjwof
 AGGvO4pjuUFJRSpEcPwqv/DyerfMcAPJmDrbaCU2RT3j/UuOKZF3MFXHwXODnGPBxwgF
 Sm4DMjbETZtjDvr+WqxBoQ/Viqm2Z+tnATn8ynTD98HxaCA+s89lsDTrpjsB0XPial0n
 rEuQ==
X-Gm-Message-State: AOAM5336L0LeK6juQ7M9B3x6epEPREFOFE4uRS8lYH1aXYYbnZlToRL4
 3K/cn3vvmGLXyrVa1LUwmVZH8OP0tN8=
X-Google-Smtp-Source: ABdhPJwvHC7mILGURVbdxbrL+/gRTsbpGJXiMmhA+umoiG1GmU7XUfW3vh3ZTLWPniw+/Id2dyLLCw==
X-Received: by 2002:a05:6e02:112:: with SMTP id
 t18mr6518479ilm.299.1604194977582; 
 Sat, 31 Oct 2020 18:42:57 -0700 (PDT)
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com.
 [209.85.166.173])
 by smtp.gmail.com with ESMTPSA id c2sm7242320iot.52.2020.10.31.18.42.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 31 Oct 2020 18:42:57 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id x20so9854704ilj.8
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2020 18:42:57 -0700 (PDT)
X-Received: by 2002:a05:6e02:931:: with SMTP id
 o17mr6579860ilt.273.1604194977267; 
 Sat, 31 Oct 2020 18:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <20201030004921.721096-1-richard.henderson@linaro.org>
 <20201030004921.721096-15-richard.henderson@linaro.org>
In-Reply-To: <20201030004921.721096-15-richard.henderson@linaro.org>
From: Joelle van Dyne <j@getutm.app>
Date: Sat, 31 Oct 2020 18:42:46 -0700
X-Gmail-Original-Message-ID: <CA+E+eSCNbkraRcEsnR7ReReQT600FnJoaPRmNoTxETwCgobytQ@mail.gmail.com>
Message-ID: <CA+E+eSCNbkraRcEsnR7ReReQT600FnJoaPRmNoTxETwCgobytQ@mail.gmail.com>
Subject: Re: [PATCH v2 14/19] RFC: accel/tcg: Support split-rwx for darwin/iOS
 with vm_remap
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=209.85.166.195; envelope-from=osy86dev@gmail.com;
 helo=mail-il1-f195.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/31 21:42:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There's a compiler warning:

warning: incompatible pointer to integer conversion assigning to
'mach_vm_address_t' (aka 'unsigned long long') from 'void *'
[-Wint-conversion]
    buf_rw = tcg_ctx->code_gen_buffer;

I changed it to
    buf_rw = (mach_vm_address_t)tcg_ctx->code_gen_buffer;

Also, MAP_JIT doesn't work with the split mapping (it needs the same
entitlements that allows for RWX mapping) so I made the following
changes

@@ -1088,15 +1094,11 @@ static bool alloc_code_gen_buffer(size_t size,
int mirror, Error **errp)
     return true;
 }
 #else
-static bool alloc_code_gen_buffer_anon(size_t size, int prot, Error **errp)
+static bool alloc_code_gen_buffer_anon(size_t size, int prot, int
flags, Error **errp)
 {
-    int flags = MAP_PRIVATE | MAP_ANONYMOUS;
     void *buf;

-#ifdef CONFIG_DARWIN
-    /* Applicable to both iOS and macOS (Apple Silicon). */
-    flags |= MAP_JIT;
-#endif
+    flags |= MAP_PRIVATE | MAP_ANONYMOUS;

     buf = mmap(NULL, size, prot, flags, -1, 0);
     if (buf == MAP_FAILED) {
@@ -1211,7 +1213,7 @@ static bool
alloc_code_gen_buffer_mirror_vmremap(size_t size, Error **errp)
     vm_prot_t cur_prot, max_prot;

     /* Map the read-write portion via normal anon memory. */
-    if (!alloc_code_gen_buffer_anon(size, PROT_READ | PROT_WRITE, errp)) {
+    if (!alloc_code_gen_buffer_anon(size, PROT_READ | PROT_WRITE, 0, errp)) {
         return false;
     }

@@ -1263,6 +1265,8 @@ static bool alloc_code_gen_buffer_mirror(size_t
size, Error **errp)

 static bool alloc_code_gen_buffer(size_t size, int mirror, Error **errp)
 {
+    int flags = 0;
+
     if (mirror) {
         Error *local_err = NULL;
         if (alloc_code_gen_buffer_mirror(size, &local_err)) {
@@ -1283,8 +1287,11 @@ static bool alloc_code_gen_buffer(size_t size,
int mirror, Error **errp)
     /* The tcg interpreter does not need execute permission. */
     prot = PROT_READ | PROT_WRITE;
 #endif
+#ifdef CONFIG_DARWIN
+    flags |= MAP_JIT;
+#endif

-    return alloc_code_gen_buffer_anon(size, prot, errp);
+    return alloc_code_gen_buffer_anon(size, prot, flags, errp);
 }
 #endif /* USE_STATIC_CODE_GEN_BUFFER, WIN32, POSIX */

With this in addition to the iOS host patches, I was able to run it on
the iPad but am getting random crashes that I am continuing to debug.

-j

On Thu, Oct 29, 2020 at 5:49 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Cribbed from code posted by Joelle van Dyne <j@getutm.app>,
> and rearranged to a cleaner structure.  Completely untested.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/tcg/translate-all.c | 68 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 67 insertions(+), 1 deletion(-)
>
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 3e69ebd1d3..bf8263fdb4 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1093,6 +1093,11 @@ static bool alloc_code_gen_buffer_anon(size_t size, int prot, Error **errp)
>      int flags = MAP_PRIVATE | MAP_ANONYMOUS;
>      void *buf;
>
> +#ifdef CONFIG_DARWIN
> +    /* Applicable to both iOS and macOS (Apple Silicon). */
> +    flags |= MAP_JIT;
> +#endif
> +
>      buf = mmap(NULL, size, prot, flags, -1, 0);
>      if (buf == MAP_FAILED) {
>          error_setg_errno(errp, errno,
> @@ -1182,13 +1187,74 @@ static bool alloc_code_gen_buffer_mirror_memfd(size_t size, Error **errp)
>      qemu_madvise(buf_rx, size, QEMU_MADV_HUGEPAGE);
>      return true;
>  }
> -#endif
> +#endif /* CONFIG_LINUX */
> +
> +#ifdef CONFIG_DARWIN
> +#include <mach/mach.h>
> +
> +extern kern_return_t mach_vm_remap(vm_map_t target_task,
> +                                   mach_vm_address_t *target_address,
> +                                   mach_vm_size_t size,
> +                                   mach_vm_offset_t mask,
> +                                   int flags,
> +                                   vm_map_t src_task,
> +                                   mach_vm_address_t src_address,
> +                                   boolean_t copy,
> +                                   vm_prot_t *cur_protection,
> +                                   vm_prot_t *max_protection,
> +                                   vm_inherit_t inheritance);
> +
> +static bool alloc_code_gen_buffer_mirror_vmremap(size_t size, Error **errp)
> +{
> +    kern_return_t ret;
> +    mach_vm_address_t buf_rw, buf_rx;
> +    vm_prot_t cur_prot, max_prot;
> +
> +    /* Map the read-write portion via normal anon memory. */
> +    if (!alloc_code_gen_buffer_anon(size, PROT_READ | PROT_WRITE, errp)) {
> +        return false;
> +    }
> +
> +    buf_rw = tcg_ctx->code_gen_buffer;
> +    buf_rx = 0;
> +    ret = mach_vm_remap(mach_task_self(),
> +                        &buf_rx,
> +                        size,
> +                        0,
> +                        VM_FLAGS_ANYWHERE | VM_FLAGS_RANDOM_ADDR,
> +                        mach_task_self(),
> +                        buf_rw,
> +                        false,
> +                        &cur_prot,
> +                        &max_prot,
> +                        VM_INHERIT_NONE);
> +    if (ret != KERN_SUCCESS) {
> +        /* TODO: Convert "ret" to a human readable error message. */
> +        error_setg(errp, "vm_remap for jit mirror failed");
> +        munmap((void *)buf_rw, size);
> +        return false;
> +    }
> +
> +    if (mprotect((void *)buf_rx, size, PROT_READ | PROT_EXEC) != 0) {
> +        error_setg_errno(errp, errno, "mprotect for jit mirror");
> +        munmap((void *)buf_rx, size);
> +        munmap((void *)buf_rw, size);
> +        return false;
> +    }
> +
> +    tcg_rx_mirror_diff = buf_rx - buf_rw;
> +    return true;
> +}
> +#endif /* CONFIG_DARWIN */
>
>  static bool alloc_code_gen_buffer_mirror(size_t size, Error **errp)
>  {
>      if (TCG_TARGET_SUPPORT_MIRROR) {
>  #ifdef CONFIG_LINUX
>          return alloc_code_gen_buffer_mirror_memfd(size, errp);
> +#endif
> +#ifdef CONFIG_DARWIN
> +        return alloc_code_gen_buffer_mirror_vmremap(size, errp);
>  #endif
>      }
>      error_setg(errp, "jit split-rwx not supported");
> --
> 2.25.1
>

