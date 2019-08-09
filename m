Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66CFC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 15:49:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9216420C01
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 15:49:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9216420C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw78w-0008Nc-UX
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 11:49:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52289)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hw78R-0007WN-Hf
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:48:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hw78Q-00051q-IL
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:48:55 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42151)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hw78Q-00050r-BZ
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:48:54 -0400
Received: by mail-wr1-f68.google.com with SMTP id b16so1976294wrq.9
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 08:48:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5Oi13/rZPM+SHevM7m+/KQw8/CzWh3xVBc3OgoZVhB0=;
 b=i6+A9ByaOF60JYblmJfIXIrI9KgL1iyYA77wJ7FhP/KHpkna85NMHTV7FmURyGLV6p
 Yim/zDPDVkJNDiSaQjVX+ZECoUaMVvim/x1rl7luE1qFaIiNU3ibVoTgeUNY8wWmZVeF
 klZghzZn+9o3TYMdY+wxRrDN7am32f+FTUQNSVBFABFD528qQHG8sXuuhw50KiTgMbDz
 9pBBgTYy0b0M8EcoegLzL1YEsseCnpVs4XlfzcJ16oGDJRTwcS0XUyEz9nop+Z0aqpMv
 jgO07hLuWeapH6pzDaQLuvbu5WeDEWGB+iFNfDizgoNyvdHpj30l0A4O480zyiAcZvdr
 g8OQ==
X-Gm-Message-State: APjAAAVDylaDBtbCJP7rfSw1V8hM9Zs532vDLsN0g6SnsGpNX5SA9wwJ
 eBIqGq7pmIcPRABngf5/PXh8ww==
X-Google-Smtp-Source: APXvYqwCcDTTAl7KKKTZ2SQ4Kmsj6ojDyUOHUQZIqhLfXF30x/5dD2G+BDbItWZr5sM9D/yV5m12hw==
X-Received: by 2002:a5d:668e:: with SMTP id l14mr24111168wru.156.1565365733268; 
 Fri, 09 Aug 2019 08:48:53 -0700 (PDT)
Received: from [192.168.1.39] (214.red-83-51-160.dynamicip.rima-tde.net.
 [83.51.160.214])
 by smtp.gmail.com with ESMTPSA id p3sm5238896wmg.15.2019.08.09.08.48.52
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 09 Aug 2019 08:48:52 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190809154153.31763-1-richard.henderson@linaro.org>
 <20190809154153.31763-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <2ca2d3fc-36cf-b3ef-8220-4bce3898b633@redhat.com>
Date: Fri, 9 Aug 2019 17:48:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190809154153.31763-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH 3/3] target/riscv: Remove redundant
 declaration pragmas
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
Cc: peter.maydell@linaro.org, Alistair.Francis@wdc.com, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/9/19 5:41 PM, Richard Henderson wrote:
> These are now generated by decodetree itself.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  target/riscv/translate.c | 19 +------------------
>  1 file changed, 1 insertion(+), 18 deletions(-)
> 
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 8d6ab73258..adeddb85f6 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -708,26 +708,9 @@ static bool gen_shift(DisasContext *ctx, arg_r *a,
>  #include "insn_trans/trans_rvd.inc.c"
>  #include "insn_trans/trans_privileged.inc.c"
>  
> -/*
> - * Auto-generated decoder.
> - * Note that the 16-bit decoder reuses some of the trans_* functions
> - * initially declared by the 32-bit decoder, which results in duplicate
> - * declaration warnings.  Suppress them.
> - */
> -#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
> -# pragma GCC diagnostic push
> -# pragma GCC diagnostic ignored "-Wredundant-decls"
> -# ifdef __clang__
> -#  pragma GCC diagnostic ignored "-Wtypedef-redefinition"
> -# endif
> -#endif
> -
> +/* Include the auto-generated decoder for 16 bit insn */
>  #include "decode_insn16.inc.c"
>  
> -#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
> -# pragma GCC diagnostic pop
> -#endif
> -
>  static void decode_opc(DisasContext *ctx)
>  {
>      /* check for compressed insn */
> 

