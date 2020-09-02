Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A736C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 10:30:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E643D2065E
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 10:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zrpe5hds"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E643D2065E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDQ1i-0007yB-0r
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 06:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDQ10-000770-OJ
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 06:29:18 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55907)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDQ0z-0004Md-7K
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 06:29:18 -0400
Received: by mail-wm1-x343.google.com with SMTP id a65so3855809wme.5
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 03:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=fOvhcYPbnMCTDcfb7OdWyEoEKQdLEu4uXBWkS2Bf9/o=;
 b=Zrpe5hds5O4EE498iwapsmuOlcKg2N4AF1nw1D5j4bZzQghmLFvNJ4EsOYDBpwZML+
 ts6BSGVAwPnbOLESdirUesFnC3X6f+laXJTallLUBAHnRso2vZqCy3Eqx607P5dhtlkD
 9+vEoHsKIGkUR3YzuwuWUqx/9O8ncIY14RgM5zEKM+eUiZ4qpdCUfx7R+4XWJamlZAog
 waGSBuDrchfwi13cL/txRTn4f+wWFwziaCbyosxMh+bmLvcBKxOqtOwx6CsfBHP/OwXs
 aeEsNz3YXBZLDSB+Ob+LybU3eXAZ4SdKMXJtGwfGfD+29xqugvpyRjDPlsfOTukYdcqq
 Fc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fOvhcYPbnMCTDcfb7OdWyEoEKQdLEu4uXBWkS2Bf9/o=;
 b=d/90zwDW44OQIi09ldJSKYndXRQuLcNCcf3fYktF/jHYGkjH0MHaeIpKAVifxeOM+O
 /lXIvtO35s6A21f4mm1ZB6nq74ACPLqB6WhVY41XVTpe46q9fhjS2YAqt9H/3BxBpRQV
 GY3QNIdZxAjLfgqPALrWRfzRsPJgdN2EB5OlZh90jVEseu7D1pPEgpDmncy3PagFUZFt
 PpuB+0xEMs63nzU0SY08COx+AyX+FBE+6kfv8pKNn1226Rejv9k5Duuf8DWW1Cyrry3o
 Z7R2TX1rUu2PV+zX9sOdz2XI9etc172cPBw0m8KKVSK29FWhwSNlPS0hjlMMMeu3Fo+n
 iaWg==
X-Gm-Message-State: AOAM530cy6NyiyMZrsBknvnvVd05R+SeKhvieuzQVFuoCGwBpy14Vy/R
 Bh/7e3WLqIz/oGJRUQQKeVtM42oczyw=
X-Google-Smtp-Source: ABdhPJzgiEq5M1VblkkJIFOtWyLMQ6zC4PMSHRAZ5S7bXLuXW6VvH5nLvfydnId6SoaDlqY68c9LBA==
X-Received: by 2002:a1c:f207:: with SMTP id s7mr395wmc.22.1599042555680;
 Wed, 02 Sep 2020 03:29:15 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id x10sm5988647wmi.37.2020.09.02.03.29.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 03:29:14 -0700 (PDT)
Subject: Re: [PATCH] linux-user: fix implicit conversion from enumeration type
 error
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200901153321.920490-1-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <79712add-76f8-43d0-c242-1668959dc3e8@amsat.org>
Date: Wed, 2 Sep 2020 12:29:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200901153321.920490-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-2.13,
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
Cc: Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/1/20 5:33 PM, Laurent Vivier wrote:
> MK_ARRAY(type,size) is used to fill the field_types buffer, and if the
> "size" parameter is an enum type, clang [-Werror,-Wenum-conversion] reports
> an error when it is assigned to field_types which is also an enum, argtypes.
> 
> To avoid that, convert "size" to "int" in MK_ARRAY(). "int" is the type
> used for the size evaluation in thunk_type_size().
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  include/exec/user/thunk.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/exec/user/thunk.h b/include/exec/user/thunk.h
> index a5bbb2c73331..b798fcb69cf4 100644
> --- a/include/exec/user/thunk.h
> +++ b/include/exec/user/thunk.h
> @@ -42,7 +42,7 @@ typedef enum argtype {
>  } argtype;
>  
>  #define MK_PTR(type) TYPE_PTR, type
> -#define MK_ARRAY(type, size) TYPE_ARRAY, size, type
> +#define MK_ARRAY(type, size) TYPE_ARRAY, (int)size, type

You need to use parenthesis:

  #define MK_ARRAY(type, size) TYPE_ARRAY, (int)(size), type

See:

  MK_ARRAY(TYPE_CHAR, USBDEVFS_MAXDRIVERNAME + 1)) /* driver */

While here I'd also add them to 'type'.

With parenthesis:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>  #define MK_STRUCT(id) TYPE_STRUCT, id
>  
>  #define THUNK_TARGET 0
> 


