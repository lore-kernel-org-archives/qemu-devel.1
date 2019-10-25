Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35483CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:40:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9A882054F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9A882054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNzpT-0003lq-GM
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 09:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNzh7-0006Uq-KU
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:32:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNzh5-0001ax-Md
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:31:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52232)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNzh5-0001ai-Dw
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:31:55 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 062EF85362
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 13:31:54 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id k184so1155084wmk.1
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 06:31:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MpXXs2Qt8oaq+/H8OajuI1nB8fUBtb9qRc35Kcub6MY=;
 b=De4O7cBWY+4Nbb+VPv+fm17gMDAZcySJhhTCIo2Ub8OXi80WDzKe5XJWlUhZwv09Jk
 JEYOtA9eQKWYpOvsW47lNgsFPsiDE/hpEHBOFed5aEi/+rhGXcTi0hJtfstfOqf+oC5t
 sMljTxW8kndwN0Z97/yfbEUj3nQDoyVLVrU/uAcFyBl3mQBjzYfwDDKoD20biwR3L0l/
 dV7D/XX5kfpGzOxO88WHDSfUGKgBtQirdFzkoDhZJrXsi0QYEZ3CoFutYN1bBwqGlSj0
 hfy9d7Imi8jty1MS7rOjW3RBSvQc6nngxVQstWvMwm4MmTvVbpfTbr589yQaybULD38O
 jAhg==
X-Gm-Message-State: APjAAAUrWFdRkQO9ZFbMPNeivYB/IEepV+Jpv+7FS6WYutdjLrZtQOAI
 O5qJP8r84MR4mYUOtZb/GEwVHe9+v8lji8iolJhsTkus8Yvm6Sv0cK4fUtYTE30kRWzD59MV+Ax
 /bKHhOqs8g5hHB1M=
X-Received: by 2002:adf:ea8c:: with SMTP id s12mr711390wrm.301.1572010312382; 
 Fri, 25 Oct 2019 06:31:52 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxtFTV50RFymAHKmrwEFUuHd2Yl7RpGPe22aYOmUplO83v9IfSZNcxEhSYLk226SLr3ar15Lw==
X-Received: by 2002:adf:ea8c:: with SMTP id s12mr711353wrm.301.1572010312008; 
 Fri, 25 Oct 2019 06:31:52 -0700 (PDT)
Received: from [192.168.1.115] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id n17sm2323803wrt.25.2019.10.25.06.31.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2019 06:31:51 -0700 (PDT)
Subject: Re: [PATCH 3/4] crypto: add support for gcrypt's native XTS impl
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20191017145654.11371-1-berrange@redhat.com>
 <20191017145654.11371-4-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ad914455-9c33-5181-0380-ea1095a87830@redhat.com>
Date: Fri, 25 Oct 2019 15:31:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191017145654.11371-4-berrange@redhat.com>
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
> Libgcrypt 1.8.0 added support for the XTS mode. Use this because long
> term we wish to delete QEMU's XTS impl to avoid carrying private crypto
> algorithm impls.
>=20
> As an added benefit, using this improves performance from 531 MB/sec to
> 670 MB/sec, since we are avoiding several layers of function call
> indirection.
>=20
> This is even more noticable with the gcrypt builds in Fedora or RHEL-8
> which have a non-upstream patch for FIPS mode which does mutex locking.
> This is catastrophic for encryption performance with small block sizes,
> meaning this patch improves encryption from 240 MB/sec to 670 MB/sec.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>   configure              | 22 ++++++++++++++++++++++
>   crypto/Makefile.objs   |  2 +-
>   crypto/cipher-gcrypt.c | 36 +++++++++++++++++++++++++++++++++++-
>   tests/Makefile.include |  2 +-
>   4 files changed, 59 insertions(+), 3 deletions(-)
>=20
> diff --git a/configure b/configure
> index 08ca4bcb46..98edb0ff44 100755
> --- a/configure
> +++ b/configure
> @@ -473,6 +473,8 @@ gnutls=3D""
>   nettle=3D""
>   gcrypt=3D""
>   gcrypt_hmac=3D"no"
> +gcrypt_xts=3D"no"
> +qemu_private_xts=3D"yes"
>   auth_pam=3D""
>   vte=3D""
>   virglrenderer=3D""
> @@ -2902,6 +2904,18 @@ EOF
>           if compile_prog "$gcrypt_cflags" "$gcrypt_libs" ; then
>               gcrypt_hmac=3Dyes
>           fi
> +        cat > $TMPC << EOF
> +#include <gcrypt.h>
> +int main(void) {
> +  gcry_cipher_hd_t handle;
> +  gcry_cipher_open(&handle, GCRY_CIPHER_AES, GCRY_CIPHER_MODE_XTS, 0);
> +  return 0;
> +}
> +EOF
> +        if compile_prog "$gcrypt_cflags" "$gcrypt_libs" ; then
> +            gcrypt_xts=3Dyes
> +            qemu_private_xts=3Dno
> +        fi
>       elif test "$gcrypt" =3D "yes"; then
>           feature_not_found "gcrypt" "Install gcrypt devel >=3D 1.5.0"
>       else
> @@ -6317,6 +6331,11 @@ echo "VTE support       $vte $(echo_version $vte=
 $vteversion)"
>   echo "TLS priority      $tls_priority"
>   echo "GNUTLS support    $gnutls"
>   echo "libgcrypt         $gcrypt"
> +if test "$gcrypt" =3D "yes"
> +then
> +   echo "  hmac            $gcrypt_hmac"
> +   echo "  XTS             $gcrypt_xts"
> +fi
>   echo "nettle            $nettle $(echo_version $nettle $nettle_versio=
n)"
>   echo "libtasn1          $tasn1"
>   echo "PAM               $auth_pam"
> @@ -6794,6 +6813,9 @@ if test "$nettle" =3D "yes" ; then
>     echo "CONFIG_NETTLE=3Dy" >> $config_host_mak
>     echo "CONFIG_NETTLE_VERSION_MAJOR=3D${nettle_version%%.*}" >> $conf=
ig_host_mak
>   fi
> +if test "$qemu_private_xts" =3D "yes" ; then

Why not check $gcrypt_xts =3D "no", so we can avoid using $qemu_private_x=
ts?

> +  echo "CONFIG_QEMU_PRIVATE_XTS=3Dy" >> $config_host_mak
> +fi
>   if test "$tasn1" =3D "yes" ; then
>     echo "CONFIG_TASN1=3Dy" >> $config_host_mak
>   fi
> diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
> index 7fe2fa9da2..cdb01f9de9 100644
> --- a/crypto/Makefile.objs
> +++ b/crypto/Makefile.objs
> @@ -31,7 +31,7 @@ crypto-obj-y +=3D ivgen-essiv.o
>   crypto-obj-y +=3D ivgen-plain.o
>   crypto-obj-y +=3D ivgen-plain64.o
>   crypto-obj-y +=3D afsplit.o
> -crypto-obj-y +=3D xts.o
> +crypto-obj-$(CONFIG_QEMU_PRIVATE_XTS) +=3D xts.o
>   crypto-obj-y +=3D block.o
>   crypto-obj-y +=3D block-qcow.o
>   crypto-obj-y +=3D block-luks.o
> diff --git a/crypto/cipher-gcrypt.c b/crypto/cipher-gcrypt.c
> index 5cece9b244..ace719526a 100644
> --- a/crypto/cipher-gcrypt.c
> +++ b/crypto/cipher-gcrypt.c
> @@ -19,7 +19,9 @@
>    */
>  =20
>   #include "qemu/osdep.h"
> +#ifdef CONFIG_QEMU_PRIVATE_XTS
>   #include "crypto/xts.h"
> +#endif
>   #include "cipherpriv.h"
>  =20
>   #include <gcrypt.h>
> @@ -59,10 +61,12 @@ bool qcrypto_cipher_supports(QCryptoCipherAlgorithm=
 alg,
>   typedef struct QCryptoCipherGcrypt QCryptoCipherGcrypt;
>   struct QCryptoCipherGcrypt {
>       gcry_cipher_hd_t handle;
> -    gcry_cipher_hd_t tweakhandle;
>       size_t blocksize;
> +#ifdef CONFIG_QEMU_PRIVATE_XTS
> +    gcry_cipher_hd_t tweakhandle;
>       /* Initialization vector or Counter */
>       uint8_t *iv;
> +#endif
>   };
>  =20
>   static void
> @@ -74,10 +78,12 @@ qcrypto_gcrypt_cipher_free_ctx(QCryptoCipherGcrypt =
*ctx,
>       }
>  =20
>       gcry_cipher_close(ctx->handle);
> +#ifdef CONFIG_QEMU_PRIVATE_XTS
>       if (mode =3D=3D QCRYPTO_CIPHER_MODE_XTS) {
>           gcry_cipher_close(ctx->tweakhandle);
>       }
>       g_free(ctx->iv);
> +#endif
>       g_free(ctx);
>   }
>  =20
> @@ -94,8 +100,14 @@ static QCryptoCipherGcrypt *qcrypto_cipher_ctx_new(=
QCryptoCipherAlgorithm alg,
>  =20
>       switch (mode) {
>       case QCRYPTO_CIPHER_MODE_ECB:
> +        gcrymode =3D GCRY_CIPHER_MODE_ECB;
> +        break;
>       case QCRYPTO_CIPHER_MODE_XTS:
> +#ifdef CONFIG_QEMU_PRIVATE_XTS
>           gcrymode =3D GCRY_CIPHER_MODE_ECB;
> +#else
> +        gcrymode =3D GCRY_CIPHER_MODE_XTS;
> +#endif
>           break;
>       case QCRYPTO_CIPHER_MODE_CBC:
>           gcrymode =3D GCRY_CIPHER_MODE_CBC;
> @@ -172,6 +184,7 @@ static QCryptoCipherGcrypt *qcrypto_cipher_ctx_new(=
QCryptoCipherAlgorithm alg,
>                      gcry_strerror(err));
>           goto error;
>       }
> +#ifdef CONFIG_QEMU_PRIVATE_XTS
>       if (mode =3D=3D QCRYPTO_CIPHER_MODE_XTS) {
>           err =3D gcry_cipher_open(&ctx->tweakhandle, gcryalg, gcrymode=
, 0);
>           if (err !=3D 0) {
> @@ -180,6 +193,7 @@ static QCryptoCipherGcrypt *qcrypto_cipher_ctx_new(=
QCryptoCipherAlgorithm alg,
>               goto error;
>           }
>       }
> +#endif
>  =20
>       if (alg =3D=3D QCRYPTO_CIPHER_ALG_DES_RFB) {
>           /* We're using standard DES cipher from gcrypt, so we need
> @@ -191,6 +205,7 @@ static QCryptoCipherGcrypt *qcrypto_cipher_ctx_new(=
QCryptoCipherAlgorithm alg,
>           g_free(rfbkey);
>           ctx->blocksize =3D 8;
>       } else {
> +#ifdef CONFIG_QEMU_PRIVATE_XTS
>           if (mode =3D=3D QCRYPTO_CIPHER_MODE_XTS) {
>               nkey /=3D 2;
>               err =3D gcry_cipher_setkey(ctx->handle, key, nkey);
> @@ -201,8 +216,11 @@ static QCryptoCipherGcrypt *qcrypto_cipher_ctx_new=
(QCryptoCipherAlgorithm alg,
>               }
>               err =3D gcry_cipher_setkey(ctx->tweakhandle, key + nkey, =
nkey);
>           } else {
> +#endif
>               err =3D gcry_cipher_setkey(ctx->handle, key, nkey);
> +#ifdef CONFIG_QEMU_PRIVATE_XTS
>           }
> +#endif
>           if (err !=3D 0) {
>               error_setg(errp, "Cannot set key: %s",
>                          gcry_strerror(err));
> @@ -228,6 +246,7 @@ static QCryptoCipherGcrypt *qcrypto_cipher_ctx_new(=
QCryptoCipherAlgorithm alg,
>           }
>       }
>  =20
> +#ifdef CONFIG_QEMU_PRIVATE_XTS
>       if (mode =3D=3D QCRYPTO_CIPHER_MODE_XTS) {
>           if (ctx->blocksize !=3D XTS_BLOCK_SIZE) {
>               error_setg(errp,
> @@ -237,6 +256,7 @@ static QCryptoCipherGcrypt *qcrypto_cipher_ctx_new(=
QCryptoCipherAlgorithm alg,
>           }
>           ctx->iv =3D g_new0(uint8_t, ctx->blocksize);
>       }
> +#endif
>  =20
>       return ctx;
>  =20
> @@ -253,6 +273,7 @@ qcrypto_gcrypt_cipher_ctx_free(QCryptoCipher *ciphe=
r)
>   }
>  =20
>  =20
> +#ifdef CONFIG_QEMU_PRIVATE_XTS
>   static void qcrypto_gcrypt_xts_encrypt(const void *ctx,
>                                          size_t length,
>                                          uint8_t *dst,
> @@ -272,6 +293,7 @@ static void qcrypto_gcrypt_xts_decrypt(const void *=
ctx,
>       err =3D gcry_cipher_decrypt((gcry_cipher_hd_t)ctx, dst, length, s=
rc, length);
>       g_assert(err =3D=3D 0);
>   }
> +#endif
>  =20
>   static int
>   qcrypto_gcrypt_cipher_encrypt(QCryptoCipher *cipher,
> @@ -289,12 +311,14 @@ qcrypto_gcrypt_cipher_encrypt(QCryptoCipher *ciph=
er,
>           return -1;
>       }
>  =20
> +#ifdef CONFIG_QEMU_PRIVATE_XTS
>       if (cipher->mode =3D=3D QCRYPTO_CIPHER_MODE_XTS) {
>           xts_encrypt(ctx->handle, ctx->tweakhandle,
>                       qcrypto_gcrypt_xts_encrypt,
>                       qcrypto_gcrypt_xts_decrypt,
>                       ctx->iv, len, out, in);
>       } else {
> +#endif
>           err =3D gcry_cipher_encrypt(ctx->handle,
>                                     out, len,
>                                     in, len);
> @@ -303,7 +327,9 @@ qcrypto_gcrypt_cipher_encrypt(QCryptoCipher *cipher=
,
>                          gcry_strerror(err));
>               return -1;
>           }
> +#ifdef CONFIG_QEMU_PRIVATE_XTS
>       }
> +#endif
>  =20
>       return 0;
>   }
> @@ -325,12 +351,14 @@ qcrypto_gcrypt_cipher_decrypt(QCryptoCipher *ciph=
er,
>           return -1;
>       }
>  =20
> +#ifdef CONFIG_QEMU_PRIVATE_XTS
>       if (cipher->mode =3D=3D QCRYPTO_CIPHER_MODE_XTS) {
>           xts_decrypt(ctx->handle, ctx->tweakhandle,
>                       qcrypto_gcrypt_xts_encrypt,
>                       qcrypto_gcrypt_xts_decrypt,
>                       ctx->iv, len, out, in);
>       } else {
> +#endif
>           err =3D gcry_cipher_decrypt(ctx->handle,
>                                     out, len,
>                                     in, len);
> @@ -339,7 +367,9 @@ qcrypto_gcrypt_cipher_decrypt(QCryptoCipher *cipher=
,
>                          gcry_strerror(err));
>               return -1;
>           }
> +#ifdef CONFIG_QEMU_PRIVATE_XTS
>       }
> +#endif
>  =20
>       return 0;
>   }
> @@ -358,9 +388,11 @@ qcrypto_gcrypt_cipher_setiv(QCryptoCipher *cipher,
>           return -1;
>       }
>  =20
> +#ifdef CONFIG_QEMU_PRIVATE_XTS
>       if (ctx->iv) {
>           memcpy(ctx->iv, iv, niv);
>       } else {
> +#endif
>           if (cipher->mode =3D=3D QCRYPTO_CIPHER_MODE_CTR) {
>               err =3D gcry_cipher_setctr(ctx->handle, iv, niv);
>               if (err !=3D 0) {
> @@ -377,7 +409,9 @@ qcrypto_gcrypt_cipher_setiv(QCryptoCipher *cipher,
>                   return -1;
>               }
>           }
> +#ifdef CONFIG_QEMU_PRIVATE_XTS
>       }
> +#endif

This is a lot of ifdef'ry...

>  =20
>       return 0;
>   }
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 3543451ed3..2e5b0d3604 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -133,7 +133,7 @@ check-unit-y +=3D tests/test-base64$(EXESUF)
>   check-unit-$(call land,$(CONFIG_BLOCK),$(if $(CONFIG_NETTLE),y,$(CONF=
IG_GCRYPT))) +=3D tests/test-crypto-pbkdf$(EXESUF)
>   check-unit-$(CONFIG_BLOCK) +=3D tests/test-crypto-ivgen$(EXESUF)
>   check-unit-$(CONFIG_BLOCK)  +=3D tests/test-crypto-afsplit$(EXESUF)
> -check-unit-$(CONFIG_BLOCK)  +=3D tests/test-crypto-xts$(EXESUF)
> +check-unit-$(if $(CONFIG_BLOCK),$(CONFIG_QEMU_PRIVATE_XTS)) +=3D tests=
/test-crypto-xts$(EXESUF)
>   check-unit-$(CONFIG_BLOCK)  +=3D tests/test-crypto-block$(EXESUF)
>   check-unit-y +=3D tests/test-logging$(EXESUF)
>   check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_REPLICATION)) +=3D te=
sts/test-replication$(EXESUF)
>=20

