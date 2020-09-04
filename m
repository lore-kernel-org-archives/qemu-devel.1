Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81944C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 18:24:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCDFA204EC
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 18:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpnBUy+X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCDFA204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEFwk-0006TZ-16
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 13:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kEFve-0005Mi-L5; Fri, 04 Sep 2020 13:55:14 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:40559)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kEFvc-0000Kl-LP; Fri, 04 Sep 2020 13:55:14 -0400
Received: by mail-il1-x142.google.com with SMTP id y2so7113996ilp.7;
 Fri, 04 Sep 2020 10:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rrRlxU6Tivxrej0Hui6en392JxWhEXAjJvXhKYn4ySM=;
 b=DpnBUy+Xf5FDTWrpzcUKC9VP4gZ05lU23armx0tLxBzZC9HpQg94WafW9FVtG5446X
 bFBw22PKLr4xLze2NR+vIE8u5tAgByTUGHnxOX5lrR6m6Uh5imtxFcr5f3aFQMJTeZPp
 Dn/6QiJC1cwMjgp5xAjXDhWOE/QNR4aZrYZckwEMSQQGhxejutZMzLhcheYEIXrZVt7j
 5LcUYvR9qkaEh4+/3ul/jJU2sdQl74m1B3eFXMtxVGwDajWeZs03o/+FM0BsZCcz9Pg0
 pXH34MaABepKPVv/oNbI+FJDR2fkV+MeOykqEoFzm3eonSS1zkqJkdKkKo3w3r630fOP
 NwVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rrRlxU6Tivxrej0Hui6en392JxWhEXAjJvXhKYn4ySM=;
 b=XdZiE5uRK6WEniFMp+wLtDdHPVCRoAKo0YtdmeVKtpxn5Ws86lieOkIZr2Ga7aipkE
 XL/xYd38z3dG9BgMPAKW7fz4po0RprgayK51vuWMqP3xJRAly5Q6Qh+7QIiCdj9KUjTf
 osZ+DrfelOudnbwFgT+CsqlBH+aQzdgiki2/cbeXV+uveZsrCvBplAYa7Fp12LZ1ulRC
 lafRRftDrixi+v4VD2olpjxinzPqLMctCxV0ZUBGi+J0IiRGIBRP6r63dAdD1KxqlHlU
 Q1TqzLPRMH/APrXGqlY38AY5acsBu1BdyhvffncXKTPewP65Xar4ntU0lgt5eanYQP6n
 4QsQ==
X-Gm-Message-State: AOAM530UyA9JCOy4mJzN4aCWdeT8uPjwvoThYlKPv2IoMhILMukVOnx5
 2PsrtcPaNtjM+GYuMoIQETCTIJouKO6L48C5fbY=
X-Google-Smtp-Source: ABdhPJwzy1rORMQ22zIKKtoQtBR41CsZAbDC0CQs18NzxJsZ7PwrUIK2/tFWO8coy5iDWMjEFVC033jtPHowWbTKJFc=
X-Received: by 2002:a92:189:: with SMTP id 131mr9313806ilb.40.1599242111094;
 Fri, 04 Sep 2020 10:55:11 -0700 (PDT)
MIME-Version: 1.0
References: <1599129623-68957-1-git-send-email-bmeng.cn@gmail.com>
 <1599129623-68957-13-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1599129623-68957-13-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Sep 2020 10:44:16 -0700
Message-ID: <CAKmqyKM6gKcuvJF2REMA9OvwLKuTZb_n1GdhbAJSumH9wGsp1w@mail.gmail.com>
Subject: Re: [PATCH 12/12] hw/riscv: Sort the Kconfig options in alphabetical
 order
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x142.google.com
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Bin Meng <bin.meng@windriver.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 3, 2020 at 3:43 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> At present the Kconfig file is in disorder. Let's sort the options.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> ---
>
>  hw/riscv/Kconfig | 58 ++++++++++++++++++++++++++++----------------------------
>  1 file changed, 29 insertions(+), 29 deletions(-)
>
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index e152fdc..2df978f 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -1,36 +1,16 @@
>  config IBEX
>      bool
>
> -config SIFIVE_E
> -    bool
> -    select MSI_NONBROKEN
> -    select SIFIVE_CLINT
> -    select SIFIVE_GPIO
> -    select SIFIVE_PLIC
> -    select SIFIVE_UART
> -    select SIFIVE_E_PRCI
> -    select UNIMP
> -
> -config SIFIVE_U
> +config MICROCHIP_PFSOC
>      bool
> -    select CADENCE
> +    select CADENCE_SDHCI
> +    select MCHP_PFSOC_MMUART
>      select MSI_NONBROKEN
>      select SIFIVE_CLINT
> -    select SIFIVE_GPIO
>      select SIFIVE_PDMA
>      select SIFIVE_PLIC
> -    select SIFIVE_UART
> -    select SIFIVE_U_OTP
> -    select SIFIVE_U_PRCI
>      select UNIMP
>
> -config SPIKE
> -    bool
> -    select HTIF
> -    select MSI_NONBROKEN
> -    select SIFIVE_CLINT
> -    select SIFIVE_PLIC
> -
>  config OPENTITAN
>      bool
>      select IBEX
> @@ -40,23 +20,43 @@ config RISCV_VIRT
>      bool
>      imply PCI_DEVICES
>      imply TEST_DEVICES
> +    select GOLDFISH_RTC
>      select MSI_NONBROKEN
>      select PCI
> -    select SERIAL
> -    select GOLDFISH_RTC
> -    select VIRTIO_MMIO
>      select PCI_EXPRESS_GENERIC_BRIDGE
>      select PFLASH_CFI01
> +    select SERIAL
>      select SIFIVE_CLINT
>      select SIFIVE_PLIC
>      select SIFIVE_TEST
> +    select VIRTIO_MMIO
>
> -config MICROCHIP_PFSOC
> +config SIFIVE_E
>      bool
>      select MSI_NONBROKEN
>      select SIFIVE_CLINT
> +    select SIFIVE_GPIO
> +    select SIFIVE_PLIC
> +    select SIFIVE_UART
> +    select SIFIVE_E_PRCI
>      select UNIMP
> -    select MCHP_PFSOC_MMUART
> +
> +config SIFIVE_U
> +    bool
> +    select CADENCE
> +    select MSI_NONBROKEN
> +    select SIFIVE_CLINT
> +    select SIFIVE_GPIO
>      select SIFIVE_PDMA
>      select SIFIVE_PLIC
> -    select CADENCE_SDHCI
> +    select SIFIVE_UART
> +    select SIFIVE_U_OTP
> +    select SIFIVE_U_PRCI
> +    select UNIMP
> +
> +config SPIKE
> +    bool
> +    select HTIF
> +    select MSI_NONBROKEN
> +    select SIFIVE_CLINT
> +    select SIFIVE_PLIC
> --
> 2.7.4
>
>

