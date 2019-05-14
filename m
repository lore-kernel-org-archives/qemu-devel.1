Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17658C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 17:09:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E43AD2084A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 17:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E43AD2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51361 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQaw0-0002kh-4b
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 13:09:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hQau4-000152-H9
	for qemu-devel@nongnu.org; Tue, 14 May 2019 13:07:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hQala-00016S-SS
	for qemu-devel@nongnu.org; Tue, 14 May 2019 12:59:03 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50466)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hQala-00012v-LH
	for qemu-devel@nongnu.org; Tue, 14 May 2019 12:59:02 -0400
Received: by mail-wm1-f68.google.com with SMTP id f204so3641587wme.0
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 09:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=Txru0t/jjgKlFBr2PCnXCr7WUnQEwCi5YXYcqSLxRfQ=;
	b=hsw1zbiGThzqGeMJ4rta+lbJP0riu6bIy8iiSsOmB2jjPf+eiJYYHBI2UU0XNoHXCp
	FVLEpne+KD0Z8HUXZo6aWK+OEqv26ekXXE66IWkzNQbxRBvyweIOeefsMbbMWAJ/Yc8u
	qH3MSXq6+Ye14OE9I1U4V2ZyGbER1gIeJv99eKifsF2qh83TZIbWjvdR+gCqNv7oi9/U
	iOTD/eNLl5YYxIdF1OjjIGQNgE302tTd0pkA2/YreOZt2OysfmoQr8R4f6invSVpj8sR
	KpgiPUfVuWGsPSwi6cBDudO0yQEd+xWL5mvmOO4dzj/ojjYwtdyTqV7yoPs11ocX5I3D
	HvHg==
X-Gm-Message-State: APjAAAUd3rBGM/bICcVtOCgRfuXRAy7AAV85SzyVTUEOa52S4+2+aTbN
	g3kG0JMyN7FdRBe4vsklQcW8rw==
X-Google-Smtp-Source: APXvYqzFysbb+63KWw9gf3qWIXZORXIlMMA3o3JJ1gmuw40/USODu/IGPrRiz84ywJJahZmR+Hc4ZA==
X-Received: by 2002:a7b:ca47:: with SMTP id m7mr1628917wml.150.1557853141496; 
	Tue, 14 May 2019 09:59:01 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	w185sm3629220wma.39.2019.05.14.09.59.00
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 09:59:01 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190514155301.16123-1-alex.bennee@linaro.org>
	<20190514155301.16123-10-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <dadc0cad-cb9a-73a7-d87e-de742756a193@redhat.com>
Date: Tue, 14 May 2019 18:59:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514155301.16123-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [RFC PATCH 09/11] target/mips: only build
 mips-semi for softmmu
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-arm@nongnu.org,
	Aurelien Jarno <aurelien@aurel32.net>,
	Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/19 5:52 PM, Alex Bennée wrote:
> The is_uhi gates all semihosting calls and always returns false for
> CONFIG_USER_ONLY builds. There is no reason to build and link
> mips-semi for these builds so lets fix that.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  target/mips/Makefile.objs | 3 ++-
>  target/mips/helper.h      | 2 ++
>  target/mips/translate.c   | 8 ++++++++
>  3 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/target/mips/Makefile.objs b/target/mips/Makefile.objs
> index 651f36f5176..3448ad5e193 100644
> --- a/target/mips/Makefile.objs
> +++ b/target/mips/Makefile.objs
> @@ -1,4 +1,5 @@
>  obj-y += translate.o dsp_helper.o op_helper.o lmi_helper.o helper.o cpu.o
> -obj-y += gdbstub.o msa_helper.o mips-semi.o
> +obj-y += gdbstub.o msa_helper.o
> +obj-$(CONFIG_SOFTMMU) += mips-semi.o
>  obj-$(CONFIG_SOFTMMU) += machine.o cp0_timer.o
>  obj-$(CONFIG_KVM) += kvm.o
> diff --git a/target/mips/helper.h b/target/mips/helper.h
> index a6d687e3405..90ab03b76e3 100644
> --- a/target/mips/helper.h
> +++ b/target/mips/helper.h
> @@ -2,7 +2,9 @@ DEF_HELPER_3(raise_exception_err, noreturn, env, i32, int)
>  DEF_HELPER_2(raise_exception, noreturn, env, i32)
>  DEF_HELPER_1(raise_exception_debug, noreturn, env)
>  
> +#ifndef CONFIG_USER_ONLY
>  DEF_HELPER_1(do_semihosting, void, env)
> +#endif
>  
>  #ifdef TARGET_MIPS64
>  DEF_HELPER_4(sdl, void, env, tl, tl, int)
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 3cd5b11b16b..fb905c88b57 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -13726,6 +13726,14 @@ static inline bool is_uhi(int sdbbp_code)
>  #endif
>  }
>  
> +#ifdef CONFIG_USER_ONLY
> +/* The above should dead-code away any calls to this..*/
> +static inline void gen_helper_do_semihosting(void *env)
> +{
> +    g_assert_not_reached();
> +}
> +#endif
> +
>  static int decode_mips16_opc (CPUMIPSState *env, DisasContext *ctx)
>  {
>      int rx, ry;
> 

