Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2DFC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 18:24:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CAD826971
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 18:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zYyHrV82"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CAD826971
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47503 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWmCF-000178-9y
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 14:24:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWm7x-0006Ff-5R
	for qemu-devel@nongnu.org; Fri, 31 May 2019 14:19:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWlvE-0007dp-B2
	for qemu-devel@nongnu.org; Fri, 31 May 2019 14:06:33 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:40552)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hWlvE-0007dG-25
	for qemu-devel@nongnu.org; Fri, 31 May 2019 14:06:32 -0400
Received: by mail-ot1-x344.google.com with SMTP id u11so10069927otq.7
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 11:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=hnyA9wLgBHKbbQ34W/r/zs8QVVWUjRzRSAHWhGML1Iw=;
	b=zYyHrV82yiC9cypEYdrLcieSLV8RBxaXepAYTRPFZFr7qX/eG5kXc/uRX6Iyjf0UaV
	cX9LUBgHdvXnpDLEaij2GFEZ++1uNO5wPppMP2oVCjMjK0A3anS3lBy901+SrH2IZHtb
	AITAHfDy4muKPOi+qDgT/RQ96LErkgvrHhziiMJeeN9mfCR0Xju6IRvxBwEBZr/plZG9
	l8vuXSYn8PSgYr4CX9jeGanScXADwKr5qo5B9rSUfTmzOwwEiSnBOr9YtOqkVXjNmhAG
	ga8FUHcJEP2rVK8+fBB5bWgwcmYQtXtxoVBTy7X6AVN4CYKgghkEsjvEOHZzd53DcRtl
	vQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=hnyA9wLgBHKbbQ34W/r/zs8QVVWUjRzRSAHWhGML1Iw=;
	b=gW1J3U/ZoT/0LZg/yrWB6Zdgd30KDFq+QeTlFY4QSX1hchhYxmoLYq2tWaHCBkxNzG
	UZAh0DZyQ3xQOrpYM6TkTFlMFRs63+LcmFIyaTbPh+vl5OkL5OBdLUvNyqPp3NaLkybf
	jK8iIKk6xQ/nwHfrUrojJbcYXqxFyqmT9r1uRp3q8kp0TWE/I1GRXwfQ4SFR2WoilhPk
	WoceCg3SNnGgbyIH8gQAfPAKZ3lNUY7WDPlWRMs+aaGHNEPpCui8+Raf7Znj2YIBaA/h
	QUPeSmHX3H0ol2kElpYfUcRQQBXglJiazkCNVroZ4Gs4gKVPx/2hwAHxXrVEd7dKKvmH
	y5Uw==
X-Gm-Message-State: APjAAAXTjBb/AoAEAFujc27/8JsXx8l5Ubj8VikADd1W3/Ki5Jsjjio+
	3yLMN5BsaDChV3swkiamh4JgvA==
X-Google-Smtp-Source: APXvYqwxQagWjoZU92yGjRU1DsSuVzoXG5ZcXEajmP08cQNXCSP8iFPQiEBv1EWWYTiFVW2OQGFM6g==
X-Received: by 2002:a9d:3ec6:: with SMTP id b64mr2739621otc.314.1559325991002; 
	Fri, 31 May 2019 11:06:31 -0700 (PDT)
Received: from [172.24.12.210] (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168]) by smtp.gmail.com with ESMTPSA id
	p12sm2207884otq.57.2019.05.31.11.06.29
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 31 May 2019 11:06:30 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190531104432.29379-1-david@redhat.com>
	<20190531104432.29379-24-david@redhat.com>
	<a65ae6d5-e9cd-a3ab-c770-5d8f3fcaa6e9@linaro.org>
	<eea6986f-5da4-ff22-385e-ba8bc419a7ac@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <89db4302-dc14-23f6-bf17-c783f187acab@linaro.org>
Date: Fri, 31 May 2019 13:06:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <eea6986f-5da4-ff22-385e-ba8bc419a7ac@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v1 23/23] s390x: Bump the "qemu" CPU model
 up to a stripped-down z13
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

On 5/31/19 12:58 PM, David Hildenbrand wrote:
> Are you aware of a HFP library?

No.  It might be possible to shoehorn into softfloat, because I *think* to can
treat HFP as BFP with weird rounding.  At least that's what I remember from my
old college daze on the esa/390.

Otherwise we could maybe steal some code from Hercules.  I see "OSI certified"
and "Q public license" on the web page, which iirc is compatible.


r~

