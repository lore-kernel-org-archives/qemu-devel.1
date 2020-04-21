Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED797C54FCC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 19:30:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4408206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 19:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeboyHPW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4408206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQybC-0003SC-KZ
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 15:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54038)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jQyaJ-0002pO-FF
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 15:29:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jQyaJ-0000dC-3I
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 15:29:31 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:46965)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jQyaH-0000bb-E5; Tue, 21 Apr 2020 15:29:29 -0400
Received: by mail-il1-x143.google.com with SMTP id x2so13182767ilp.13;
 Tue, 21 Apr 2020 12:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RX/aPZ+fHoPj+Zbkc6eE+LublHh2w6galhL9tc5FP1o=;
 b=FeboyHPWJU3pvBob5ljHXUS2ifdtlzu97efc5aIbwTkAFxLvDe3msHKkSggRxKr4+Y
 g6GwWpL3KJxa4X+ClUDfC/P+B271qR7mjVtVx8UO0Mr+HurDqoYMfKApxAk2ubUjg9uA
 DB3yBaJ9ubEi3oX/iD+XvJMr3gZTnllx5TkUJnDGBVYo6fgCcmxkf41+HCe6uAX4FXid
 LL2N+4sg0OJwKKrP5ycs6WcUcgEaFMJLxxZZeS5gSiMGXe/+94jw24HMAB48yI66N7f4
 ig7t3zJP7jecOotIa/gLW0f7f2YljCCI3z/Wy//q/Fci6pwjSWwJMuPnRymQf466oLad
 G/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RX/aPZ+fHoPj+Zbkc6eE+LublHh2w6galhL9tc5FP1o=;
 b=Ya26g01YogpyB82bmC/7T0uG9eorNELW9FSRD/WK5cgzgpfJQ/J4DfCapPPRxL6oFe
 qYTXgzDBLADw/jwLwOOrcAyvF5qS7B1NxVqR5R0o8JZtIbs9P7lsU5IlkLIesCPMkDDn
 vW0mD85d6dKICkYnI1IfJJhqujb2MVyAU+KMEuPudvl/EbeBDqJTpq81Ut/t6gfiX3h4
 N5eYuzLVWYtpoRLK1x73M1D1j303XZJCpz7+wxfkb/UsKtN/LIeI7j8Qk33c0Py/nu9B
 F5+Y5iWuuzZnD/PmYE7REywhCl1iVCFkwKAxRqoWHC9lOmCPjvQPH6FfKOJF91WG4gcD
 LFnw==
X-Gm-Message-State: AGi0PuaAexiwsuRpEAmpS2mIC+huXMcKJQwHxwgKqUtv+WrGLkAH8jTZ
 Xfp5kR8VATin5yShwHU+JVs8K+BcKpdFuwbBfJQ=
X-Google-Smtp-Source: APiQypKu9h4VaafNUPmM9Z3ueR8iNro9/MjgQ9yXEHOK7ZbBeBhBNWEO7HHy2bvrvR7WclSlHHUyxm7k/EBBqu+2YCk=
X-Received: by 2002:a92:bbd8:: with SMTP id x85mr23326894ilk.40.1587497367393; 
 Tue, 21 Apr 2020 12:29:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200421191001.92644-1-palmerdabbelt@google.com>
 <20200421191001.92644-2-palmerdabbelt@google.com>
In-Reply-To: <20200421191001.92644-2-palmerdabbelt@google.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 21 Apr 2020 12:20:58 -0700
Message-ID: <CAKmqyKM=mYL7U+SkzdDc6BuXFPC55aaWPnhKJbF5cqumNqSiBw@mail.gmail.com>
Subject: Re: [PULL 1/6] target/riscv: Don't set write permissions on dirty PTEs
To: Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::143
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 21, 2020 at 12:19 PM Palmer Dabbelt
<palmerdabbelt@google.com> wrote:
>
> From: Alistair Francis <alistair.francis@wdc.com>
>
> The RISC-V spec specifies that when a write happens and the D bit is
> clear the implementation will set the bit in the PTE. It does not
> describe that the PTE being dirty means that we should provide write
> access. This patch removes the write access granted to pages when the
> dirty bit is set.
>
> Following the prot variable we can see that it affects all of these
> functions:
>  riscv_cpu_tlb_fill()
>    tlb_set_page()
>      tlb_set_page_with_attrs()
>        address_space_translate_for_iotlb()
>
> Looking at the cputlb code (tlb_set_page_with_attrs() and
> address_space_translate_for_iotlb()) it looks like the main affect of
> setting write permissions is that the page can be marked as TLB_NOTDIRTY.
>
> I don't see any other impacts (related to the dirty bit) for giving a
> page write permissions.
>
> Setting write permission on dirty PTEs results in userspace inside a
> Hypervisor guest (VU) becoming corrupted. This appears to be because it
> ends up with write permission in the second stage translation in cases
> where we aren't doing a store.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>

This commit is wrong. Please do not apply this.

Alistair

> ---
>  target/riscv/cpu_helper.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index d3ba9efb02..e2da2a4787 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -572,10 +572,8 @@ restart:
>              if ((pte & PTE_X)) {
>                  *prot |= PAGE_EXEC;
>              }
> -            /* add write permission on stores or if the page is already dirty,
> -               so that we TLB miss on later writes to update the dirty bit */
> -            if ((pte & PTE_W) &&
> -                    (access_type == MMU_DATA_STORE || (pte & PTE_D))) {
> +            /* add write permission on stores */
> +            if ((pte & PTE_W) && (access_type == MMU_DATA_STORE)) {
>                  *prot |= PAGE_WRITE;
>              }
>              return TRANSLATE_SUCCESS;
> --
> 2.26.1.301.g55bc3eb7cb9-goog
>
>

