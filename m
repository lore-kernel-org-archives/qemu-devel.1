Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14382CA9EBD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:18:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCC6221D71
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:18:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCC6221D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO0Pw-0005LG-44
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 10:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42932)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1iO0Le-0007oJ-Bw
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:13:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1iO0Ld-0005iQ-2M
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:13:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:27944)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1iO0Lc-0005hZ-Pg
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:13:49 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 17F444E8AC
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 14:13:47 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id l4so1210720wru.10
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 07:13:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=zKTrq6oks7rUSVsuB0L6seNToGcRYUZAuxxkU9Ca8qM=;
 b=gy3rm5N44bNwQ8InbLYFhF55dxHsUP21x552Kd5Bw7nEoM1TtxaNdFlCMijQxLrwP8
 JbpLqMFz4XuT/Kji786bcKQchUzWG+D+R9uc70piFptBDPywLspTHRpCcQ7Wk9pBjVYj
 INLeEuXcKhNTiseNKtVwWH3FUDpru0zS7C086cQF0P15MvrJ6XqBakGdRZk3NzYrdJ40
 y8+oBfPyW4XFupW8GrDbSEGvAhgOehjzMxK5zJzPO6Yiy4PYXaCkXzqfZNxqjYEQ8XGc
 xwtTuyoB1YC1+n3fF0LyxRA/ZdClbEYhL921Jml8K1cU1bBoTDI2w68qfvL04oxcLd1d
 X3dA==
X-Gm-Message-State: APjAAAXZxmSZN+8PcGXBfIHGYjqAKAAlUtF1LO6q8VzkGCL4fhNMGGYm
 0L/LuBpR1Ykuni3QKouPrnAGjKioxq6FU4ZdJ7+caTdzIm1775HQubpX0W4e0lwukU/BrY1faXx
 /82kHfQIxZ+IrlWo=
X-Received: by 2002:a1c:a848:: with SMTP id r69mr3604404wme.83.1572012825761; 
 Fri, 25 Oct 2019 07:13:45 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzsj3r3hipAg2S1cjb3DeddN7eH+6TZiyngn2IHCm9XpMJyOh0ca5bzg6NdbBdM6TKFmZo4BA==
X-Received: by 2002:a1c:a848:: with SMTP id r69mr3604383wme.83.1572012825487; 
 Fri, 25 Oct 2019 07:13:45 -0700 (PDT)
Received: from steredhat (host174-200-dynamic.52-79-r.retail.telecomitalia.it.
 [79.52.200.174])
 by smtp.gmail.com with ESMTPSA id 200sm3399381wme.32.2019.10.25.07.13.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 07:13:45 -0700 (PDT)
Date: Fri, 25 Oct 2019 16:13:43 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH 4/4] crypto: add support for nettle's native XTS impl
Message-ID: <20191025141343.l4aiis6acb6hhp35@steredhat>
References: <20191017145654.11371-1-berrange@redhat.com>
 <20191017145654.11371-5-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20191017145654.11371-5-berrange@redhat.com>
User-Agent: NeoMutt/20180716
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 17, 2019 at 03:56:54PM +0100, Daniel P. Berrang=E9 wrote:
> Nettle 3.5.0 will add support for the XTS mode. Use this because long
> term we wish to delete QEMU's XTS impl to avoid carrying private crypto
> algorithm impls.
>=20
> Unfortunately this degrades nettle performance from 612 MB/s to 568 MB/=
s
> as nettle's XTS impl isn't so well optimized yet.
>=20
> Signed-off-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> ---
>  configure              | 18 ++++++++++++++++++
>  crypto/cipher-nettle.c | 18 ++++++++++++++++++
>  2 files changed, 36 insertions(+)
>=20
> diff --git a/configure b/configure
> index 98edb0ff44..6650c72348 100755
> --- a/configure
> +++ b/configure
> @@ -471,6 +471,7 @@ gtk_gl=3D"no"
>  tls_priority=3D"NORMAL"
>  gnutls=3D""
>  nettle=3D""
> +nettle_xts=3D"no"
>  gcrypt=3D""
>  gcrypt_hmac=3D"no"
>  gcrypt_xts=3D"no"
> @@ -2862,6 +2863,19 @@ if test "$nettle" !=3D "no"; then
>              pass=3D"yes"
>          fi
>      fi
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
> +        fi
> +    fi
>      if test "$pass" =3D "no" && test "$nettle" =3D "yes"; then
>          feature_not_found "nettle" "Install nettle devel >=3D 2.7.1"
>      else
> @@ -6337,6 +6351,10 @@ then
>     echo "  XTS             $gcrypt_xts"
>  fi
>  echo "nettle            $nettle $(echo_version $nettle $nettle_version=
)"
> +if test "$nettle" =3D "yes"
> +then
> +   echo "  XTS             $nettle_xts"
> +fi
>  echo "libtasn1          $tasn1"
>  echo "PAM               $auth_pam"
>  echo "iconv support     $iconv"
> diff --git a/crypto/cipher-nettle.c b/crypto/cipher-nettle.c
> index d7411bb8ff..08794a9b10 100644
> --- a/crypto/cipher-nettle.c
> +++ b/crypto/cipher-nettle.c
> @@ -19,7 +19,9 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#ifdef CONFIG_QEMU_PRIVATE_XTS
>  #include "crypto/xts.h"
> +#endif
>  #include "cipherpriv.h"
> =20
>  #include <nettle/nettle-types.h>
> @@ -30,6 +32,9 @@
>  #include <nettle/serpent.h>
>  #include <nettle/twofish.h>
>  #include <nettle/ctr.h>
> +#ifndef CONFIG_QEMU_PRIVATE_XTS
> +#include <nettle/xts.h>
> +#endif
> =20
>  typedef void (*QCryptoCipherNettleFuncWrapper)(const void *ctx,
>                                                 size_t length,
> @@ -626,9 +631,15 @@ qcrypto_nettle_cipher_encrypt(QCryptoCipher *ciphe=
r,
>          break;
> =20
>      case QCRYPTO_CIPHER_MODE_XTS:
> +#ifdef CONFIG_QEMU_PRIVATE_XTS
>          xts_encrypt(ctx->ctx, ctx->ctx_tweak,
>                      ctx->alg_encrypt_wrapper, ctx->alg_encrypt_wrapper=
,
>                      ctx->iv, len, out, in);
> +#else
> +        xts_encrypt_message(ctx->ctx, ctx->ctx_tweak,
> +                            ctx->alg_encrypt_native,
> +                            ctx->iv, len, out, in);
> +#endif
>          break;
> =20
>      case QCRYPTO_CIPHER_MODE_CTR:
> @@ -673,9 +684,16 @@ qcrypto_nettle_cipher_decrypt(QCryptoCipher *ciphe=
r,
>          break;
> =20
>      case QCRYPTO_CIPHER_MODE_XTS:
> +#ifdef CONFIG_QEMU_PRIVATE_XTS
>          xts_decrypt(ctx->ctx, ctx->ctx_tweak,
>                      ctx->alg_encrypt_wrapper, ctx->alg_decrypt_wrapper=
,
>                      ctx->iv, len, out, in);
> +#else
> +        xts_decrypt_message(ctx->ctx, ctx->ctx_tweak,
> +                            ctx->alg_encrypt_native,
> +                            ctx->alg_decrypt_native,
> +                            ctx->iv, len, out, in);
> +#endif
>          break;
>      case QCRYPTO_CIPHER_MODE_CTR:
>          ctr_crypt(ctx->ctx, ctx->alg_encrypt_native,

It seems clear to me:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


