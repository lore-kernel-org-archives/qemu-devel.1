Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25291C4BA3B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:56:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E623624696
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HG8CBhe3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E623624696
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7GqY-0004Qi-19
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 05:56:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55810)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7Gpl-0003Sw-Bc
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:56:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7Gpk-0006bE-AI
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:56:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58136
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7Gpk-0006at-6z
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:56:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582800959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wEYoNT/cijPB7GqibG/gzqnvDkM/46SZAJDGRq2EqsQ=;
 b=HG8CBhe3OuA4hfRWyk93ZGoz7OA3SOShTej+pccZBxHQ+2IdMpdUjeNwVr0t2tJtPChoUR
 TYmtwspXSp361ZyMNEr0DnuDXBCz8vO4+k1TPkdm74i9Hp7SijX1L9XRLvimrFBq2hHbw7
 L56Y2VcFUjQEERG/z+L2PNWSB77nJes=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-gUK0bQh9NRu-GE7qj7zP7g-1; Thu, 27 Feb 2020 05:55:56 -0500
X-MC-Unique: gUK0bQh9NRu-GE7qj7zP7g-1
Received: by mail-wr1-f70.google.com with SMTP id m15so1125033wrs.22
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 02:55:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kteApUs3RsCNniCriUznWuhA9fmjUixYiTjqoR6ql5U=;
 b=kVe3uern5MGXF91x3854+ikpcFoO8O+z3sHwmDXUftwzzY+RSp9fczCfv9Lt1PFHKZ
 WVOqbmet12MV32v+Exx1+Up6qLYc7m5JcCwAqQL+Hk+OMsVwrU5cNR9OD7MpKxBho1j0
 CrPzbssSfaXHURtK6uXOOuEAuN54b/djjz0CWyCjIPz1z+1xwfwTX5choCf43KhE1VML
 S4iOCgi/4/uejEI/FY48FJLGRq0ZlS6NjPT1/Sx8I/3ORKHURoGmCoBmb6YKEKxXqcaR
 iPmK1RffafmAnXg524Cn+dYcqVQ0uDwAYPRmppKY2CqYXKzdnby+fAKbTlnm2kJ0Dppt
 fJVg==
X-Gm-Message-State: APjAAAU4T/UlsjI6tRThFNhE4aSVD8wGlBFYmF0o815ng/1i0OXlPsrr
 DoPCn/uDyr6+Pu4Bv8g4C2iiLdYwcWkxjvKBIPhPW9RYqEyypuFPyC+QF3XIZIonx+vMhgLgx9e
 I95v5uW44qOi3Goc=
X-Received: by 2002:a5d:4bd2:: with SMTP id l18mr4003615wrt.99.1582800954945; 
 Thu, 27 Feb 2020 02:55:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqwyMoDRhL4+i7rPHMjmjL/Tru5T7F5waZVmvTHOmnkE4AF+7DTxNNTsXS5RxpkHq5lckvZCtQ==
X-Received: by 2002:a5d:4bd2:: with SMTP id l18mr4003591wrt.99.1582800954643; 
 Thu, 27 Feb 2020 02:55:54 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id p10sm559730wrx.81.2020.02.27.02.55.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2020 02:55:54 -0800 (PST)
Subject: Re: [PATCH v1 3/4] accel/tcg: only USE_STATIC_CODE_GEN_BUFFER on 32
 bit hosts
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200226181020.19592-1-alex.bennee@linaro.org>
 <20200226181020.19592-4-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fe07b79c-3324-c9ea-b658-ef7790494ecf@redhat.com>
Date: Thu, 27 Feb 2020 11:55:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200226181020.19592-4-alex.bennee@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/26/20 7:10 PM, Alex Benn=C3=A9e wrote:
> There is no particular reason to use a static codegen buffer on 64 bit
> hosts as we have address space to burn. Allow the common CONFIG_USER
> case to use the mmap'ed buffers like SoftMMU.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   accel/tcg/translate-all.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 5b66af783b5..4ce5d1b3931 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -892,11 +892,12 @@ static void page_lock_pair(PageDesc **ret_p1, tb_pa=
ge_addr_t phys1,
>       }
>   }
>  =20
> -#if defined(CONFIG_USER_ONLY)
> -/* Currently it is not recommended to allocate big chunks of data in
> -   user mode. It will change when a dedicated libc will be used.  */
> -/* ??? 64-bit hosts ought to have no problem mmaping data outside the
> -   region in which the guest needs to run.  Revisit this.  */
> +#if defined(CONFIG_USER_ONLY) && TCG_TARGET_REG_BITS =3D=3D 32
> +/*
> + * For user mode on smaller 32 bit systems we may run into trouble
> + * allocating big chunks of data in the right place. On these systems
> + * we utilise a static code generation buffer directly in the binary.
> + */
>   #define USE_STATIC_CODE_GEN_BUFFER
>   #endif
>  =20
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


