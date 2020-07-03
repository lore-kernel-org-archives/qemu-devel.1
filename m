Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC2BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 01:20:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8453020737
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 01:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxhJuctL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8453020737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrANN-0002Fp-QR
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 21:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jrAMT-0000zp-Mv; Thu, 02 Jul 2020 21:19:29 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:32774)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jrAMS-0005MZ-47; Thu, 02 Jul 2020 21:19:29 -0400
Received: by mail-yb1-xb44.google.com with SMTP id o4so14712894ybp.0;
 Thu, 02 Jul 2020 18:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=W96E0lKCag1Y0M/Pnhw3YHiDTbeq3/x61CkSWRMK3fc=;
 b=lxhJuctLowhRrVeRUWRu1zBG2xx9OCpN/Uet5PRrEue9Yst+lv3mWw+tkLOrAQjyxO
 d3vXaJGGW6MhgcVwjgijen+C8uIcRAR2sn6zZ4mzw3F6frVk7FcJzPhAZKGakehsUtCP
 rdzk2zVNwZseY5ZyNG8T/niK0OFp/TOFQpPs2YTW/xHH97OXT4bIYwHMSlfrN7cGoGlO
 vcXnbZJmhqAlJAZmLG3w6AjBw/Lb+XCI37K0Pw4BDNRQwyqh7S8GGo3AcprQeUusdkk7
 SnZ/86O4rkO/i8/amL+1t8TY6DPGYQ/deWFnOk+lUOGUC5YJE+jzhdmhigOfvrXDstvz
 6ZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=W96E0lKCag1Y0M/Pnhw3YHiDTbeq3/x61CkSWRMK3fc=;
 b=TtVTTT/OvJ34zQ0XLTVwSfpRP8Zvx/WC+TgA+JXz6+4pU+lUS7qrEjqZNnyMRslwUq
 62p31qpgZ5zOpJNH2webYNFT7znYqOQTd278MRrpzCObWnPTPSkVsaJ1FssXIkPgtUb9
 2N1w6YwqbQkve4wTlRUVFB6PBJMzYEzJYoOv8/Gd7sAtEPAA1bcJYOrMIkhgFFAKSrCb
 xG/IeRGqKTu3H4pr+O2KXIAhs2zd4e3aBHmKCD0I+hL81VODsrdeOZROzrs2OzwECxcy
 MThbtZBXFyHfcCQz1AW6Ee/2JpWuVWSPAUNxqdQORCi9d0Mt5mEUw5UUAfjqb88fcJT7
 3h9w==
X-Gm-Message-State: AOAM531i2ZIqBiNENZz7+oK1Yg2feDqP3Me+NgC/BTDKEHS5uLEP7AKu
 e/9gQFdwgzZ0YIGt2qBwVxgwegfJwwAN4goK64Y=
X-Google-Smtp-Source: ABdhPJwcWmtms5y/bvECvWO5XcgmbQqN9/LANeTuvA7K10ukCmDUcMYGWzOMoHS+rdnh67XJi8gJWyM9WrBdkrWbKmQ=
X-Received: by 2002:a25:afca:: with SMTP id d10mr50985211ybj.517.1593739166826; 
 Thu, 02 Jul 2020 18:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200701183949.398134-1-atish.patra@wdc.com>
 <20200701183949.398134-4-atish.patra@wdc.com>
In-Reply-To: <20200701183949.398134-4-atish.patra@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 3 Jul 2020 09:19:15 +0800
Message-ID: <CAEUhbmWcRCTVg-9kkFzPZ5_ZF63h841QzPYP=xRm=Y2s1=sJDQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] riscv: Add opensbi firmware dynamic support
To: Atish Patra <atish.patra@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b44;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alexander Richardson <Alexander.Richardson@cl.cam.ac.uk>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 2, 2020 at 2:39 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> OpenSBI is the default firmware in Qemu and has various firmware loading
> options. Currently, qemu loader uses fw_jump which has a compile time
> pre-defined address where fdt & kernel image must reside. This puts a
> constraint on image size of the Linux kernel depending on the fdt location
> and available memory. However, fw_dynamic allows the loader to specify
> the next stage location (i.e. Linux kernel/U-Boot) in memory and other
> configurable boot options available in OpenSBI.
>
> Add support for OpenSBI dynamic firmware loading support. This doesn't
> break existing setup and fw_jump will continue to work as it is. Any
> other firmware will continue to work without any issues as long as it
> doesn't expect anything specific from loader in "a2" register.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/riscv/boot.c                 | 42 +++++++++++++++++++++---
>  hw/riscv/sifive_u.c             | 20 +++++++++---
>  hw/riscv/spike.c                | 13 ++++++--
>  hw/riscv/virt.c                 | 12 +++++--
>  include/hw/riscv/boot.h         |  5 ++-
>  include/hw/riscv/boot_opensbi.h | 58 +++++++++++++++++++++++++++++++++
>  6 files changed, 134 insertions(+), 16 deletions(-)
>  create mode 100644 include/hw/riscv/boot_opensbi.h
>

Reviewed-by: Bin Meng <bin.meng@windriver.com>
Tested-by: Bin Meng <bin.meng@windriver.com>

