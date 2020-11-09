Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D718FC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 17:57:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1353820665
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 17:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g+eWU2Uk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1353820665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcBQS-0004zh-1x
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 12:57:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kcB9n-0008US-Qa
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 12:40:43 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:41613)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kcB9l-00010J-31
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 12:40:43 -0500
Received: by mail-pg1-x542.google.com with SMTP id f18so3263173pgi.8
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 09:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=26CNjaDMaKzJJMGdHjXVHnHucjERQ5R8EH22DjY8K2k=;
 b=g+eWU2UkreYN3A0u8v65Wfss+o9mT8sUBRrBqgkMhwyfRfY4Ff3Gn454ugBt9Sb94A
 K0ijnCqJ1YiQOQTo153xywnicp2mh6ySjgAzGCG0xctmQS+e7TVH4O2kNeB4miIcJ3sf
 cDWRSoSWArIsMOVaDcIvH3kgLmL7iH/glMSZNc8MuPlqAFXrj3zfEVeNAPcO2tMIeZuw
 xBXeGQ/pNQDQKadWOTiwtP4m7QAuxVcO4hJQBra3UuCqJdFHzHwI8pamB4zeVfJOmLPs
 zBZa7QS+LMvMvgkGW7jcHegqcEsECfEpGWG3PjbAHuT3nTEzopHRAMq7ThLbpBZP9+pS
 5VKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=26CNjaDMaKzJJMGdHjXVHnHucjERQ5R8EH22DjY8K2k=;
 b=QsFsUFP11J9Llhfcrbp5IPY18vVPytorwn3UzBywOOGtx4mTHP4XCQiBDEMBnzNsVl
 ImddJmViiwz0UO9h+izzuOyUXNem8aLmN7wsb25N2bns3XEgXBQ7DYmX/QvqtIYAwF9d
 XMHEaSknwBMe166A3g8qCo8dXo/67SAvUPDeglyOHNUWgMz7Ya6jbF1wAGflx22xKQrz
 /yQ9hS57bGdRxVORWTBNLRnfNqBSzsMVRLIOP2Qw0qmW81WDazlkPQDYNt+YEGflEh/m
 JyvlZbaIx+BGoNB+b4qvFxErIwy+cNsy6fub2LGXJztTanyd6EYdmVZLktpN1A/GPSi/
 z1Nw==
X-Gm-Message-State: AOAM530khsPfq86j7cLXeN+OzifqAV9oWEx4/H86/QoqMzUtIEldOLJB
 s67fAEm8QnWmWzVf6uMQYwqsfhaqn9he+A==
X-Google-Smtp-Source: ABdhPJzQc48hAAHC+LYGdxnUFdOzl8E/5r19YQe/OxnOuDYRPPXaKPdjnovl6QM6owMnfJpCURNGiw==
X-Received: by 2002:a62:fc4b:0:b029:18a:aa9d:10cf with SMTP id
 e72-20020a62fc4b0000b029018aaa9d10cfmr11378882pfh.28.1604943639555; 
 Mon, 09 Nov 2020 09:40:39 -0800 (PST)
Received: from [172.16.1.221] (76-14-210-194.or.wavecable.com. [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id a12sm77786pjh.48.2020.11.09.09.40.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2020 09:40:38 -0800 (PST)
Subject: Re: [PATCH 2/2] ppc/translate: Rewrite gen_lxvdsx to use gvec
 primitives
To: LemonBoy <thatlemon@gmail.com>, qemu-devel@nongnu.org
References: <d7d533e18c2bc10d924ee3e09907ff2b41fddb3a.1604912739.git.thatlemon@gmail.com>
 <a463dea379da4cb3a22de49c678932f74fb15dd7.1604912739.git.thatlemon@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1a69a2bc-ab5c-eb0b-09c8-1d736c6603dd@linaro.org>
Date: Mon, 9 Nov 2020 09:40:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a463dea379da4cb3a22de49c678932f74fb15dd7.1604912739.git.thatlemon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/9/20 1:17 AM, LemonBoy wrote:
> Make the implementation match the lxvwsx one.
> The code is now shorter smaller and potentially faster as the
> translation will use the host SIMD capabilities if available.
> 
> No functional change.
> 
> Signed-off-by: Giuseppe Musacchio <thatlemon@gmail.com>
> ---
>  target/ppc/translate/vsx-impl.c.inc | 46 ++++++++++++++---------------
>  1 file changed, 23 insertions(+), 23 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


