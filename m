Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A538DC10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 18:20:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D49F208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 18:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YeWVsztK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D49F208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57905 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ01z-0002Ss-KA
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 14:20:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ00z-00024L-4Z
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:19:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ00v-0008Fp-5V
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:19:31 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:45069)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ00u-0008DU-V4
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:19:29 -0400
Received: by mail-pf1-x444.google.com with SMTP id e24so7880748pfi.12
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 11:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=vfyvn11smECe2f2UW2BDcJAI+g6zW9RtaHTxK/MNreo=;
	b=YeWVsztKfpQXTxh1yXZjMfNqotsYe5mapNecFrjL5J/A5Io9BWtwCBHYWsM8LVEyjk
	DZh5xEeA5JGn+l2lRh+3zMU/2rJqm8oH/JQsEkfU71IquNWrS5zM05ZxW0iqLKldHOyQ
	gkZBgBZNH7lMa1VQNXtlBfwd3DZBfFjP64I97Fftep6RSOqTOTZqX8aoMGIv6gWUTWDj
	gmLCybBE+cjlnPnAMXkLul9lOs8RNGbrzRuHfOo/lzxhkkNfe3TZmLcfyaZaPUCpekNL
	jbeREJV+tQfr/U1L1qnQl1K2dixsudk/036eJINMZdGuF3OnoyVlkSCcxQqqTspTOmtd
	GV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=vfyvn11smECe2f2UW2BDcJAI+g6zW9RtaHTxK/MNreo=;
	b=pXv7gUu+cR3KS8FJ7ZPtudq7jOfU4IbOS7LgI7mPKFfywCWnwlbkE5PhmcERO3Z8xh
	a2+kZs3Y5NQt3CzKj/2dNVncZ+j3Aao3l/8ETv1RdmELVSITFrn5GxI2o40+9Nmh7BWZ
	UTBknctvGmqkhcSHctru3gXesMlBaA3Qa5U7IBTTG7pRWtuh49lY+2rvM6WCmyM6vjzj
	agwy4hiQ2hx0m+Cp5r7J+disLSIZa2uleydsQVVAXoQifGN7qZBLpc02TM7xFqLPaHxw
	/iqV/Zs6tfKHCLkBPR8WQ+ubTiaw4Xtuo5LVYESQJCG0Q98lXtypH0lKQI3uBOZOmogC
	+Aow==
X-Gm-Message-State: APjAAAV73ODUw7DJBjd+N2iyXHNtZSzF4ffrEPozw/2YysG3pmJu+Z5J
	oKSgeHex0eYmD1fHWqGN8+1wdXpaw6M=
X-Google-Smtp-Source: APXvYqx9Y0M3lReud9dMQEoS7IAmwYFuS+dRvjTLyeKSiW1iJOvsvWG31l5gn+ULxer37eD9VqKKzg==
X-Received: by 2002:a63:1359:: with SMTP id 25mr25539688pgt.92.1556043566744; 
	Tue, 23 Apr 2019 11:19:26 -0700 (PDT)
Received: from [192.168.1.11] (97-113-179-147.tukw.qwest.net. [97.113.179.147])
	by smtp.gmail.com with ESMTPSA id
	c3sm29267491pfg.88.2019.04.23.11.19.25
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 11:19:25 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
References: <20190416125744.27770-1-peter.maydell@linaro.org>
	<20190416125744.27770-6-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d5f58c94-3122-9c65-6f6f-18d19acbad8d@linaro.org>
Date: Tue, 23 Apr 2019 11:19:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416125744.27770-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [PATCH 05/26] target/arm: Honour M-profile FP
 enable bits
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
Message-ID: <20190423181923.kHcswisIOXOPl_-zy8_651hEtdo9a5sFtoUf59GeE3Y@z>

On 4/16/19 5:57 AM, Peter Maydell wrote:
> Like AArch64, M-profile floating point has no FPEXC enable
> bit to gate floating point; so always set the VFPEN TB flag.
> 
> M-profile also has CPACR and NSACR similar to A-profile;
> they behave slightly differently:
>  * the CPACR is banked between Secure and Non-Secure
>  * if the NSACR forces a trap then this is taken to
>    the Secure state, not the Non-Secure state
> 
> Honour the CPACR and NSACR settings. The NSACR handling
> requires us to borrow the exception.target_el field
> (usually meaningless for M profile) to distinguish the
> NOCP UsageFault taken to Secure state from the more
> usual fault taken to the current security state.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c    | 55 +++++++++++++++++++++++++++++++++++++++---
>  target/arm/translate.c | 10 ++++++--
>  2 files changed, 60 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


