Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3974AC282CE
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 15:35:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0227E20850
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 15:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mTwHXO3g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0227E20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50813 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEbjA-0005BL-29
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 11:35:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hEbdd-0000nT-Ua
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:29:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hEbdd-0001Bq-3c
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:29:17 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:36830)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hEbdc-0001BM-O8
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:29:17 -0400
Received: by mail-pg1-x52d.google.com with SMTP id 85so3688046pgc.3
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 08:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=ktJGr5Jfv361QpuU4BPGXzMuOOrLXeJvQKQH/1BYFxA=;
	b=mTwHXO3gcX17PEZfr3sBY51B163qSmuh3pPYKBAMfsR6QSCU4HKheLf10ysDKK/ylI
	m1vTSdjF5aJbFBtjPj7aHksHyOu2kAOBR66yJeaELfc8rcEiR1074kJ0vXOXDhRUIbX4
	mt1HueiKM8eCns3XM5coUsKUHIJQNNUU5cP1n+aghD42oQurh6A67InYIcAqYtR8LRPE
	Lcf3cAyNtNqJYPULdyLUbefmuYF+O0W2jlmn7lMtyJfAB03/TmiNlLvDeZtbUWlIwmot
	v8R3qwQGq/6AD7tqpFQdgJYBmXwlrntgGkr30HzN7kszqRV00AmfOEwxA7kflVYJmvBQ
	8t5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=ktJGr5Jfv361QpuU4BPGXzMuOOrLXeJvQKQH/1BYFxA=;
	b=SUPou3VWCDMfJ85t97PnGV5auILHBjQeKWGZwtJkodQ50neWfuZmNlr0Hxm3QSdCLq
	W3u4buMxtqFkGvYMnPlclFCOMyTjsXa7Y+CrfdaxD18S0qCgr3CpN5hTWTXRwkf2CzMb
	HnS9NY5XRxQW1/bulr0m85gAS9L18xBIHK/wqh4hbJtzPj3tF/OCOBpYWvT6MSx/GWXU
	/5ExN9wuztg4ISJMYgm0YoLPr1mzZKpE0+Oga9QvMLs0jk9vHnHlSJqmPTIE2O6zUA+p
	nPzAKD8OpuPJX8hTVlD7WNgin7BxuC9/0BFA38s+vaBEhU7y3uJuhsMyq+aXMLKtM6E6
	Sn9Q==
X-Gm-Message-State: APjAAAW+4bqAVxUC0o0iZXfZYqUrpqnNwVgS+WwbUzf9as/dfwpb7x3N
	ey8zi9nq0BDMSLJNpjqKEtQAHg==
X-Google-Smtp-Source: APXvYqzg6FxFaUgoGItKRv2NJlhchZIHFKRHtYTHxGFEa8SqMITH/SGElpnzLgDw9rwZ5myQ7WjwZQ==
X-Received: by 2002:aa7:8719:: with SMTP id b25mr50418362pfo.90.1554996555195; 
	Thu, 11 Apr 2019 08:29:15 -0700 (PDT)
Received: from [192.168.3.43] (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	81sm30366441pfy.89.2019.04.11.08.29.13
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 11 Apr 2019 08:29:14 -0700 (PDT)
To: Stefan Weil <sw@weilnetz.de>, Richard Henderson <rth@twiddle.net>,
	qemu-devel@nongnu.org
References: <20190410194838.10123-1-sw@weilnetz.de>
	<46e4ee2d-f991-1910-db15-0ec216ab9cab@twiddle.net>
	<f7f4f96e-7900-45e8-10ef-65f7870b3c3e@weilnetz.de>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <7423e23c-244b-3481-db82-e84baa4976d1@linaro.org>
Date: Thu, 11 Apr 2019 05:29:10 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f7f4f96e-7900-45e8-10ef-65f7870b3c3e@weilnetz.de>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::52d
Subject: Re: [Qemu-devel] [PATCH] tci: Add implementation for
 INDEX_op_ld16u_i64
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
Cc: Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411152910.ylEDvDnCKFhFljOwmNgSSaiYfkZixHDkCHLcaK84R00@z>

On 4/10/19 9:37 PM, Stefan Weil wrote:
>> Why not use tci_write_reg64, since that is the size of the register you're
>> modifying?  Let the zero-extension explicit in the name of the opcode to be
>> reflected in the zero-extension implied by the passing of a uint16_t value to a
>> uint64_t argument.
> 
> I think that using tci_write_reg64 would be wrong on 32 bit hosts.

... as would using INDEX_op_ld16u_i64 in the first place.
This is already within #if TCG_TARGET_REG_BITS == 64.


r~

