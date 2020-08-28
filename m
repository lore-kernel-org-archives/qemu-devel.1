Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F35EC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:53:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5739920776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VI970/Em"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5739920776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBep4-0003Fr-L8
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 09:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kBeoX-0002qN-GO
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:53:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35500
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kBeoU-00017a-Tz
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598622785;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=B+P1De35VpUZ7uz8Q0Tr25zwebLjQWYLyQn488oxYlM=;
 b=VI970/EmfkDujp45VUSz//w49bNjWRi0deCWIzAqOD/LMCOW7CZ/jX1OSEM37hpQLQFVZq
 ISLIkGH2Ovn201UH4/3Iw9QdA6W0K8rFxoXaDWHjcAK4lna/FhZkwLpKCnbjXQ9HSsA4sI
 KkX3zN4i8rUbHY8YR0hY1d0unb9SLN8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-R_8AkU2rNvWX2BsUTAI2HQ-1; Fri, 28 Aug 2020 09:53:03 -0400
X-MC-Unique: R_8AkU2rNvWX2BsUTAI2HQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B69D5801ABC;
 Fri, 28 Aug 2020 13:53:02 +0000 (UTC)
Received: from redhat.com (ovpn-113-167.ams2.redhat.com [10.36.113.167])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EF21B1045E9F;
 Fri, 28 Aug 2020 13:53:01 +0000 (UTC)
Date: Fri, 28 Aug 2020 14:52:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 17/17] crypto/gcrypt: Split QCryptoCipherGcrypt into
 subclasses
Message-ID: <20200828135258.GK224144@redhat.com>
References: <20200813032537.2888593-1-richard.henderson@linaro.org>
 <20200813032537.2888593-18-richard.henderson@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20200813032537.2888593-18-richard.henderson@linaro.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 04:08:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Aug 12, 2020 at 08:25:37PM -0700, Richard Henderson wrote:
> With gcrypt, most of the dispatch happens in the library,
> so there aren't many classes to create.  However, we can
> still create separate dispatch for CTR mode, and for
> CONFIG_QEMU_PRIVATE_XTS, which avoids needing to check
> for these modes at runtime.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  crypto/cipher-gcrypt.inc.c | 512 ++++++++++++++++++-------------------
>  1 file changed, 250 insertions(+), 262 deletions(-)
> 
> diff --git a/crypto/cipher-gcrypt.inc.c b/crypto/cipher-gcrypt.inc.c
> index 7a1fbc9745..1f9d08a7fa 100644
> --- a/crypto/cipher-gcrypt.inc.c
> +++ b/crypto/cipher-gcrypt.inc.c
> @@ -24,8 +24,6 @@
>  

>  
> - error:
> -    qcrypto_gcrypt_cipher_free_ctx(ctx, mode);
> + error3:
> +#ifdef CONFIG_QEMU_PRIVATE_XTS
> +    gcry_cipher_close(ctx->tweakhandle);
> + error2:
> +#endif
> +    gcry_cipher_close(ctx->handle);
> + error1:
> +    g_free(ctx);

gcry_cipher_close is a no-op if the handle is NULL, so I don't
think we need to have a chain of jump targets, just a single
"error:".


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


