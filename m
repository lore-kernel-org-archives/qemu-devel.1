Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE2BC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 20:13:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 167A9206C1
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 20:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oys04Ya4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 167A9206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzo1u-0006TT-93
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 16:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44759)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1hzo1A-0005KC-2t
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 16:12:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hzo19-0000ta-69
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 16:12:40 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:34562)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hzo18-0000s8-V3; Mon, 19 Aug 2019 16:12:39 -0400
Received: by mail-lj1-x243.google.com with SMTP id x18so2963902ljh.1;
 Mon, 19 Aug 2019 13:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dMWi4Kl+LFYOvsH7VUL2TkzS7+FaZsWR+nLrdeAFAQM=;
 b=oys04Ya4DQ6ImESpJK2QEfJ0uycDW0RazyL3RKd0QscAnBJQQunsW2TVwHyYhaWQjT
 ww2pkNhTh4dzfPYyzG4SJoqLPn0+C167siYah5f8dvQ4hWr/TzQZVeUSoxc3p+b25Rc9
 J3LTRuKBUCgEybFUZyzCJZ6IPHDNVdTZnE37JOQ14cPZGhmm2SGv8+mBFdQ/pD3lDNsw
 L+Mu7kV4JmPMpOh1KGNd+kBsejy5BuX9OPBjJw13D5TpcV5n+RR7Y/1YCYowqh+gCXlY
 ErDiRtOcuv/l+OINXq/lEntEGuV7Q1wftM9V1kzAG21Ki1hLQyYQuY7MKOJQieyD+I8V
 Z9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dMWi4Kl+LFYOvsH7VUL2TkzS7+FaZsWR+nLrdeAFAQM=;
 b=e2rXwn0IwRec2UMP8QP9fNWVHKLSdLvcTfjmtOYetNy7X4enn+aC31RFVg7dw01rgr
 RSVVcC+x0LJvappKLRn39kKQozNVEP6dpACZXItd6weijid+xW6R8Jze5XUqLlefmsxe
 5YoRF/o4xmuVrx7+0g/dU+sde+h4PZqpS13LiIrOArMcl6cj/5LPoEkoa9zJvrj5n3yJ
 VlB+3/0fOIgtgdknFia1HfbxkdoPzD/M3uNC7Urzj3iqe6exj3y4n/SD741bORwsorZt
 yIk7Nw6/Te+TFB1QjsMGv//9tpFASF3RcJy3xPL53NfprVeq1L/J4EqGdm25y1G2ElNE
 VQaQ==
X-Gm-Message-State: APjAAAWWGLTjZSH/8mHW1+FO0aQKdClWmj+wtF52sHntOwuzqGrLh3n9
 6vczPH8sOUEnPmlI25kS7MWOOLKWlW9Ym34MnRs=
X-Google-Smtp-Source: APXvYqzQ65fyIpOSl7qRmhDQssnvYCBTlC6arOqaGlFZg3BChn94LQzPxnw941my9LYOG+uFtGedRZ0vGFQcLpEx0Ss=
X-Received: by 2002:a05:651c:c1:: with SMTP id
 1mr13805212ljr.119.1566245557733; 
 Mon, 19 Aug 2019 13:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <1566191521-7820-1-git-send-email-bmeng.cn@gmail.com>
 <1566191521-7820-6-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1566191521-7820-6-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 19 Aug 2019 13:08:37 -0700
Message-ID: <CAKmqyKPu0r2WKxiMYpZrP1M86weKWJFAUO5kAws7yk_vW3NffQ@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
Subject: Re: [Qemu-devel] [PATCH v4 05/28] riscv: roms: Remove executable
 attribute of opensbi images
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
 Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Aug 18, 2019 at 10:15 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Like other binary files, the executable attribute of opensbi images
> should not be set.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> ---
>
> Changes in v4:
> - new patch to remove executable attribute of opensbi images
>
> Changes in v3: None
> Changes in v2: None
>
>  pc-bios/opensbi-riscv32-virt-fw_jump.bin     | Bin
>  pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin | Bin
>  pc-bios/opensbi-riscv64-virt-fw_jump.bin     | Bin
>  3 files changed, 0 insertions(+), 0 deletions(-)
>  mode change 100755 => 100644 pc-bios/opensbi-riscv32-virt-fw_jump.bin
>  mode change 100755 => 100644 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
>  mode change 100755 => 100644 pc-bios/opensbi-riscv64-virt-fw_jump.bin
>
> diff --git a/pc-bios/opensbi-riscv32-virt-fw_jump.bin b/pc-bios/opensbi-riscv32-virt-fw_jump.bin
> old mode 100755
> new mode 100644
> diff --git a/pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin b/pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
> old mode 100755
> new mode 100644
> diff --git a/pc-bios/opensbi-riscv64-virt-fw_jump.bin b/pc-bios/opensbi-riscv64-virt-fw_jump.bin
> old mode 100755
> new mode 100644
> --
> 2.7.4
>
>

