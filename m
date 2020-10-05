Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFF9C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 07:43:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5661F20665
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 07:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhM9FlIa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5661F20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPLA5-0001X7-E0
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 03:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPL92-0000de-5K; Mon, 05 Oct 2020 03:42:52 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36864)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPL90-0002B4-NB; Mon, 05 Oct 2020 03:42:51 -0400
Received: by mail-wm1-x343.google.com with SMTP id j136so7697334wmj.2;
 Mon, 05 Oct 2020 00:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ou425MrM93zzw94YYkXdoKoDa2dIAXchADFAz/T72ZU=;
 b=RhM9FlIa4bUryVwqQ7YTZMYccyqmQhR2C0t2biu6QEkJJRTQS9Y+4wdsLHNVM3VaXO
 JU8Sax7/1qxdPEHYdT9srG15gtn9//EPhK7gWitgOAdhnXHeFH/2xrxFhNpx5xgoShiW
 bf3AZZChZ7D5Upy9wqDLc9Wc8NavyDUb9xszXtWk3JWjFVl+jXnXkyyqXJGdCdM+f7yT
 5sPaoqAdpKwu6+NsUh8BPMAaMkpB+TzD300d4zncmFSWKsgwPmC4HDvTUlge/Y3jDFij
 RrZGVNU2tcavHXv3uLcSo8c2yeg5tctEWxJPl7877BkmZOCpd/8nQousLPJOXNSJ7mFl
 GAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ou425MrM93zzw94YYkXdoKoDa2dIAXchADFAz/T72ZU=;
 b=tIEARE2bCdZjlIBOI3STTgCyVPPeVQ2erlGxNHHJF92mPhylz+Qv2HFP7Uzb+7cpXv
 By3qpikF0nAHHXrDYrHFw1/xXJhZTKKwCgndiPk+3a4HaouEK9AQvoJVqw6pvKMrGj87
 NE6RNk/8PExtrACgku4YAmbmvDYm5fKzXuLwetnf7sxhO1B/Kd1J5TVr9yYVzhzZZLIl
 PP0MuB6gDPiISkAsDFfYZoDR0+h0Mm1+gx1DAlT0TXN7Em7Z4J6JIilPVzq8zaMiLoT8
 Ze3w9srKMD+vD0lY1W3kOSmnO802oemzrRWfWqJT6ZUmJ0nAdQPMZt+D4O9gwGjI55nA
 kJNQ==
X-Gm-Message-State: AOAM5327Zr4Yc2OsGH0QMMcNdfgHu758QDyCHyjKk3QaR3q0S7/fVyga
 dxKjajRxJ4Ghbc1iaWxs8WM=
X-Google-Smtp-Source: ABdhPJzsmgNxpqxFPtPclObri4nInCRZ43xrueZH1WGFYHgmYG0sBK++gIsjj0LKIjEYI1cgoVab9w==
X-Received: by 2002:a1c:f415:: with SMTP id z21mr15395968wma.88.1601883768847; 
 Mon, 05 Oct 2020 00:42:48 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id q15sm11896659wrr.8.2020.10.05.00.42.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2020 00:42:48 -0700 (PDT)
Subject: Re: [PATCH] qom: Improve error message displayed with missing object
 properties
To: qemu-devel@nongnu.org
References: <20200920155340.401482-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8cb8d06a-3d28-58a1-7203-a49469ecb820@amsat.org>
Date: Mon, 5 Oct 2020 09:42:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200920155340.401482-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248, NICE_REPLY_A=-0.001,
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo, can you take this patch, or can it goes via qemu-trivial?

On 9/20/20 5:53 PM, Philippe Mathieu-Daudé wrote:
> Instead of only displaying the property missing, also display
> the object name. This help developer to quickly figure out the
> mistake without opening a debugger.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  qom/object.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/qom/object.c b/qom/object.c
> index 387efb25ebe..257914b1fe3 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -1259,7 +1259,8 @@ ObjectProperty *object_property_find(Object *obj, const char *name,
>          return prop;
>      }
>  
> -    error_setg(errp, "Property '.%s' not found", name);
> +    error_setg(errp, "Property '%s.%s' not found",
> +               object_get_typename(obj), name);
>      return NULL;
>  }
>  
> 

