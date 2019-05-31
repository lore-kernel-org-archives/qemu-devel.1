Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571AFC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 17:52:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2467C2642F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 17:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MrUPTdko"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2467C2642F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47178 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWlho-0007Ut-EY
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 13:52:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWlgc-0006ex-7r
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:51:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWlgb-00006d-1B
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:51:26 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hWlgY-0008Vo-TQ
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:51:24 -0400
Received: by mail-ot1-x343.google.com with SMTP id t24so9996372otl.12
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 10:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=4sDxSNVJ0DnE0F/TPiPp8rI+YRiJEEEqf81aayINH1M=;
	b=MrUPTdko/dD95kMf3AN/ToOqKhCuwKzxiSRMNz12vaB749vHDZRL7EwE4g/zTi1VHi
	2wRgJIb4t367z/EbIJyC/kW+0s9wHRExcPUvyV0e565WSpLIYXxTGwtBnSui+PiGXRV8
	n2H0C/OLYiQ0G/lzEv2M7jeXt+JhEFIHx8wVVpbtgYeXGC1f3/MObd/ZiYz/c+HYi+gq
	uh3Vg95WdzgPcUD3bWr3HJwgkmaQKGwJTHTewu+I6HwNZd1RDjknCs/g6Yu5BA5vJbc5
	g5z8bV2NypzMFOpk38hzSz89Leb0btCyKDVW8RF4o0t1hZajOzJ0cCMl9VY8mRYJDhdC
	TrXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=4sDxSNVJ0DnE0F/TPiPp8rI+YRiJEEEqf81aayINH1M=;
	b=qguX7qVcFX3swgp/86X1az54JjAT7VuRYRy5Cv5Ivc/Tph4GxBYnUBMifcaYnphiWZ
	N1rGcHpxv2kZG5RdG8wpOglOY2hPtauzD3RgQE5//73CgHkZwRb/tD1gaD1UaLhn5Dfm
	48PDINXyAqI1v5WJhD7UZYJSaEECo4GL28kWRdkhFiqfafFHYre5C4/JQiSjsR0x8jdE
	se2bhxKR1ffeApeVsBZ51VAVF7e+G3fPvAYsNeN8WBZcIUMyyPCgXFFVaBPW5fmYRdkB
	6zaGkMm4TpkaZLv/+nIWQhvazeAWIr9LN0jHn/k4bOLvzMtqnU8leQI5yh7IChhuXqVf
	gKvQ==
X-Gm-Message-State: APjAAAVtBAp4FHjm7xcWNSMhsaE4fDf1qszBygdFfP/yi+42buunYA6B
	U1x6qwtwlafzJXQ5ZSrmiJK3zg==
X-Google-Smtp-Source: APXvYqzmmAr8MPJxV45FWupOZzb8PKYcR5LJCLi9BD7BW2DI7w7CohGlo+sYOdZaEJcS0C+JVARs2g==
X-Received: by 2002:a05:6830:2149:: with SMTP id
	r9mr2787262otd.210.1559325082197; 
	Fri, 31 May 2019 10:51:22 -0700 (PDT)
Received: from [172.24.12.210] (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168]) by smtp.gmail.com with ESMTPSA id
	h12sm1046146oti.71.2019.05.31.10.51.20
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 31 May 2019 10:51:21 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190531104432.29379-1-david@redhat.com>
	<20190531104432.29379-20-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d052e01a-056d-5d8d-4a69-f0451055bd8c@linaro.org>
Date: Fri, 31 May 2019 12:51:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190531104432.29379-20-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v1 19/23] s390x/tcg: Implement VECTOR FP
 SUBTRACT
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
> Similar to VECTOR FP ADD.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h           |  2 ++
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c |  3 +++
>  target/s390x/vec_fpu_helper.c   | 17 +++++++++++++++++
>  4 files changed, 24 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



