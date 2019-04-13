Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9126AC10F11
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 06:18:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DD0D20869
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 06:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uounp/ca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DD0D20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47399 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFBzn-0007cd-IC
	for qemu-devel@archiver.kernel.org; Sat, 13 Apr 2019 02:18:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFBz0-0007Iv-55
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 02:17:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFByz-0001Y2-3m
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 02:17:46 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43444)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hFByy-0001W0-Ol
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 02:17:45 -0400
Received: by mail-pl1-x642.google.com with SMTP id n8so6111149plp.10
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 23:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=vkMJpRMtuQwMViTWD9KjuryELlHTeBZ7meuzyfOEGCw=;
	b=Uounp/caif54pSzqxUr0/5RNRuVCt7eLnbSnhtWY4WDaezZHYVCK8X7jiAc8GCAE6Y
	P2kR6IF/HN5hWpumvUvjQ6cLf4Nq1aci+oj98ZtS27p3m+6c3jTxeqigbyBAbdvxyFAv
	MpgagH4c29IxSVK7569zWf29LSUNu7i4gf/mVOSJHgYEIVa1lYyTx4vsDU2wURW/S0cc
	1OB667si6YdU73GOrPmJdx1npgSWJlBd79rHUL4RtRzq8mqAjhhhv1KQ3qVJhnMVvK/R
	Di1dt6V3lRhtuSoIggjmW5t192Vd0tkcsV1snT5YR6gKiDzluquHBFvW6cQvDon3WjGS
	i1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=vkMJpRMtuQwMViTWD9KjuryELlHTeBZ7meuzyfOEGCw=;
	b=NH8pr/rKwaLiWsv+YKA2+CyqOqMSUWE+YghyjAcKYI/VVLyVHzV1F36bjXLLTJcYDL
	0XibxUxwMPVGxoeuq1zCTCCLzwRlY81smtx/ap0U8mewUOLL1I4g2L0aii/r2moYc+3g
	EkBciU/66zctT1DEjtGqF6yECHrI9qYsIYeY1HlWUWHH66pe5ouPzsxr2mTQ/aLAJBiG
	iNVmlFnJEzXoC2WJEaq4vw9+YR0Ol3qBchng2k8KFCXk8aBYLrkPAvLiAtwBVGtJYRtV
	V/sdTVQlJUvfmbUnyAaDMjtDomAZKgESCeCwdHu68m3qKjjBjbllD51H6cpn97nsTx1o
	+klw==
X-Gm-Message-State: APjAAAVBZgz0AHjJ3jVMZwtrCbRHUHHMZQ0YenRKyynmLnESCGzZrbOw
	2lsitTloFLs8q4r5a4LBbSwngw==
X-Google-Smtp-Source: APXvYqyam1m1lqOleEcF0UT11znTZIC5yUUQ68MomCyALhzBzsOmnCvyOJ2EsEj3Ni+Y2Ts/itfXvQ==
X-Received: by 2002:a17:902:e182:: with SMTP id
	cd2mr62764138plb.240.1555136263391; 
	Fri, 12 Apr 2019 23:17:43 -0700 (PDT)
Received: from [172.20.98.58] (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	j22sm58089881pfn.129.2019.04.12.23.17.41
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 23:17:42 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-40-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <606f01ca-f4db-068d-7dcb-c1c7925a9216@linaro.org>
Date: Fri, 12 Apr 2019 20:17:38 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-40-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [PATCH v1 39/41] s390x/tcg: Implement VECTOR SUM
 ACROSS QUADWORD
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190413061738.-bQtQ7vfzDVd4Ow-OxpPr4jjwmY3z_bAGaN4oY2RSjk@z>

On 4/11/19 12:08 AM, David Hildenbrand wrote:
> +    read_vec_element_i64(suml, get_field(s->fields, v3), max_idx, es);
> +    for (idx = 0; idx <= max_idx; idx++) {
> +        read_vec_element_i64(tmpl, get_field(s->fields, v2), idx, es);
> +        tcg_gen_add2_i64(suml, sumh, suml, sumh, tmpl, zero);
> +    }
> +    write_vec_element_i64(sumh, get_field(s->fields, v1), 0, ES_64);
> +    write_vec_element_i64(suml, get_field(s->fields, v1), 1, ES_64);

It's a long way around for ES_32, as there will never be overflow into bit 65.
 But I guess it's not wrong.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


