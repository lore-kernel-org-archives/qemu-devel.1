Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7F7C81857
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 22:28:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 240B32078C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 22:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6bk27Eb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 240B32078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTCEQ-0006hs-8I
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 18:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40690)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jTCDA-0005Qu-Dn
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 18:26:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jTCD9-0004fD-Kb
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 18:26:48 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:33822)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jTCD9-0004YC-7y; Mon, 27 Apr 2020 18:26:47 -0400
Received: by mail-io1-xd42.google.com with SMTP id f3so20783992ioj.1;
 Mon, 27 Apr 2020 15:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nnkbYLVpGs1sFMwOsT/+QgsmLFUVwaH3mRyqwZfJivs=;
 b=e6bk27EbsY/USbF0g7LDxKCaqwTWnyee+u3EQY74ofARNQ2MUVSbQ3wrA4lBuqiVlA
 MpAdi5+ExhnYPToRmMIDYT4sYA4eCMRBdAQVJg0H2CSwwoHGuESmBuO7JKMP8QZRNOxA
 OMvfQfFizivK5SIG/zzRZsz8iDJ/0TmDkNjBgaJpfrs0QHOQPUz1YrQVI6rNtP29Vnq5
 fjqvXnnzDAHX5qf74US5nzqwISgY5dwU/uEzBNgCyJ93PiA0BITiZRsNp8Xjb8/sO+Uw
 Ada4f6JafNvSwtn56iPngfKSsRupDTe/mmHGB4iNgQPfjJSotwpUq9ALeBeFYiBsnCPq
 7yUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nnkbYLVpGs1sFMwOsT/+QgsmLFUVwaH3mRyqwZfJivs=;
 b=rwaJpJ3LPCBLhZ2PaPYdE6oeVHhaBnqV1OEjFH2Nyrdpv7XB6FvGcOCieCdm2AKEhl
 pP9/HhnlYrK/7fYZtqhYemx3pf4Z/d6ONeEvRy3He5rM48fxpBsBNwX/ohKPQltZ8pZC
 LhhusfR+HF6XdsJCioEfwSOzT92fu+Ctw9vBrA39XlmAFp1aVNyOrtO5rdTy07TZ0+3N
 cbTcylWqm39DqKTsNYtZ480UEop7UhI+4WZhZNDq4Rh6lvFr0dVcuIm4Fqs1bXiry6PJ
 vTU537Ba5QwbJtlGqDt4kvH9mlqFCVrYKL/eQgc+Iswox4X/UnJYjCw9GmcMsv57KQ8y
 n88Q==
X-Gm-Message-State: AGi0PuZt3ebBNVCJQ37o3kFK/CNw7L0t86HawPxXmvPJ+8u94TJONIl+
 4rQYhCvdydby/KnDuotFOAbHzxzI4l2O6NKNWkM=
X-Google-Smtp-Source: APiQypIsxlpK6UjqdMIKy+Di8bHp+JNDbUDFqs+PHFsEzLLzsub07xzW7fVXhrnix91ukckz+i0PUMPWFPiddQYmJ4o=
X-Received: by 2002:a5e:880b:: with SMTP id l11mr23372252ioj.42.1588026405744; 
 Mon, 27 Apr 2020 15:26:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200427181649.26851-1-edgar.iglesias@gmail.com>
 <20200427181649.26851-4-edgar.iglesias@gmail.com>
In-Reply-To: <20200427181649.26851-4-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 27 Apr 2020 15:18:05 -0700
Message-ID: <CAKmqyKMMt1ZzKcFDYphQ59jtowWdTLmtnFOQJaMO_3x+WyWpAg@mail.gmail.com>
Subject: Re: [PATCH v1 03/11] hw/arm: versal-virt: Fix typo xlnx-ve ->
 xlnx-versal
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd42.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::d42
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
Cc: figlesia@xilinx.com, Peter Maydell <peter.maydell@linaro.org>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Apr 27, 2020 at 11:20 AM Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Fix typo xlnx-ve -> xlnx-versal.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/xlnx-versal-virt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index 878a275140..8a608074d1 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c
> @@ -440,7 +440,7 @@ static void versal_virt_init(MachineState *machine)
>          psci_conduit = QEMU_PSCI_CONDUIT_SMC;
>      }
>
> -    sysbus_init_child_obj(OBJECT(machine), "xlnx-ve", &s->soc,
> +    sysbus_init_child_obj(OBJECT(machine), "xlnx-versal", &s->soc,
>                            sizeof(s->soc), TYPE_XLNX_VERSAL);
>      object_property_set_link(OBJECT(&s->soc), OBJECT(machine->ram),
>                               "ddr", &error_abort);
> --
> 2.20.1
>
>

