Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE99C34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:44:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 203DB222D9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MkPoI0fK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 203DB222D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3lNE-0003uB-B8
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 13:44:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3lMO-0002d4-62
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:43:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3lMN-0000d0-6S
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:43:12 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:37798)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3lMN-0000cf-0Z
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:43:11 -0500
Received: by mail-pg1-x544.google.com with SMTP id z12so9674677pgl.4
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 10:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=neBA8Hq1GQLpQE9uLrWtM+1QvsYgKbBzd7S7LOkq7UA=;
 b=MkPoI0fK4wxmXoBVB1SZ3BoRrdX82+kCcUYJsKrmVxILW3F1bx76geI9u9hSSX1/xl
 MGVUzhc3HnmQi6Eu2Pvo6ONsOh+3Pkge+6q2i2vOdhQzcnD7yB5H58vbiFjtffSYnQZo
 HvgnazythMn+vmvQ9Gsp0Te3ycLnDd2x0SiHf6up6mbUdUh/qQWE2hEjlXOCXwvq5+EW
 AFkur8O0z0P4e1jl9LGngh7Zk6u6TSeFBJjQYS84FWu4ISoLFFkNVkbJsp2MNHHrAosK
 kggTcXwFQIcFB8L3xBpqiQIBBH/FtuvK8xjAWC++JViiP1TV4aXSCd41AIM0JcaFtVPY
 XDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=neBA8Hq1GQLpQE9uLrWtM+1QvsYgKbBzd7S7LOkq7UA=;
 b=rBY4uzUxl3j/919b7DDj84CNA9YrxUEHzsIhYP8oz2ml5kNuaTQBShrNgHyICBSY8h
 B7wzFG2r8+gPnXDX2Lq4Z+v151hvCBEYaSPZz37Dai1pfrFS19D5uuNYboMez2a9lHzU
 GcWQhKafb9vhdPoJfq7cW9hms13pN/mBHmXhVFYWPfjtgu97W597JME9R2IkC4ivJ2gZ
 8oSBx0Z8d2mNi5AozU87sOpbAh6m2nz3s/8dX+JObXYN/UCInEo1EBJ85JkbA8g4X8Jl
 hQKfV9j8nBeUD+3Fzm3IIF/a83E9/qfzfga8wawrlFRN2r8Q4DS7soupTyH3PbGdZrio
 6aBw==
X-Gm-Message-State: APjAAAXLvnZrWhx/rXU2oQw0JxdZpK+PUWnMDuNzbUF02wwQwH2P0SAD
 GNm4J+tQ/Wg2H09rQ1S8ODyBBw==
X-Google-Smtp-Source: APXvYqxR9LUw6efxmmejX8FoH40Q7noE8wsora4g009tH3MiWCmDq2zpeLWRMI7iXrGONxYk0C4OuA==
X-Received: by 2002:a17:90a:bd97:: with SMTP id
 z23mr464448pjr.19.1581964989632; 
 Mon, 17 Feb 2020 10:43:09 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id j8sm189372pjb.4.2020.02.17.10.43.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 10:43:08 -0800 (PST)
Subject: Re: [PATCH v5 02/79] machine: introduce memory-backend property
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-3-imammedo@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1acd01a5-ea66-b9a1-79b4-0a903fc916ed@linaro.org>
Date: Mon, 17 Feb 2020 10:43:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-3-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: pasic@linux.ibm.com, Paolo Bonzini <pbonzini@redhat.com>,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 9:33 AM, Igor Mammedov wrote:
> Property will contain link to memory backend that will be
> used for backing initial RAM.
> Follow up commit will alias -mem-path and -mem-prealloc
> CLI options into memory backend options to make memory
> handling consistent (using only hostmem backend family
> for guest RAM allocation).
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v4:
>  * make property a string, instead of a link.
>    Fixes -M memory-backend=foo: foo not found error
>    since foo creation is delayed well beyond point
>    where machine's properties are set
> v3:
>  * rename property name from ram-memdev to memory-backend
>    (Paolo Bonzini <pbonzini@redhat.com>)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

