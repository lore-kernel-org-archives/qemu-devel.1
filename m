Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B6BC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 14:20:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FE5A208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 14:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EBPS5v8A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FE5A208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAwHb-0002h0-TC
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 10:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAwH0-0002Aw-UT
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 10:19:34 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:39648)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAwGz-0003q8-DC
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 10:19:34 -0400
Received: by mail-pj1-x1041.google.com with SMTP id s2so342369pjr.4
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 07:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=8OHx5jO/kav4lj8u22V3saFr2wMXN1jueodhUQb/5jI=;
 b=EBPS5v8AxpVZspew/CEMOmIOEb+WrFmfjQDgK/DziShqqhN8hFmC4lnetpQho2FB91
 xUKzXUz4HLQZr2af2vkU1AC4E35XHqbck9HINOLOf+P+5kFokm6bKJA5L4IlSP4e/wlv
 6fJ0yx0qhrqtpiTxlG2O9KIFV2C3pVjvHVnv+rv1ndre4tyw4grUaOL98pwuPo+kuPtI
 /r0aeEU5wluQTxUzo5p0cb6SwRpYGLs4E4rEMC8KlOHa715C6EiuugxSTVrsXjDxTTQS
 INhBf+qoLf0YgtLeKx1KNdXx0R+t/Bo3pBuaObGWxo/RZcnEkphKDgCcdVPlVtwauVym
 1p9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8OHx5jO/kav4lj8u22V3saFr2wMXN1jueodhUQb/5jI=;
 b=s9Dl9ihfiEOSwy9p8EUZdvkjef3BMP3jXOkBBxjMk0aY/5+fM580xH6sg/fzG5iFhl
 1oKNM+oPxkVWhvUJLzE4qOCdiYMwGpoIzW8dWnMPjqeC3mnta7jsm+huuiRZuLlmcsjU
 Oz2BD4xylmU9v4bUuYP8YYbXNXWB0uEL5Bmu+Z89QVngeyj4/ySMS46/fL+pO973Fcsi
 gAFhVAgS4mpbhGw8OvdoohnbZwwMRXAu1XkgtTnkcdq7sTv6Qqcmv7KYEGbdbqjS6+J7
 u7zHl/WL2zG+AhxBxfsxEq9+2GKRT2L+aEYF+dpnFx/nRs5l7BzsKNTypXoqdl6ctRgj
 4jyQ==
X-Gm-Message-State: AOAM531kK+1OfQZROVNddGYLmv0ZPRxbHXXPe9Fm4B9Lg5PtK6bzT1yr
 AwRUqsRPRG07L2CXjDsGMyNXsg==
X-Google-Smtp-Source: ABdhPJyK5NyLJxeH7I9OYlAGUczQMatibe24L6hmK6hLPF59rknf07pYoz6vAo2L+SrNnYnvcCtTHA==
X-Received: by 2002:a17:90a:7e15:: with SMTP id
 i21mr5134233pjl.175.1598451571910; 
 Wed, 26 Aug 2020 07:19:31 -0700 (PDT)
Received: from [192.168.81.79]
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id x19sm3340486pfq.43.2020.08.26.07.19.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2020 07:19:31 -0700 (PDT)
Subject: Re: [RFC PATCH v3 09/34] Hexagon (target/hexagon) architecture types
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-10-git-send-email-tsimpson@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <264c9851-81c4-67e3-3e04-865b30c06ec1@linaro.org>
Date: Wed, 26 Aug 2020 07:19:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1597765847-16637-10-git-send-email-tsimpson@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
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
> +#ifndef HEXAGON_ARCH_TYPES_H
> +#define HEXAGON_ARCH_TYPES_H
> +
> +#include <stdint.h>

Do you really need to re-include this?
This was done in "qemu/osdep.h".

In general, osdep.h must be included first, and it takes care of all of the
basic system includes.


r~

