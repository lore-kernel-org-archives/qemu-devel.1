Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A02AC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 12:49:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 255D12133D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 12:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 255D12133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51250 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbldj-0005DP-At
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 08:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59500)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hblWu-0000TR-MX
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 08:42:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hblWr-0000tF-Uy
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 08:42:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33533)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hblWr-0000sf-Mz
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 08:42:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so2414104wru.0
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 05:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AVivPINX2Kzu9XL6OoWJrB2b9xTjP4o+TM2G8HvSIs4=;
 b=it9M+U/EIuUf8FeKj6MOUr1fdNba1aEqMt8YZUhKf29X83QuG430yNV8pWMvZyi26/
 hsL2Id8sT11/Od84tX+6JQca985BkE61Ry0hCXjmSrFSgnvxKURC3X62xrCTaKcdKqYa
 i0PRYX3xxSdxtPb9Rcf+irA+PKtexw7ccMxH3dx6OpkujqL2yTJVk2huNcNBk1xPL6h9
 NDJ+uTkn2ftlmXfNyFGir1HaGLM766qScMcYC2F+ANdEcuXa0Livf/UcUQ4gCIiD2LGV
 saJBp67Uqp47/BlAMaMS865XRvkhGPoAwuUQaCHif39A/JJcqma/RPgKCnmNquFLCsW2
 lMKA==
X-Gm-Message-State: APjAAAVGRk9CdKviNslX4ldk8+jydGcvjBsNxx67t+Ex+taUUZjoHCwy
 DtzmT0vTCG6V3rlmgMruzw7fQA==
X-Google-Smtp-Source: APXvYqx2rRAg3jf6EanQNtzkRFsFeyi6hK1D3nzxtfsa2zb8d+n0lf9wLOaPxWHgfrtXAei38N3w+Q==
X-Received: by 2002:a5d:4bce:: with SMTP id l14mr4919269wrt.79.1560516120751; 
 Fri, 14 Jun 2019 05:42:00 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id a2sm3884548wmj.9.2019.06.14.05.42.00
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Jun 2019 05:42:00 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190614104457.24703-1-peter.maydell@linaro.org>
 <20190614104457.24703-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <943f65bd-ba2d-7172-a19d-f565ce86410e@redhat.com>
Date: Fri, 14 Jun 2019 14:41:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190614104457.24703-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH 1/2] target/arm: Fix typos in trans
 function prototypes
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/14/19 12:44 PM, Peter Maydell wrote:
> In several places cut and paste errors meant we were using the wrong
> type for the 'arg' struct in trans_ functions called by the
> decodetree decoder, because we were using the _sp version of the
> struct in the _dp function.  These were harmless, because the two
> structs were identical and so decodetree made them typedefs of the
> same underlying structure (and we'd have had a compile error if they
> were not harmless), but we should clean them up anyway.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-vfp.inc.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
> index 709fc65374d..85187bcc9dc 100644
> --- a/target/arm/translate-vfp.inc.c
> +++ b/target/arm/translate-vfp.inc.c
> @@ -835,7 +835,7 @@ static bool trans_VMOV_64_sp(DisasContext *s, arg_VMOV_64_sp *a)
>      return true;
>  }
>  
> -static bool trans_VMOV_64_dp(DisasContext *s, arg_VMOV_64_sp *a)
> +static bool trans_VMOV_64_dp(DisasContext *s, arg_VMOV_64_dp *a)
>  {
>      TCGv_i32 tmp;
>  
> @@ -910,7 +910,7 @@ static bool trans_VLDR_VSTR_sp(DisasContext *s, arg_VLDR_VSTR_sp *a)
>      return true;
>  }
>  
> -static bool trans_VLDR_VSTR_dp(DisasContext *s, arg_VLDR_VSTR_sp *a)
> +static bool trans_VLDR_VSTR_dp(DisasContext *s, arg_VLDR_VSTR_dp *a)
>  {
>      uint32_t offset;
>      TCGv_i32 addr;
> @@ -1500,7 +1500,7 @@ static void gen_VMLA_dp(TCGv_i64 vd, TCGv_i64 vn, TCGv_i64 vm, TCGv_ptr fpst)
>      tcg_temp_free_i64(tmp);
>  }
>  
> -static bool trans_VMLA_dp(DisasContext *s, arg_VMLA_sp *a)
> +static bool trans_VMLA_dp(DisasContext *s, arg_VMLA_dp *a)
>  {
>      return do_vfp_3op_dp(s, gen_VMLA_dp, a->vd, a->vn, a->vm, true);
>  }
> @@ -1538,7 +1538,7 @@ static void gen_VMLS_dp(TCGv_i64 vd, TCGv_i64 vn, TCGv_i64 vm, TCGv_ptr fpst)
>      tcg_temp_free_i64(tmp);
>  }
>  
> -static bool trans_VMLS_dp(DisasContext *s, arg_VMLS_sp *a)
> +static bool trans_VMLS_dp(DisasContext *s, arg_VMLS_dp *a)
>  {
>      return do_vfp_3op_dp(s, gen_VMLS_dp, a->vd, a->vn, a->vm, true);
>  }
> @@ -1580,7 +1580,7 @@ static void gen_VNMLS_dp(TCGv_i64 vd, TCGv_i64 vn, TCGv_i64 vm, TCGv_ptr fpst)
>      tcg_temp_free_i64(tmp);
>  }
>  
> -static bool trans_VNMLS_dp(DisasContext *s, arg_VNMLS_sp *a)
> +static bool trans_VNMLS_dp(DisasContext *s, arg_VNMLS_dp *a)
>  {
>      return do_vfp_3op_dp(s, gen_VNMLS_dp, a->vd, a->vn, a->vm, true);
>  }
> @@ -1614,7 +1614,7 @@ static void gen_VNMLA_dp(TCGv_i64 vd, TCGv_i64 vn, TCGv_i64 vm, TCGv_ptr fpst)
>      tcg_temp_free_i64(tmp);
>  }
>  
> -static bool trans_VNMLA_dp(DisasContext *s, arg_VNMLA_sp *a)
> +static bool trans_VNMLA_dp(DisasContext *s, arg_VNMLA_dp *a)
>  {
>      return do_vfp_3op_dp(s, gen_VNMLA_dp, a->vd, a->vn, a->vm, true);
>  }
> @@ -1624,7 +1624,7 @@ static bool trans_VMUL_sp(DisasContext *s, arg_VMUL_sp *a)
>      return do_vfp_3op_sp(s, gen_helper_vfp_muls, a->vd, a->vn, a->vm, false);
>  }
>  
> -static bool trans_VMUL_dp(DisasContext *s, arg_VMUL_sp *a)
> +static bool trans_VMUL_dp(DisasContext *s, arg_VMUL_dp *a)
>  {
>      return do_vfp_3op_dp(s, gen_helper_vfp_muld, a->vd, a->vn, a->vm, false);
>  }
> @@ -1648,7 +1648,7 @@ static void gen_VNMUL_dp(TCGv_i64 vd, TCGv_i64 vn, TCGv_i64 vm, TCGv_ptr fpst)
>      gen_helper_vfp_negd(vd, vd);
>  }
>  
> -static bool trans_VNMUL_dp(DisasContext *s, arg_VNMUL_sp *a)
> +static bool trans_VNMUL_dp(DisasContext *s, arg_VNMUL_dp *a)
>  {
>      return do_vfp_3op_dp(s, gen_VNMUL_dp, a->vd, a->vn, a->vm, false);
>  }
> @@ -1658,7 +1658,7 @@ static bool trans_VADD_sp(DisasContext *s, arg_VADD_sp *a)
>      return do_vfp_3op_sp(s, gen_helper_vfp_adds, a->vd, a->vn, a->vm, false);
>  }
>  
> -static bool trans_VADD_dp(DisasContext *s, arg_VADD_sp *a)
> +static bool trans_VADD_dp(DisasContext *s, arg_VADD_dp *a)
>  {
>      return do_vfp_3op_dp(s, gen_helper_vfp_addd, a->vd, a->vn, a->vm, false);
>  }
> @@ -1668,7 +1668,7 @@ static bool trans_VSUB_sp(DisasContext *s, arg_VSUB_sp *a)
>      return do_vfp_3op_sp(s, gen_helper_vfp_subs, a->vd, a->vn, a->vm, false);
>  }
>  
> -static bool trans_VSUB_dp(DisasContext *s, arg_VSUB_sp *a)
> +static bool trans_VSUB_dp(DisasContext *s, arg_VSUB_dp *a)
>  {
>      return do_vfp_3op_dp(s, gen_helper_vfp_subd, a->vd, a->vn, a->vm, false);
>  }
> @@ -1678,7 +1678,7 @@ static bool trans_VDIV_sp(DisasContext *s, arg_VDIV_sp *a)
>      return do_vfp_3op_sp(s, gen_helper_vfp_divs, a->vd, a->vn, a->vm, false);
>  }
>  
> -static bool trans_VDIV_dp(DisasContext *s, arg_VDIV_sp *a)
> +static bool trans_VDIV_dp(DisasContext *s, arg_VDIV_dp *a)
>  {
>      return do_vfp_3op_dp(s, gen_helper_vfp_divd, a->vd, a->vn, a->vm, false);
>  }
> @@ -1741,7 +1741,7 @@ static bool trans_VFM_sp(DisasContext *s, arg_VFM_sp *a)
>      return true;
>  }
>  
> -static bool trans_VFM_dp(DisasContext *s, arg_VFM_sp *a)
> +static bool trans_VFM_dp(DisasContext *s, arg_VFM_dp *a)
>  {
>      /*
>       * VFNMA : fd = muladd(-fd,  fn, fm)
> @@ -2201,7 +2201,7 @@ static bool trans_VRINTR_sp(DisasContext *s, arg_VRINTR_sp *a)
>      return true;
>  }
>  
> -static bool trans_VRINTR_dp(DisasContext *s, arg_VRINTR_sp *a)
> +static bool trans_VRINTR_dp(DisasContext *s, arg_VRINTR_dp *a)
>  {
>      TCGv_ptr fpst;
>      TCGv_i64 tmp;
> @@ -2257,7 +2257,7 @@ static bool trans_VRINTZ_sp(DisasContext *s, arg_VRINTZ_sp *a)
>      return true;
>  }
>  
> -static bool trans_VRINTZ_dp(DisasContext *s, arg_VRINTZ_sp *a)
> +static bool trans_VRINTZ_dp(DisasContext *s, arg_VRINTZ_dp *a)
>  {
>      TCGv_ptr fpst;
>      TCGv_i64 tmp;
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

