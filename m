Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	PDS_TONAME_EQ_TOLOCAL_SHORT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBE1C4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 16:11:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6B6D206F7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 16:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDwWQhru"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6B6D206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNehI-00030J-NK
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 12:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNeXx-00007g-Bx; Wed, 30 Sep 2020 12:01:37 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37689)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNeXv-0002F9-SI; Wed, 30 Sep 2020 12:01:37 -0400
Received: by mail-wm1-x341.google.com with SMTP id a9so52185wmm.2;
 Wed, 30 Sep 2020 09:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FN8QF9OeGBHcS3Ikvq47L0HMj3W/IbqJABlhYv6lL/A=;
 b=gDwWQhruWkPeaDjk1q817iP0v+3ClyjzZpq6bW9w2cdGJbSYgdK8BDYFxnX8Dy7Jhi
 Uu4HgquFq69gKuZg0oGP1wRKM5Ia3G2hfViaDWRjSsxP/zt7j8g4VXlWultfKNYoIANI
 DZjdcUl5w73vUTfNr0LyL5dLLZ+Jn9Yn6+MPH+YA+McJ2W+/l+5IA6ZhN/JA1DIrO+cZ
 sQcNhKRGoDf73Of+IN8C/qDXJrOD4gV2APJD9OgAOSqAtxr3nlnZARFo9k9z0cbo4y4b
 KN6cx0jN+dojvrxdHyP7lPApx9W7/FZp1x0xGlvX3hiN3CIf1AiPGpAUn3qcXeTLdLXP
 3bKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FN8QF9OeGBHcS3Ikvq47L0HMj3W/IbqJABlhYv6lL/A=;
 b=e2zDD2zjdLSHfOz9I8T2qTRQzKW3RsC5imZ1LfONes5Ya+B2CuVXvNvTby6APN+XZz
 XG/X9WMbOMszq4iBE8Fu4fXHQSFMWWXRJqOTklt0M6509Y6UVqizEAd9X9CwhsGeR5x7
 jthmKgCDdSsU+ockUfbp7D44+HsF6JhCKXZUi7ZdCtFbBxFFnJeTlvTUrU5fVZhrT3hU
 /dk4swW8OKPfeqNw8JKtsd28aNQ3ju9WGmVyF2WYt8qTKUUiLssmd+RYIh6KKa8lMg8Z
 u05CbqmTBwWKVkw6NzLV7Nh2yk5QuaIX5hj6KeZJeXvXp5iTzn6QvyNlXOLXEvRfnQbm
 aH4g==
X-Gm-Message-State: AOAM531B1uCa+rCOHgkB1Q5QY9zk2ugzdiH0qP2gwCN5WRMLYfhgdJnN
 I3aqa+fixOk01VJAXHfiuSnj72bsxoQ=
X-Google-Smtp-Source: ABdhPJw9oS6GEzGHe0Ko1N3pN1FKPsg2DyBTM1g7YSuaW5mQgPSgmPv3GRZ70EPDcHipsL0ll/29Gg==
X-Received: by 2002:a7b:c345:: with SMTP id l5mr3768677wmj.123.1601481689616; 
 Wed, 30 Sep 2020 09:01:29 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id z191sm3604774wme.40.2020.09.30.09.01.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2020 09:01:28 -0700 (PDT)
Subject: Re: [PATCH RFC 13/14] alpha/: fix some comment spelling errors
To: zhaolichang <zhaolichang@huawei.com>, qemu-trivial@nongnu.org
References: <20200930095321.2006-1-zhaolichang@huawei.com>
 <20200930095321.2006-14-zhaolichang@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <51cf9db0-36ef-23b6-3b92-6d1e6a054694@amsat.org>
Date: Wed, 30 Sep 2020 18:01:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200930095321.2006-14-zhaolichang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-0.001,
 PDS_TONAME_EQ_TOLOCAL_SHORT=1.999, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/30/20 11:53 AM, zhaolichang wrote:
> I found that there are many spelling errors in the comments of qemu/target/alpha.
> I used spellcheck to check the spelling errors and found some errors in the folder.
> 
> Signed-off-by: zhaolichang <zhaolichang@huawei.com>
> ---
>  target/alpha/cpu.h       | 4 ++--
>  target/alpha/translate.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

