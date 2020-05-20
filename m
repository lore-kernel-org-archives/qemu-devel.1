Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C5EC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 17:33:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 353D520709
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 17:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="adslTD1e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 353D520709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbSau-0003uA-C6
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 13:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jbSXw-0006p4-Eu
 for qemu-devel@nongnu.org; Wed, 20 May 2020 13:30:24 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d]:41386)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jbSXv-0004iM-EQ
 for qemu-devel@nongnu.org; Wed, 20 May 2020 13:30:24 -0400
Received: by mail-ej1-x62d.google.com with SMTP id x1so4964596ejd.8
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 10:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=gCsN2Hk1sU0xzNL4AIWx7BMeAlkTZEIG27VpbqniL2w=;
 b=adslTD1ekujX7RSOAsUYT5haBjqAyII84V7/ApuyqqaI5CDu1b4Fq3KTmU2oHQwU0x
 iZ0wp8wvS2SFsoaOEJSAxS5rqo8fkM/zyUCCW9t5NmeZckhPfYC6agaaMRZsVySoHssD
 liMP69Rq/6LDx+8uZ/3kw4C810pyw0v90zkIS357+sJjvq0Z/zipk8lVzKNyFy7Ey0Ri
 Zd8NMVjp2o7PToZI8fGrahrfXbGMq7JfgwhBhwdoPgPuUK7mF/1rd/iLPns1yXLBeUCp
 WABh45Usd5sIq7i3Q0pjCpm/pZvdIdpCzosQ0Kt5n82bd86w8vSo44oGW+w7T9LYVX8K
 Lzxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=gCsN2Hk1sU0xzNL4AIWx7BMeAlkTZEIG27VpbqniL2w=;
 b=LndXXu5ty4tc0u26gMANtL7L0ar+OPThZacuXU3pc5uNeVglZt6H6Dzyl5P65GyZv3
 jF0iBK6mFpZTeCYCqfW0zXxsmqZkarvjOWuz/TLMfkpMlLXQU2bznSQazz6/kUwisAts
 EMWuXYtg32uxxZkP44AR3ZTTSOGwk4BIb9EUKHV8J+h3acIN9GuXIuLq9FAY/nL5696+
 VbKUyM88T/bGEh0z8BJHLlrBrrSMVyafASobzhZxE2Bj1NhxMehZhsILsw4zkRLy3DDW
 vkoKKzl+6vEuYMVgPGoiQtxAXk7RdNHiB86gdofyBfgikVWXNs2MQIebhvHmxShKN0xe
 6U1g==
X-Gm-Message-State: AOAM533J2b83gHI9n8j5QzsMk4q0l3O68xoy//klWuLUlmRrhOAyjIKQ
 iyHfVPOlXXz4UbZ6mHhO2ll+Qw==
X-Google-Smtp-Source: ABdhPJwVu676Ik6HHBoqgxuLh1kv2+y30/CW2Y6HlRQZSjRhUArBPdiEeAodrLIEZW5JEMnAGQMMGw==
X-Received: by 2002:a17:906:3509:: with SMTP id
 r9mr135686eja.382.1589995821602; 
 Wed, 20 May 2020 10:30:21 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d22sm2531856edj.62.2020.05.20.10.30.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2020 10:30:20 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 945EE1FF7E;
 Wed, 20 May 2020 18:30:19 +0100 (BST)
References: <20200519025355.4420-1-richard.henderson@linaro.org>
 <20200519025355.4420-16-richard.henderson@linaro.org>
User-agent: mu4e 1.4.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RISU v2 15/17] Compute reginfo_size based on the reginfo
In-reply-to: <20200519025355.4420-16-richard.henderson@linaro.org>
Date: Wed, 20 May 2020 18:30:19 +0100
Message-ID: <87sgfufr9w.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> This will allow dumping of SVE frames without having
> to know the SVE vector length beforehand.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  risu.h                 | 2 +-
>  reginfo.c              | 6 +++---
>  risu_reginfo_aarch64.c | 4 ++--
>  risu_reginfo_arm.c     | 2 +-
>  risu_reginfo_i386.c    | 2 +-
>  risu_reginfo_m68k.c    | 2 +-
>  risu_reginfo_ppc64.c   | 2 +-
>  7 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/risu.h b/risu.h
> index eeb6775..054cef7 100644
> --- a/risu.h
> +++ b/risu.h
> @@ -155,6 +155,6 @@ int reginfo_dump(struct reginfo *ri, FILE * f);
>  int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f);
>=20=20
>  /* return size of reginfo */
> -const int reginfo_size(void);
> +int reginfo_size(struct reginfo *ri);
>=20=20
>  #endif /* RISU_H */
> diff --git a/reginfo.c b/reginfo.c
> index f187d9c..411c2a6 100644
> --- a/reginfo.c
> +++ b/reginfo.c
> @@ -38,7 +38,7 @@ RisuResult send_register_info(void *uc)
>      case OP_TESTEND:
>      case OP_COMPARE:
>      case OP_SIGILL:
> -        header.size =3D reginfo_size();
> +        header.size =3D reginfo_size(&ri);
>          extra =3D &ri;
>          break;
>=20=20
> @@ -109,7 +109,7 @@ RisuResult recv_and_compare_register_info(void *uc)
>      case OP_TESTEND:
>      case OP_COMPARE:
>      case OP_SIGILL:
> -        extra_size =3D reginfo_size();
> +        extra_size =3D reginfo_size(&master_ri);
>          break;
>      case OP_SETMEMBLOCK:
>      case OP_GETMEMBLOCK:
> @@ -217,7 +217,7 @@ void report_mismatch_header(void)
>          case OP_COMPARE:
>          case OP_SIGILL:
>              kind =3D "reginfo";
> -            a_sz =3D reginfo_size();
> +            a_sz =3D reginfo_size(&apprentice_ri);
>              break;
>          case OP_SETMEMBLOCK:
>          case OP_GETMEMBLOCK:
> diff --git a/risu_reginfo_aarch64.c b/risu_reginfo_aarch64.c
> index 028c690..7044648 100644
> --- a/risu_reginfo_aarch64.c
> +++ b/risu_reginfo_aarch64.c
> @@ -69,7 +69,7 @@ void process_arch_opt(int opt, const char *arg)
>  #endif
>  }
>=20=20
> -const int reginfo_size(void)
> +int reginfo_size(struct reginfo *ri)
>  {
>      int size =3D offsetof(struct reginfo, simd.end);
>  #ifdef SVE_MAGIC
> @@ -194,7 +194,7 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc)
>  /* reginfo_is_eq: compare the reginfo structs, returns nonzero if equal =
*/
>  int reginfo_is_eq(struct reginfo *r1, struct reginfo *r2)
>  {
> -    return memcmp(r1, r2, reginfo_size()) =3D=3D 0;
> +    return memcmp(r1, r2, reginfo_size(r1)) =3D=3D 0;
>  }
>=20=20
>  #ifdef SVE_MAGIC
> diff --git a/risu_reginfo_arm.c b/risu_reginfo_arm.c
> index 3662f12..3832e27 100644
> --- a/risu_reginfo_arm.c
> +++ b/risu_reginfo_arm.c
> @@ -36,7 +36,7 @@ void process_arch_opt(int opt, const char *arg)
>      abort();
>  }
>=20=20
> -const int reginfo_size(void)
> +int reginfo_size(struct reginfo *ri)
>  {
>      return sizeof(struct reginfo);

I wonder if the fixed size architectures should return (sizeof *ri) to
reinforce the point? Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

