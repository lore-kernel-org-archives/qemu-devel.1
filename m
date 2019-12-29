Return-Path: <SRS0=KIBN=2T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD455C2D0C8
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 00:01:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D6FA2176D
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 00:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RsFC9qJl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D6FA2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilM1I-0006OL-Ma
	for qemu-devel@archiver.kernel.org; Sat, 28 Dec 2019 19:01:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41668)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ilM0M-0005sW-Om
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 19:00:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ilM0L-0000mI-Jy
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 19:00:22 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:37573)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ilM0L-0000gq-BT
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 19:00:21 -0500
Received: by mail-pl1-x642.google.com with SMTP id c23so13232007plz.4
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2019 16:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=lkN3IB64Q1IrriYJtscRleYQCKAbrUZYj5bSa7990bg=;
 b=RsFC9qJlsPiTHsq1vieDOIHZNFiyEbJsoxq1GwnsAWEoqfTqA4xJbs5t1fz9ipEG1V
 VV3IQFZnNB7mZG8G2i19ZHEddlwO7KXLUlw0quftbImu86++tUbjZ3wbKOpW61TfckGR
 21WFuNskjozarMXke0oVpgSCfIyMIatrqmB4h0E+uYAtkPEQzx2GrkQSKm7uEp0T6HcY
 IZ8pFICokuarL5dkFzYie3fsK03kN7GXhRR94V61TtxYJUT2My4yh+A2i0pmCbTWjQqp
 wpS6MUpfVjQuvM2oPa2L21eq+m61CFtGgjWVl22Qfpd4ViuO4omBFHNAOdwYzMF+o1NV
 ExEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lkN3IB64Q1IrriYJtscRleYQCKAbrUZYj5bSa7990bg=;
 b=te5wsAeHMBI6SIeSZiAKk5K+wMV4iUjGtjhtwsp5mORyPcYCfM+1IRHrXeI3C923Kb
 n/ZDnX+DP69XfgoHPzT3OTIUfDZZ0iJdgAyXClTH2kw03tHxR0tH/p/w3KvZBTwyYyRn
 UtqTnJl6NBE+lNuXUhVuUkVj5fS4py26fX0nbprN99HZdcBgEEC/5FPVY0C1PLtuR6H2
 1bj9+iZXvYT4F0HLF2XaSKEFu3BO745mQIulcjsCPbo6zSelzvZLagNfwCRaUekcf96h
 IhMaEu1EL6L0F3BIMpXmjdX8gNjOp+CUmGBwKVc7H8f2SNrQffOMe56XKIECBCSI+Rbs
 6NJg==
X-Gm-Message-State: APjAAAXWlZgC9avLFu3MjbsG9/Lb5XTB3oll6PLiVPL0vGT0WZI5OvoW
 o1GFm6nfxvjESlaLmf/T5CFIbQ==
X-Google-Smtp-Source: APXvYqwCzhXb7Bo72/LD34zoUHA2pjugOBwgBCeLUrx9HdGgIm2LDMa8W23Kdpnmjp3H8LOUtbViVw==
X-Received: by 2002:a17:902:bc45:: with SMTP id
 t5mr58984379plz.163.1577577620266; 
 Sat, 28 Dec 2019 16:00:20 -0800 (PST)
Received: from [192.168.1.118] (194-223-58-9.tpgi.com.au. [194.223.58.9])
 by smtp.gmail.com with ESMTPSA id v13sm45895683pgc.54.2019.12.28.16.00.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Dec 2019 16:00:19 -0800 (PST)
Subject: Re: [PATCH v6 08/11] hw/core: deprecate old reset functions and
 introduce new ones
To: Damien Hedde <damien.hedde@greensocs.com>, qemu-devel@nongnu.org
References: <20191220115035.709876-1-damien.hedde@greensocs.com>
 <20191220115035.709876-9-damien.hedde@greensocs.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <638df95d-c92f-2dcf-2405-3c71ccb7ac25@linaro.org>
Date: Sun, 29 Dec 2019 11:00:11 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191220115035.709876-9-damien.hedde@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 cohuck@redhat.com, mark.burton@greensocs.com, edgari@xilinx.com,
 qemu-s390x@nongnu.org, pbonzini@redhat.com, philmd@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/20/19 10:50 PM, Damien Hedde wrote:
> Deprecate device_legacy_reset(), qdev_reset_all() and
> qbus_reset_all() to be replaced by new functions
> device_cold_reset() and bus_cold_reset() which uses resettable API.
> 
> Also introduce resettable_cold_reset_fn() which may be used as a
> replacement for qdev_reset_all_fn and qbus_reset_all_fn().
> 
> Following patches will be needed to look at legacy reset call sites
> and switch to resettable api. The legacy functions will be removed
> when unused.
> 
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/qdev-core.h  | 27 +++++++++++++++++++++++++++
>  include/hw/resettable.h |  9 +++++++++
>  hw/core/bus.c           |  5 +++++
>  hw/core/qdev.c          |  5 +++++
>  hw/core/resettable.c    |  5 +++++
>  5 files changed, 51 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

