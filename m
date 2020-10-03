Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A24CC4363D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 17:57:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D8F9206C1
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 17:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVU4lr2V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D8F9206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOlma-0005Rv-AI
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 13:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kOllQ-0004Zt-02
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 13:56:08 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34091)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kOllO-000523-8s
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 13:56:07 -0400
Received: by mail-wr1-x444.google.com with SMTP id t10so5232006wrv.1
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2020 10:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=PVrMD5bSIZeKuBg0Tot7BN24PM8CfVzFwvMeC136QJY=;
 b=lVU4lr2VH0sG2lfOzs20YHlD2sM3Z9gmAgoBi3lGpVCak1WsRRQNo2JlneNUacAoO4
 U8Eb8DZMBhK0JY4klw2NEUvINrwJvSQ4/NrUyhQ+/6cB3WgdCef8iVgjF/k8TJ6G/a15
 bHxTx329qk18Do9JTxjPSFiaYL8s1h/c6gH7nOmwhrv/N1d+cmLUFspmhCHha+dyDmp1
 1oe7HpgFQe5L20wxWFz4Cw5SjUlRnuRDwIkRVGWdMiVJlnrsGEq3xsudKBNhyQx/We77
 WkWdcDc2t4Mee6gIHlW/gB9Rly7tG/Qrr9aaR9IZcTEYW8jA3ZTLOVfTFZIS9M8fvsHp
 fxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PVrMD5bSIZeKuBg0Tot7BN24PM8CfVzFwvMeC136QJY=;
 b=Zk6aimxGnbdQiLuLLQQL9CzPl1ADxBr+bcnyUyY4xaklYfngQjEYndZKcZFuhNEnpk
 nT9CFHe9S4mjZo0kBTZGabrorVQTaTfyuvvwqqSTGCOjTAxpIuwn+wf11lYgAeFjklxy
 5+fTKHlN5Hzlzg6JKEXj+BtvbpxlN5TVbX74RMsh61qpHIYtvLkos41ZF4m1cjTPY22t
 MswTsWoLt91FUiVG23Qd/scuFD1yEJFZfvgOGuTc6EEezN5F5gMoDCiYTk1wRudd4p12
 XUN0LHpWKtCyQBXfap9kDhXCzcIXT09L3astWLTFwo4ojzq7HC2BdaQsTezID477UhuR
 6YjA==
X-Gm-Message-State: AOAM5304WvPltZcfQi/2lzYM5Hac+TjGQEJxDZTz5TIi96erVhH1+qYd
 xNAs0zS2fWtx7ha9VSQNPvlYj4YfslY=
X-Google-Smtp-Source: ABdhPJw7MYY0mDhxYxM1BGYAI6iqJ90cVgEkVK6N/XeT4QMx/5k8GRpUJFgYBHYN8KBNXB9TQ/OwjQ==
X-Received: by 2002:a5d:6886:: with SMTP id h6mr9408689wru.374.1601747764871; 
 Sat, 03 Oct 2020 10:56:04 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id t5sm6319506wrb.21.2020.10.03.10.56.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2020 10:56:04 -0700 (PDT)
Subject: Re: [PATCH 6/6] docs/devel/qom: Avoid long lines
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20201003025424.199291-1-ehabkost@redhat.com>
 <20201003025424.199291-7-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <09310238-32b2-b570-56da-a9f8d550ab8d@amsat.org>
Date: Sat, 3 Oct 2020 19:56:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201003025424.199291-7-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.252,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/3/20 4:54 AM, Eduardo Habkost wrote:
> Long code lines don't look good in the rendered documents, make
> them shorter.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  docs/devel/qom.rst | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/docs/devel/qom.rst b/docs/devel/qom.rst
> index 0c610e20d62..42d0dc4f4da 100644
> --- a/docs/devel/qom.rst
> +++ b/docs/devel/qom.rst
> @@ -284,7 +284,8 @@ in the header file:
>  .. code-block:: c
>     :caption: Declaring a simple type
>  
> -   OBJECT_DECLARE_SIMPLE_TYPE(MyDevice, my_device, MY_DEVICE, DEVICE)
> +   OBJECT_DECLARE_SIMPLE_TYPE(MyDevice, my_device,
> +                              MY_DEVICE, DEVICE)
>  
>  This is equivalent to the following:
>  
> @@ -360,7 +361,8 @@ This accepts an array of interface type names.
>  
>     OBJECT_DEFINE_TYPE_WITH_INTERFACES(MyDevice, my_device,
>                                        MY_DEVICE, DEVICE,
> -                                      { TYPE_USER_CREATABLE }, { NULL })
> +                                      { TYPE_USER_CREATABLE },
> +                                      { NULL })
>  
>  If the type is not intended to be instantiated, then then
>  the OBJECT_DEFINE_ABSTRACT_TYPE() macro can be used instead:
> @@ -368,7 +370,8 @@ the OBJECT_DEFINE_ABSTRACT_TYPE() macro can be used instead:
>  .. code-block:: c
>     :caption: Defining a simple abstract type
>  
> -   OBJECT_DEFINE_ABSTRACT_TYPE(MyDevice, my_device, MY_DEVICE, DEVICE)
> +   OBJECT_DEFINE_ABSTRACT_TYPE(MyDevice, my_device,
> +                               MY_DEVICE, DEVICE)
>  
>  
>  
> 


