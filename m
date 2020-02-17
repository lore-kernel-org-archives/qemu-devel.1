Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF53C34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:38:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2890120578
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="huqf4VgJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2890120578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3mEM-0007f5-7e
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 14:38:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56375)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3m9z-0000FT-Ma
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:34:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3m9y-0005bx-M0
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:34:27 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:38589)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3m9y-0005bH-G5
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:34:26 -0500
Received: by mail-pg1-x530.google.com with SMTP id d6so9734341pgn.5
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 11:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ySFA3KfialoliWZET+9zt6n0u1z2S8g5S2ST1nfP0eQ=;
 b=huqf4VgJiaCjjhiPEOE7QCdEOJowpb92DuYyzWlS9ohGUqLGDMLhu+ttN6eUCoB/Xa
 VI2+qZcygxKZRm884MTrMEL4KHx5WhAer2K5P+bO8FEL89ZME76ZIZSqNr+k73qAGbK4
 YZKGi46f56DSbRHt6jFDpQ1PaE6+P5Bb4IEfZJubSAiTLkXYlhURwhBLD79jI/yKkgSA
 k0jpihjZUetrJfy4xgzlKeX0PIj7QxITuc3utFFMaJUsPIyTzyDMt2DumgdmcKX/cATt
 geytfqzxlwY4SA17thMJaf04vmzo6BsUQSOhHHYJsrc0Id94sG9IROOFtLONY+pohULj
 JHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ySFA3KfialoliWZET+9zt6n0u1z2S8g5S2ST1nfP0eQ=;
 b=t/Iu3ck2GGwwBUVvvZcN/wcf+Va7Gyf2UKCUNlUAaowF2egTqW+IVJ5tL0vaWyaG4V
 704ZNjmXP+piQCmHFeVGiyQOljqkcu7o6NV0BfOAS2N+nGWx/OAa9c7E/Ury3w+a8Afm
 uNpLKLk/HD5UTZbxwB/4wFppHtMVUDwlnWZDBmZch8b6yOGqGAQxONvXP5WW37wP5hKm
 CBaP3M2/FYuwEspT6R8uz8RxiAVIlreDsiKfQdBGNezEoacygaoMucQeQ64T+AiiAE2F
 UttnwnuRrsZXTerPKZ1jNMe3gbg6uWkgyMdRt2LhB2kLMtBLs2w1MFNyulMzGD+TBIQy
 SitQ==
X-Gm-Message-State: APjAAAVmuZaOa40PH4hVE6Q/JAsWsAyuMVXB6Tw+vHzvmYQ2wPCtR9RV
 Kqi674BmeJTWFNBWTlBQegZjrQ==
X-Google-Smtp-Source: APXvYqz+bFr/7cNKwvcYXzJXGKNGyExzR6IOUMhWGcF1W0uR4maoKHULQd7aeHMkSWksWayA6Edo7g==
X-Received: by 2002:a62:cfc1:: with SMTP id b184mr17681693pfg.55.1581968065370; 
 Mon, 17 Feb 2020 11:34:25 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 z10sm1728178pgf.35.2020.02.17.11.34.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 11:34:24 -0800 (PST)
Subject: Re: [PATCH v5 63/79] ppc/ppc405_boards: add RAM size checks
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-64-imammedo@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e135eeb1-1ae9-14f7-f984-451f686e64b9@linaro.org>
Date: Mon, 17 Feb 2020 11:34:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-64-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::530
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 9:34 AM, Igor Mammedov wrote:
> If user provided non-sense RAM size, board will ignore it
> and continue running with fixed RAM size.
> 
> Also RAM is going to be allocated by generic code, so it
> won't be possible for board to fix CLI.
> 
> Make it error message and exit to force user fix CLI,
> instead of accepting non-sense CLI values.
> 
> PS:
> move fixed RAM size into mc->default_ram_size, so that
> generic code will know how much to allocate.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> ---
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


