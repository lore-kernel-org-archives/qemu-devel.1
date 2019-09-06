Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309DCC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 12:34:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 052AC20854
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 12:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 052AC20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6DRP-0001tK-07
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 08:34:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50664)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i6DQN-00015W-Iw
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 08:33:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i6DQM-0004oU-E0
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 08:33:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60451)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1i6DQJ-0004mp-Nl; Fri, 06 Sep 2019 08:33:07 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0BEF218C4274;
 Fri,  6 Sep 2019 12:33:07 +0000 (UTC)
Received: from redhat.com (ovpn-112-50.ams2.redhat.com [10.36.112.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A3F3510016EB;
 Fri,  6 Sep 2019 12:33:01 +0000 (UTC)
Date: Fri, 6 Sep 2019 13:32:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Message-ID: <20190906123258.GC5119@redhat.com>
References: <20190826135103.22410-1-mlevitsk@redhat.com>
 <20190826135103.22410-7-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190826135103.22410-7-mlevitsk@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Fri, 06 Sep 2019 12:33:07 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 06/13] qcrypto-block: pass keyslot index
 rather that pointer to the keyslot
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

On Mon, Aug 26, 2019 at 04:50:56PM +0300, Maxim Levitsky wrote:
> Another minor refactoring
>=20
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  crypto/block-luks.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/crypto/block-luks.c b/crypto/block-luks.c
> index 331377293d..0d81f2ac61 100644
> --- a/crypto/block-luks.c
> +++ b/crypto/block-luks.c
> @@ -410,7 +410,7 @@ qcrypto_block_luks_essiv_cipher(QCryptoCipherAlgori=
thm cipher,
>   */
>  static int
>  qcrypto_block_luks_load_key(QCryptoBlock *block,
> -                            QCryptoBlockLUKSKeySlot *slot,
> +                            unsigned int slot_idx,

FWIW, I tend to prefer 'size_t' for things which are array
indexes especially....

>                              const char *password,
>                              QCryptoCipherAlgorithm cipheralg,
>                              QCryptoCipherMode ciphermode,
> @@ -424,6 +424,7 @@ qcrypto_block_luks_load_key(QCryptoBlock *block,
>                              Error **errp)
>  {
>      QCryptoBlockLUKS *luks =3D block->opaque;
> +    const QCryptoBlockLUKSKeySlot *slot =3D &luks->header.key_slots[sl=
ot_idx];
>      g_autofree uint8_t *splitkey =3D NULL;
>      size_t splitkeylen;
>      g_autofree uint8_t *possiblekey =3D NULL;
> @@ -580,13 +581,12 @@ qcrypto_block_luks_find_key(QCryptoBlock *block,
>                              void *opaque,
>                              Error **errp)
>  {
> -    QCryptoBlockLUKS *luks =3D block->opaque;
>      size_t i;
>      int rv;
> =20
>      for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
>          rv =3D qcrypto_block_luks_load_key(block,
> -                                         &luks->header.key_slots[i],
> +                                         i,

..given that 'i' is size_t here.

>                                           password,
>                                           cipheralg,
>                                           ciphermode,

With that type changed

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

