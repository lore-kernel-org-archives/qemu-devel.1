Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26483C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 13:04:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E35AE2073B
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 13:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bcWPTdZM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E35AE2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jValb-0007FF-Uo
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 09:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jVag9-000205-U3
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:58:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32420
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jVag8-0004jH-5B
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588597114;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U05Kp7C8HXmvLrUvUyv8t64M+ewRGwsbBz/fv0kA7C0=;
 b=bcWPTdZMCiTJxK83s/rNXlPfhB9C6ojki4RxL9TQQy4yEo8b3zQ4oD0n2mfQliLaIgR/M9
 r7gfn1B9IKGoX8NkNad9gbE/+vmwB9kWNenxW1Evc1vk3ZXIvOVy3Ph5m2ki5W69aNgDk9
 VA8+kSjtu4bcBx9oXq0jy9bhDANsh1E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-AakZ6xgyMNu5Ne7AQ34ViQ-1; Mon, 04 May 2020 08:58:30 -0400
X-MC-Unique: AakZ6xgyMNu5Ne7AQ34ViQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18E0383DE6C;
 Mon,  4 May 2020 12:58:29 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E580605DC;
 Mon,  4 May 2020 12:58:26 +0000 (UTC)
Date: Mon, 4 May 2020 13:58:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Chen Qun <kuhn.chenqun@huawei.com>
Subject: Re: [PULL 04/20] crypto: Redundant type conversion for AES_KEY pointer
Message-ID: <20200504125824.GL115875@redhat.com>
References: <20200504115758.283914-1-laurent@vivier.eu>
 <20200504115758.283914-5-laurent@vivier.eu>
MIME-Version: 1.0
In-Reply-To: <20200504115758.283914-5-laurent@vivier.eu>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 04:24:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-trivial@nongnu.org, Euler Robot <euler.robot@huawei.com>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Chen,

This patch triggered a build failure in QEMU about discarding the
"const" qualifier.

IOW, the type conversion is not redundant after all - it is required
in order to explicitly discard "const".

I believe we can probably fix this by changing
qcrypto_cipher_aes_ecb_(en|de)crypt() methods so that they also have
a "const" qualifier on the AES_KEY parameter.

On Mon, May 04, 2020 at 01:57:42PM +0200, Laurent Vivier wrote:
> From: Chen Qun <kuhn.chenqun@huawei.com>
>=20
> Fix: eaec903c5b8
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> Acked-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> Message-Id: <20200325092137.24020-4-kuhn.chenqun@huawei.com>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  crypto/cipher-builtin.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/crypto/cipher-builtin.c b/crypto/cipher-builtin.c
> index bf8413e71a6e..99d6280a1669 100644
> --- a/crypto/cipher-builtin.c
> +++ b/crypto/cipher-builtin.c
> @@ -133,8 +133,7 @@ static void qcrypto_cipher_aes_xts_encrypt(const void=
 *ctx,
>  {
>      const QCryptoCipherBuiltinAESContext *aesctx =3D ctx;
> =20
> -    qcrypto_cipher_aes_ecb_encrypt((AES_KEY *)&aesctx->enc,
> -                                   src, dst, length);
> +    qcrypto_cipher_aes_ecb_encrypt(&aesctx->enc, src, dst, length);
>  }
> =20
> =20
> @@ -145,8 +144,7 @@ static void qcrypto_cipher_aes_xts_decrypt(const void=
 *ctx,
>  {
>      const QCryptoCipherBuiltinAESContext *aesctx =3D ctx;
> =20
> -    qcrypto_cipher_aes_ecb_decrypt((AES_KEY *)&aesctx->dec,
> -                                   src, dst, length);
> +    qcrypto_cipher_aes_ecb_decrypt(&aesctx->dec, src, dst, length);
>  }
> =20
> =20
> --=20
> 2.26.2
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


