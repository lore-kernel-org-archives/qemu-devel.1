Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09DBC433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 17:29:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A081121743
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 17:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WAl1iYGI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A081121743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvmEB-0001Xw-TT
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 13:29:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34453)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hvmDn-00018B-HT
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 13:29:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hvmDm-0004sW-Gy
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 13:29:03 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:34104)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hvmDm-0004s0-AJ
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 13:29:02 -0400
Received: by mail-pf1-x444.google.com with SMTP id b13so44475650pfo.1
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2019 10:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=c68VHGrRsl0wReanWvU77ZKK0T9KeGcaCFyjPLxQe48=;
 b=WAl1iYGIlaDqRy9f1UsYrLTeU4RlcYjCkMxadv5bQlnDXT/Q9kjCLFZddVdVCAmIzu
 rqX1xD3N+nsBKoxHNdFiHk85q6xLXmeQWn5VSF97IldkFmaRtmMulq8UEfysbV3qhG+f
 K77Q+P7uSOn80bX7iNybBhheoAFOKqZSIfw0xGH70lv9F0Q49KO+a4w185CDNnH9wI9E
 iN7CEqab4YnwMGrh8QCSh09rsIPq0A5+iW9H/i+lcdf1TVhTXsiGneTESVnTRW5BHLgX
 XER1HSH8u7zANi/u+PYYZJ+S6oywxvTfg9KWAyRYei8FMpOxui5DfB5BeVASwKKQfzVQ
 gv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=c68VHGrRsl0wReanWvU77ZKK0T9KeGcaCFyjPLxQe48=;
 b=LjLOdIFJGpIxpvqoyZhF7cgaKDk7LAPa/MjWDlB2GJwDzIOIh3UAxahn3wvscEvm9X
 r4LQBzyGJkm32H+PVIk/eZbGBiO9KZPCI4/ONieGQjbB4cmGHYpMCjl5J7hROLTBo3Ah
 sdKq0wl6wo99oWpdREpiWFS0P9AFZIyRqsLULiTJHjAVCj2TkO0LQQeDfnHQbEcJj2SO
 r5beM2kASG+tGaWUfGvrnPwHsjhfilv4NYMsnKuuna5IMhfk/RuIKOvbX5JjdTYJfJ53
 LnjSwzAMtsx00xKg4z9vv97fkt7duOKjQ+DFGvGfajAoyQwTFk7tAieroDo3NJ5yEZLQ
 Odhw==
X-Gm-Message-State: APjAAAWoElykvx0vzuYYc/NU9kXjNh82/+jqPXawS7acDOkWTDROL2I5
 EMdIcLvOmILkLX2ASDhGLBMRdw==
X-Google-Smtp-Source: APXvYqwzIBGVGopOJIAjIZvCKDOZgRy+mcfEjTfKRqDMU2Bd/jhSWvp/2nNjweK0w1byfO/CtabHeQ==
X-Received: by 2002:a62:2c8e:: with SMTP id s136mr16915087pfs.3.1565285340558; 
 Thu, 08 Aug 2019 10:29:00 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id w1sm3146422pjt.30.2019.08.08.10.28.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 08 Aug 2019 10:28:59 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190808164117.23348-1-alex.bennee@linaro.org>
 <20190808164117.23348-2-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <58444302-0862-10c3-eff5-5244e6dad783@linaro.org>
Date: Thu, 8 Aug 2019 10:28:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808164117.23348-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v1 1/7] fpu: move LIT64 helper to
 softfloat-types
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
Cc: Peter Maydell <peter.maydell@linaro.org>, armbru@redhat.com,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/8/19 9:41 AM, Alex Bennée wrote:
> This simple pasting helper can be used by those who don't need the
> entire softfloat api. Move it to the smaller types header.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  include/fpu/softfloat-types.h | 2 ++
>  include/fpu/softfloat.h       | 2 --
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
> index 2aae6a89b19..7e88152dfc4 100644
> --- a/include/fpu/softfloat-types.h
> +++ b/include/fpu/softfloat-types.h
> @@ -80,6 +80,8 @@ this code that are retained.
>  #ifndef SOFTFLOAT_TYPES_H
>  #define SOFTFLOAT_TYPES_H
>  
> +#define LIT64( a ) a##LL

Better would be to replace all uses with {,U}INT64_C from <stdint.h>.

But if you prefer this smaller patch for now,
Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~

