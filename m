Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955F0C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 17:41:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72588206B6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 17:41:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72588206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39402 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSmHo-0006ms-In
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 13:41:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hSm1d-0001qp-7S
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:24:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hSm1b-0005Pr-Nx
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:24:36 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hSm1b-0005On-IE
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:24:35 -0400
Received: by mail-wm1-f65.google.com with SMTP id x64so157263wmb.5
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 10:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=Z3bIzp7bNN8LqmaeDZr/a8qvIyz/8zh6J2BdewSw5zQ=;
	b=Ym95GArO4EQzL8EP/waOGoXpmeNAjgHRQ+NqVoCi/CuOhfq+RPB/D/JA3lLEuoHZY3
	D96iSwykhATEMFBiIsDySVzuVH1FDmJgH/E9GzJ3yhjmdWbmkupJWoxOkFC1HETqEUl3
	gpg6TjOhhsHo2rFFO5sMykp31N5UhlikK2ChXFkAaRuHtBdXzdSGhJgHSKlXNYaUcHcR
	vkuFDX9X4Er/qGMAPE232G213Fw5qcQmjh44WuNVTWFozrJ3zi3iYQJ/fL3FzWb+qFGx
	OZu1/ytR9nfsWUdKixJDEfyjkGn7/lL8W4UbHncRo2Sr/Ol2PyNNhyF1NUsqeNBF3psC
	1/DA==
X-Gm-Message-State: APjAAAXH4yayO77vcY0lfTasNeSPJMW+5yWriLBDYTuTDzO434r56VDU
	IrfaPDphZTrvECJXL6FJLpjqK9XN/Kc=
X-Google-Smtp-Source: APXvYqwaigkkNIh93sawUx14+YZLvP20ukuUM0EUu6id90aSZWvjJ/V5sEMHw5p5jxu8chv12N81wA==
X-Received: by 2002:a1c:2245:: with SMTP id i66mr166605wmi.19.1558373073452;
	Mon, 20 May 2019 10:24:33 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	e8sm42662114wrc.34.2019.05.20.10.24.32
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 20 May 2019 10:24:33 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
References: <20190520162809.2677-1-peter.maydell@linaro.org>
	<20190520162809.2677-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <dc232ab2-5a8d-1df7-074e-0e7eed1b2960@redhat.com>
Date: Mon, 20 May 2019 19:24:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520162809.2677-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
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

On 5/20/19 6:28 PM, Peter Maydell wrote:
> The GIC ID registers cover an area 0x30 bytes in size
> (12 registers, 4 bytes each). We were incorrectly decoding
> only the first 0x20 bytes.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

"8.1.13 Identification registers" OK.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

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
> 

