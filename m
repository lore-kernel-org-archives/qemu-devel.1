Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD11C5ACAE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:47:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 395F02089F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gISRMP7N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 395F02089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i84qK-0006rn-2z
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 11:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55673)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i84ZJ-000067-F2
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:30:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i84ZI-0002VD-1H
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:30:04 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:37825)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i84ZH-0002Ud-Pw
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:30:03 -0400
Received: by mail-qk1-x743.google.com with SMTP id u184so18312157qkd.4
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 08:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=BO7GFqdrqAcKKpdSwrUpnV7FzHwEPwd3mFCKB7mnIyY=;
 b=gISRMP7N8edhvw52S87oeSPqa3fanA/+Xs9P6nwaXWt7aNUOdpli3w8gjhAcGHG9EJ
 bhAp8QhDXwB0JC4F4+MuDJ2Xj8AtVlru16DVLcrSU1HbtD9AVwKYywR4TggetNFlyCz+
 ctwoLMdSjAxuchmN+b+Gj2KL3X5fdA9yFvgmfOR/rUcMvm4i0hIU3vfDe9yN4xFMdM8G
 zgAa6O4yGXIeTmILPsFcSwSj15FKXDSPSZ0igbtYPbDSge81rbng5Wmnm2W+HF3tnNmP
 5Izu/VDcdTGXuPnr5M3tvs/nIQaStQQOYI4escWrzvoOFmOOV7ctIcgZb+Lf+LDp01EQ
 kMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BO7GFqdrqAcKKpdSwrUpnV7FzHwEPwd3mFCKB7mnIyY=;
 b=gLpYyYTO8LwUEYIqDyL/7Vre7eb3SFbAwmCtUsYNjExb/691NfZxAuymIBC7Ec9Rh4
 kQAJ/dWgyoEEpUMo1F2qQUdK/WQYe5t8ePruTAU/hP/Y7D7s7PqFdp6IZb1jYX4fqnNi
 lrR1YkAGi3u68b+eNk+CqfF90F4uGBLIMdnC1IJfulJIgfxqaaW1LMD8yS4apUrad0D6
 m8VZZ1swN3cJ4lHbq/wyb/QvXUJWyVoZmDvIg0F0Tpw4wzLaTJimXFZ0KDObNE2JK9dC
 Nai+VIZ1jysxbqgyJkh8KNwBrJhlNdbGhntwifyUiHHo2CC7oLRpu8fkL3+TjGnd7+Mw
 2dVg==
X-Gm-Message-State: APjAAAUygfUuc10HQok2jH9C+vLJu/Q46wng37f5GbuVZHQnzdayzJMr
 KNSHczcyhD255YLYsAkF7mg5dg==
X-Google-Smtp-Source: APXvYqxlal+DabqrVniDai4ezpSedikvWupNY8KXUKgN1Bv9mAfMkcK5qrNkShnBkwpaN3QtAO3LTw==
X-Received: by 2002:a37:6651:: with SMTP id a78mr23240323qkc.474.1568215803031; 
 Wed, 11 Sep 2019 08:30:03 -0700 (PDT)
Received: from [192.168.5.185] (otwaon236nw-grc-01-64-229-69-35.dsl.bell.ca.
 [64.229.69.35])
 by smtp.gmail.com with ESMTPSA id c29sm13906803qtc.89.2019.09.11.08.30.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Sep 2019 08:30:02 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190906075750.14791-1-david@redhat.com>
 <20190906075750.14791-16-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <14ac2663-4ffc-7688-8662-19db0f775db0@linaro.org>
Date: Wed, 11 Sep 2019 11:29:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906075750.14791-16-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
Subject: Re: [Qemu-devel] [PATCH v2 15/28] s390x/tcg: Fault-safe memset
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
> +    if (likely(desta.haddr1)) {
> +        memset(desta.haddr1, byte, desta.size1);
> +    } else {
> +        for (i = 0; i < desta.size1; i++) {
> +            helper_ret_stb_mmu(env, desta.vaddr1 + i, byte, oi, ra);
> +        }

The only thing perhaps that we could do better here is to re-check
tlb_vaddr_to_host after a singe access.  This would handle NOTDIRTY with a
single iotlb access and then fall back to memset, without re-checking host
address for real mmio after every store.

> +    if (likely(desta.haddr2)) {
> +            memset(desta.haddr2, byte, desta.size2);

Indentation.

> +    } else {
> +        for (i = 0; i < desta.size2; i++) {
> +            helper_ret_stb_mmu(env, desta.vaddr2 + i, byte, oi, ra);
>          }

Likewise wrt NOTDIRTY, which suggests a subroutine to handle a single page?

That said, what's here looks correct so
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

