Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779A4C5B579
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 10:03:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39460208CB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 10:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vIAwVhJc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39460208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgnj0-0004RA-7v
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 06:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53086)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hgnhm-0003LJ-Pn
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 06:02:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hgnhl-0003Ir-Lj
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 06:02:06 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40972)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hgnhh-0003An-QJ
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 06:02:03 -0400
Received: by mail-wr1-x443.google.com with SMTP id c2so5615357wrm.8
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 03:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dUaTT133M6N6iRffm9OBJKPIznJwm9poJo8urSZ/JXw=;
 b=vIAwVhJcXzrD+nNgFEnqa0N73cWyeZ1EbJNAiM8m+2dI6WgBrmSMzMJZ2jAhDwREuC
 HlE0+QBXBKxQx5BW6AGCqG7bH5rEo2uvEmMuz+BZDMCbySqePgZROH73TnMpeQ6bqk+y
 drrC06zO/rCXMt6ZIhEeMMRy8QyiFYZJa141n2ObtLnoJfNmYSo3u30GezR4U5yawSpH
 oSlOgVk0UdWnQeknRz0VIJBzL6klf/mZ/y5HUdC+/YO8x0jacw78rCZ/6fODxkmp0sAe
 Ore15Zf4CKPmy0MZYrwrp1TvND6VLr/GvUlIw5P/oWh+qGKtJgzavkW5WpKJtSvs8Nhj
 NShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dUaTT133M6N6iRffm9OBJKPIznJwm9poJo8urSZ/JXw=;
 b=FrBuBcVMy5dF5iUPkvzU95iNgSCoEJkyDF4DIu39ksyJWVN/SWAEESfDScLJeCs7E7
 MOtD5Uz/ewTthGcYGpAzEaACWp7vwZXHlU9TK+FEZPBcbkfDjxL03JXga7/gTKM3TjWb
 9dySLBTrXM6UPWFylOCDva6FJqBYv06bxgwnx64Vy19aCx+72ptjGX0p7KN/02vMT2Qz
 5oSVUgl7NyDruLl8LT6DgyMhqqESHaqtcd5ScvT7j+a3YCUlqzyasL7yGVS4L/i8cPhy
 ucGcTJnajQ8wtZRdl7dQumHfYF+6Z25K8ANctGzGeSUcDkXPeJC9/DwnjLHahcF3hbVC
 utHQ==
X-Gm-Message-State: APjAAAXlBdERQqRQK1FYlP9RwBqlV5B+r4HfFGzluf4rHsdjvxndkZf1
 5VSsAEuRvfP3kKzpVC5X7BLPBHFkYgW83Q==
X-Google-Smtp-Source: APXvYqxqEc3e5opc5bnDLd0FcFIwYsINqiQgXM3vLg7Bo6sOwKnb4Pdgjs5mfymnBoSLpYUojj7HYw==
X-Received: by 2002:adf:e84d:: with SMTP id d13mr2841269wrn.88.1561716117897; 
 Fri, 28 Jun 2019 03:01:57 -0700 (PDT)
Received: from [192.168.2.137] (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id 66sm1626681wma.11.2019.06.28.03.01.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Jun 2019 03:01:57 -0700 (PDT)
To: Igor Mammedov <imammedo@redhat.com>, Michael Rolnik <mrolnik@gmail.com>
References: <20190627052750.31856-1-mrolnik@gmail.com>
 <20190627052750.31856-2-mrolnik@gmail.com>
 <20190627132800.462655c5@redhat.com>
 <CAK4993j0BP62dEM_X7dP_9zT5JjJ1F4_OwEuHTnVY+59RHgm0g@mail.gmail.com>
 <CAK4993gq=Nz+r0H5jOfY7NqS2+rjM=vMRJSCtbXbxPwtwZYRSw@mail.gmail.com>
 <20190628103626.2d10bcfa@redhat.com>
 <CAK4993gOmQK71qNDyYe-f00Xqny+OXDH1O89gXmQVh8jdqmABQ@mail.gmail.com>
 <20190628112253.275bdf7d@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <32aa0f8c-f779-4629-c3a6-9cad5357642a@linaro.org>
Date: Fri, 28 Jun 2019 12:01:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190628112253.275bdf7d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v23 1/7] target/avr: Add outward facing
 interfaces and core CPU logic
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/28/19 11:22 AM, Igor Mammedov wrote:
> On Fri, 28 Jun 2019 11:43:22 +0300
> Michael Rolnik <mrolnik@gmail.com> wrote:
> 
>> Nobody else does it.
> it doesn't mean that we should blindly copy pre-existing patterns
> which might/will exist for compatibility reasons.
> 
> pls see the same argument on RX CPU for reasons not to support
> anything else beside typename there.
>   [Qemu-devel] [PATCH v16 13/23] target/rx: Fix cpu types and  names
>   [Qemu-devel] [PATCH v19 03/21] target/rx: CPU definition
> 
>  
>> Richard.
>> What do you think?

We are going with Igor's advice for target/rx, yes.
You should do the same here in target/avr.


r~

