Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42722C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 08:54:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0593D20685
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 08:54:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0593D20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50275 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIrBq-0003QS-A8
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 04:54:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIrAm-0002po-Bs
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 04:53:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIrAi-0006Mh-I8
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 04:53:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50840)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hIrAg-000645-LH
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 04:53:00 -0400
Received: by mail-wm1-f66.google.com with SMTP id 10so1178008wmk.0
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 01:52:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=5amF3rMMW0JKkHGQuB0Nco9Et3F92ZoGz7Ke3wTsUAk=;
	b=duCAEO6j1JZMKeesqHANIe83+Qy/8k4LkonALzzzd0YxHybhxrapAOGO3FVbMyF+Oj
	Y6GMifVVCYYP3qSLoVHoKdMr9xtEWM+x0z/nuJUFAUkoXzX2ariKm0LzyoUROAySh/Ta
	MOG2fUa2oZnJUrkO2YlxGxT859W1p2LyUEBIq7IhMDBAnMz2liQnrgjASSWMo07Rgn4+
	ny3BvepDIuFaYiPYT1l+TDLxEBOOvsqfK/arhOfN3AUYDsqvkWJdzsXfJRajVR6zhHrG
	CAytYCX9BQ4ocAQKkOjr3g0Ick4vtaHeMqu9biQhc4jVFfrGLX4vScdTEkOxzmpsTIf8
	hfBQ==
X-Gm-Message-State: APjAAAUk2LoPPcGog2BbVegKLa7KFd72Wy6+KynbqPkp8ZONIjk644DN
	hOln4n+ZuLdHFTrQkHIqWXHGDT1HMISoFQ==
X-Google-Smtp-Source: APXvYqxgYHTgDrXLrtgtP75ObH5c5zYs0nzoqUGyzYcPzfRH82xSjtyV/OFOeQQAsjJZzlW7km4IZA==
X-Received: by 2002:a1c:2d45:: with SMTP id t66mr1396603wmt.106.1556009563047; 
	Tue, 23 Apr 2019 01:52:43 -0700 (PDT)
Received: from [192.168.1.25] (atoulouse-656-1-803-163.w86-221.abo.wanadoo.fr.
	[86.221.12.163]) by smtp.gmail.com with ESMTPSA id
	t17sm12166607wrr.26.2019.04.23.01.52.42
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 01:52:42 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190420073442.7488-1-richard.henderson@linaro.org>
	<20190420073442.7488-20-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <2f9b3973-4e56-b3b0-1a5c-bbb68e27e939@redhat.com>
Date: Tue, 23 Apr 2019 10:52:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190420073442.7488-20-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH 19/38] tcg: Add support for integer
 absolute value
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
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423085241.6eDft5CSr5BQVAi60pGmGIWMO3s6dMXPEERToQ_usL4@z>

On 4/20/19 9:34 AM, Richard Henderson wrote:
> Remove a function of the same name from target/arm/.
> Use a branchless implementation of abs that gcc uses for x86.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/tcg-op.h           |  5 +++++
>  target/arm/translate.c | 10 ----------
>  tcg/tcg-op.c           | 20 ++++++++++++++++++++
>  3 files changed, 25 insertions(+), 10 deletions(-)
> 
> diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
> index 472b73cb38..660fe205d0 100644
> --- a/tcg/tcg-op.h
> +++ b/tcg/tcg-op.h
> @@ -335,6 +335,7 @@ void tcg_gen_smin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
>  void tcg_gen_smax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
>  void tcg_gen_umin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
>  void tcg_gen_umax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
> +void tcg_gen_abs_i32(TCGv_i32, TCGv_i32);
>  
>  static inline void tcg_gen_discard_i32(TCGv_i32 arg)
>  {
> @@ -534,6 +535,7 @@ void tcg_gen_smin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
>  void tcg_gen_smax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
>  void tcg_gen_umin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
>  void tcg_gen_umax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
> +void tcg_gen_abs_i64(TCGv_i64, TCGv_i64);
>  
>  #if TCG_TARGET_REG_BITS == 64
>  static inline void tcg_gen_discard_i64(TCGv_i64 arg)
> @@ -973,6 +975,7 @@ void tcg_gen_nor_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
>  void tcg_gen_eqv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
>  void tcg_gen_not_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
>  void tcg_gen_neg_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
> +void tcg_gen_abs_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
>  void tcg_gen_ssadd_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
>  void tcg_gen_usadd_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
>  void tcg_gen_sssub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
> @@ -1019,6 +1022,7 @@ void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset, TCGType t);
>  #define tcg_gen_addi_tl tcg_gen_addi_i64
>  #define tcg_gen_sub_tl tcg_gen_sub_i64
>  #define tcg_gen_neg_tl tcg_gen_neg_i64
> +#define tcg_gen_abs_tl tcg_gen_abs_i64
>  #define tcg_gen_subfi_tl tcg_gen_subfi_i64
>  #define tcg_gen_subi_tl tcg_gen_subi_i64
>  #define tcg_gen_and_tl tcg_gen_and_i64
> @@ -1131,6 +1135,7 @@ void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset, TCGType t);
>  #define tcg_gen_addi_tl tcg_gen_addi_i32
>  #define tcg_gen_sub_tl tcg_gen_sub_i32
>  #define tcg_gen_neg_tl tcg_gen_neg_i32
> +#define tcg_gen_abs_tl tcg_gen_abs_i32
>  #define tcg_gen_subfi_tl tcg_gen_subfi_i32
>  #define tcg_gen_subi_tl tcg_gen_subi_i32
>  #define tcg_gen_and_tl tcg_gen_and_i32
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 83a008e945..721171794d 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -603,16 +603,6 @@ static void gen_sar(TCGv_i32 dest, TCGv_i32 t0, TCGv_i32 t1)
>      tcg_temp_free_i32(tmp1);
>  }
>  
> -static void tcg_gen_abs_i32(TCGv_i32 dest, TCGv_i32 src)
> -{
> -    TCGv_i32 c0 = tcg_const_i32(0);
> -    TCGv_i32 tmp = tcg_temp_new_i32();
> -    tcg_gen_neg_i32(tmp, src);
> -    tcg_gen_movcond_i32(TCG_COND_GT, dest, src, c0, src, tmp);
> -    tcg_temp_free_i32(c0);
> -    tcg_temp_free_i32(tmp);
> -}
> -
>  static void shifter_out_im(TCGv_i32 var, int shift)
>  {
>      if (shift == 0) {
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index a00d1df37e..0ac291f1c4 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -1091,6 +1091,16 @@ void tcg_gen_umax_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
>      tcg_gen_movcond_i32(TCG_COND_LTU, ret, a, b, b, a);
>  }
>  
> +void tcg_gen_abs_i32(TCGv_i32 ret, TCGv_i32 a)
> +{
> +    TCGv_i32 t = tcg_temp_new_i32();
> +
> +    tcg_gen_sari_i32(t, a, 31);
> +    tcg_gen_xor_i32(ret, a, t);
> +    tcg_gen_sub_i32(ret, ret, t);
> +    tcg_temp_free_i32(t);
> +}
> +
>  /* 64-bit ops */
>  
>  #if TCG_TARGET_REG_BITS == 32
> @@ -2548,6 +2558,16 @@ void tcg_gen_umax_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
>      tcg_gen_movcond_i64(TCG_COND_LTU, ret, a, b, b, a);
>  }
>  
> +void tcg_gen_abs_i64(TCGv_i64 ret, TCGv_i64 a)
> +{
> +    TCGv_i64 t = tcg_temp_new_i64();
> +
> +    tcg_gen_sari_i64(t, a, 63);
> +    tcg_gen_xor_i64(ret, a, t);
> +    tcg_gen_sub_i64(ret, ret, t);
> +    tcg_temp_free_i64(t);
> +}
> +
>  /* Size changing operations.  */
>  
>  void tcg_gen_extrl_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

