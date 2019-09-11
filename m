Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F5BC49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 21:12:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E00A20838
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 21:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EkjlKNzd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E00A20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i89uO-0000vI-95
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 17:12:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54190)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i89tj-0000TV-9H
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 17:11:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i89ti-0000pL-3e
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 17:11:31 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:39437)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i89th-0000oh-Uk
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 17:11:30 -0400
Received: by mail-qk1-x741.google.com with SMTP id 4so22303265qki.6
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 14:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=OEaBTf2V0hI83wp0Q8rsw3rpzqVce8iYnEk3vLOEqik=;
 b=EkjlKNzdFnofr0c0JtZ+RpzH8Upg4rZ63LOj8HXPMWDzU/PvS5erNJr/dTtaT+yw54
 xN7UtaxVuPzmCRHvQknPRNH/AUXxarb+JMW1GeUwlUpVXpksATwg7e8cDTMPKbhu8jMf
 zvuUU/6Q4hQF+3pHpl2sTHlK3JpUs0CrHXbKuiOz+esOtzoPB2hx9s07mBKAbFyDAYdn
 xHdMbvZ3TlOVwxxuIfCRR7ppyPRDxipbTT/xlsfla8sAFAEbqi8l43Zf+w1KyizvA9s9
 eN3aCASIz9RniGeRqctr6wqhljO52JAddyR0W4ukDjopLzOobbx9+EvgsEmigId13MPB
 Fc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OEaBTf2V0hI83wp0Q8rsw3rpzqVce8iYnEk3vLOEqik=;
 b=IrVD6CXohBOnXgcLdOjW3XTUmn6hWtD5OtHDJZu/wrrk8OnMH+M5XLypU0F3NKA9ON
 ySfpnxNHeUJsCQV670RDO0ITsTHRYbn/iaLpoXhhSpD/x+qVrQpXxLxm5w8p1Nxvhhax
 Mo1e1Crno5otVe0CYU5IAuBMfxk3g1nIznMQ+CgauBvDOz3qAJSYsHYUzXfR0StdMRko
 OxNMOQIROffo27OeRvQIRgYfCy7MeZS20dIyuCfsp/N3ljWHKg84WmccaUSjD/Qf/dTH
 sl8m85Z6uDNoP3+9DtUw7hBSuSSjmgB6LVR0YwgusDAVOJusvl4qSK5fx0I6ViWyqu58
 hhCQ==
X-Gm-Message-State: APjAAAVg0t5Cv3XJpdCa7OP9MdRQv8YkFFvKhlH7yPoLi5RNiHz4CKzx
 7WQcjGxuhtTtHkhe+L4pQ2lVRw==
X-Google-Smtp-Source: APXvYqzVTq40iS9pZPCrXgxwCsG5w0gdeb7nlVVYJ7qYHTJxDxIXLGOo05GyUJW53duspAz9E7y/Yw==
X-Received: by 2002:a37:a182:: with SMTP id
 k124mr37851212qke.354.1568236288629; 
 Wed, 11 Sep 2019 14:11:28 -0700 (PDT)
Received: from [172.20.5.51] ([67.69.50.154])
 by smtp.gmail.com with ESMTPSA id l22sm8795252qtp.8.2019.09.11.14.11.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Sep 2019 14:11:27 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190906075750.14791-1-david@redhat.com>
 <20190906075750.14791-17-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <2536ca8e-414e-980b-6a00-b097c07aa5d8@linaro.org>
Date: Wed, 11 Sep 2019 17:11:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906075750.14791-17-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
Subject: Re: [Qemu-devel] [PATCH v2 16/28] s390x/tcg: Fault-safe memmove
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
> Replace fast_memmove() variants by access_memmove() variants, that
> first try to probe access to all affected pages (maximum is two pages).
> 
> In MVCOS, simply always call access_memmove_as() and drop the TODO
> about LAP. LAP is already handled in the MMU.
> 
> Get rid of adj_len_to_page(), which is now unused.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/mem_helper.c | 204 +++++++++++++++++++++-----------------
>  1 file changed, 115 insertions(+), 89 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

