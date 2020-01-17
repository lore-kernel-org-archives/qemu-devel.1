Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8249C33C9E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 17:31:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F3282073A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 17:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mqKMA30I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F3282073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isVT2-0000mW-0R
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 12:31:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53446)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1isVS9-0000HX-Rg
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 12:30:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1isVS8-0002CF-Rh
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 12:30:37 -0500
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:53451)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1isVS8-0002Am-Kj
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 12:30:36 -0500
Received: by mail-pj1-x1043.google.com with SMTP id n96so3441328pjc.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 09:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=h1CzXGyPSgcp4W4X48Fvvvy6A4vmx5d0s3Q5h62TvUk=;
 b=mqKMA30IXbqp9TrRdnZbIdGW39QZISAtYSJUFKX4XMDr2ZRJ2tpy6Y7rhxSdSOVDy/
 2bWD7JOJq2L473ZBregBu+0rU6qEKqAhDNe4DNmJyAUmloF/uQzXpxFRabWlGVrxZUQa
 2CFV+54fnQVlJMPsfV8LyvG1ZDqDReZoIlXffa1GQJmqk+5739eQtR7DEk6G7BB6mscV
 vSoZGycNGWgj5RNaXb9+jrng372rcG2eCRxKYzyy7Kb4oaIMlLaG0D2LPgQQ9Xx+vExn
 N0wflIsdUwjR8urwUdGADDCN1US6uEQD3EYME9f2Up5wohtBzyWvn1f7uxRJWAi30d7C
 xNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=h1CzXGyPSgcp4W4X48Fvvvy6A4vmx5d0s3Q5h62TvUk=;
 b=MJ3gPy2qPqL6QYIW9Rt9Cf35MLyvq4m5Ut9N84MNHlv3lJv2Z1XYH7R0ajeAsXdv5L
 yXVdiKJweUsknqOY/uxN4MkFq3leYzpiQcZ+zF1LHZVNK+IttYN+GPL7BtqQ3WNJKVQ+
 xp8s5miAlXsb5aKyMfy0a+M1/YpUIpcVawmuLxw64u4bwOskT7uC5k5Z2Hq6xifUvA6G
 j/ecmU7NhyNB94NuM3PbQCS/72t/DKRbEbpPy9zlUqvclICDsUjpJR+oKwPAfBu5LenD
 kXr8RpCpUqjkRhMea2wC5HVwVOyWPOprdlDKXoBZOVzJrkEuX6qXQtIvEmKr1k6oZc/F
 Ea2g==
X-Gm-Message-State: APjAAAVwhupofBpBsoeNAYzYjq9GjAz3uaO08P2ChFnG2ejXuiLdA+RU
 tjI4Mfx7/dVYCjP1gLYRerQsOQ==
X-Google-Smtp-Source: APXvYqwrUC0ShaOCI28JI9MPNQXBMoKJabikzM/yKGZnc2Z+CpURqFYcmCUUY7GpW2S4fD2B2jxP3A==
X-Received: by 2002:a17:902:74cb:: with SMTP id
 f11mr92638plt.139.1579282235324; 
 Fri, 17 Jan 2020 09:30:35 -0800 (PST)
Received: from [192.168.3.43] (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id e19sm8093191pjr.10.2020.01.17.09.30.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2020 09:30:34 -0800 (PST)
Subject: Re: [PATCH] target/hppa: Allow, but diagnose, LDCW aligned only mod 4
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
References: <20200117015322.12953-1-richard.henderson@linaro.org>
 <7b14c840-0d3f-0c67-06be-81b058c727fb@gmx.de>
 <08c4bdcb-b07d-eb30-a38d-f27ed6400952@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <57d3bd1a-0597-8353-46bd-09dd93347f7b@linaro.org>
Date: Fri, 17 Jan 2020 07:30:30 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <08c4bdcb-b07d-eb30-a38d-f27ed6400952@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: dave.anglin@bell.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/17/20 6:13 AM, Philippe Mathieu-Daudé wrote:
>>> -    MemOp mop = MO_TEUL | MO_ALIGN_16 | a->size;
>>> +    MemOp mop = MO_TE | MO_ALIGN | a->size;
> 
> 
> Hmmm you changed MO_TEUL -> MO_TE, so from MO_32 to MO_8.
> 
> Per your description, shouldn't this be MO_TEUL | MO_ALIGN_4?

The "UL" part is also being added by a->size.  This code was written this way
in preparation for the 64-bit ldc, and the bug was not noticable because we
don't have that yet.


r~

