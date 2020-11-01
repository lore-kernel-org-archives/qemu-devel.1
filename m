Return-Path: <SRS0=Dm/C=EH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCCAC2D0A3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 21:24:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EA38208A9
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 21:24:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EA38208A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZKq0-0003rf-9T
	for qemu-devel@archiver.kernel.org; Sun, 01 Nov 2020 16:24:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kZKdE-0003ia-CL
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 16:11:20 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:33872)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kZKdC-0006Wv-9D
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 16:11:19 -0500
Received: by mail-io1-f65.google.com with SMTP id z5so13050087iob.1
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2020 13:11:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5L5v3pEfYK7064mC1fv44rrn+W6tYPiByrmYV5fWSPQ=;
 b=Q5a8NV/QIfTb2v2HK9xbSd0DdIZrW5hb6CckedibWJy3y7AbY/a7JS5/yhhwl/gHRW
 IrFEQHfGmJOjTZuvNQG/Zu6U5WYNyVdcHSQvHIDvxRIFqxqczRciScnTvajDf2KabcyB
 rLIWtc3lmjaWdMzpeKQV++8p64SMpiAvzh+UUCUNbgycF93/Kku57Q1dwOXU1gdD8a+Q
 CNcyGbre1umscTPV+c7qkHBdXYzvPryRJQpfYnXTlEhreLEL2mOEnOoDJr7ukIwD6LQZ
 ato3IMFt4BiOS6laaxxYF5GiOFwWMBbLOSeWn3aQjlM65aNlgLyPEt+sZRPETcOZ3z5l
 009A==
X-Gm-Message-State: AOAM532XdRN3qpCFt5bBDeKOo3SmaRqWpVyC43sm7ABOy5FBk2cpF5Ok
 RK5GeyOfKLV2cf0FUpuQiDME6MYJ4Zo=
X-Google-Smtp-Source: ABdhPJy2XDBgsgQ1qij7dXkXZMsNBZ6koItBiLII8nWT8SH28FlAGA75g/tGq6vKP+WOgjUjgeTREA==
X-Received: by 2002:a5e:c017:: with SMTP id u23mr8254543iol.81.1604265077169; 
 Sun, 01 Nov 2020 13:11:17 -0800 (PST)
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com.
 [209.85.166.179])
 by smtp.gmail.com with ESMTPSA id w81sm9918391ilk.38.2020.11.01.13.11.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Nov 2020 13:11:16 -0800 (PST)
Received: by mail-il1-f179.google.com with SMTP id c11so11219718iln.9
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2020 13:11:16 -0800 (PST)
X-Received: by 2002:a92:ac0e:: with SMTP id r14mr9118863ilh.197.1604265076545; 
 Sun, 01 Nov 2020 13:11:16 -0800 (PST)
MIME-Version: 1.0
References: <20201030004921.721096-1-richard.henderson@linaro.org>
 <20201030004921.721096-15-richard.henderson@linaro.org>
 <CA+E+eSCNbkraRcEsnR7ReReQT600FnJoaPRmNoTxETwCgobytQ@mail.gmail.com>
In-Reply-To: <CA+E+eSCNbkraRcEsnR7ReReQT600FnJoaPRmNoTxETwCgobytQ@mail.gmail.com>
From: Joelle van Dyne <j@getutm.app>
Date: Sun, 1 Nov 2020 13:11:05 -0800
X-Gmail-Original-Message-ID: <CA+E+eSCFTZy6=Emj=L0=z7rMsZ6NbjXJCt=fE-G2ic1H06De1A@mail.gmail.com>
Message-ID: <CA+E+eSCFTZy6=Emj=L0=z7rMsZ6NbjXJCt=fE-G2ic1H06De1A@mail.gmail.com>
Subject: Re: [PATCH v2 14/19] RFC: accel/tcg: Support split-rwx for darwin/iOS
 with vm_remap
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=209.85.166.65; envelope-from=osy86dev@gmail.com;
 helo=mail-io1-f65.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/01 16:11:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

Another change I made in alloc_code_gen_buffer_mirror_vmremap (in my
patch as well) is to remove VM_FLAGS_RANDOM_ADDR. This was causing a
rare out of memory error whenever the random address it chooses is too
high.

-j

On Sat, Oct 31, 2020 at 6:42 PM Joelle van Dyne <j@getutm.app> wrote:
>
> There's a compiler warning:
>
> warning: incompatible pointer to integer conversion assigning to
> 'mach_vm_address_t' (aka 'unsigned long long') from 'void *'
> [-Wint-conversion]
>     buf_rw = tcg_ctx->code_gen_buffer;
>
> I changed it to
>     buf_rw = (mach_vm_address_t)tcg_ctx->code_gen_buffer;
>
> Also, MAP_JIT doesn't work with the split mapping (it needs the same
> entitlements that allows for RWX mapping) so I made the following
> changes
>
> @@ -1088,15 +1094,11 @@ static bool alloc_code_gen_buffer(size_t size,
> int mirror, Error **errp)
>      return true;
>  }
>  #else
> -static bool alloc_code_gen_buffer_anon(size_t size, int prot, Error **errp)
> +static bool alloc_code_gen_buffer_anon(size_t size, int prot, int
> flags, Error **errp)
>  {
> -    int flags = MAP_PRIVATE | MAP_ANONYMOUS;
>      void *buf;
>
> -#ifdef CONFIG_DARWIN
> -    /* Applicable to both iOS and macOS (Apple Silicon). */
> -    flags |= MAP_JIT;
> -#endif
> +    flags |= MAP_PRIVATE | MAP_ANONYMOUS;
>
>      buf = mmap(NULL, size, prot, flags, -1, 0);
>      if (buf == MAP_FAILED) {
> @@ -1211,7 +1213,7 @@ static bool
> alloc_code_gen_buffer_mirror_vmremap(size_t size, Error **errp)
>      vm_prot_t cur_prot, max_prot;
>
>      /* Map the read-write portion via normal anon memory. */
> -    if (!alloc_code_gen_buffer_anon(size, PROT_READ | PROT_WRITE, errp)) {
> +    if (!alloc_code_gen_buffer_anon(size, PROT_READ | PROT_WRITE, 0, errp)) {
>          return false;
>      }
>
> @@ -1263,6 +1265,8 @@ static bool alloc_code_gen_buffer_mirror(size_t
> size, Error **errp)
>
>  static bool alloc_code_gen_buffer(size_t size, int mirror, Error **errp)
>  {
> +    int flags = 0;
> +
>      if (mirror) {
>          Error *local_err = NULL;
>          if (alloc_code_gen_buffer_mirror(size, &local_err)) {
> @@ -1283,8 +1287,11 @@ static bool alloc_code_gen_buffer(size_t size,
> int mirror, Error **errp)
>      /* The tcg interpreter does not need execute permission. */
>      prot = PROT_READ | PROT_WRITE;
>  #endif
> +#ifdef CONFIG_DARWIN
> +    flags |= MAP_JIT;
> +#endif
>
> -    return alloc_code_gen_buffer_anon(size, prot, errp);
> +    return alloc_code_gen_buffer_anon(size, prot, flags, errp);
>  }
>  #endif /* USE_STATIC_CODE_GEN_BUFFER, WIN32, POSIX */
>
> With this in addition to the iOS host patches, I was able to run it on
> the iPad but am getting random crashes that I am continuing to debug.
>
> -j
>
> On Thu, Oct 29, 2020 at 5:49 PM Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > Cribbed from code posted by Joelle van Dyne <j@getutm.app>,
> > and rearranged to a cleaner structure.  Completely untested.
> >
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> >  accel/tcg/translate-all.c | 68 ++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 67 insertions(+), 1 deletion(-)
> >
> > diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> > index 3e69ebd1d3..bf8263fdb4 100644
> > --- a/accel/tcg/translate-all.c
> > +++ b/accel/tcg/translate-all.c
> > @@ -1093,6 +1093,11 @@ static bool alloc_code_gen_buffer_anon(size_t size, int prot, Error **errp)
> >      int flags = MAP_PRIVATE | MAP_ANONYMOUS;
> >      void *buf;
> >
> > +#ifdef CONFIG_DARWIN
> > +    /* Applicable to both iOS and macOS (Apple Silicon). */
> > +    flags |= MAP_JIT;
> > +#endif
> > +
> >      buf = mmap(NULL, size, prot, flags, -1, 0);
> >      if (buf == MAP_FAILED) {
> >          error_setg_errno(errp, errno,
> > @@ -1182,13 +1187,74 @@ static bool alloc_code_gen_buffer_mirror_memfd(size_t size, Error **errp)
> >      qemu_madvise(buf_rx, size, QEMU_MADV_HUGEPAGE);
> >      return true;
> >  }
> > -#endif
> > +#endif /* CONFIG_LINUX */
> > +
> > +#ifdef CONFIG_DARWIN
> > +#include <mach/mach.h>
> > +
> > +extern kern_return_t mach_vm_remap(vm_map_t target_task,
> > +                                   mach_vm_address_t *target_address,
> > +                                   mach_vm_size_t size,
> > +                                   mach_vm_offset_t mask,
> > +                                   int flags,
> > +                                   vm_map_t src_task,
> > +                                   mach_vm_address_t src_address,
> > +                                   boolean_t copy,
> > +                                   vm_prot_t *cur_protection,
> > +                                   vm_prot_t *max_protection,
> > +                                   vm_inherit_t inheritance);
> > +
> > +static bool alloc_code_gen_buffer_mirror_vmremap(size_t size, Error **errp)
> > +{
> > +    kern_return_t ret;
> > +    mach_vm_address_t buf_rw, buf_rx;
> > +    vm_prot_t cur_prot, max_prot;
> > +
> > +    /* Map the read-write portion via normal anon memory. */
> > +    if (!alloc_code_gen_buffer_anon(size, PROT_READ | PROT_WRITE, errp)) {
> > +        return false;
> > +    }
> > +
> > +    buf_rw = tcg_ctx->code_gen_buffer;
> > +    buf_rx = 0;
> > +    ret = mach_vm_remap(mach_task_self(),
> > +                        &buf_rx,
> > +                        size,
> > +                        0,
> > +                        VM_FLAGS_ANYWHERE | VM_FLAGS_RANDOM_ADDR,
> > +                        mach_task_self(),
> > +                        buf_rw,
> > +                        false,
> > +                        &cur_prot,
> > +                        &max_prot,
> > +                        VM_INHERIT_NONE);
> > +    if (ret != KERN_SUCCESS) {
> > +        /* TODO: Convert "ret" to a human readable error message. */
> > +        error_setg(errp, "vm_remap for jit mirror failed");
> > +        munmap((void *)buf_rw, size);
> > +        return false;
> > +    }
> > +
> > +    if (mprotect((void *)buf_rx, size, PROT_READ | PROT_EXEC) != 0) {
> > +        error_setg_errno(errp, errno, "mprotect for jit mirror");
> > +        munmap((void *)buf_rx, size);
> > +        munmap((void *)buf_rw, size);
> > +        return false;
> > +    }
> > +
> > +    tcg_rx_mirror_diff = buf_rx - buf_rw;
> > +    return true;
> > +}
> > +#endif /* CONFIG_DARWIN */
> >
> >  static bool alloc_code_gen_buffer_mirror(size_t size, Error **errp)
> >  {
> >      if (TCG_TARGET_SUPPORT_MIRROR) {
> >  #ifdef CONFIG_LINUX
> >          return alloc_code_gen_buffer_mirror_memfd(size, errp);
> > +#endif
> > +#ifdef CONFIG_DARWIN
> > +        return alloc_code_gen_buffer_mirror_vmremap(size, errp);
> >  #endif
> >      }
> >      error_setg(errp, "jit split-rwx not supported");
> > --
> > 2.25.1
> >

