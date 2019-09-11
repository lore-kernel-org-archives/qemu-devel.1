Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF08C49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 14:48:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F03120644
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 14:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PNOF4pyl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F03120644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i83vL-0004OS-MX
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 10:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45291)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i83p1-0007ei-Fk
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:42:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i83p0-0003Ai-En
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:42:15 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:41511)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i83p0-0003AR-9P
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:42:14 -0400
Received: by mail-qt1-x844.google.com with SMTP id j10so25473564qtp.8
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 07:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=OrqciU6SzLz+CiWco+/E8F545d1oKr5ISM5XzIw2qcE=;
 b=PNOF4pylPjXX32D+7xa6NV/2d5H/6JoNgHZnnBgyDFREt2da1uoaoHOis0YtlCN12s
 VQVJWxBMA3YPGlbG9ACFHw0uq2pEA7qyzvfhAfkXi3aiv8rg9oS3tYzVpq2nauXmIdUd
 EYDgBHLVaHaeJWVW+EKutB/ZyWyjAkJRf8YW49JRcax1xRlIizlKSgPep8qTWStup50I
 I4akt780xAbg7ha3Xx3wY1QHxeIWO04RmtCCTO6J8RSArW8nyyDbj1AcMmcs0zcn/V4D
 i7lPBOPg8+wWBMQ8w5F+0isYIrwVn/0StDprzMIevG9GWNrTehwkCosayjhvOrIwF3lr
 bfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OrqciU6SzLz+CiWco+/E8F545d1oKr5ISM5XzIw2qcE=;
 b=djjmW+MmNZtSH9N42+rZYI2swMmN3F7Ra7Sg1sFV5EElto4Zw4GjvsuftKX6AXyYeR
 iSQnf7dCGcofkAfSh4oG2TJ1U+5HkDW463rRlmAjy+yyP9YOpm/5GT1SY13AHLqMPlXh
 /8hTLmeuppI20nmhqC69vUxEMi6v7EN8NzcW8uxGMhxMdo4/rTnD9zpmSoPFx4ssZLWc
 7OOfztWhsupm4iLO58dxNCHKo9T5FI/wGVaOy7e5lVWqpJ8t6DFUHk5/5W46YmABNGYg
 kidfKkfsGs+hc5pASJNR9bg/XajElxZfXv0VlRW3TRTzHdIr25RF8/z41qFCQsfS0gFo
 Tz+w==
X-Gm-Message-State: APjAAAVw3gQsEhwLBIuxKw3xOOz0AJypiC/MWIw5px6RyKFarrh+g/Ig
 MBkYucvbw0UzrUQn4216hI3Giw==
X-Google-Smtp-Source: APXvYqwLOJNcb7HgBhuz6C55KrF8PzyPsruSf4KkAVsEAV/9kQGmzuyFntMbb08bHiteL1uC7xNnHA==
X-Received: by 2002:ac8:7b2a:: with SMTP id l10mr911192qtu.115.1568212933760; 
 Wed, 11 Sep 2019 07:42:13 -0700 (PDT)
Received: from [192.168.5.185] (otwaon236nw-grc-01-64-229-69-35.dsl.bell.ca.
 [64.229.69.35])
 by smtp.gmail.com with ESMTPSA id f14sm2646452qtq.54.2019.09.11.07.42.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Sep 2019 07:42:13 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190906075750.14791-1-david@redhat.com>
 <20190906075750.14791-4-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <2fedb734-2af5-bff0-f458-c36aa6bd5812@linaro.org>
Date: Wed, 11 Sep 2019 10:42:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906075750.14791-4-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
Subject: Re: [Qemu-devel] [PATCH v2 03/28] s390x/tcg: MVCL: Detect
 destructive overlaps
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
> We'll have to zero-out unused bit positions, so amke sure to write the
> addresses back.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/mem_helper.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


