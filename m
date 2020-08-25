Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC8FC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 22:43:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6045A206EB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 22:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6jNk1mL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6045A206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAhfB-0001Vn-OB
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 18:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kAheH-0000z6-Kg; Tue, 25 Aug 2020 18:42:37 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:36043)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kAheG-0005vh-30; Tue, 25 Aug 2020 18:42:37 -0400
Received: by mail-il1-x141.google.com with SMTP id f75so171927ilh.3;
 Tue, 25 Aug 2020 15:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aMdNCsXgjW6uG5fd7uc9SJ1TfO0QhFu+yDtNH7/bqiY=;
 b=B6jNk1mLYvhVL14779B+kk6568ROMDnUwBbSMKZ7/8wHWUHotDd4Q17yIhgwFP+YOk
 GnubxYLsczY9rGov1Pgmi/9DV2P+P10BLzNp0B3G15Y0MSUes+7hKdVX0YNf+2srWdCn
 VeB6cys0jrM7rNGd5D6vK4IlQg+J/724a3V/xZOWIXrx8bg5JCc2L3yXbcRfYYsANSQq
 PMbaijVta/UdupU55A37NEUJpzuu44jYu5oDvBcr3FkA4xSTK7V3y7tLo07uZP3peUwJ
 M7VS/lLRdXfVQatPNCQmkHtP/HXkLNsmEcXfJeyXl9/h9te3mwzOD+oCZoCAsf4bBaif
 LKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aMdNCsXgjW6uG5fd7uc9SJ1TfO0QhFu+yDtNH7/bqiY=;
 b=j8D376M8u3InKF3+M72BfvC3IxZyYTAGs6BMZ8E5ZmFI4dx8SPWqH0E4Kwkws5y91S
 rMXGzfQBNN6G7X15pqPkSJfyRNr6UViwMK38LRILSBPbm0LSTmVVGyCjDjO4rP7tZUAg
 UA3qowVb5A9iq1mwtRMoIrX7Y61Z1iAXuD8P+bn+TunUvpH6yFRGJCI98VTJiRP/VenU
 gJ95dwqhwdcGqOFad/61C49UlUmoXIsVTa3GXkM5UZfU5BbCHspgC8EqW11iEO9b7Zlx
 egpdnCdAOkMIImnZked764q+EVcy90gi19JncmCSASYZ9LkYqSU6dgrryDfTCyk8LW6N
 K9sw==
X-Gm-Message-State: AOAM533Ra0QM4LEw+xlPkGZBMp8b8ELUP2ee8lLgxEkC/6pqSHGNGoPU
 6yBXf4bxai7NsJk/rDR0F2diQHfLyTrJ3zUWpXo=
X-Google-Smtp-Source: ABdhPJzBsRzUeI9iSy4gMsR5OyFeMqpLfddhdzokAN3iJ9TJQ1L2vq/VyyADiZfkBYnLXsNYN6RjZsNglFiaKA3IRVE=
X-Received: by 2002:a05:6e02:ed4:: with SMTP id
 i20mr11204879ilk.267.1598395354455; 
 Tue, 25 Aug 2020 15:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200811002325.46056-1-weiying_hou@outlook.com>
 <SG2PR02MB2634D85E5DF0C2BB540AE1BB93450@SG2PR02MB2634.apcprd02.prod.outlook.com>
In-Reply-To: <SG2PR02MB2634D85E5DF0C2BB540AE1BB93450@SG2PR02MB2634.apcprd02.prod.outlook.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 25 Aug 2020 15:31:51 -0700
Message-ID: <CAKmqyKMQZ_KYU-ZN60tqfLPdxa4pka6fxqtS6s2a-tCP4_1JFA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] Define ePMP mseccfg
To: Hou Weiying <weiying_hou@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x141.google.com
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Hongzheng-Li <Ethan.Lee.QNL@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Myriad-Dreamin <camiyoru@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 10, 2020 at 5:25 PM Hou Weiying <weiying_hou@outlook.com> wrote:
>
> Currently using 0x390 and 0x391 for x-epmp (experimental). This may change in the future spec.
>
> Signed-off-by: Hongzheng-Li <Ethan.Lee.QNL@gmail.com>
> Signed-off-by: Hou Weiying <weiying_hou@outlook.com>
> Signed-off-by: Myriad-Dreamin <camiyoru@gmail.com>
> ---
>  target/riscv/cpu_bits.h | 3 +++
>  target/riscv/gdbstub.c  | 2 ++
>  2 files changed, 5 insertions(+)
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 8117e8b5a7..9c35179983 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -229,6 +229,9 @@
>  #define CSR_MTINST          0x34a
>  #define CSR_MTVAL2          0x34b
>
> +/* Enhanced PMP */
> +#define CSR_MSECCFG         0x390
> +#define CSR_MSECCFGH        0x391

I was hoping that this address would be set by this time, but that
doesn't seem to have happened. I'll try and get this going.

I think we will have to wait for the address to be finalised before
this can be merged.

Alistair

>  /* Physical Memory Protection */
>  #define CSR_PMPCFG0         0x3a0
>  #define CSR_PMPCFG1         0x3a1
> diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> index eba12a86f2..de5551604a 100644
> --- a/target/riscv/gdbstub.c
> +++ b/target/riscv/gdbstub.c
> @@ -132,6 +132,8 @@ static int csr_register_map[] = {
>      CSR_MIP,
>      CSR_MTINST,
>      CSR_MTVAL2,
> +    CSR_MSECCFG,
> +    CSR_MSECCFGH,
>      CSR_PMPCFG0,
>      CSR_PMPCFG1,
>      CSR_PMPCFG2,
> --
> 2.20.1
>
>

