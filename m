Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D88C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:39:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C541206B5
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPXWEqqw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C541206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW06e-0002ss-7z
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kVzHy-0004ys-3K; Fri, 23 Oct 2020 11:47:34 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:37529)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kVzHv-0004Az-UZ; Fri, 23 Oct 2020 11:47:33 -0400
Received: by mail-io1-xd42.google.com with SMTP id q25so2323382ioh.4;
 Fri, 23 Oct 2020 08:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Q0zhBuJwVfaqWFxVDvRV6NmbWfYwQwjqyLOvb6HnaOo=;
 b=BPXWEqqwSKCrYmOPf2dmlb/NdjOA+3/T1KBwcxXbKvrezDVt/U6Rwey1JIg0LSqFPR
 fiELqCyuIvHWp8z9qz0laUB7UvsodIWIq3d4Rmnzr2INwP6UdgQqFMjtgwnAmK3pviLc
 2rBl5H3jo1+8Rh9biHM3QFTPRN3P3bsWti1hMu3lhgCnYKHXJqa8h0btcOe0oJb6Rkop
 fQdUqMAZoSmNBX/tq5/sv15i63ZkkafBycmEYnxP+hj6R6axV1qMpT6rLDuBA4mD+P3k
 W2hiT4eDMMs/ZrKqdeq5QNee3BgnaMUjVr1S9tykskJQka7LYYx08cL22QJuXMqz9cDd
 4GUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Q0zhBuJwVfaqWFxVDvRV6NmbWfYwQwjqyLOvb6HnaOo=;
 b=R1MVDbiFuAiIxpF68vOLjEdCbKF+zwVdmCqisDapXWCsQRGvieU4JKpCkgMefAsrGC
 HpAE8Tg0VoKFIaLPw2UzTkgRT0viAs39z25zAPPQEUthHu7Oe7+cN41IEUn4QKx6axsN
 vMjmWmU2muQ9giWNNI3Exq7YY6SqxZXVqj5Jc73n5yCWF6nOd3bD06TUzNSwG+B+WccK
 sIhORNX/XFdckMyrKgAIijju5qtx4kJlwMWf3bQX9o/YAcPcHE33bRdJDaN8EmVx2Pgv
 VaTBIWUL226tkAF3gIfftzH4QSwg5m5qyT8jRIWjxvcBStKKUeo5mDIyFpJQ84ianP6d
 Z4gA==
X-Gm-Message-State: AOAM533EGbw6ta3bsP18fM3CZBg1TTPamsjdS/0+/s5C+nNXI3afMl7A
 UdgR4lt9ybv8+Pv+cdO/FA3lRF3LAC4JpDlUa8k=
X-Google-Smtp-Source: ABdhPJw3usEvnAShsrwsaSGjnr7oHPjh0r00VfbjESsA//+BSur0QqlIQyc1UMWcLOwlejxXM1TufgcvT11xjQ21BuE=
X-Received: by 2002:a05:6638:1696:: with SMTP id
 f22mr2586337jat.8.1603468050333; 
 Fri, 23 Oct 2020 08:47:30 -0700 (PDT)
MIME-Version: 1.0
References: <20201021170842.25762-1-alex.bennee@linaro.org>
 <20201021170842.25762-3-alex.bennee@linaro.org>
In-Reply-To: <20201021170842.25762-3-alex.bennee@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 23 Oct 2020 08:35:43 -0700
Message-ID: <CAKmqyKNdUQ4cEOzm4Ldd9nyPkiALktz-m0YKAo+vtkn4t8QcOg@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] hw/riscv: migrate fdt field to generic MachineState
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: julien@xen.org, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>, andre.przywara@arm.com,
 stefano.stabellini@linaro.org,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Alistair Francis <Alistair.Francis@wdc.com>, stefano.stabellini@xilinx.com,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 21, 2020 at 10:13 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>
> This is a mechanical change to make the fdt available through
> MachineState.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/hw/riscv/virt.h |  1 -
>  hw/riscv/virt.c         | 18 +++++++++---------
>  2 files changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> index b4ed9a32eb..6505ae8d23 100644
> --- a/include/hw/riscv/virt.h
> +++ b/include/hw/riscv/virt.h
> @@ -41,7 +41,6 @@ struct RISCVVirtState {
>      DeviceState *plic[VIRT_SOCKETS_MAX];
>      PFlashCFI01 *flash[2];
>
> -    void *fdt;
>      int fdt_size;
>  };
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 41bd2f38ba..17c0706156 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -194,7 +194,7 @@ static void create_fdt(RISCVVirtState *s, const struc=
t MemmapEntry *memmap,
>      hwaddr flashsize =3D virt_memmap[VIRT_FLASH].size / 2;
>      hwaddr flashbase =3D virt_memmap[VIRT_FLASH].base;
>
> -    fdt =3D s->fdt =3D create_device_tree(&s->fdt_size);
> +    fdt =3D mc->fdt =3D create_device_tree(&s->fdt_size);
>      if (!fdt) {
>          error_report("create_device_tree() failed");
>          exit(1);
> @@ -434,12 +434,12 @@ static void create_fdt(RISCVVirtState *s, const str=
uct MemmapEntry *memmap,
>      g_free(name);
>
>      name =3D g_strdup_printf("/soc/flash@%" PRIx64, flashbase);
> -    qemu_fdt_add_subnode(s->fdt, name);
> -    qemu_fdt_setprop_string(s->fdt, name, "compatible", "cfi-flash");
> -    qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
> +    qemu_fdt_add_subnode(mc->fdt, name);
> +    qemu_fdt_setprop_string(mc->fdt, name, "compatible", "cfi-flash");
> +    qemu_fdt_setprop_sized_cells(mc->fdt, name, "reg",
>                                   2, flashbase, 2, flashsize,
>                                   2, flashbase + flashsize, 2, flashsize)=
;
> -    qemu_fdt_setprop_cell(s->fdt, name, "bank-width", 4);
> +    qemu_fdt_setprop_cell(mc->fdt, name, "bank-width", 4);
>      g_free(name);
>  }
>
> @@ -613,9 +613,9 @@ static void virt_machine_init(MachineState *machine)
>              hwaddr end =3D riscv_load_initrd(machine->initrd_filename,
>                                             machine->ram_size, kernel_ent=
ry,
>                                             &start);
> -            qemu_fdt_setprop_cell(s->fdt, "/chosen",
> +            qemu_fdt_setprop_cell(machine->fdt, "/chosen",
>                                    "linux,initrd-start", start);
> -            qemu_fdt_setprop_cell(s->fdt, "/chosen", "linux,initrd-end",
> +            qemu_fdt_setprop_cell(machine->fdt, "/chosen", "linux,initrd=
-end",
>                                    end);
>          }
>      } else {
> @@ -636,11 +636,11 @@ static void virt_machine_init(MachineState *machine=
)
>
>      /* Compute the fdt load address in dram */
>      fdt_load_addr =3D riscv_load_fdt(memmap[VIRT_DRAM].base,
> -                                   machine->ram_size, s->fdt);
> +                                   machine->ram_size, machine->fdt);
>      /* load the reset vector */
>      riscv_setup_rom_reset_vec(start_addr, virt_memmap[VIRT_MROM].base,
>                                virt_memmap[VIRT_MROM].size, kernel_entry,
> -                              fdt_load_addr, s->fdt);
> +                              fdt_load_addr, machine->fdt);
>
>      /* SiFive Test MMIO device */
>      sifive_test_create(memmap[VIRT_TEST].base);
> --
> 2.20.1
>
>

