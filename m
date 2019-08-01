Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5897C19759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 20:19:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC31320838
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 20:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ykGQiLik"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC31320838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htHXc-00045O-2Q
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 16:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54678)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htHWj-0003dY-Vs
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 16:18:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htHWj-00007Y-0l
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 16:18:17 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:37520)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htHWi-00007F-QV
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 16:18:16 -0400
Received: by mail-pf1-x443.google.com with SMTP id 19so34693122pfa.4
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 13:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6yz+LFTqIMbOU950btg8zapbKFoC8f/yPYKq0hfG4TY=;
 b=ykGQiLikuiEuOPfghQvN0dPsPVuPY+iOZH6XRmsdgS4I+9rtDIj3iU1OZAMgE8nFbb
 pVJs3OCvEQToPHDmVvZhN0qZtgO5h6AlGmd6zgHKyTibOH6tHmGFg/kB8et6KaxqP2ao
 t1bGBIobgsWhEZoWh8gnV7ctiE7AFNRXJ/76ApkJz1zfcoWg7QWQZjgTrPPcWD2kb89X
 sef7GEplEKf3kA0KqPucn2chvJI3NVC8LEp/QrMoAHWBZR+WxhX5DTB1I3qA3ccLPWQZ
 iVYC/XcP0cupQtyhQ7aUe9kGf9/I0baImg/y20NAWLGA1LKmcqIfVosdhjAtsGFc7UL6
 2Ovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6yz+LFTqIMbOU950btg8zapbKFoC8f/yPYKq0hfG4TY=;
 b=DHBiy2amu6A/h5bdtIodadL59N0pPOfh/vVfV5f6B0Y2c8bbUO7+TnFAwD8iYC8aWt
 zoANQUJEHejqSnJj8wX6KY24mRxyNMjjgBouloR1Nv4Z8SrHN0E6hZuWK1SOu/pekqgn
 SKu5HiEjWtjyw3jFAqVOIhjW1d/E5A7YgjPyt7HQU/50+I25Y2Yy3s8KPesDqOW22Z9W
 1rZgvx3jbGeeh2P/PzZ5in7Wn8KVfTPvla/Sw0hdXN3vXieb2/fwkfnYgwZLNDEWdnir
 mW4K/MSX6TdspGB3+KgNa74U9tKgsSUpTTqqv89FFfmUNbL5ov78gt0y+149kDCEWGi1
 e9mg==
X-Gm-Message-State: APjAAAV1XhpRMOH5NXSyt19nuqeiuy81APwuviH1Rpk+acZZpjAjXpiT
 2xN+RNc5nP4SnO/flqbvnrZVTQ==
X-Google-Smtp-Source: APXvYqz2++e1IrVL2z2tcEyrUPd/cEAXg1onS1olgJ96OwgaJ7DX7/lnDPTz54afE/7itxL8Y6Tg2Q==
X-Received: by 2002:aa7:8b11:: with SMTP id f17mr55563418pfd.19.1564690695739; 
 Thu, 01 Aug 2019 13:18:15 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id v185sm82771418pfb.14.2019.08.01.13.18.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 01 Aug 2019 13:18:15 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20190801183012.17564-1-peter.maydell@linaro.org>
 <20190801183012.17564-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <075e3c64-b5bd-0b30-4775-41ea420a7612@linaro.org>
Date: Thu, 1 Aug 2019 13:18:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190801183012.17564-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH 2/7] target/sparc: Check for transaction
 failures in MMU passthrough ASIs
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/1/19 11:30 AM, Peter Maydell wrote:
> Currently the ld/st_asi helper functions make calls to the
> ld*_phys() and st*_phys() functions for those ASIs which
> imply direct accesses to physical addresses. These implicitly
> rely on the unassigned_access hook to cause them to generate
> an MMU fault if the access fails.
> 
> Switch to using the address_space_* functions instead, which
> return a MemTxResult that we can check. This means that when
> we switch SPARC over to using the do_transaction_failed hook
> we'll still get the same MMU faults we did before.
> 
> This commit converts the ASIs which do "MMU passthrough".
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/sparc/ldst_helper.c | 49 +++++++++++++++++++++++++-------------
>  1 file changed, 33 insertions(+), 16 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


