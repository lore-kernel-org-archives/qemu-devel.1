Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20D2C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 17:56:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C10E826D83
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 17:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lbxGm93s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C10E826D83
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47226 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWllS-0000im-1A
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 13:56:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWlkN-00007e-0O
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:55:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWlkL-0004p4-9V
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:55:18 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:42582)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hWlkL-0004oE-3u
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:55:17 -0400
Received: by mail-oi1-x242.google.com with SMTP id v25so7798655oic.9
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 10:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=ItlfX3eea/MQXK+9296JXd1RGHTyZIthoSdVeg4kGrc=;
	b=lbxGm93sFj16HhZHEJFVtbpoYJB7nnoIkLi3Qj29QmGlFFpdjo6ZqLWg05wyecHovA
	yOXyxgecI2fqaaQxJAfOWnvKBQUxaejBmJkDRh4Br4WQl6eL0egKx80kr2k5LbI65hoD
	0vmnN3gqraImsRwn51UMwAIw3XEcZqS7wO+Pe370AM4hDFoDxiWmgrnnW3+8j2a2l4QK
	epkQi5oBeOgwRxYc6+9OgIOrm/f/+BRctS+dYLyvUfvbzbk156twXFK6sbqdUnOJ6BC2
	kgT0oLCbhty5ymeiGmYdA4ugZ4lJKiV6J8pDF9N3PU+k2Q9FDZggGuwEOxO2lYO+WDKL
	QKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=ItlfX3eea/MQXK+9296JXd1RGHTyZIthoSdVeg4kGrc=;
	b=HCRMJLkxwW1b4qssb6nY36ZBrUQxIoBprpCVoN8n2D8EJu1uIts4SgKxjifMyjeB1L
	FVhUW2dua7Fb9znuUder+hQzB0ti+g94yGJ10rqBIVBiY53MgU5dOD+J3yTNpkx8PDTY
	iS3YxUK9+KIwgLtwkoBUVcBR8cHpjL9Qr1BbRXHh16NwSjlZNlyI9qHmiv3lgad6ea3D
	41ZwkBIOPeEDH9M/1TDMVTq5/rIJ7FXYPMUcOI3Ju8IBM5N2HB9L+vUwS5f7/zgxNHOa
	va7XCxto5iroKH0jRZAfdd1HvA+riooZHRgZ1mFqb0S+Fy7anib6bstJTN8Fle/0l1lm
	2Fxg==
X-Gm-Message-State: APjAAAUv1plPSFZhKkK2dKxCQueB5OTXDfqsU4LQCbGodK60pfATssLg
	NftlryheFzBwR5grKachiVdeOQ==
X-Google-Smtp-Source: APXvYqyjMwxXTmRjwWcKxm9FbJZBigqTHQG+a2vJK05qrudQ4x2JvCL7RHh32yAVEjgBywaDJQxMFw==
X-Received: by 2002:aca:5ad6:: with SMTP id o205mr118178oib.92.1559325316003; 
	Fri, 31 May 2019 10:55:16 -0700 (PDT)
Received: from [172.24.12.210] (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168])
	by smtp.gmail.com with ESMTPSA id 59sm2411776otq.8.2019.05.31.10.55.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 31 May 2019 10:55:15 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190531104432.29379-1-david@redhat.com>
	<20190531104432.29379-23-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <1bb8e6bd-b41b-94a1-e110-9ed0ebe499e1@linaro.org>
Date: Fri, 31 May 2019 12:55:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190531104432.29379-23-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH v1 22/23] s390x/tcg: We support the Vector
 Facility
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
	Denys Vlasenko <dvlasenk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/31/19 5:44 AM, David Hildenbrand wrote:
> Let's add it to the max model, so we can enable it.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/gen-features.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



