Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3FEC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 12:30:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92D60206CD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 12:30:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92D60206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6DNS-0007q2-Qg
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 08:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49681)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i6DMg-0007DB-5l
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 08:29:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i6DMe-00038P-P7
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 08:29:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42124)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1i6DMc-00037O-9k; Fri, 06 Sep 2019 08:29:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3E623308A958;
 Fri,  6 Sep 2019 12:29:17 +0000 (UTC)
Received: from redhat.com (ovpn-112-50.ams2.redhat.com [10.36.112.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EBF4F5D9CA;
 Fri,  6 Sep 2019 12:29:11 +0000 (UTC)
Date: Fri, 6 Sep 2019 13:29:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Message-ID: <20190906122908.GA5119@redhat.com>
References: <20190826135103.22410-1-mlevitsk@redhat.com>
 <20190826135103.22410-5-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190826135103.22410-5-mlevitsk@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 06 Sep 2019 12:29:17 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 04/13] qcrypto-luks: don't overwrite
 cipher_mode in header
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 26, 2019 at 04:50:54PM +0300, Maxim Levitsky wrote:
> This way we can store the header we loaded, which
> will be used in key management code
>=20
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  crypto/block-luks.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/crypto/block-luks.c b/crypto/block-luks.c
> index f12fa2d270..e9ae3f6baa 100644
> --- a/crypto/block-luks.c
> +++ b/crypto/block-luks.c
> @@ -645,6 +645,7 @@ qcrypto_block_luks_open(QCryptoBlock *block,
>      QCryptoHashAlgorithm hash;
>      QCryptoHashAlgorithm ivhash;
>      g_autofree char *password =3D NULL;
> +    g_autofree char *cipher_mode =3D NULL;
> =20
>      if (!(flags & QCRYPTO_BLOCK_OPEN_NO_IO)) {
>          if (!options->u.luks.key_secret) {
> @@ -701,6 +702,8 @@ qcrypto_block_luks_open(QCryptoBlock *block,
>          goto fail;
>      }
> =20
> +    cipher_mode =3D g_strdup(luks->header.cipher_mode);
> +
>      /*
>       * The cipher_mode header contains a string that we have
>       * to further parse, of the format
> @@ -709,11 +712,11 @@ qcrypto_block_luks_open(QCryptoBlock *block,
>       *
>       * eg  cbc-essiv:sha256, cbc-plain64
>       */
> -    ivgen_name =3D strchr(luks->header.cipher_mode, '-');
> +    ivgen_name =3D strchr(cipher_mode, '-');
>      if (!ivgen_name) {
>          ret =3D -EINVAL;
>          error_setg(errp, "Unexpected cipher mode string format %s",
> -                   luks->header.cipher_mode);
> +                cipher_mode);

nitpick - align with the (

>          goto fail;
>      }
>      *ivgen_name =3D '\0';
> @@ -735,7 +738,7 @@ qcrypto_block_luks_open(QCryptoBlock *block,
>          }
>      }
> =20
> -    ciphermode =3D qcrypto_block_luks_cipher_mode_lookup(luks->header.=
cipher_mode,
> +    ciphermode =3D qcrypto_block_luks_cipher_mode_lookup(cipher_mode,
>                                                         &local_err);
>      if (local_err) {
>          ret =3D -ENOTSUP;

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

