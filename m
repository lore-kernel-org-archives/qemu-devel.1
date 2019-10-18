Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7D5CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 18:57:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E183320640
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 18:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CB24nTpd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E183320640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLXR4-00063k-SD
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 14:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40434)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iLXPx-0004lm-1v
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 14:56:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iLXPw-0005rb-5b
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 14:56:04 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:46146)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iLXPv-0005qo-Lt
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 14:56:03 -0400
Received: by mail-pf1-x443.google.com with SMTP id q5so4405513pfg.13
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 11:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ZUUbV8ymRLgABLYM8MHvxuL10t9ty/qU6QeRlIeHBzQ=;
 b=CB24nTpdfhzvz7D1UQld8Ty5JDERuDhvaWKsohwclB0nPn7TUMl0g91/0cl0YW5x4Q
 TtppS3gAXth3Vgi3GtGkRJ3V1qBydP3Uh65t2O1+msnYIJdysCDQ4JGBxrMQC9ZtGzQV
 +cS0I4463UiH9QiO8msLzlhkm8GlyPDEObrqjkzVy1JiLWhbGlojg2qAS7gC8icmDaWq
 DuBRQqKeNQ6UMZ+f69t9+Em3RTW1iFImgetueLDst/LpIx3Xl/+m4dWXyg/+nRWbmW0u
 oAtv6VLCqngoPP4UO/e5DcxNsPpfrFqVGS/sqmwzA+zu+HO/yCv13v/Wd9MWw3H/KwT/
 Q8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZUUbV8ymRLgABLYM8MHvxuL10t9ty/qU6QeRlIeHBzQ=;
 b=DaUJ+IvF+uaBBy523qfLcasKukV0yzlVGhP/tGyfYWNlMpBRXDbXeHjfFQv7RB4HTg
 +ZGRtfbh3pnMzO+M464tNe/IDDb+URgKJdy49jmEqIzOigxii25To5OVOPNNj0DOe+RU
 tri9C3CtH+2+HK5tYCbj0p5wtr0oZoixpHGeaVxH9WjNboyEyPnoaIPrPtRndgoYummz
 TCzMgGt010rivCYFOKL7YVBQEQEEFDoiKqDpR4i3xhYC0p4dDXbvM/vFdbcshi/b97KK
 UHZt9mZCPTRbcv45iDvhMNfH/68uPOU7s0AEz/UKWjZ3x40p4+q1Okf6AEQ/YywksqM2
 aliQ==
X-Gm-Message-State: APjAAAUTWk1Sb20tGPbaIaYSGpq40agTU5LgSu6CSGX9V8OiUVmPuuL2
 Re/OD9ZC2U8hk4WHiEmVdfJ7Pw==
X-Google-Smtp-Source: APXvYqxPd8j3Pzm4f3UBlYrduKDM3DO15ScHbSBh8jJeS4HndQ5ERLAQHZ/thGtJK2scVY9mZujf/w==
X-Received: by 2002:a17:90a:b30d:: with SMTP id
 d13mr12989170pjr.49.1571424962171; 
 Fri, 18 Oct 2019 11:56:02 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z20sm8975321pfj.156.2019.10.18.11.56.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Oct 2019 11:56:01 -0700 (PDT)
Subject: Re: [PATCH v1 6/6] s390x/tcg: Fix VECTOR SUBTRACT WITH BORROW COMPUTE
 BORROW INDICATION
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20191018161044.6983-1-david@redhat.com>
 <20191018161044.6983-7-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <2761c05e-3189-244d-3fd5-b7090f94796a@linaro.org>
Date: Fri, 18 Oct 2019 11:55:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191018161044.6983-7-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: Ivan Warren <ivan@vmfacility.fr>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/18/19 9:10 AM, David Hildenbrand wrote:
> +    /* Isolate the carry to the next doubleword */
>      tcg_gen_andi_i64(dl, th, 1);

You can remove this now, since the only possible results are 0/1; it was only
our subtract implementation that produced -1/0.


r~

