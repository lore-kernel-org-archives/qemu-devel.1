Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC092C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 20:59:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 954152166E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 20:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g23BpLIQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 954152166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlf9D-0000y4-RP
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 16:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlf8f-0000G0-18
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 16:58:29 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031]:39875)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlf8d-0007VU-2p
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 16:58:28 -0400
Received: by mail-pj1-x1031.google.com with SMTP id h95so1647326pje.4
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 13:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+CZkQnJ1cLWp+4wmH8lq39XpIr2oYMbbxwIFRe3RB3I=;
 b=g23BpLIQjBvNSf5bsw6bZ1G5w/HcSyp5sqRLxuSxBE0D9Y1tiIbBlbCqMWhKyihnWe
 fPllpS1vgwYGGHvbwkJuKR2o1w9tI3NyANiCImC0AxgofvZHHMqE0EezV4xdf8m6YsGl
 GNhyqgkhbEUk482YhxGbXdu385jYnprMVWhCjqgmIeKtWzcG+zmvSBjRSJUEVZDXzqOM
 37zwgAd93IczB3iZ2JMSaaImjWsMfIdhTXEBhPYH/97CQUL96SHtjc2ucx6++dnneU/O
 xpEBOyao0zw0xTs1gsS+80l6YCEZktRz0lYw80M6FoUWZ0BMaZ8S69aLLZttUMxcI+y+
 Zwsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+CZkQnJ1cLWp+4wmH8lq39XpIr2oYMbbxwIFRe3RB3I=;
 b=kTIesA/6W7DDc2snd302zM5uANZG6whF6RVlnDEc7cL6+2NYAZzcYXdAtTVvk8U1iZ
 BAHOWtDAiCjjjtxVULLTQM60a39Uwbe23wYGoSgPPKBypx+XyOgdSBP1l3zTFVduVzsx
 3teUjQ6ao2dK8LzDnIJnjW/KCdmHUEQcZGfhemvWyBVgf4aaGOgVoJFuM2s5p6L0MPYB
 eCvRUNkDet1IZprrvREbcEm17uwpvmpJHNNv8Ncy+DifBsLN0n7SwByxNzQ+8CtLwM0D
 tLaTYxxgNzhxjhMUGtWc/RRhrykQ0nY/YPgQav7Lg2tjZ4P6QCFWQJd+dGGRlVjz3Kmb
 JOMQ==
X-Gm-Message-State: AOAM532i2i3fplibiVWAK87p8snRcb3iaBuunmfvFIdMQ3ay74Ghl9Bd
 TNlC/UwLlClSxYuQUnHscXy1dQ==
X-Google-Smtp-Source: ABdhPJzg8ZBPAayK86UHQxFWVt+obWdHqILode+Pj9rcZdj1VzwS3LVPt0tAzyhIodrWeqLozHLZgA==
X-Received: by 2002:a17:90a:74cb:: with SMTP id
 p11mr875273pjl.89.1592427505441; 
 Wed, 17 Jun 2020 13:58:25 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id dw17sm401182pjb.40.2020.06.17.13.58.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2020 13:58:24 -0700 (PDT)
Subject: Re: [PATCH v4 6/6] qht: Fix threshold rate calculation
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20200617201309.1640952-1-richard.henderson@linaro.org>
 <20200617201309.1640952-7-richard.henderson@linaro.org>
Message-ID: <c5a6e38c-0365-a695-8bbb-c61b381c668e@linaro.org>
Date: Wed, 17 Jun 2020 13:58:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200617201309.1640952-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: philmd@redhat.com, "Emilio G . Cota" <cota@braap.org>,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/17/20 1:13 PM, Richard Henderson wrote:
> -        *threshold = rate * UINT64_MAX;
> +        *threshold = (rate * 0xffff000000000000ull)
> +                   + (rate * 0x0000ffffffffffffull);

Well, while this does silence the warning, it produces the exact same results
as before, since the intermediate double result still only has 53 bits of
precision.

We're probably be better off with the nextafter(0x1p64, 0.0) form that we've
used elsewhere.


r~

