Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07C2C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 14:26:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E5AE21773
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 14:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qp+Q+scM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E5AE21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54734 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT5io-0004hG-Tg
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 10:26:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT5hs-00047h-Qi
	for qemu-devel@nongnu.org; Tue, 21 May 2019 10:25:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT5hr-0003dZ-Kt
	for qemu-devel@nongnu.org; Tue, 21 May 2019 10:25:32 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:45066)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hT5hr-0003ci-BU
	for qemu-devel@nongnu.org; Tue, 21 May 2019 10:25:31 -0400
Received: by mail-oi1-x243.google.com with SMTP id w144so12893232oie.12
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 07:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to; 
	bh=b8hMg6Mf31pTr8e2qazKiIGVX2fefsXToDRaN2vaHcA=;
	b=Qp+Q+scMuNBTWnOXtlLGWMX3ZhQYML8IQyIvRVFzS+Z75e2feI49VGmMhBNjcT6M1S
	h2lt37r660Sj8cHivKhgkhLhgHD3slldn85jmbHqomgOGY28+BExXsGY1zqHzwpWJ5TR
	sOSXPOjJwc27Ol+8oVuqOD/IiRBNI9dgI2yh7iKMRAO5FgYA+vBN0ZwaCW3CEnAtw9du
	tuOork1S1wdA3cBkcRgkEL2Grh2PbsTmP+TDsStq9gLFDUgnq4n52QQDRJc+PZO9Ppm6
	5QIO9YOXt4UF4VxB7FNF3wNzf22z/aZtDHPuwqHGuqhNXDwCywnf/FRDqr1X2L8LxgA/
	rgZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to;
	bh=b8hMg6Mf31pTr8e2qazKiIGVX2fefsXToDRaN2vaHcA=;
	b=uLcvntiNMTNBrJF0Uzausv00+94KVkdW7KATkL6bOoQmKXYnPjS02cq8Rhmem7KXur
	hsPRWcprPgAU9yo/7u2i0NEboHScW2TJ3kfJ1gDWbp/sgO9mbkXDgwOKcV2nhM4cZxmK
	MNwOEa8Sd5nHvHeGmwUmtMidHmf2H+dfc1iDKExIEmv/iAlpyjc2CRUebBYVto31PSwY
	if5VOu+JG8C9mH59phyH6yAr6XMmigPN9oal42sg0SRzwNaSd24LCIu60xG7hLvp0tWc
	9tZ+ZMeXjbV4fCES0im5DiydWYyEsA+vO8BlZuBuB1sSCNAmrJcdKhfQQEEn1IQ2GGI7
	lMFw==
X-Gm-Message-State: APjAAAV8beI5EQC/vQupFnokKPfBCMWQ8xtWqQ0oP/ojPMmbJ62uiTIR
	i/Fi3JaYEg2kvnigUJPebU1ZSEDvEKoCI79qJpzDKA==
X-Google-Smtp-Source: APXvYqwoczvRGHUlmS1rrzkBznC1wpOVMXzAG7/s6Izf1iIbFi6YJnKiOl4SVzdiY0ly/fW8KroVHD0ZDDUR35xSrM8=
X-Received: by 2002:aca:b1c1:: with SMTP id a184mr3682643oif.98.1558448730586; 
	Tue, 21 May 2019 07:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190520162809.2677-1-peter.maydell@linaro.org>
	<20190520162809.2677-2-peter.maydell@linaro.org>
In-Reply-To: <20190520162809.2677-2-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 May 2019 15:25:19 +0100
Message-ID: <CAFEAcA-pZEgQ8z61gxxJW=-Oc8O_Eg9Q5vwa=1iU4e11LSePAg@mail.gmail.com>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH 1/4] hw/intc/arm_gicv3: Fix decoding of ID
 register range
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 20 May 2019 at 17:28, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The GIC ID registers cover an area 0x30 bytes in size
> (12 registers, 4 bytes each). We were incorrectly decoding
> only the first 0x20 bytes.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/arm_gicv3_dist.c   | 2 +-
>  hw/intc/arm_gicv3_redist.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/intc/arm_gicv3_dist.c b/hw/intc/arm_gicv3_dist.c
> index 53c55c57291..335386ff3ac 100644
> --- a/hw/intc/arm_gicv3_dist.c
> +++ b/hw/intc/arm_gicv3_dist.c
> @@ -533,7 +533,7 @@ static MemTxResult gicd_readl(GICv3State *s, hwaddr offset,
>          }
>          return MEMTX_OK;
>      }
> -    case GICD_IDREGS ... GICD_IDREGS + 0x1f:
> +    case GICD_IDREGS ... GICD_IDREGS + 0x2f:
>          /* ID registers */
>          *data = gicv3_idreg(offset - GICD_IDREGS);
>          return MEMTX_OK;
> diff --git a/hw/intc/arm_gicv3_redist.c b/hw/intc/arm_gicv3_redist.c
> index 3b0ba6de1ab..9bb11423382 100644
> --- a/hw/intc/arm_gicv3_redist.c
> +++ b/hw/intc/arm_gicv3_redist.c
> @@ -233,7 +233,7 @@ static MemTxResult gicr_readl(GICv3CPUState *cs, hwaddr offset,
>          }
>          *data = cs->gicr_nsacr;
>          return MEMTX_OK;
> -    case GICR_IDREGS ... GICR_IDREGS + 0x1f:
> +    case GICR_IDREGS ... GICR_IDREGS + 0x2f:
>          *data = gicv3_idreg(offset - GICR_IDREGS);
>          return MEMTX_OK;
>      default:

Just noticed that I forgot to also update the case statements
in the *writel functions :-(

thanks
-- PMM

