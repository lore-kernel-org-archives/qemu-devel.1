Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45FBC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 01:20:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4DC920737
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 01:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qiPZMUMO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4DC920737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrANJ-00024c-RB
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 21:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jrAMR-0000xN-0R; Thu, 02 Jul 2020 21:19:27 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:38111)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jrAMP-0005MP-FF; Thu, 02 Jul 2020 21:19:26 -0400
Received: by mail-yb1-xb41.google.com with SMTP id e197so10659575yba.5;
 Thu, 02 Jul 2020 18:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YGahHP3tyu+0BNL78d1oYyAyhbkJC746FTnL0fkPy7A=;
 b=qiPZMUMO0EPe8+RJHmDiuneh8JfDk3m0eFse94euLCwEX3hqff8cKmqLKI3fon/uVt
 WLf0U4N4Z1ZkrcwU6149ROsUAh/ZcQU0MXSz3zK+J/kGLEHxNLFaxjftw13B3Fveeru6
 xkCvoQTyarvz0poen2uZk3Q0fyHgpf/b5xHvQyJM8eyfC41KWjaTXV6ysX0eCIvRhPRh
 OqzEae8bViEkZClnb5bY0N8X3/NvxlXGY7x5guMaWJGgW3z0PAlSVCFfExzi19SdsQbR
 QIbU3K9c+zJjtfQKyYR8uCVii4VjjKA75OpHQind0SRD9hbZUU7EGTepKPySfGJfgtdy
 1JHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YGahHP3tyu+0BNL78d1oYyAyhbkJC746FTnL0fkPy7A=;
 b=gpB9FVLVElFAuggLS1HXBvR5YOP09+32DkfGUPVZkWMH5oBTcbv8mHcuPBk1DZ4QkR
 DxeDgY7xRAYFcpPWC6xHBItcpGKyCHxlwOWBGHdXSHaQ18LYiYJZTUBZYiBczyQ5L2X4
 vBCMw7DOR9TIgJLPhYAGkEby2pJrN/YBqxNrA60e4nEKJIvIqdeTn4IFSp/O5YetTVXy
 HdB2oIROf+M16WvG3gca6mjNnVu74xgyEIsiRNYj2cv767C1Fw8sNV5u3KD+FUYfnW5x
 TKzxSHYu1PPwEEUUV4z2EyKzPMVG4xSzUjhhUi7RoxcS6R6wylbV0AyrcI7BomFKbpE+
 ei/g==
X-Gm-Message-State: AOAM533Bcr6ML9hLKdzOFMrAqbnAmfRN+RpPvnGVPa0MNdfweyXniEUI
 N55JLMGkpTTx3wCaslhI0tPgzrHgo4mTMlDYU+Q=
X-Google-Smtp-Source: ABdhPJzP26e/++syjzTiKuWSwUfZOMZA2zTlzlfVOVLDbt5j0U1izzRe5W/hPvYhAJfdJPu0ZifCXD5iEBWyZPXDLU0=
X-Received: by 2002:a25:38c5:: with SMTP id
 f188mr55693721yba.332.1593739163789; 
 Thu, 02 Jul 2020 18:19:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200701183949.398134-1-atish.patra@wdc.com>
 <20200701183949.398134-3-atish.patra@wdc.com>
In-Reply-To: <20200701183949.398134-3-atish.patra@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 3 Jul 2020 09:19:12 +0800
Message-ID: <CAEUhbmX9O2UO-Vc1jn=VOY6fz0Drdnh-F+m6h9CZVSJLUFTxwg@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] RISC-V: Copy the fdt in dram instead of ROM
To: Atish Patra <atish.patra@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b41;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb41.google.com
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
> Currently, the fdt is copied to the ROM after the reset vector. The firmware
> has to copy it to DRAM. Instead of this, directly copy the device tree to a
> pre-computed dram address. The device tree load address should be as far as
> possible from kernel and initrd images. That's why it is kept at the end of
> the DRAM or 4GB whichever is lesser.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/riscv/boot.c         | 53 +++++++++++++++++++++++++++++------------
>  hw/riscv/sifive_u.c     | 28 ++++++++++------------
>  hw/riscv/spike.c        |  7 +++++-
>  hw/riscv/virt.c         |  7 +++++-
>  include/hw/riscv/boot.h |  4 +++-
>  5 files changed, 66 insertions(+), 33 deletions(-)
>

Reviewed-by: Bin Meng <bin.meng@windriver.com>
Tested-by: Bin Meng <bin.meng@windriver.com>

