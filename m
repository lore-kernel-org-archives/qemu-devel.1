Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC462C433E4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 18:01:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 887032067D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 18:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NFWW4Blo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 887032067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwUfo-00033i-Q5
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 14:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jwUee-0002Vd-Sk
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 14:00:17 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:52536)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jwUec-0006Tx-T1
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 14:00:16 -0400
Received: by mail-pj1-x1043.google.com with SMTP id gc9so6906536pjb.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 11:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dgPeCZq9aikFtrDS1LfWs8TsUvouIYbvL66uRO6CVqk=;
 b=NFWW4BlobuIYFZXhFKntgTpdjbLvB7fmAKDunA6rj1eugbtbEAdR8pcvr9hQNVU3q0
 oyDhgrmqly262WqjjQvbQzwBUYpf9HPr3nM0bej246y1kXjdhjeeFzUD6yoSXYfbcz/a
 ECFEGYO9ghor9YW8wFzcqxQLkgOfwYw2DtQLdNp44wwAzTt6ZVNqqmqPcOp8Vh05/Ujk
 J7ylkmE1Y/up0htQeOGPqpBTjpd2y8IyEnK2KoIAk+qiDR28oWAqQ+jRUD3zZH/KcaVG
 pTLiG1zXEvHju2KsuzUqoK6pNANtNYdKI/wsdODAjgUR9ENaefzn3iWvbWpOxhH8afzz
 JvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dgPeCZq9aikFtrDS1LfWs8TsUvouIYbvL66uRO6CVqk=;
 b=BXiaaD1+OkwAjPAre3Ar2K3smrNXT2ukYQQ36x2PvMOtdyELTOpKTimKfgrnfOmvD7
 9pyLV2x3C+Un+2KVod4PzL5Z4NtR0Voo3weUlbvAt3ao7AiI9VrfaPx4QPmmMggnWYmZ
 4N38lbMf+UG24dCGIaXjyo4c2PPkvFKiZo+bOI5rlM/yom3DX3Sl4oX7efn1+Vl74FgW
 ML+ADdNfjyf7dBT9Ph2HnUas7jyEGVaQ6N16CZfZB3VGg1ajTE4EmaVC2hckIa401ZuK
 YAAVZxjF2WlUaKHxWHy+eRd7vCUvNm/jJU1suM41ZTQNPYRBFoYQ9JV7ldtBsldLuWrG
 xYQw==
X-Gm-Message-State: AOAM530OpITFLlR/sCBYgSMcg4UotfP1+2YPodXslXVSTICvAkyV8/7V
 bp6CPIppuBYgdrm79yPGb3zg/Q==
X-Google-Smtp-Source: ABdhPJzxEbTJp2iVzxyJtQA0nr+c17lQK1qBLNBwHW52bYhDzKUroft7jwQ99SegqhDn4ouu+BAiUA==
X-Received: by 2002:a17:902:d70f:: with SMTP id
 w15mr8703324ply.110.1595008811739; 
 Fri, 17 Jul 2020 11:00:11 -0700 (PDT)
Received: from [192.168.1.11] (216-160-65-90.tukw.qwest.net. [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id
 y8sm3499745pju.49.2020.07.17.11.00.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2020 11:00:11 -0700 (PDT)
Subject: Re: [PATCH v1 4/5] util: add qemu_get_host_physmem utility function
To: Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
References: <20200717105139.25293-1-alex.bennee@linaro.org>
 <20200717105139.25293-5-alex.bennee@linaro.org>
 <alpine.BSF.2.22.395.2007171529440.1227@zero.eik.bme.hu>
 <CAATJJ0+JV0PFcPBdr5CbMnQF2FZrSe7B0g0fGmzOobHhjOdfJg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b565376b-a269-27c1-61c5-b010db963f9f@linaro.org>
Date: Fri, 17 Jul 2020 11:00:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAATJJ0+JV0PFcPBdr5CbMnQF2FZrSe7B0g0fGmzOobHhjOdfJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: fam@euphon.net, "Daniel P. Berrange" <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, f4bug@amsat.org, cota@braap.org,
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/17/20 7:24 AM, Christian Ehrhardt wrote:
>     > +size_t qemu_get_host_physmem(void)
>     > +{
>     > +#ifdef _SC_PHYS_PAGES
>     > +    long pages = sysconf(_SC_PHYS_PAGES);
>     > +    if (pages > 0) {
>     > +        return pages * qemu_real_host_page_size;
> 
>     The Linux man page warns that this product may overflow so maybe you could
>     return pages here.
> 
> 
> The caller might be even less aware of that than this function - so maybe
> better handle it here.
> How about handling overflows and cutting it to MiB before returning?

Indeed, the caller may be less aware, so we should handle it here.  But I don't
think truncating to MiB helps at all, because again, the caller has to handle
overflow.

Better, I think, to saturate the result to ~(size_t)0 and leave it at that.


r~

