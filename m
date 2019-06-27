Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9A8C48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 17:47:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DA552086D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 17:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKCkLQg/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DA552086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgYUq-0004KZ-F7
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 13:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37495)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <fintelia@gmail.com>) id 1hgYS5-0002O6-Lp
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 13:44:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fintelia@gmail.com>) id 1hgYS3-0003J2-OP
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 13:44:53 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:39891)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <fintelia@gmail.com>)
 id 1hgYRt-00035Y-C2; Thu, 27 Jun 2019 13:44:42 -0400
Received: by mail-lj1-x241.google.com with SMTP id v18so3239990ljh.6;
 Thu, 27 Jun 2019 10:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0qJOU4T9A+Rgo+KUWUOXYaNJYMQ+KH3leoUF1qgEo/8=;
 b=gKCkLQg/+PShoplCFDLy0X9iaLC2OCi3K56QnXinjkOoLFoGJ7K+hptYhrHMLbd9UM
 3euNXo4ZLxzFzvDBZygC9PioJZzs1mBl9Giq+VUeidnYNg/1zaFbMt/JZKar5pqTI0E2
 IH/0kwdU4BTiSZqUzRPexi+UtHOqwMW0bXd3e/L88wMyihPZoo+O51ewgqTkUCEiaFCh
 G2n7Z2j8vzV8pNlIdQIagpCVm4i4VZMRVjuUenmozowig3ohZmrL77QYwy3Q4zqxb0Xb
 ozcAOUejVZUOxFfkY3xAVpeh/c8o8w88kYDNl3WVuP/uJs0//0jJrn8OhOLxAOybwXVY
 wwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0qJOU4T9A+Rgo+KUWUOXYaNJYMQ+KH3leoUF1qgEo/8=;
 b=F1CtT1X2XZbuiPitx/fAYwKRXbG1bDYyXlvrdkFB02JyDSbEyOuCmpmi6P3pHFv8hy
 xaij321zT2kRIHgwgWlnoHdp3ysVniUfDGgLgMa3dZj+CC8sLIQwSRIvAClS5e58aFX1
 3X/Ii2rzdcfJk19V4gID8ehJUKI6JHuxUr7pvny2VsHXnakbnxHTQpWRkPQKe1F8F0iZ
 j4QRl06gNdizbS2jyKBW72IeSRD70wHoVM9NhgbL5cx5oJbKvmkM51aYaqtRVLOfvNcr
 HbyMYr0Zoss6hFxvEG6rFVw+TExsnOjTmT/nlbLDrzaX1piEhqhiRthRAm5X0vBgLbKh
 bJxw==
X-Gm-Message-State: APjAAAUb7ZMX+2thmtCYstmT6mteijs/Peth82ykD1Wf6OEu8hFT/bLI
 RLs93eg9t9YTSDqpjeLU9bj9O2/yAqgk3CGzJBc=
X-Google-Smtp-Source: APXvYqzVhVvV7KdV7YJydYeWk9vSo1O5VS+ZDj/VodpS1pL3jdugrAefpf4Er2frOLWs5h0ZDsX356z//YDFuEGzMW4=
X-Received: by 2002:a2e:9a82:: with SMTP id p2mr3510779lji.64.1561657477249;
 Thu, 27 Jun 2019 10:44:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190627152011.18686-1-palmer@sifive.com>
 <20190627152011.18686-11-palmer@sifive.com>
In-Reply-To: <20190627152011.18686-11-palmer@sifive.com>
From: Jonathan Behrens <fintelia@gmail.com>
Date: Thu, 27 Jun 2019 13:44:06 -0400
Message-ID: <CANnJOVF3F_k1LpSYp8OdxSx6LtQR5p-XR5fMKCsXg_0pxySg+Q@mail.gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [Qemu-riscv] [PULL 10/34] RISC-V: Fix a PMP check
 with the correct access size
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
 Hesham Almatary <Hesham.Almatary@cl.cam.ac.uk>,
 Alistair Francis <alistair.francis@wdc.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I think this patch is slightly incorrect. If the PMP region is valid for
the size of the access, but not the rest of the page then a few lines down
in this function the entire page should not be placed into the TLB. Instead
only the portion of the page that passed the access check should be
included. To give an example of where this goes wrong, in the code below
access to address 0x90000008 should always fail due to PMP rules, but if
the TLB has already been primed by loading the (allowed) address 0x90000000
then no fault will be triggered. Notably, this code also executes
improperly without the patch because the first `ld` instruction traps when
it shouldn't.

  li t0, 0x0000000024000000 // region[0]: 0x90000000..0x90000007
  csrw pmpaddr0, t0

  li t0, 0x00000000240001FF // region[1]: 0x90000000..0x90000fff
  csrw pmpaddr1, t0

  li t0, 0x1F0000000000989F // cfg[0] = LXRW, cfg[1] = L
  csrw pmpcfg0, t0

  sfence.vma

  li t0, 0x90000000
  ld s0, 0(t0)
  ld s1, 8(t0) // NO TRAP: address is incorrectly in TLB!

  sfence.vma
  ld s1, 8(t0) // TRAP: TLB has been flushed!

I think that the proper fix would be to first do a PMP check for the full
PAGE_SIZE and execute normally if it passes. Then in the event the full
page fails, there could be a more granular PMP check with only the accessed
region inserted as an entry in the TLB.

Unrelated question: should I be sending "Reviewed By" lines if I read
through patches that seem reasonable? Or there some formal process I'd have
to go through first to be approved?

Jonathan

On Thu, Jun 27, 2019 at 11:43 AM Palmer Dabbelt <palmer@sifive.com> wrote:

> From: Hesham Almatary <Hesham.Almatary@cl.cam.ac.uk>
>
> The PMP check should be of the memory access size rather
> than TARGET_PAGE_SIZE.
>
> Signed-off-by: Hesham Almatary <Hesham.Almatary@cl.cam.ac.uk>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> ---
>  target/riscv/cpu_helper.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 66be83210f11..e1b079e69c60 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -452,8 +452,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address,
> int size,
>
>      if (riscv_feature(env, RISCV_FEATURE_PMP) &&
>          (ret == TRANSLATE_SUCCESS) &&
> -        !pmp_hart_has_privs(env, pa, TARGET_PAGE_SIZE, 1 << access_type,
> -        mode)) {
> +        !pmp_hart_has_privs(env, pa, size, 1 << access_type, mode)) {
>          ret = TRANSLATE_PMP_FAIL;
>      }
>      if (ret == TRANSLATE_PMP_FAIL) {
> --
> 2.21.0
>
>
>
