Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B81FC43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 20:22:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54FA420866
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 20:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cqb3L/P7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54FA420866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40884 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLvkR-00039V-Cc
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 16:22:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLvjh-0002ns-0A
	for qemu-devel@nongnu.org; Wed, 01 May 2019 16:21:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLvjg-0007s7-3v
	for qemu-devel@nongnu.org; Wed, 01 May 2019 16:21:48 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:34873)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLvjf-0007rY-Tn
	for qemu-devel@nongnu.org; Wed, 01 May 2019 16:21:48 -0400
Received: by mail-pl1-x644.google.com with SMTP id w24so8671616plp.2
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 13:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=igkppwCXm54O3OBwUGQYzCmsVfl8AXOSNeV0i24t+4c=;
	b=cqb3L/P7K1xabOrB6Gybb3iQ5z6UcoKVf3FOv7g/soL3VwiqUmNMYeAYQMWd7YR12E
	qdXusFvab/VZUNtVB86j9sCtpYWR4mVk6UY4vN2nCKyXLTbsBpZPFnSMqVvmUI0fMlDv
	aW8Na8oNYByuvSbh+QgEyTRs0DBdGEO0RbWnBhNCaGJFEkiyQCQZQolS/wUKTpd+JwYU
	jVtaYTsj/LqRdqtXeBP67IbDwqNc/2Bj04zNbfYGN9qFzQCrG6b2KG46GN71bLcSgZRE
	wu8D2IX+7avjbkbmhQyXSe1EMSTEDu4Cj0ZDkoSI1uJ/Bd7VSPNcx6KyHPXje3il//Rp
	EINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=igkppwCXm54O3OBwUGQYzCmsVfl8AXOSNeV0i24t+4c=;
	b=SZegmWvY5HlvpnicnyHPmKpn0lc7Wb+u87HIGSHEEopFaTZG2Udu8O+TR+tAEBraV2
	AVJurHE7CTT4yP2HvxVUZ/xC0I4G5trNxuAbOEN5HXpR01WHqI3dNNZxHc0bkuNiw6JC
	Ca2nkcmwBKvao6fanK482sns7t1K1iehWA8YIEQt09IWzvroJl6USCulDoIN+qECKIMP
	G9vFQNC3XksUV9bRw8ik5vDJpz6d5IveTCIkscfoQTuhTYSnk6o3oop9S8ngxy9pTLcf
	mfuXdcJHsOErV8voxgrFmR9918llIi7YxIBcF+hLFBxAzO0S/axHyYMPb161sXwCPvpG
	Zhjg==
X-Gm-Message-State: APjAAAWHv4jS2dK+pAxsdri+0M1gss5UHcMN4gwutMZUrq7ly34SKfu4
	jgjKS4B0+fZCPBhYXs6Mt9DY4m2GjVI=
X-Google-Smtp-Source: APXvYqxwwgn9aUCyvljfhaXKaUxHmU34dVb2LC0JTHgNkAd8vQG66bdaxmcVdgQxQyJrQp4UDz482A==
X-Received: by 2002:a17:902:a583:: with SMTP id
	az3mr79667490plb.205.1556742105937; 
	Wed, 01 May 2019 13:21:45 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id
	y1sm46300098pgc.29.2019.05.01.13.21.44
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 01 May 2019 13:21:45 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190501050536.15580-1-richard.henderson@linaro.org>
	<20190501050536.15580-9-richard.henderson@linaro.org>
	<87lfzq5b4w.fsf@zen.linaroharston>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <71153219-741d-3c27-53b8-455c62de36c8@linaro.org>
Date: Wed, 1 May 2019 13:21:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87lfzq5b4w.fsf@zen.linaroharston>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: Re: [Qemu-devel] [PATCH v2 08/29] tcg: Promote tcg_out_{dup,
 dupi}_vec to backend interface
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
Message-ID: <20190501202143.Sivx3r5BM0c55m28Iltuy4btTjqTCsMEH1UjitZ0djI@z>

On 5/1/19 10:37 AM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> The i386 backend already has these functions, and the aarch64
>> backend could easily split out one.  Nothing is done with these
>> functions yet, but this will aid register allocation of
>> INDEX_op_dup_vec in a later patch.
> 
>   "Also use correct type for tcg_out_dupi_vec"?

Added:

"Adjust the aarch64 tcg_out_dupi_vec signature to match the new interface."


r~

