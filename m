Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0894DC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 17:29:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3A5320767
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 17:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0it/BS5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3A5320767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtaMS-0006YR-1Y
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 13:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jtaLu-00067e-SJ; Thu, 09 Jul 2020 13:28:54 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:43063)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jtaLt-0005oq-Ax; Thu, 09 Jul 2020 13:28:54 -0400
Received: by mail-io1-xd41.google.com with SMTP id k23so3137661iom.10;
 Thu, 09 Jul 2020 10:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=3eprv0vHNk1cbTgErogcMPWD9Mv/u0rtXsYYUQqfdws=;
 b=W0it/BS56cMeA2rGFhIKK+swKAhyEp0Rpc6cSDoVTUnCiio8ujrRtxIxyJzZJNLl9F
 q/qa6+hDqvbK0mtfgISerCPSIwA9iybdI8oxDfvsLJdfDcqz5LtJlMS4D/MLqn3MbL/N
 gt+ORKa0T4BcueAkl+0U2wt1OTjGdiW75EifMuo3J3oYAXoaxbADkPeWqfzgHNTcTcUd
 QZA0QIzZf0tH6LQQg1XMtng5wtVhLwUEPxsBGttaKfXKConD6KJitiJ54Bt6bK6UV9tK
 Dff6gs3RN9UYKAyBGWi7xRyMGpdqCZ0Dlhx0BNvnREkOXisi4SpM25UJR6pB0as1OcT9
 dt4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3eprv0vHNk1cbTgErogcMPWD9Mv/u0rtXsYYUQqfdws=;
 b=rln10qOLUJK1RWOp9S/z8xllryYk0rXFeegqXDyWDOHa3pkJ0L9JFYYIKlAdlDQgqZ
 bXISrl4HZ4sg09qiYm0SWVKv6f2tc+5p01WeIUVdG+7J4/OPT45zXlvBOj/CPUZAns0H
 202piKjY7I2WgmndQ0O+IbGNU0P8HWG/kxrL2rnmiVBvZ7M6oBvSx9GFKRhfGrhcuhGz
 04s9I+PPnxVHvkCUpbiEKhZJsPAyZfGO48azfTEJarDofgGdCVVzC+g3dd+RLyn3uF/a
 TqgcYbEdYeXul0yhelkckgw6CUV2Fzt8XPEHvyECsJYkyMxNPeloheALd4lv50Do1mAf
 19pg==
X-Gm-Message-State: AOAM530PR/Nx0vzt2yaOaU9pK9eKgwovYOELpjuQQMijeu8T5nGgLGCn
 QYkw7x/kVKYV+8+MNF/G+CyzIy5vy0F2M54fNDk=
X-Google-Smtp-Source: ABdhPJw/Je0m2CCSDIYtbFl2epzVL4KdxRSTPktcxbTBObac7BG6J40qAN9IIAqNJQ5L4Ht6d5kjJryRC/dachQ+Hps=
X-Received: by 2002:a02:6c4c:: with SMTP id w73mr74782575jab.26.1594315731840; 
 Thu, 09 Jul 2020 10:28:51 -0700 (PDT)
MIME-Version: 1.0
References: <1594289144-24723-1-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1594289144-24723-1-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 Jul 2020 10:19:00 -0700
Message-ID: <CAKmqyKPYG8wuS5zP58PqqZD=ZAYpmsE=+VwUH7N6ZiBH3APMBg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] hw/riscv: Modify MROM size to end at 0x10000
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 9, 2020 at 3:06 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> At present the size of Mask ROM for sifive_u / spike / virt machines
> is set to 0x11000, which ends at an unusual address. This changes the
> size to 0xf000 so that it ends at 0x10000.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>
> (no changes since v1)
>
>  hw/riscv/sifive_u.c | 2 +-
>  hw/riscv/spike.c    | 2 +-
>  hw/riscv/virt.c     | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index dc46f64..3413369 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -70,7 +70,7 @@ static const struct MemmapEntry {
>      hwaddr size;
>  } sifive_u_memmap[] =3D {
>      [SIFIVE_U_DEBUG] =3D    {        0x0,      0x100 },
> -    [SIFIVE_U_MROM] =3D     {     0x1000,    0x11000 },
> +    [SIFIVE_U_MROM] =3D     {     0x1000,     0xf000 },
>      [SIFIVE_U_CLINT] =3D    {  0x2000000,    0x10000 },
>      [SIFIVE_U_L2LIM] =3D    {  0x8000000,  0x2000000 },
>      [SIFIVE_U_PLIC] =3D     {  0xc000000,  0x4000000 },
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index a187aa3..ea4be98 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -57,7 +57,7 @@ static const struct MemmapEntry {
>      hwaddr base;
>      hwaddr size;
>  } spike_memmap[] =3D {
> -    [SPIKE_MROM] =3D     {     0x1000,    0x11000 },
> +    [SPIKE_MROM] =3D     {     0x1000,     0xf000 },
>      [SPIKE_CLINT] =3D    {  0x2000000,    0x10000 },
>      [SPIKE_DRAM] =3D     { 0x80000000,        0x0 },
>  };
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 5ca49c5..37b8c55 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -53,7 +53,7 @@ static const struct MemmapEntry {
>      hwaddr size;
>  } virt_memmap[] =3D {
>      [VIRT_DEBUG] =3D       {        0x0,         0x100 },
> -    [VIRT_MROM] =3D        {     0x1000,       0x11000 },
> +    [VIRT_MROM] =3D        {     0x1000,        0xf000 },
>      [VIRT_TEST] =3D        {   0x100000,        0x1000 },
>      [VIRT_RTC] =3D         {   0x101000,        0x1000 },
>      [VIRT_CLINT] =3D       {  0x2000000,       0x10000 },
> --
> 2.7.4
>
>

