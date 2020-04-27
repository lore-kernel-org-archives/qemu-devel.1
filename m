Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5D5C4CECD
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 20:33:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48EB4206D4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 20:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrjfK5R6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48EB4206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60915 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTAR8-0001M0-F3
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 16:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51564)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jTAQ2-000090-93
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 16:31:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jTAQ1-0003fl-PH
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 16:31:58 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:39991)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jTAQ1-0003fW-C4
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 16:31:57 -0400
Received: by mail-il1-x144.google.com with SMTP id e8so18063974ilm.7
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 13:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=t9QkHlohjVzswOM4gFAcFrhaecvR1YRMYTqzfioKbLY=;
 b=HrjfK5R6wZ7+zmjoC7jt4DWElz68K0CrU4vDaqzWffNTet1RhL4m971WJS56YWgGPi
 cPVh13ty3Lhst340/E8yGF+pBS+Pfid0KWa+pMVS43GOnXRXfVWkDRXuDFbxmx1yd4KT
 XeWlstPNMouIgkodQA7+gwe8YzkfZ9npij8okyuFbJiU9od7GSK+S0Fsu7exjg4LWNnU
 k4WywobzxN+hHgakwucCzcqB1mQ4LJMvy2gHT41sdDBDePekw+HHO3r5C4yWETXsHpMI
 vXxlqEYYZ07OuIa4WS76dDGGn++fi5u0ynz4QlAGMPKCG74LWcD3BAerPgGUdJB861Hb
 V0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=t9QkHlohjVzswOM4gFAcFrhaecvR1YRMYTqzfioKbLY=;
 b=t0nFmk1m0IqYxlOw55QHAQArTrzsmrx7JV7bWRfQuWJYdJnxT09T+T7uj7GIVRMp6U
 DOP7kMKtHpfOqn7Lq23h2p+XOJoPWa65agG5BlUveGaAKmDugd2phEIq90Lik7bTp20t
 FJ3uE9EZiCXxOxip2nZgv276vE/QJaSnD7caA8tD8cDBTlMduE0LWq+iNBXjFOLAjpX0
 I828nF7a0xuNTYZ3EyNDXD9aS6Y12Wos8GJkFW0f+omQunFvnmahvLFDid/oVixY2OYK
 3h60NYnkqy5JAULSMCRjLSCquTJu4poyv4enq3HrR6wVjiIDQc0By75fT27E++2Vk5qB
 Fq9g==
X-Gm-Message-State: AGi0PuY8LcX0UOV/c4ZpttQGbA+3NNuYdghfph8IlOOJdiHZUxmFK9Hr
 RN0fvBzbNHZ90jbKFADPeZeGmFh1aV7TaSKxm1k=
X-Google-Smtp-Source: APiQypIwMjdIvDKNdefgxmxIwVy8SARL9Kt/faOdn7mjA7pBw5IMWEr13N1pfkkTPJw0n3CCBb3R39xpvlaLTvI4gmw=
X-Received: by 2002:a92:aa07:: with SMTP id j7mr3811682ili.40.1588019516370;
 Mon, 27 Apr 2020 13:31:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200427201120.1500504-1-amanieu@gmail.com>
In-Reply-To: <20200427201120.1500504-1-amanieu@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 27 Apr 2020 13:23:18 -0700
Message-ID: <CAKmqyKOnG6Q2g0KGcPRO51UKuDiCaXu_Z3_Une2SM24obrnEew@mail.gmail.com>
Subject: Re: [PATCH] linux-user/riscv: Fix target_ucontext and
 target_sigcontext
To: "Amanieu d'Antras" <amanieu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::144
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Apr 27, 2020 at 1:11 PM Amanieu d'Antras <amanieu@gmail.com> wrote:
>
> These now match the field layout used by the kernel.
>
> Signed-off-by: Amanieu d'Antras <amanieu@gmail.com>

Thanks for the patch!

Unfortunately this fixed has already been applied to the RISC-V tree
(https://github.com/alistair23/qemu/tree/riscv-to-apply) and will be
merged once the 5.1 development window opens up.

Alistair

> ---
>  linux-user/riscv/signal.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/linux-user/riscv/signal.c b/linux-user/riscv/signal.c
> index 83ecc6f799..2b15e32a7b 100644
> --- a/linux-user/riscv/signal.c
> +++ b/linux-user/riscv/signal.c
> @@ -32,7 +32,7 @@
>  struct target_sigcontext {
>      abi_long pc;
>      abi_long gpr[31]; /* x0 is not present, so all offsets must be -1 */
> -    uint64_t fpr[32];
> +    uint64_t fpr[32] __attribute__((aligned(16)));
>      uint32_t fcsr;
>  }; /* cf. riscv-linux:arch/riscv/include/uapi/asm/ptrace.h */
>
> @@ -40,8 +40,9 @@ struct target_ucontext {
>      unsigned long uc_flags;
>      struct target_ucontext *uc_link;
>      target_stack_t uc_stack;
> -    struct target_sigcontext uc_mcontext;
>      target_sigset_t uc_sigmask;
> +    char __unused[1024 / 8 - sizeof(target_sigset_t)];
> +    struct target_sigcontext uc_mcontext;
>  };
>
>  struct target_rt_sigframe {
> --
> 2.26.1
>
>

