Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE82C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 23:48:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42551207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 23:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rMkQP6Uz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42551207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCuXx-0005IX-Ag
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 19:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50853)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iCu1o-0006GZ-8e
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 19:15:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iCu1n-0007jh-3I
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 19:15:28 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:41216)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iCu1m-0007jL-Qy
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 19:15:27 -0400
Received: by mail-pl1-x644.google.com with SMTP id t10so1588506plr.8
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 16:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Q2k3GUr3SAzAjwy6rPxhiGuKjd66qeUszHaOxEKx8rY=;
 b=rMkQP6UzR5MaO7TRZuHXnGLGxOIGWK1nVJacz1rbhSxewgbElrmeUVdrFuu/mQjry+
 zSjnlG6SmqzQIMo+EAGdaDOh1ewgy2notRomg31+qhTv/GG1LnUTOdlxYXV/YjCbTcDm
 rlTwhiifDp7TtJUoURrlxCFF9H6kezkmuvy1XQ++h2blZlGAtz+GDuaf52zd1DjiCqqA
 JaJ9Th1AnRKITwlZtLOYYzHf2UefonmDx3B8WiinVrrxdWmMgDexp1QsZGbSm5CFR0F5
 GpIykBwv6Q2+FGUDRbdFLkjlaVz3Ec7Aay2Nps79IX+r/Sl2PBO1/EbTr0nGBZryplDp
 Ewlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Q2k3GUr3SAzAjwy6rPxhiGuKjd66qeUszHaOxEKx8rY=;
 b=r1qzDZip2jb+sV2Dj6zfQRsloWTRj+0yH7G6uxYF8jAi2y8gB0uPniQTlyPjRbMzmB
 XkXMkUZrr41NaWD4LpzAhwmovMnFX8sXtZqS8OB5EhFVKdOdvhHhR7dp8N92FcA9vyOl
 O+PhE0GrNIutniqAxpQ5qkHAc+AVG+E6JA822RTvqs5EdqoNz/GSjiLrsuWGVUfDabAL
 xJO7JSpCMUOU9jdWHAvFZ9x9pM/trPxAa0Hr6vsr2IUyXNLKUcsTs/Y5SIc/HL8Z1w2H
 mAC4RUqV69YYtRgub+GCzDJV9bTCNH/A3mkDsw9H8acTYVv/GgWC1gd1p2EDMDHdzsHD
 t4lA==
X-Gm-Message-State: APjAAAUzn7ivmho7aGeoLD1MZZRiGuIpoZmgtffVQZaQjsHN/Twe6YdM
 ZuC+KM5l6T+glud41IrPwawfsXCkGXU=
X-Google-Smtp-Source: APXvYqzno6UY8XO/fYdl0gEn4M0qrvRkQ/FPCI49iGOhmOLbrWD+KgvkZQUdwtooZYgqXaXBRhbuuQ==
X-Received: by 2002:a17:902:b482:: with SMTP id
 y2mr5057574plr.334.1569360573206; 
 Tue, 24 Sep 2019 14:29:33 -0700 (PDT)
Received: from [172.20.32.216] ([12.157.10.114])
 by smtp.gmail.com with ESMTPSA id q20sm3311132pfl.79.2019.09.24.14.29.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 24 Sep 2019 14:29:32 -0700 (PDT)
Subject: Re: [PATCH 1/7] target/ppc: introduce get_dfp{64,128}() helper
 functions
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, pc@us.ibm.com, david@gibson.dropbear.id.au
References: <20190924153556.27575-1-mark.cave-ayland@ilande.co.uk>
 <20190924153556.27575-2-mark.cave-ayland@ilande.co.uk>
 <e4e2220b-d23b-aa54-2c46-c937bd0efe86@linaro.org>
 <e4ba6c27-e57a-de8f-c993-4172db2ea01a@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <af723c90-4dc3-c45d-b3fa-75d7a7097833@linaro.org>
Date: Tue, 24 Sep 2019 14:29:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e4ba6c27-e57a-de8f-c993-4172db2ea01a@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/24/19 2:05 PM, Mark Cave-Ayland wrote:
> With the full patchset applied you'll see that get_dfp64() and friends are
> in exactly the same form you show above, and if I swap the arguments then
> the compiler does actually complain, although somewhat cryptically.
Oh, good.  I'll finish reading the whole set before making too many more
comments ahead of your actual steps.


r~

