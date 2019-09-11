Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF327C49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:17:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BACB206A5
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="msdw71Wi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BACB206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i84NE-0005jE-3l
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 11:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50443)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i84DG-0005zf-SH
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:07:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i84DF-0006vK-TF
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:07:18 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:39548)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i84DF-0006uc-Oh
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:07:17 -0400
Received: by mail-qt1-x841.google.com with SMTP id n7so25657122qtb.6
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 08:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=x7A7jDWxquOfq7qhXvyuRv3/zyVYTvutUxLFeg7VzTA=;
 b=msdw71WiBESJXYfwZ3lNy8cOm/szzJUOhiIfDoIQlEv1TAdt5YJLUHH2hV3ihVaRqM
 /smdO15BcIO8zluOK5bXL+J+3C9Lr2ia+/nFCaW6Dr697FH68XUz0OR7p6mH0n6jdNDm
 /OTE2hW4t0x4LwBomG0OeQ6zrKbNzzq5MdOfHFoiHr0Yq1RflR8vriMhGqKbausFNeR3
 Lwr5XrqBYP3UCI+yrbkLX5xN9JNtMGwkEODd+H02FCfb03iaNCjW0g28+7jzm24PwyP7
 BesIOOQUaCDPMD7g6qP8h+pNdKFNVfbUxZu/nRfDmCfWXMxzD8scKbNQIfEmFsxoTBOQ
 pbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=x7A7jDWxquOfq7qhXvyuRv3/zyVYTvutUxLFeg7VzTA=;
 b=tlMEXu9YTHtVHRDX32t7JUblhszUsda8ZHaVrvW37uV06Di3sHs+Jdhh21N4pe/v+2
 g1+ORyk3Ir9Wf0UaaRuyU0O2j9pSIqPAlSDPhrUaTNS0Ezd+e+O3jP7b6oSWEdQLj2yx
 jPDLVB3g8eBlCZg7GvjeDvpdZz/OZcE37hqmIb6wYM+FIch27RmGdTgCEUkv69D/638T
 5PWHIM7BgtFkZ64EkfPrCOEGcMkQfJ8TslFQeLy7lfBekZkrNf2P3izNWtbTaIZ98wMM
 lnkvggUeC8SiLlbzJyyoEJtLfjVCYHxZBIv8LvS4BazesySvfRgIZcW57o4IDEj9AYk5
 z94g==
X-Gm-Message-State: APjAAAVqICzGXGQPefpo/0o4SMlJnsJgpbgasz3UULIQEOFBz5Orvk8A
 16qlkpLuZyNOMf1s/lQFCDMJ+w==
X-Google-Smtp-Source: APXvYqyvbg9KrKPFFO0KwV0eiI9JrYqpKVG8jRU304SYNyE+tPbMVa92H9zPYIPLuQiVvOjNWofIjQ==
X-Received: by 2002:a05:6214:12f1:: with SMTP id
 w17mr1528031qvv.108.1568214437191; 
 Wed, 11 Sep 2019 08:07:17 -0700 (PDT)
Received: from [192.168.5.185] (otwaon236nw-grc-01-64-229-69-35.dsl.bell.ca.
 [64.229.69.35])
 by smtp.gmail.com with ESMTPSA id c12sm1483684qkc.81.2019.09.11.08.07.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Sep 2019 08:07:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190906075750.14791-1-david@redhat.com>
 <20190906075750.14791-5-david@redhat.com>
 <7788b1b6-fbf0-3370-5563-1da4f7124999@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <905250c7-b249-6812-391c-408af69d9523@linaro.org>
Date: Wed, 11 Sep 2019 11:07:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7788b1b6-fbf0-3370-5563-1da4f7124999@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
Subject: Re: [Qemu-devel] [PATCH v2 04/28] s390x/tcg: MVCL: Process max 2k
 bytes at a time
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

On 9/11/19 10:52 AM, Richard Henderson wrote:
> The code within Hercules breaks the action at every 2k address boundary -- for
> both src and dest.  That's the only way that actually makes sense to me, as
> otherwise we end up allowing userspace to read/write into a page without
> permission.  Which is a security hole.

Also, doesn't "2k" come from the old esa/360 page size?

Which means that we could break at 4k pages instead of 2k now
and the program wouldn't really be able to tell the difference.


r~


