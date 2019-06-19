Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953B9C31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 05:15:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62434208CB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 05:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="uXRJ9eeK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62434208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35222 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdSwi-0005Jt-N7
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 01:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36507)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <anup@brainfault.org>) id 1hdSvs-0004ge-Ta
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 01:14:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anup@brainfault.org>) id 1hdSvr-00063p-Vi
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 01:14:52 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34914)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <anup@brainfault.org>) id 1hdSvr-00063D-L1
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 01:14:51 -0400
Received: by mail-wr1-x443.google.com with SMTP id m3so1835580wrv.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 22:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brainfault-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VbJYxAtvHmysQDILbBP8+ZL3Z+mNXu2CIculfcaMCJE=;
 b=uXRJ9eeK8AgCk1YYdEhddYRWEEs4M8LoFcMv+hhui2I2hzELj4wFBjtHIjneiDZU60
 9IuV3Xc//UtozzN1ZfEp1B39PkqR9geJ/CbNP46tL42sejaiAbgMn4Lc8tO02N3GPZmi
 dtqIUOo3jyvcljoFg6GpI65IOSbFHL4cIxClc9nAg2mz5MmMwYpBJdou23MxdQVkK5X6
 YO00J1OKWrt0yOExut8R/sXyWYtnbyibeaGOl10+Q5nb8hcHjSEMsQwSSJsZOQXzXn+S
 36PK4AKelwXiB2oJd76zVPe/cMiDSIGyXN3EHzky1wlID6RepuvFyVTY527MoxEENufm
 iVCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VbJYxAtvHmysQDILbBP8+ZL3Z+mNXu2CIculfcaMCJE=;
 b=VWkM0pNb0X8OgIgSEEV/pOBW54YT3IS62DGCAgHuwmJfc/syU7s+xfwb57nO4g0/ur
 dDkCDIQVdwppWtz/PLuA4QxFDM9k17h0VM25AfZhZTH3lWazZa/ETakbDktjqUuZf3H+
 CC8hhCOcE2FKiD1L/LeYILQaAbT8jg41TTlM8gcVmKV5wn0OMerYTOBdLDA5Og5raIiQ
 9zKuYFdck4cTy/FDXU6O66L4UXWSUs++fa89S/vJ4C3lJExObRhIE2RwKDvw8izmt8LM
 c1X5QrKwK7cI7V0ZSeMIvvdPBF7QZhAmxvctjF7EpiPXoKAdy/HAlPhjEsv/HFSiE+n/
 MQag==
X-Gm-Message-State: APjAAAVhLIYOgKNVfz/AvlhTSQBcxDOoP982XlxXacDnKD7XFwiN7CWd
 DeRoKdZb3P0+r5eYNYiBAY5Tv6XU4q02j/xknA8wwA==
X-Google-Smtp-Source: APXvYqy/A/d+8Bio1Pp+SyCfrrXokFHwnDMPzBlGtlN1vmhcWY2fx3ugzlxzop+9RcBBCfyxLFjz2XQ7ycFo+QJKvys=
X-Received: by 2002:a5d:5448:: with SMTP id w8mr51324461wrv.180.1560921289422; 
 Tue, 18 Jun 2019 22:14:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560904640.git.alistair.francis@wdc.com>
 <2fd2fa66cf561d8041f75351c28ed025828c56ff.1560904640.git.alistair.francis@wdc.com>
In-Reply-To: <2fd2fa66cf561d8041f75351c28ed025828c56ff.1560904640.git.alistair.francis@wdc.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 19 Jun 2019 10:44:37 +0530
Message-ID: <CAAhSdy12uKV14cdxvUniSLFw_iF5WNKjoLCanS3Bs=33w-c9xA@mail.gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [Qemu-riscv] [RFC v1 4/5] roms: Add OpenSBI
 version 0.3
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
Cc: alistair23@gmail.com, Palmer Dabbelt <palmer@sifive.com>,
 qemu-riscv@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 19, 2019 at 6:24 AM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> Add OpenSBI version 0.3 as a git submodule and as a prebult binary.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  .gitmodules                         |   3 +++
>  Makefile                            |   3 ++-
>  configure                           |   1 +
>  pc-bios/opensbi-riscv32-fw_jump.elf | Bin 0 -> 197988 bytes
>  pc-bios/opensbi-riscv64-fw_jump.elf | Bin 0 -> 200192 bytes
>  roms/Makefile                       |  17 +++++++++++++++++
>  roms/opensbi                        |   1 +
>  7 files changed, 24 insertions(+), 1 deletion(-)
>  create mode 100644 pc-bios/opensbi-riscv32-fw_jump.elf
>  create mode 100644 pc-bios/opensbi-riscv64-fw_jump.elf
>  create mode 160000 roms/opensbi
>

The OpenSBI firmwares are platform specific so we should have
machine directory under pc-bios/ directory

So for virt machine we will have:
pc-bios/riscv32/virt/fw_jump.elf
pc-bios/riscv64/virt/fw_jump.elf

Regards,
Anup

