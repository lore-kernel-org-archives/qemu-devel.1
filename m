Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3CAC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 17:02:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7884E2067C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 17:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ckMyiMVk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7884E2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7iWJ-0000Mx-DE
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 13:02:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k7iV8-0008Hs-Iv
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 13:00:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26543
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k7iV6-00022j-Od
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 13:00:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597683647;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A54fNI9QPqrGIE5U1pshI4tgpYWr6OnRZEdnCkhiigk=;
 b=ckMyiMVkQLsg3XvVuJAoFUGwNqwLELyuoi+YsEfFeD1euLa2YeaN6zxynoXmm8kwf04uQZ
 C/tE7+muu7M/KoCGcSAQCG5SeMyEW9QlhpB/sIu3IBbOoNwfBiOk2tTw0ZkSaIkM9cNMIp
 EXGYanMyfGXZ6p8GwegMM8fjZWAn1Ek=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-541-vDHJmPL_Mu-2UBp7jTMEMQ-1; Mon, 17 Aug 2020 13:00:29 -0400
X-MC-Unique: vDHJmPL_Mu-2UBp7jTMEMQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD91E100CED6;
 Mon, 17 Aug 2020 17:00:27 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D0DA7709E4;
 Mon, 17 Aug 2020 17:00:26 +0000 (UTC)
Date: Mon, 17 Aug 2020 18:00:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 12/17] crypto/builtin: Merge
 qcrypto_cipher_aes_{ecb,xts}_{en,de}crypt
Message-ID: <20200817170023.GU4775@redhat.com>
References: <20200813032537.2888593-1-richard.henderson@linaro.org>
 <20200813032537.2888593-13-richard.henderson@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20200813032537.2888593-13-richard.henderson@linaro.org>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 00:24:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 12, 2020 at 08:25:32PM -0700, Richard Henderson wrote:
> There's no real reason we need two separate helper functions here.
> Standardize on the function signature required for xts_encrypt.
> Rename to do_aes_{en,de}crypt_ecb, since the helper does not
> itself do anything with respect to xts.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  crypto/cipher-builtin.inc.c | 69 ++++++++++---------------------------
>  1 file changed, 18 insertions(+), 51 deletions(-)
> 
> diff --git a/crypto/cipher-builtin.inc.c b/crypto/cipher-builtin.inc.c
> index e2ae5d090c..4d971a2b82 100644
> --- a/crypto/cipher-builtin.inc.c
> +++ b/crypto/cipher-builtin.inc.c
> @@ -72,65 +72,34 @@ static void qcrypto_cipher_free_aes(QCryptoCipher *cipher)
>      g_free(cipher);
>  }
>  
> -
> -static void qcrypto_cipher_aes_ecb_encrypt(const AES_KEY *key,
> -                                           const void *in,
> -                                           void *out,
> -                                           size_t len)
> +static void do_aes_encrypt_ecb(const void *vctx, size_t len,
> +                               uint8_t *out, const uint8_t *in)

nitpick - stick with the 1-arg-per-line style, instead of packing
args.

>  {
> -    const uint8_t *inptr = in;
> -    uint8_t *outptr = out;
> +    const QCryptoCipherBuiltinAESContext *ctx = vctx;
>  
>      /* We have already verified that len % AES_BLOCK_SIZE == 0. */
>      while (len) {
> -        AES_encrypt(inptr, outptr, key);
> -        inptr += AES_BLOCK_SIZE;
> -        outptr += AES_BLOCK_SIZE;
> +        AES_encrypt(in, out, &ctx->enc);
> +        in += AES_BLOCK_SIZE;
> +        out += AES_BLOCK_SIZE;
>          len -= AES_BLOCK_SIZE;
>      }
>  }
>  
> -
> -static void qcrypto_cipher_aes_ecb_decrypt(const AES_KEY *key,
> -                                           const void *in,
> -                                           void *out,
> -                                           size_t len)
> +static void do_aes_decrypt_ecb(const void *vctx, size_t len,
> +                               uint8_t *out, const uint8_t *in)
>  {
> -    const uint8_t *inptr = in;
> -    uint8_t *outptr = out;
> +    const QCryptoCipherBuiltinAESContext *ctx = vctx;
>  
>      /* We have already verified that len % AES_BLOCK_SIZE == 0. */
>      while (len) {
> -        AES_decrypt(inptr, outptr, key);
> -        inptr += AES_BLOCK_SIZE;
> -        outptr += AES_BLOCK_SIZE;
> +        AES_decrypt(in, out, &ctx->dec);
> +        in += AES_BLOCK_SIZE;
> +        out += AES_BLOCK_SIZE;
>          len -= AES_BLOCK_SIZE;
>      }
>  }
>  
> -
> -static void qcrypto_cipher_aes_xts_encrypt(const void *ctx,
> -                                           size_t length,
> -                                           uint8_t *dst,
> -                                           const uint8_t *src)
> -{
> -    const QCryptoCipherBuiltinAESContext *aesctx = ctx;
> -
> -    qcrypto_cipher_aes_ecb_encrypt(&aesctx->enc, src, dst, length);
> -}
> -
> -
> -static void qcrypto_cipher_aes_xts_decrypt(const void *ctx,
> -                                           size_t length,
> -                                           uint8_t *dst,
> -                                           const uint8_t *src)
> -{
> -    const QCryptoCipherBuiltinAESContext *aesctx = ctx;
> -
> -    qcrypto_cipher_aes_ecb_decrypt(&aesctx->dec, src, dst, length);
> -}
> -
> -

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


