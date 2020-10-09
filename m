Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF871C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 07:17:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F8BA22244
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 07:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ghf4Hjyl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F8BA22244
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQmem-0007P1-1V
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 03:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kQmdT-0006ro-NK; Fri, 09 Oct 2020 03:16:16 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:43238)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kQmdN-0004v8-Am; Fri, 09 Oct 2020 03:16:15 -0400
Received: by mail-yb1-xb42.google.com with SMTP id n65so2766258ybg.10;
 Fri, 09 Oct 2020 00:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BoBqAmKxWIwTVBSQjzR2MvO5DNeQhNVblINghDND6eQ=;
 b=Ghf4HjylinUd0CuWtagt8NPab58sMJponcgZVm37MLWdbZDS1M6OaH8fqjp1GfSow6
 0Yinxlogix4LxxCDSeDAOmiQS2vVWEwjU0N8yD5yph8HoKjETBTrxlPKWTP3z5ZUz/2q
 JA4be3upzBlv/S28u/Ud4ZIvxRFziVoecB4qXwZ7hjFd2ZDM23rW8yrdCU8MZ2zL+fBh
 hmmTFcgPmscDjmzuVBCVXr1D60KuIQE1gA9AZU4M9yx1ybNdJaoloMb1a1Zq2KamBO+9
 7xE1a8iha4L551yv+lwh/ZekA3faTh/T1x5FaROiAYu/ljO0aKxnm7LI6uSOlJdIKyOe
 ORIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BoBqAmKxWIwTVBSQjzR2MvO5DNeQhNVblINghDND6eQ=;
 b=BzJc6/++a6st6PQqNAaWPLWWt7ERPIedd5lgYynUgfw0bWTjKvaQww4TWdN53xv1FT
 k3I5T0G9v8y6LYJ4k9tg5VtlBxgwzZuZ9qUDmaPTDHN7g1ji6p1EcGnOoOXw/tRJrxeJ
 Irj6hQKrEQw/mCxIzp4EQM3+UuD20jTF7pJgPHzIzhQWqC4g5fDwFkCbFj9naGQYmQic
 UOHVVVDf13QX/Y0MolcFsbJT4LZvvUpKjXekpw6x1tjquTPkAlGbrG51ZK15J1am7BAM
 ZAQg5TsWNgVlrNb7ZOgMlLH8/G7b/K6VQFagCOFs/KRTJTAcEyVy/KxuyQbyjbprxmew
 J8MA==
X-Gm-Message-State: AOAM533X3tKeY/nj8rOV5i8Ac/x+XFK5xUQATjmMDo/fKygQMMrRGE7T
 6IGckYYAWZocRb0dBRK1EzYAmJP7axPTWwumuHA=
X-Google-Smtp-Source: ABdhPJwjxJAT9HJzdZYdFPOqh9MfKtzmgIOuy4fLtCuwyQE048azDOO7Dw4bowURwyIBfiyU/LGw7SzVtyirTIefa+g=
X-Received: by 2002:a25:bb01:: with SMTP id z1mr17143529ybg.387.1602227767750; 
 Fri, 09 Oct 2020 00:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <20201009064449.2336-1-zhaolichang@huawei.com>
 <20201009064449.2336-4-zhaolichang@huawei.com>
In-Reply-To: <20201009064449.2336-4-zhaolichang@huawei.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 9 Oct 2020 15:15:56 +0800
Message-ID: <CAEUhbmXKmx+c3DtA2i4WzG3Hb5x+WPwMEB6dd1792gyqp2NSSA@mail.gmail.com>
Subject: Re: [PATCH V2 03/14] riscv/: fix some comment spelling errors
To: zhaolichang <zhaolichang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b42;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, David Edmondson <david.edmondson@oracle.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On Fri, Oct 9, 2020 at 2:55 PM zhaolichang <zhaolichang@huawei.com> wrote:
>
> I found that there are many spelling errors in the comments of qemu/target/riscv.
> I used spellcheck to check the spelling errors and found some errors in the folder.
>
> Signed-off-by: zhaolichang <zhaolichang@huawei.com>
> Reviewed-by: David Edmondson <david.edmondson@oracle.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu.c           | 2 +-
>  target/riscv/cpu_bits.h      | 2 +-
>  target/riscv/csr.c           | 6 +++---
>  target/riscv/vector_helper.c | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 0bbfd7f457..f40a0b26a3 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -472,7 +472,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>                      return;
>                  }
>              } else {
> -                qemu_log("vector verison is not specified, "
> +                qemu_log("vector version is not specified, "
>                          "use the default value v0.7.1\n");
>              }
>              set_vext_version(env, vext_version);
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index bd36062877..6e1155560b 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -536,7 +536,7 @@
>  /* Leaf page shift amount */
>  #define PGSHIFT             12
>
> -/* Default Reset Vector adress */
> +/* Default Reset Vector address */
>  #define DEFAULT_RSTVEC      0x1000
>
>  /* Exception causes */
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index aaef6c6f20..93e117020d 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -624,7 +624,7 @@ static int write_mcounteren(CPURISCVState *env, int csrno, target_ulong val)
>      return 0;
>  }
>
> -/* This regiser is replaced with CSR_MCOUNTINHIBIT in 1.11.0 */
> +/* This register is replaced with CSR_MCOUNTINHIBIT in 1.11.0 */
>  static int read_mscounteren(CPURISCVState *env, int csrno, target_ulong *val)
>  {
>      if (env->priv_ver < PRIV_VERSION_1_11_0) {
> @@ -634,7 +634,7 @@ static int read_mscounteren(CPURISCVState *env, int csrno, target_ulong *val)
>      return 0;
>  }
>
> -/* This regiser is replaced with CSR_MCOUNTINHIBIT in 1.11.0 */
> +/* This register is replaced with CSR_MCOUNTINHIBIT in 1.11.0 */
>  static int write_mscounteren(CPURISCVState *env, int csrno, target_ulong val)
>  {
>      if (env->priv_ver < PRIV_VERSION_1_11_0) {
> @@ -1278,7 +1278,7 @@ int riscv_csrrw(CPURISCVState *env, int csrno, target_ulong *ret_value,
>          !riscv_cpu_virt_enabled(env)) {
>          /*
>           * We are in S mode without virtualisation, therefore we are in HS Mode.
> -         * Add 1 to the effective privledge level to allow us to access the
> +         * Add 1 to the effective privilege level to allow us to access the
>           * Hypervisor CSRs.
>           */
>          effective_priv++;
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index a156573d28..fa89a6e6c1 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -709,7 +709,7 @@ typedef void vext_amo_noatomic_fn(void *vs3, target_ulong addr,
>                                    uint32_t wd, uint32_t idx, CPURISCVState *env,
>                                    uintptr_t retaddr);
>
> -/* no atomic opreation for vector atomic insructions */
> +/* no atomic operation for vector atomic insructions */

There is still one typo here: instructions

>  #define DO_SWAP(N, M) (M)
>  #define DO_AND(N, M)  (N & M)
>  #define DO_XOR(N, M)  (N ^ M)
> --

Regards,
Bin

