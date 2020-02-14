Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAA7C35242
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 20:17:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0342222C4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 20:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ktT3k91Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0342222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2hP9-00055w-0D
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 15:17:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53284)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j2hNy-0003VQ-LN
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 15:16:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j2hNw-0008W9-Pp
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 15:16:26 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:42740)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j2hNv-0008SS-2x
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 15:16:23 -0500
Received: by mail-pl1-x641.google.com with SMTP id e8so4116801plt.9
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 12:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=yLOIlj4grM8eviEKTqXRptVV66hvg/CY2BHHsnJ6OZY=;
 b=ktT3k91QI2LArI/nDEvOp5qp1+rc2G6SI1Fs68B20ern9mNOvsosFQfH052r9yxdA7
 Bm7MdmVtTbPg8dQr8o1vZqmPbBpvYj6hBxY/xEVKaYW+vx87YzYywu6GQ4HRJTTqkM4S
 KMLeqDMfwZJIGFntKl4ty7pK/MzXBNNvMTaf+Le4DBMBNIX71PlBEnBKAUjitJuyuuaQ
 bGXbbKG08S/+RVypC0v2R9nv/9w0SoccnBuqdD6PimqMQHI+yNyJmDrpmMgoGTOjwhJu
 mrGviXSugVKRgRnd81jT8lFhL31bJq8WxSosmTOSR+lyVMrlLjONpv5eLnmO01g6v682
 o3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yLOIlj4grM8eviEKTqXRptVV66hvg/CY2BHHsnJ6OZY=;
 b=nk72ubtL7pRj1oDPPA+ER+HZxNC2Jhmc7LPsxLkj8BZ19zUyb+zkZ9g0gTddm6ks3/
 cyVsmuvcbMPsQGfchEXFYyXbjm/SP/tS2LGxNbbv1ZIG1jGymNk4UrMoasIYDriWo6Jr
 UzjdFgMggT1//Z7GeN37gc6UvXHG8mqhO6wUQ8NfSJN8h646NR89WUAgYOP4XV4AXOBR
 CpH26aUkJtunlpGkkJEQfULviXVdNpsLFIwjp5XlOEylB375eLLYdb20k2etUheXeJQQ
 6C55z5qingNhGw1HbblD+bH6OgjrDtfQufvbKn7bLeNoW+z3LM/W7NIhd2Lo6qQneD+d
 2fOQ==
X-Gm-Message-State: APjAAAU5zUX13s/i7FyWuBy4oMqP1JNeaJ8WbXEeGWr4mI2BkZ9/RqJ3
 C8rUPmcTrG5jHq0yo6htjSD/SQ==
X-Google-Smtp-Source: APXvYqyHlwli2Jx/Yg+3xpHv1hkNoYtXnxvxqcVXApbXqLrfkXmM6aOjykuv59A9xTr8uCW86c9qlw==
X-Received: by 2002:a17:902:820b:: with SMTP id
 x11mr4984546pln.196.1581711381611; 
 Fri, 14 Feb 2020 12:16:21 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 z4sm7854380pfn.42.2020.02.14.12.16.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Feb 2020 12:16:20 -0800 (PST)
Subject: Re: [PATCH v2 11/21] target/arm: Move DBGDIDR into ARMISARegisters
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200214175116.9164-1-peter.maydell@linaro.org>
 <20200214175116.9164-12-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <728d0df5-3fa1-f9f4-1fd0-9671a494b3f0@linaro.org>
Date: Fri, 14 Feb 2020 12:16:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214175116.9164-12-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Aaron Lindsay <aaron@os.amperecomputing.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/14/20 9:51 AM, Peter Maydell wrote:
> We're going to want to read the DBGDIDR register from KVM in
> a subsequent commit, which means it needs to be in the
> ARMISARegisters sub-struct. Move it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h       | 2 +-
>  target/arm/internals.h | 6 +++---
>  target/arm/cpu.c       | 8 ++++----
>  target/arm/cpu64.c     | 6 +++---
>  target/arm/helper.c    | 2 +-
>  5 files changed, 12 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


