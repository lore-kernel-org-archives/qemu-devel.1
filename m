Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F5BC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:09:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EC7C2074A
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DNwgK9RB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC7C2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAx35-0005D8-Il
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 11:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAx2G-000474-EW
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:08:24 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:46300)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAx2E-0002yf-Sf
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:08:24 -0400
Received: by mail-pg1-x543.google.com with SMTP id 31so1144364pgy.13
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 08:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+BvoVsPSmTTX0hxoFpN5sQy5f15RGu8vRK15BM1PvLM=;
 b=DNwgK9RB0jj9tT+FsF+UetI/ggdPjk/YhdDYXzyN/kCxM47iW6NcZYG6gOVK8Tjh6J
 GWTqBvJCEXrDiQUCSk9/598qWvoWYNFv9ArwHCsf/JIm82MXVOl9dhis+fKU/ObpakQP
 Ajf8lRA36VqZny4h5l6enBZdmRsCrAKxUSgLAsIDmDHJtRi1KAS4m7DTVogA2EmMJWSe
 ExljtLD3MDJYd6vvcr9+Gw3j1KAFcZFBjVQ2K7YyWkZLI2yy4ZSCuRZAYGmotpYMBzJR
 Ujmtn7xIeGKr4lGn2jMPCRm9oqQGRaAQZbC8gmgGp66PCpmom60CHhXM+VOpbZNpF3ka
 fH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+BvoVsPSmTTX0hxoFpN5sQy5f15RGu8vRK15BM1PvLM=;
 b=TCcjGLply2LtwBQYhJEJT5l01RnkZ5CXu31cwGIlABaK6Dge4NHBkszvlHpXBYfFhq
 M5A7zTJ59IzfGc8RehpkcCPvj8rBlqYGKyu9ZGEo7SytgjgavFmv2DoN+v7iC8o3SJjB
 FGdRkfi0KUCz4JG2ajglzkCVwtffZC+0N07hoyaYgrFVKHnrc1HFnIyk97/X6tONRVQz
 qwQkxXGbDyK7Rr8A0kXwxG3FmRgcSUs7dI5qnq0lVkbUFB8LqXbAXIo5NbNHWHa1W7gL
 jdnikzE2VcVG8V652b9/yRqgg9vRL+WAZVR2foS7x8iE1LqFWNB92nGzjCHHdTRQMJap
 9Ngg==
X-Gm-Message-State: AOAM5325F2ywEAI/okzubx4P4BB0gkCWu1Mm2RJT2h1wDqaSvkUcXAtt
 EGgdh8Ak9yS2KOFi1x2gCPXsgA==
X-Google-Smtp-Source: ABdhPJzk8Lag5ZNkAHGrh9SY6eqUpTXr3JMi9wt8eUhsvyGlpR7kDaZc8iXmMoO/acXMImj97yxwfw==
X-Received: by 2002:a62:8f51:: with SMTP id n78mr12621234pfd.74.1598454501302; 
 Wed, 26 Aug 2020 08:08:21 -0700 (PDT)
Received: from [192.168.81.79]
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id 124sm3401781pfb.19.2020.08.26.08.08.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2020 08:08:20 -0700 (PDT)
Subject: Re: [RFC PATCH v3 15/34] Hexagon (target/hexagon) instruction printing
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-16-git-send-email-tsimpson@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6043eaf5-c32b-489d-3133-d38f4a02efbc@linaro.org>
Date: Wed, 26 Aug 2020 08:08:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1597765847-16637-16-git-send-email-tsimpson@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.239,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: ale@rev.ng, riku.voipio@iki.fi, philmd@redhat.com, laurent@vivier.eu,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/18/20 8:50 AM, Taylor Simpson wrote:
> +extern void snprint_a_pkt(char *buf, int n, packet_t *pkt);

Is there a good reason you're using a fixed size buffer and not returning a
GString?


r~

