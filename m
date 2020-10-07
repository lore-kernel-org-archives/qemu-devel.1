Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8CBC41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 17:56:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE6312173E
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 17:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLXnPJ+O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE6312173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQDg1-0006Mf-GD
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 13:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQDfO-0005um-Vg
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 13:55:55 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54495)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQDfN-0003nh-DN
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 13:55:54 -0400
Received: by mail-wm1-x344.google.com with SMTP id p15so3308630wmi.4
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 10:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=lSz0YWB7gFXbZmT1s8tI5W0MPmM0x31+cjvaWbwB5Ck=;
 b=HLXnPJ+OY4K8obu3amdMp2EyF5241j/ZUzZMSvF9wzav/9mqyjeo97KnfOGo/SRZkY
 Rqp/JUhW33HpdqV7fx6Ve6T1nD27oq88w82BeVpX4GtMNUgHzgmq7w6Yp/kRt2/wJ0JT
 38wP9sdcn+u7lRyWvBug29HekQd374BQLDZIQp3RvziHeuMdQY2tahzwAvt9Bb/vcy4F
 8yKbX6arD3T4kkrKNDxEyUkERqWXJis55obW6wypRi9fitCa7NcDw6g5p3Hv95sFoE8F
 ahGh+FkHb4/9kjFCoLSdAbgLJOBXKB3Dj+nR/6jzHFnPRLQusu3qU4Zf3ChARpPTu7dA
 YLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lSz0YWB7gFXbZmT1s8tI5W0MPmM0x31+cjvaWbwB5Ck=;
 b=c98HEwZ8hL3yIUtXV5pmOV1yfaEXaUhjrKj+xncKsNRbkAkiNRp9HUhyw3YKGZUGVI
 F1iSHUFJYF30L5SYxzNJyjrYvneQkFvxyWHIWKC8wF6/kOTGmC5Nl+ayEfGkYTHQFsSj
 3WWpg2dcxcTeKo+2a6lFi6fovdo9vGYoy8hYwOvL9PH45HTiUBQCyS/3gUOZ0huSBmX/
 6sZOJWEK0F2ndsbtWxasnT5TjHy5gAbHmfzUVQMea/iGXdv1XHfulQ9xzDU6zcslPbdf
 AU3YlKntnvcnJgzjbXlK9jccMU5FkdtvE0f1Zo+OqkUJhLDHuutT/xq54JER7rUKcbZJ
 7mSw==
X-Gm-Message-State: AOAM530/BkQ6EeROzGqvbhv3Z6KkMRAon9r0X5vjuCitk4/gLt1ipNKa
 JcZuOOsf1QAa51abeMhNH+I=
X-Google-Smtp-Source: ABdhPJwyoChasmgjzD0sI5izjvEZHbw6wgxCLWgAkkPAjSR1/jbAUJoQDIRTI/VBV1vuO+A5eSLSqw==
X-Received: by 2002:a7b:c04a:: with SMTP id u10mr4789557wmc.83.1602093351644; 
 Wed, 07 Oct 2020 10:55:51 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id k190sm3645311wme.33.2020.10.07.10.55.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2020 10:55:51 -0700 (PDT)
Subject: Re: [PATCH v2] Adding ani's email as an individual contributor
To: Ani Sinha <ani@anisinha.ca>, qemu-devel@nongnu.org
References: <20201007161940.1478-1-ani@anisinha.ca>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0250c54c-ea93-335b-7d37-cbfe79e4086f@amsat.org>
Date: Wed, 7 Oct 2020 19:55:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201007161940.1478-1-ani@anisinha.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/20 6:19 PM, Ani Sinha wrote:
> Ani is an individual contributor into qemu project. Adding my email into the
> correct file to reflect so.
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Thanks!

> Signed-off-by: Ani Sinha <ani@anisinha.ca>
> ---
>  contrib/gitdm/group-map-individuals | 1 +
>  1 file changed, 1 insertion(+)
> 
> changelog:
> v2: removed accidentally added submodule update into this commit
> v1: initial patch
> 
> diff --git a/contrib/gitdm/group-map-individuals b/contrib/gitdm/group-map-individuals
> index cf8a2ce367..64cb859193 100644
> --- a/contrib/gitdm/group-map-individuals
> +++ b/contrib/gitdm/group-map-individuals
> @@ -16,3 +16,4 @@ aurelien@aurel32.net
>  balaton@eik.bme.hu
>  e.emanuelegiuseppe@gmail.com
>  andrew.smirnov@gmail.com
> +ani@anisinha.ca
> 

