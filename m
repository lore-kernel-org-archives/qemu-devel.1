Return-Path: <SRS0=0Zkw=4R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A984C3F2D2
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 01:52:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6948F246A8
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 01:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c7UWjc1Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6948F246A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7rIr-0004lw-Jn
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 20:52:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuanzi@google.com>) id 1j7qEE-0007CV-1b
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 19:43:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuanzi@google.com>) id 1j7qEC-0000h9-Pb
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 19:43:37 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:46836)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuanzi@google.com>) id 1j7qEC-0000gn-JD
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 19:43:36 -0500
Received: by mail-oi1-x243.google.com with SMTP id a22so4638951oid.13
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 16:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=W7nuvaWsjXLJMeKbo1frRq/4Vd8hFCnRBBwkhk29YBw=;
 b=c7UWjc1YmtIzGTJA7Gb+c4293IHg78xKaMq3VhFKU/W8+Zta/i//sEGfTYfFZQe4dL
 ToQPetoVicGpsP9cTc1xzkHZe8DCV1W88+A5/n8I84rZ5JJhx5tuZse0wx19PjEWN5gA
 zP5JUAKptuhzJyN/Lna3BDD+tSslAxphzxUqyv3x47abfGibMy8SfhtVrmoilxQHaOJI
 In6Zr2qxm2gz3YHbXmEulZ67GqMHXsCyq6954Ma2/dodFfnc5L4rWIp/iOcQcRbWso4d
 uTuyMnTnZIW6PhhZ3iS3S5TdOwPWm398cWeTG+jQv9I3IWQUFYMqCtaIrBnffiecq2qI
 KuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=W7nuvaWsjXLJMeKbo1frRq/4Vd8hFCnRBBwkhk29YBw=;
 b=pC4x3vf55gEZ1JbXQDv6cROUSUm4Q0FMtH8FGB4UY9UYr5hUgEv3//i5u3Cqy7qwum
 Y6+g2eR/8DSo9meW/om5I8uSK34YUbuL/hkEkp/gn0J5uCk/ATbwsVXpFzjQwLT+s9O0
 RZcxOFeJ54okDZ7hDFRJyCxJ1UlY/dRVR5jLwRO0207WssxJ50jQjeeKchsBk0MBdgP1
 1mxXOWOJWXMOWc0gcZHyMSfkcdjll0oaNeruus1f/ea31NWcqpcjIKukYTMasb1+pI89
 rFidUHMHCZsQ1P8c+SJ9gH1zBiObSNOgYWBlzTWbcphgAN7ITgq1DRsk42pRe9TYazy7
 pzZg==
X-Gm-Message-State: APjAAAVt0XfY4xbLk0Jrq0KQdMBCd38genyjxp7pXmD47REmjy7WQEMP
 vXMViCwfqJbKiSxsbojCNGEmVmPHHrHf5Dn3RG4VcAJciNg=
X-Google-Smtp-Source: APXvYqxOzoQ7LK8bnCVWMy7mVU078AjfjnK6aVEZu8J1rhMG3tFIUP9Q93bJO8bLeQT+8fn5E9rT8o3B8YihktGYiK0=
X-Received: by 2002:aca:62c4:: with SMTP id w187mr5057038oib.38.1582937015392; 
 Fri, 28 Feb 2020 16:43:35 -0800 (PST)
MIME-Version: 1.0
References: <20200222010925.32858-1-yuanzi@google.com>
In-Reply-To: <20200222010925.32858-1-yuanzi@google.com>
From: Lirong Yuan <yuanzi@google.com>
Date: Fri, 28 Feb 2020 16:43:24 -0800
Message-ID: <CADjx4CKoSuu2zWn7BRhpxLL3TaimR7fX99u_r41egctwA1LVTQ@mail.gmail.com>
Subject: Re: [PATCH] linux-user: Add an argument QEMU_MMAP_BASE to set custom
 mmap base address in qemu user mode
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
X-Mailman-Approved-At: Fri, 28 Feb 2020 20:51:37 -0500
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 21, 2020 at 5:09 PM Lirong Yuan <yuanzi@google.com> wrote:
>
> This change allows us to set custom base address for guest programs. It is needed to allow qemu to work with Thread Sanitizer (TSan), which has specific boundary definitions for memory mappings on different platforms:
> https://github.com/llvm/llvm-project/blob/master/compiler-rt/lib/tsan/rtl/tsan_platform.h
>
> Signed-off-by: Lirong Yuan <yuanzi@google.com>
> ---
>  linux-user/main.c | 12 ++++++++++++
>  linux-user/mmap.c |  3 ++-
>  linux-user/qemu.h |  5 +++++
>  3 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/linux-user/main.c b/linux-user/main.c
> index fba833aac9..c01af6bfee 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -336,6 +336,16 @@ static void handle_arg_guest_base(const char *arg)
>      have_guest_base = 1;
>  }
>
> +static void handle_arg_mmap_base(const char *arg)
> +{
> +    int err = qemu_strtoul(arg, NULL, 0, &mmap_base);
> +    if (err) {
> +        fprintf(stderr, "Invalid mmap_base: %s, err: %d\n", arg, err);
> +        exit(EXIT_FAILURE);
> +    }
> +    mmap_next_start = mmap_base;
> +}
> +
>  static void handle_arg_reserved_va(const char *arg)
>  {
>      char *p;
> @@ -440,6 +450,8 @@ static const struct qemu_argument arg_table[] = {
>       "uname",      "set qemu uname release string to 'uname'"},
>      {"B",          "QEMU_GUEST_BASE",  true,  handle_arg_guest_base,
>       "address",    "set guest_base address to 'address'"},
> +    {"mmap_base",  "QEMU_MMAP_BASE",   true,  handle_arg_mmap_base,
> +     "",           "begin allocating guest pages at this host address"},
>      {"R",          "QEMU_RESERVED_VA", true,  handle_arg_reserved_va,
>       "size",       "reserve 'size' bytes for guest virtual address space"},
>      {"d",          "QEMU_LOG",         true,  handle_arg_log,
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index 8685f02e7e..3f35543acf 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -189,6 +189,7 @@ static int mmap_frag(abi_ulong real_start,
>  # define TASK_UNMAPPED_BASE  0x40000000
>  #endif
>  abi_ulong mmap_next_start = TASK_UNMAPPED_BASE;
> +abi_ulong mmap_base = TASK_UNMAPPED_BASE;
>
>  unsigned long last_brk;
>
> @@ -299,7 +300,7 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong align)
>
>              if ((addr & (align - 1)) == 0) {
>                  /* Success.  */
> -                if (start == mmap_next_start && addr >= TASK_UNMAPPED_BASE) {
> +                if (start == mmap_next_start && addr >= mmap_base) {
>                      mmap_next_start = addr + size;
>                  }
>                  return addr;
> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
> index 560a68090e..83c00cfea2 100644
> --- a/linux-user/qemu.h
> +++ b/linux-user/qemu.h
> @@ -161,6 +161,11 @@ void task_settid(TaskState *);
>  void stop_all_tasks(void);
>  extern const char *qemu_uname_release;
>  extern unsigned long mmap_min_addr;
> +/*
> + * mmap_base is minimum address to use when allocating guest pages. All guest
> + * pages will be allocated at this (guest) address or higher addresses.
> + */
> +extern abi_ulong mmap_base;
>
>  /* ??? See if we can avoid exposing so much of the loader internals.  */
>
> --
> 2.25.0.265.gbab2e86ba0-goog
>

Friendly ping~

Link to the page for the patch on patchwork:
http://patchwork.ozlabs.org/patch/1242370/

