Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C00CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:36:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3713E2054F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:36:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3713E2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNzly-0004zR-5F
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 09:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35146)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNziu-0000Hb-9V
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:33:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNzir-0002ku-E5
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:33:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52096)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNzir-0002kC-4g
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:33:45 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 876B381F0C
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 13:33:42 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id a6so1166943wru.1
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 06:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=berD3fWxhcwCOUWiOjo2XF+v7CI9NfplN/fbr5hnQU0=;
 b=Mk3bR2IsD/10wuFehkSRib1JK2hEVwUtKXfn3/36QzObQNK1QWJ3O0UQJO8DrzcY0O
 YsVyoHe8qd0GFh2OA2Q2aV9NJ+Q1x4iOlhUGxupANFXMY0eGfQv8QTAfzfSEUsmbA3Ej
 xC9TAA0TFDcEGulrTH8p/ZY+vZevLW5b4h10L4lG5CZALYBTq1ydH1L274t5GLXAsZy/
 eHkfUhrq5+O0b1y6OGho8KV2byX9z1Fg8IAs31dlAaPiC2Z5IKDtJBKs//4paKWlW29/
 NYybj8xtkIqUr51+/Y6Qro7HAafg+HGgpzdjAs+rpqBtptH31T/22KBYkqqM4OqvTaJD
 FjNQ==
X-Gm-Message-State: APjAAAVVL/IbdYQ6WIC4TMPGkFEtItNjS2oAEYqMUYZiMqv0PC3jqebz
 MT3SLI/hqRv9JHzGHB7tiJGLjWw6RYcYXuwfN/Bnu/6JOaElTB3dmnag9V9aWmf1xkxDv0dCKLi
 lkmeuZSEqHOAoB9k=
X-Received: by 2002:a5d:630f:: with SMTP id i15mr3130531wru.226.1572010421019; 
 Fri, 25 Oct 2019 06:33:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzW8VykVqc1WgsYusKZVrDR9P7PkgdYAa5iROQyrHeymAwaPkc0WEi4K1l4ixyl9BnGW01LrQ==
X-Received: by 2002:a5d:630f:: with SMTP id i15mr3130515wru.226.1572010420801; 
 Fri, 25 Oct 2019 06:33:40 -0700 (PDT)
Received: from [192.168.1.115] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id n187sm2896515wmb.47.2019.10.25.06.33.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2019 06:33:40 -0700 (PDT)
Subject: Re: [PATCH 4/4] crypto: add support for nettle's native XTS impl
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20191017145654.11371-1-berrange@redhat.com>
 <20191017145654.11371-5-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ad516c72-1b66-daf0-60bd-2eeb34aba227@redhat.com>
Date: Fri, 25 Oct 2019 15:33:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191017145654.11371-5-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/17/19 4:56 PM, Daniel P. Berrang=C3=A9 wrote:
> Nettle 3.5.0 will add support for the XTS mode. Use this because long
> term we wish to delete QEMU's XTS impl to avoid carrying private crypto
> algorithm impls.
>=20
> Unfortunately this degrades nettle performance from 612 MB/s to 568 MB/=
s
> as nettle's XTS impl isn't so well optimized yet.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>   configure              | 18 ++++++++++++++++++
>   crypto/cipher-nettle.c | 18 ++++++++++++++++++
>   2 files changed, 36 insertions(+)
>=20
> diff --git a/configure b/configure
> index 98edb0ff44..6650c72348 100755
> --- a/configure
> +++ b/configure
> @@ -471,6 +471,7 @@ gtk_gl=3D"no"
>   tls_priority=3D"NORMAL"
>   gnutls=3D""
>   nettle=3D""
> +nettle_xts=3D"no"
>   gcrypt=3D""
>   gcrypt_hmac=3D"no"
>   gcrypt_xts=3D"no"
> @@ -2862,6 +2863,19 @@ if test "$nettle" !=3D "no"; then
>               pass=3D"yes"
>           fi
>       fi
> +    if test "$pass" =3D "yes"
> +    then
> +        cat > $TMPC << EOF
> +#include <nettle/xts.h>
> +int main(void) {
> +  return 0;
> +}
> +EOF
> +        if compile_prog "$nettle_cflags" "$nettle_libs" ; then
> +            nettle_xts=3Dyes
> +            qemu_private_xts=3Dno

Ah, now this variable makes sense.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +        fi
> +    fi
>       if test "$pass" =3D "no" && test "$nettle" =3D "yes"; then
>           feature_not_found "nettle" "Install nettle devel >=3D 2.7.1"
>       else
> @@ -6337,6 +6351,10 @@ then
>      echo "  XTS             $gcrypt_xts"
>   fi
>   echo "nettle            $nettle $(echo_version $nettle $nettle_versio=
n)"
> +if test "$nettle" =3D "yes"
> +then
> +   echo "  XTS             $nettle_xts"
> +fi
>   echo "libtasn1          $tasn1"
>   echo "PAM               $auth_pam"
>   echo "iconv support     $iconv"
> diff --git a/crypto/cipher-nettle.c b/crypto/cipher-nettle.c
> index d7411bb8ff..08794a9b10 100644
> --- a/crypto/cipher-nettle.c
> +++ b/crypto/cipher-nettle.c
> @@ -19,7 +19,9 @@
>    */
>  =20
>   #include "qemu/osdep.h"
> +#ifdef CONFIG_QEMU_PRIVATE_XTS
>   #include "crypto/xts.h"
> +#endif
>   #include "cipherpriv.h"
>  =20
>   #include <nettle/nettle-types.h>
> @@ -30,6 +32,9 @@
>   #include <nettle/serpent.h>
>   #include <nettle/twofish.h>
>   #include <nettle/ctr.h>
> +#ifndef CONFIG_QEMU_PRIVATE_XTS
> +#include <nettle/xts.h>
> +#endif
>  =20
>   typedef void (*QCryptoCipherNettleFuncWrapper)(const void *ctx,
>                                                  size_t length,
> @@ -626,9 +631,15 @@ qcrypto_nettle_cipher_encrypt(QCryptoCipher *ciphe=
r,
>           break;
>  =20
>       case QCRYPTO_CIPHER_MODE_XTS:
> +#ifdef CONFIG_QEMU_PRIVATE_XTS
>           xts_encrypt(ctx->ctx, ctx->ctx_tweak,
>                       ctx->alg_encrypt_wrapper, ctx->alg_encrypt_wrappe=
r,
>                       ctx->iv, len, out, in);
> +#else
> +        xts_encrypt_message(ctx->ctx, ctx->ctx_tweak,
> +                            ctx->alg_encrypt_native,
> +                            ctx->iv, len, out, in);
> +#endif
>           break;
>  =20
>       case QCRYPTO_CIPHER_MODE_CTR:
> @@ -673,9 +684,16 @@ qcrypto_nettle_cipher_decrypt(QCryptoCipher *ciphe=
r,
>           break;
>  =20
>       case QCRYPTO_CIPHER_MODE_XTS:
> +#ifdef CONFIG_QEMU_PRIVATE_XTS
>           xts_decrypt(ctx->ctx, ctx->ctx_tweak,
>                       ctx->alg_encrypt_wrapper, ctx->alg_decrypt_wrappe=
r,
>                       ctx->iv, len, out, in);
> +#else
> +        xts_decrypt_message(ctx->ctx, ctx->ctx_tweak,
> +                            ctx->alg_encrypt_native,
> +                            ctx->alg_decrypt_native,
> +                            ctx->iv, len, out, in);
> +#endif
>           break;
>       case QCRYPTO_CIPHER_MODE_CTR:
>           ctr_crypt(ctx->ctx, ctx->alg_encrypt_native,
>=20

