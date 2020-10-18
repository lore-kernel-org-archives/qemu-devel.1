Return-Path: <SRS0=E7tW=DZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A8AC433E7
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 07:13:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94659208FE
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 07:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOHXjdly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94659208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kU2sK-0004zb-DT
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 03:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kU2r8-0004NJ-EF; Sun, 18 Oct 2020 03:11:50 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40403)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kU2r6-0002CA-OL; Sun, 18 Oct 2020 03:11:50 -0400
Received: by mail-wr1-x444.google.com with SMTP id h5so7889832wrv.7;
 Sun, 18 Oct 2020 00:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mFFEz8tDnJlX8yX4OkWIhZ1N+VAazZHnQz7+NUK8tG4=;
 b=EOHXjdly4qSqVCT+06WBVTywJBgtcY0OJBlv76rkJaEEdP5+2Uu6X23Khl4y8KuLEX
 Lua4VVsKzRL2DjQWDA3uSl5drPEzaf7QsZq+UexPO5/5/FWysYOaFf89IVI79UYD2OPg
 bY0L0L+Fzji5pkkJb8Rv20y3el2wyUhjBrlStKMXyTKdScloDz3esjAo41Iv6kQCo3xE
 vV4FYuRM7PbtmWJEweNbWyz4mQOO4cK47xtXbJpZlw4hyzfvdy3DJIS0KaXALS2M9tSk
 BTpxDdeMvQn5sXjyMfKriw9k3zXmS7Ht/jK730PPxanOLsaMTUpkuAgMl+oiLfLa2JxZ
 jEuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mFFEz8tDnJlX8yX4OkWIhZ1N+VAazZHnQz7+NUK8tG4=;
 b=MzH/ddQhvuqKaXBFACOEhQ8LNyMjb//6mFfOq8wi3Jh2A28rZIJt1jhXG2l8F7YHkH
 piKcH4vs3D9NMLIo6GctLtFqnK4vN7C2+/UJf7zhAziquUYjX0BGrGCUFo1rqSa/vDvg
 d2MSxXkDEbdm/+qu8/znt2PmEFHtpn5hl48+kIVXZGM4kS/WOj22MRWpVhvKMo2uEnDo
 fED0bnojla8oV8e946ogiuHhCP52geu+Fm+yGkVfVddSEebzqxtUpEcdFgnIndgD1Uo8
 vWmPn4gmv+UZGIkml9RrbAgWPokbUDxQIB4/Z4DSk1EXa+PZN/mzvMRVlMJgh/ZqBj3s
 eUnA==
X-Gm-Message-State: AOAM531JUotyi7wi5ILeBtRfzLrFCioTYdVxKRYpW/0xymTFX/mQLGr9
 4nP/mdW2NFnubcpgTdf4jZ4=
X-Google-Smtp-Source: ABdhPJy+kWj5NY9UScGYQUcCwdUlwcf2JkVwMhob56sP4kO/oYrVp9TVgipfzczRcM4dOV33f4uptA==
X-Received: by 2002:a05:6000:108:: with SMTP id
 o8mr1837532wrx.256.1603005105970; 
 Sun, 18 Oct 2020 00:11:45 -0700 (PDT)
Received: from [192.168.1.36] (117.red-83-52-172.dynamicip.rima-tde.net.
 [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id f17sm7561538wme.22.2020.10.18.00.11.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Oct 2020 00:11:45 -0700 (PDT)
Subject: Re: [PATCH 2/6] mt48t59: Set default value of base-year property to
 1968
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <cover.1602965621.git.balaton@eik.bme.hu>
 <403ddfbe83c6df7dfb0c3ae69202c5e2c4fae767.1602965621.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a7057073-f3b7-f205-c98f-865d951ffa5b@amsat.org>
Date: Sun, 18 Oct 2020 09:11:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <403ddfbe83c6df7dfb0c3ae69202c5e2c4fae767.1602965621.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.247,
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
Cc: Herve Poussineau <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/17/20 10:13 PM, BALATON Zoltan via wrote:
> All instances set this value explicitely so make it the default to

Typo explicitely -> explicitly.

> make it simpler to create instances without setting property.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   hw/rtc/m48t59.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/rtc/m48t59.c b/hw/rtc/m48t59.c
> index 6525206976..3108cf3d3f 100644
> --- a/hw/rtc/m48t59.c
> +++ b/hw/rtc/m48t59.c
> @@ -655,7 +655,7 @@ static void m48txx_sysbus_toggle_lock(Nvram *obj, int lock)
>   }
>   
>   static Property m48t59_sysbus_properties[] = {
> -    DEFINE_PROP_INT32("base-year", M48txxSysBusState, state.base_year, 0),
> +    DEFINE_PROP_INT32("base-year", M48txxSysBusState, state.base_year, 1968),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   
> 

