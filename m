Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86471C49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 21:39:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C3D92085B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 21:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OtdhD7zp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C3D92085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8AKw-0008KR-Gj
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 17:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i8AJg-0007UM-KC
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 17:38:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i8AJc-0003Nq-7q
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 17:38:18 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:33930)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i8AJc-0003Mi-49
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 17:38:16 -0400
Received: by mail-qk1-x742.google.com with SMTP id q203so22397374qke.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 14:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VjoGAPkzI76OHMq+wI3WO8RY7RMfm9D74OTV0WL6Z3Y=;
 b=OtdhD7zpQcLj3JEazfTvKQoPNqO1DTFXvZzJ5uBaSY8Y/Y2tuL204OQHXo+/jJGU1s
 xHWMu93N7KzXX+ehkFAV0+WKQcgUPCC1uHAPIeEjQXnd0lOFhdS4NItja7PXI3qTHzIF
 TeDR+NHbxllSjLYHpkct0tqA1Oae1xXsj5xnOvWOlQTrH29jCLljHywgVY65ewNQFNot
 oOCvs7iYg+EIedg3dOrTsSw6Wt1gQyGKZDUq1mNc5V6n3PnPqX6dLvHj7UZ9FYTaZA6M
 iTsolxSbqJ+AxJGnilBdoqlPnbnWWDIwNX+z3vBv81YVKd0sqPxnmMgn9tKSjJAbXlsX
 RpZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VjoGAPkzI76OHMq+wI3WO8RY7RMfm9D74OTV0WL6Z3Y=;
 b=Uxl1/QBrm8WHpUEhkOWHXgi9BMxfsH2n0r7FaZj8TFAbGlsf/zl3On4PApHfx7Fb20
 9YOpSue04PdyXA0ozvz8QjaBzmg8su3FL6LtOXRLthayqGbr3F2Dizs/gnYtXPFWuVBU
 iitcLzj6Fe+jBmi9wy9D/slWK1DXXqadKbLt8F3Pl2wUwuV3aQef8vZaMa1w4dkTM+G2
 W9WwE0UPMhGt3/lfd1b69IjmmuX3yG/HUJnxecPUvRqR+BkHFR0K/QT7tMUKuUwz8hPc
 GXN6Ot6a2lDVSoZuosPNoqHVVNiO8HxPKAQnutOWKUDg2RkNwXnz0kcSsnBagXOWAuTj
 qr8g==
X-Gm-Message-State: APjAAAW3KCgDO2ZblKzLCEsx2UPV8j9P4xsEfxBKFZAM0v4ZvPF8p9VX
 AYhPSa7kpztewSbYqETxjqf52w==
X-Google-Smtp-Source: APXvYqxx5/QbNnhdD7MA36mla7txGFXRPxuJiFLapjHDsKuSGaKVOQ/oGuz7SwrzKSOpdpYg2mm2wA==
X-Received: by 2002:ae9:ee06:: with SMTP id i6mr17010344qkg.3.1568237892577;
 Wed, 11 Sep 2019 14:38:12 -0700 (PDT)
Received: from [172.20.5.51] ([67.69.50.154])
 by smtp.gmail.com with ESMTPSA id t40sm13622121qta.36.2019.09.11.14.38.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Sep 2019 14:38:11 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190906075750.14791-1-david@redhat.com>
 <20190906075750.14791-26-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <9cee72f1-3e5d-c1ea-37c5-55560e0d9c88@linaro.org>
Date: Wed, 11 Sep 2019 17:38:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906075750.14791-26-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
Subject: Re: [Qemu-devel] [PATCH v2 25/28] s390x/tcg: MVZ: Fault-safe
 handling
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
Cc: Florian Weimer <fweimer@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Stefano Brivio <sbrivio@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/6/19 3:57 AM, David Hildenbrand wrote:
> We can process a maximum of 256 bytes, crossing two pages.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/mem_helper.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

