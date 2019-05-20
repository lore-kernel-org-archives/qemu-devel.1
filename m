Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54851C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 17:38:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 284F4206B6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 17:38:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 284F4206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39337 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSmEo-00044N-4X
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 13:38:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hSlxr-0006Y1-B2
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:20:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hSlxp-0003bc-W0
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:20:43 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39062)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hSlxp-0003aO-QY
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:20:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id w8so15516545wrl.6
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 10:20:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=rGovGWCGVTw0/7S/ozvyRwUzMR8pvgv1I3ri6GNXBsM=;
	b=Bt+XJKUAZXBgFYdQ95sc+g+N8unV5HUJnCZaFDmGuiJERYgIIfFxGDktVbpzQqHiQR
	nVVyaBz9he5Nr/MTrpTX3GNCcpQIjD7dDZNMPLVlPrpGaOnJtfkkiQxnBCgVBWbLtqdF
	dhriEbRsjkRDXYGRmqX2Z3o2EF8XGXKQ4u5Br0gWByOYyIdOSN5/RvrX+/tvGBHGUxvE
	Zhw3mFkQAcfP3rlu7HsoskUSLJx6fjLpeMumMwxR4s3Y+CvBKMBDkC03QFxjTHyLc9b4
	XPbpq0ASMi9/oS+1JZvZj2mC10NcJpMSdh96cJx9JSqLnw6IJwjhbwqvejFepgU/KJEt
	kYnQ==
X-Gm-Message-State: APjAAAX+HteS9LacmAYLzFmGuUMzXWtSTxbMUdO28RJjitI1ns0LVwW3
	UxUU0VFs05F6fTsN/R7XuxogIGa4e9E=
X-Google-Smtp-Source: APXvYqxj8drm7J/dgxmJLey5IICAeHzk9/62+x/iWe2XbG+Aod+yz5Ogx9uulEnde6KMYCU/H//m1Q==
X-Received: by 2002:adf:e850:: with SMTP id d16mr32604035wrn.269.1558372839839;
	Mon, 20 May 2019 10:20:39 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	k17sm15291292wrm.73.2019.05.20.10.20.39
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 20 May 2019 10:20:39 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
References: <20190520162809.2677-1-peter.maydell@linaro.org>
	<20190520162809.2677-5-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <0d39932f-8959-cb68-1ac7-ac79cfdb98a9@redhat.com>
Date: Mon, 20 May 2019 19:20:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520162809.2677-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH 4/4] hw/intc/arm_gicv3: Fix writes to
 ICC_CTLR_EL3
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

Hi Peter,

On 5/20/19 6:28 PM, Peter Maydell wrote:
> The ICC_CTLR_EL3 register includes some bits which are aliases
> of bits in the ICC_CTLR_EL1(S) and (NS) registers. QEMU chooses
> to keep those bits in the cs->icc_ctlr_el1[] struct fields.
> Unfortunately a missing '~' in the code to update the bits
> in those fields meant that writing to ICC_CTLR_EL3 would corrupt
> the ICC_CLTR_EL1 register values.

How did you notice? Simply reviewing?

> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/intc/arm_gicv3_cpuif.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
> index 000bdbd6247..3b212d91c8f 100644
> --- a/hw/intc/arm_gicv3_cpuif.c
> +++ b/hw/intc/arm_gicv3_cpuif.c
> @@ -1856,7 +1856,7 @@ static void icc_ctlr_el3_write(CPUARMState *env, const ARMCPRegInfo *ri,
>      trace_gicv3_icc_ctlr_el3_write(gicv3_redist_affid(cs), value);
>  
>      /* *_EL1NS and *_EL1S bits are aliases into the ICC_CTLR_EL1 bits. */
> -    cs->icc_ctlr_el1[GICV3_NS] &= (ICC_CTLR_EL1_CBPR | ICC_CTLR_EL1_EOIMODE);
> +    cs->icc_ctlr_el1[GICV3_NS] &= ~(ICC_CTLR_EL1_CBPR | ICC_CTLR_EL1_EOIMODE);
>      if (value & ICC_CTLR_EL3_EOIMODE_EL1NS) {
>          cs->icc_ctlr_el1[GICV3_NS] |= ICC_CTLR_EL1_EOIMODE;
>      }
> @@ -1864,7 +1864,7 @@ static void icc_ctlr_el3_write(CPUARMState *env, const ARMCPRegInfo *ri,
>          cs->icc_ctlr_el1[GICV3_NS] |= ICC_CTLR_EL1_CBPR;
>      }
>  
> -    cs->icc_ctlr_el1[GICV3_S] &= (ICC_CTLR_EL1_CBPR | ICC_CTLR_EL1_EOIMODE);
> +    cs->icc_ctlr_el1[GICV3_S] &= ~(ICC_CTLR_EL1_CBPR | ICC_CTLR_EL1_EOIMODE);
>      if (value & ICC_CTLR_EL3_EOIMODE_EL1S) {
>          cs->icc_ctlr_el1[GICV3_S] |= ICC_CTLR_EL1_EOIMODE;
>      }
> 

