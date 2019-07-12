Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CB1C742D1
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 17:15:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D5902080A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 17:15:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D5902080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlz8u-0003fR-3m
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 13:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33899)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hlz8j-0003H5-6j
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:15:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hlz8h-0002L1-Cb
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:15:21 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37655)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hlz8g-0002Ge-8g
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:15:19 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so10739215wrr.4
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 10:15:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Bg/3jcL7CLpz56OKD1VjdqaU51xy8j8oxvc1VrBZUBo=;
 b=NmF3ynA/9sxeyRFzyllo/kbT2BwwhPaMEyfywyRwnNgk7/IDprTHdx0P/9RJOogYvw
 4RzqCZrLK86hHgfzrVDZ7F9fORTKaURe3hw/PoPgVfeL2SIq/pa3+G3sgpw/3JwpChmt
 sfbuRJCcpMwGf6ayDVz+s8tM+2kVZtivujxqeovBtPvGBYKpcKA4uICicaCo0uzdxr1g
 CGRWTNJxvf2qGrFnVXDtHTpoZAe7ZgQX+vtiNaRdbfFYWSvWgmSSw9Hsc0cgVFtCC3mO
 v6gwf0vrwMniP3pC2i3bIiEgUH0K1cpg9ZAqAu8kEUMielg0rS5f3iLCUcndMZonoYaw
 8e2w==
X-Gm-Message-State: APjAAAXK1hptIj7BhuDmwx9PAePA8pQWRhOSgfCjD6K5852u7OWDToP1
 GNj3xEV1Ewb1G+BsFjeoJGAShQ==
X-Google-Smtp-Source: APXvYqx4lPZPVelwZByVNyJkos883K/Z+8QftI3VH9s2i1xp8dShBRJpB+AXfQefAZgF5O6p7kSHcw==
X-Received: by 2002:adf:eb89:: with SMTP id t9mr12300344wrn.120.1562951716701; 
 Fri, 12 Jul 2019 10:15:16 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id k9sm6363161wmi.33.2019.07.12.10.15.15
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 12 Jul 2019 10:15:16 -0700 (PDT)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20190712101849.8993-1-berrange@redhat.com>
 <20190712101849.8993-3-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <dbeca5cf-1f95-b851-b284-f1ad3bc7db1a@redhat.com>
Date: Fri, 12 Jul 2019 19:15:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190712101849.8993-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH for-4.1 2/2] crypto: fix function
 signatures for nettle 2.7 vs 3
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
Cc: Amol Surati <suratiamol@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/12/19 12:18 PM, Daniel P. Berrangé wrote:
> Nettle version 2.7.x used 'unsigned int' instead of 'size_t' for length
> parameters in functions. Use a local typedef so that we can build with
> the correct signature depending on nettle version, as we already do in
> the cipher code.
> 

Reported-by: Amol Surati <suratiamol@gmail.com>

> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  crypto/hash-nettle.c | 12 +++++++++---
>  crypto/hmac-nettle.c | 17 +++++++++++++----
>  2 files changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/crypto/hash-nettle.c b/crypto/hash-nettle.c
> index 96f186f442..6ffb9c3db7 100644
> --- a/crypto/hash-nettle.c
> +++ b/crypto/hash-nettle.c
> @@ -26,12 +26,18 @@
>  #include <nettle/sha.h>
>  #include <nettle/ripemd160.h>
>  
> +#if CONFIG_NETTLE_VERSION_MAJOR < 3
> +typedef unsigned int     hash_length_t;
> +#else
> +typedef size_t       hash_length_t;
> +#endif
> +
>  typedef void (*qcrypto_nettle_init)(void *ctx);
>  typedef void (*qcrypto_nettle_write)(void *ctx,
> -                                     unsigned int len,
> +                                     hash_length_t len,
>                                       const uint8_t *buf);
>  typedef void (*qcrypto_nettle_result)(void *ctx,
> -                                      unsigned int len,
> +                                      hash_length_t len,
>                                        uint8_t *buf);
>  
>  union qcrypto_hash_ctx {
> @@ -112,7 +118,7 @@ qcrypto_nettle_hash_bytesv(QCryptoHashAlgorithm alg,
>                             size_t *resultlen,
>                             Error **errp)
>  {
> -    int i;
> +    size_t i;
>      union qcrypto_hash_ctx ctx;
>  
>      if (!qcrypto_hash_supports(alg)) {
> diff --git a/crypto/hmac-nettle.c b/crypto/hmac-nettle.c
> index ec2d61bdde..1152b741fd 100644
> --- a/crypto/hmac-nettle.c
> +++ b/crypto/hmac-nettle.c
> @@ -18,14 +18,23 @@
>  #include "hmacpriv.h"
>  #include <nettle/hmac.h>
>  
> +#if CONFIG_NETTLE_VERSION_MAJOR < 3
> +typedef unsigned int hmac_length_t;
> +#else
> +typedef size_t hmac_length_t;
> +#endif
> +
>  typedef void (*qcrypto_nettle_hmac_setkey)(void *ctx,
> -              size_t key_length, const uint8_t *key);
> +                                           hmac_length_t key_length,
> +                                           const uint8_t *key);
>  
>  typedef void (*qcrypto_nettle_hmac_update)(void *ctx,
> -              size_t length, const uint8_t *data);
> +                                           hmac_length_t length,
> +                                           const uint8_t *data);
>  
>  typedef void (*qcrypto_nettle_hmac_digest)(void *ctx,
> -              size_t length, uint8_t *digest);
> +                                           hmac_length_t length,
> +                                           uint8_t *digest);
>  
>  typedef struct QCryptoHmacNettle QCryptoHmacNettle;
>  struct QCryptoHmacNettle {
> @@ -135,7 +144,7 @@ qcrypto_nettle_hmac_bytesv(QCryptoHmac *hmac,
>                             Error **errp)
>  {
>      QCryptoHmacNettle *ctx;
> -    int i;
> +    size_t i;
>  
>      ctx = (QCryptoHmacNettle *)hmac->opaque;
>  
> 

