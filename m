Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF04C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 13:15:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9391320644
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 13:15:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9391320644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54461 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUA2w-0000io-Ql
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 09:15:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hUA0w-0007lR-8L
	for qemu-devel@nongnu.org; Fri, 24 May 2019 09:13:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hUA0u-0003OZ-VC
	for qemu-devel@nongnu.org; Fri, 24 May 2019 09:13:38 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53651)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hUA0u-0003Lu-Oz
	for qemu-devel@nongnu.org; Fri, 24 May 2019 09:13:36 -0400
Received: by mail-wm1-f67.google.com with SMTP id 198so9352328wme.3
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 06:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=+b5UOSAlUR+hB3EqivhPNylQiolTiEORqjkuY+QlSLo=;
	b=k430ay5dg4qX19l1Y89OAN7+saMxPfDNYDCID2f8N1t91nCptZXO7ILs29UNT20aQz
	p7F0ckFjIl4ThoJzr7YBWrt1uVP8AdcZ14aWmpgzAH/b2GSQ36bU08uc6P4MKhgVtIin
	er4Uy7z3r5vndW0AE6QcF7zXLpWkwNNyvksSk2MvKawicgOtvQUqpCyHQPruztYKizjE
	KHXnFa8JRVwLTwtH0sAgZ4GkYTd0duvix7Fbs6PMsAU3qCMP7HzjROSQkSTzsNuWaBlo
	tHhTM+q8KlZSsKrtnYRiOaVZuUyTQY+cqMd5u/RJw1k/aar0BBY91TzdOs+iARsfLB2y
	zTGA==
X-Gm-Message-State: APjAAAX+A+8VNtPENapncu4x6vtq0P8a0RfdNQBvrfCy16ClEEu5wxjF
	i17lHV6pSWoanw7Zt7GeikoPdn1supQ=
X-Google-Smtp-Source: APXvYqyz7Gi8wSNzRJ4b9YWEIpUxMu8SllqdA0LqNq058lPvRzq1mGmwbovRba14tXhAKAGhdzb5FA==
X-Received: by 2002:a1c:35c9:: with SMTP id
	c192mr15305708wma.147.1558703610997; 
	Fri, 24 May 2019 06:13:30 -0700 (PDT)
Received: from [192.168.1.38] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	z74sm14412362wmc.2.2019.05.24.06.13.30
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 24 May 2019 06:13:30 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
References: <20190524124248.28394-1-peter.maydell@linaro.org>
	<20190524124248.28394-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d5c49edf-f864-09ff-be9d-7072cfbb355b@redhat.com>
Date: Fri, 24 May 2019 15:13:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524124248.28394-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH v2 1/2] hw/intc/arm_gicv3: Fix decoding of
 ID register range
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

On 5/24/19 2:42 PM, Peter Maydell wrote:
> The GIC ID registers cover an area 0x30 bytes in size
> (12 registers, 4 bytes each). We were incorrectly decoding
> only the first 0x20 bytes.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/arm_gicv3_dist.c   | 4 ++--
>  hw/intc/arm_gicv3_redist.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/intc/arm_gicv3_dist.c b/hw/intc/arm_gicv3_dist.c
> index 53c55c57291..e6fe4905fd3 100644
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
> @@ -744,7 +744,7 @@ static MemTxResult gicd_writel(GICv3State *s, hwaddr offset,
>          gicd_write_irouter(s, attrs, irq, r);
>          return MEMTX_OK;
>      }
> -    case GICD_IDREGS ... GICD_IDREGS + 0x1f:
> +    case GICD_IDREGS ... GICD_IDREGS + 0x2f:
>      case GICD_TYPER:
>      case GICD_IIDR:
>          /* RO registers, ignore the write */
> diff --git a/hw/intc/arm_gicv3_redist.c b/hw/intc/arm_gicv3_redist.c
> index 3b0ba6de1ab..8645220d618 100644
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
> @@ -363,7 +363,7 @@ static MemTxResult gicr_writel(GICv3CPUState *cs, hwaddr offset,
>          return MEMTX_OK;
>      case GICR_IIDR:
>      case GICR_TYPER:
> -    case GICR_IDREGS ... GICR_IDREGS + 0x1f:
> +    case GICR_IDREGS ... GICR_IDREGS + 0x2f:
>          /* RO registers, ignore the write */
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "%s: invalid guest write to RO register at offset "
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

