Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FF1C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 00:00:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C5512339F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 00:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C5512339F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0aWS-0004U8-Qu
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 20:00:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52614)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i0aVZ-0003xg-FF
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 19:59:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i0aVX-0008NL-RQ
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 19:59:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50086)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i0aVS-0008Kh-6R; Wed, 21 Aug 2019 19:59:10 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 33CA73695F;
 Wed, 21 Aug 2019 23:59:09 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5DBC03DB3;
 Wed, 21 Aug 2019 23:59:04 +0000 (UTC)
Message-ID: <98bce17338318a95b94e053731864ce1caaeab4c.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 02:59:03 +0300
In-Reply-To: <4d242249-f823-7465-4b31-64fce484679f@redhat.com>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <20190814202219.1870-3-mlevitsk@redhat.com>
 <4d242249-f823-7465-4b31-64fce484679f@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Wed, 21 Aug 2019 23:59:09 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 02/13] qcrypto-luks: misc refactoring
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2019-08-20 at 19:36 +0200, Max Reitz wrote:
> On 14.08.19 22:22, Maxim Levitsky wrote:
> > This is also a preparation for key read/write/erase functions
> >=20
> > * use master key len from the header
> > * prefer to use crypto params in the QCryptoBlockLUKS
> >   over passing them as function arguments
> > * define QCRYPTO_BLOCK_LUKS_DEFAULT_ITER_TIME
> > * Add comments to various crypto parameters in the QCryptoBlockLUKS
> >=20
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  crypto/block-luks.c | 213 ++++++++++++++++++++++--------------------=
--
> >  1 file changed, 105 insertions(+), 108 deletions(-)
> >=20
> > diff --git a/crypto/block-luks.c b/crypto/block-luks.c
> > index 409ab50f20..48213abde7 100644
> > --- a/crypto/block-luks.c
> > +++ b/crypto/block-luks.c
>=20
> [...]
>=20
> > @@ -199,13 +201,25 @@ QEMU_BUILD_BUG_ON(sizeof(struct QCryptoBlockLUK=
SHeader) !=3D 592);
> >  struct QCryptoBlockLUKS {
> >      QCryptoBlockLUKSHeader header;
> > =20
> > -    /* Cache parsed versions of what's in header fields,
> > -     * as we can't rely on QCryptoBlock.cipher being
> > -     * non-NULL */
>=20
> Hm, why remove this comment?

Because the intended uses of these fields changed.
As Daniel explained to me initially none of the crypto parameters
were stored in the QCryptoBlockLUKS, and thus there were all passed
as function arguments.
Later when qemu-img info was added/implemented, there was need to 'cache'=
 them
in the header so that info command could use them after image was opened.

Now after my changes this is no longer true. now these crypto parameters =
are set early
on create/load and used everywhere to avoid passing them over and over to=
 each
function.

>=20
> > +    /* Main encryption algorithm used for encryption*/
> >      QCryptoCipherAlgorithm cipher_alg;
> > +
> > +    /* Mode of encryption for the selected encryption algorithm */
> >      QCryptoCipherMode cipher_mode;
> > +
> > +    /* Initialization vector generation algorithm */
> >      QCryptoIVGenAlgorithm ivgen_alg;
> > +
> > +    /* Hash algorithm used for IV generation*/
> >      QCryptoHashAlgorithm ivgen_hash_alg;
> > +
> > +    /*
> > +     * Encryption algorithm used for IV generation.
> > +     * Usually the same as main encryption algorithm
> > +     */
> > +    QCryptoCipherAlgorithm ivgen_cipher_alg;
> > +
> > +    /* Hash algorithm used in pbkdf2 function */
> >      QCryptoHashAlgorithm hash_alg;
> >  };
> > =20
> > @@ -397,6 +411,12 @@ qcrypto_block_luks_essiv_cipher(QCryptoCipherAlg=
orithm cipher,
> >      }
> >  }
> > =20
> > +static int masterkeylen(QCryptoBlockLUKS *luks)
>=20
> This should be a const pointer.
I haven't had const in mind while writing this but you are right.
Fixed.


>=20
> > +{
> > +    return luks->header.key_bytes;
> > +}
> > +
> > +
> >  /*
> >   * Given a key slot, and user password, this will attempt to unlock
> >   * the master encryption key from the key slot.
> > @@ -410,21 +430,15 @@ qcrypto_block_luks_essiv_cipher(QCryptoCipherAl=
gorithm cipher,
> >   */
> >  static int
> >  qcrypto_block_luks_load_key(QCryptoBlock *block,
> > -                            QCryptoBlockLUKSKeySlot *slot,
> > +                            uint slot_idx,
>=20
> Did you use uint on purpose or do you mean a plain =E2=80=9Cunsigned=E2=
=80=9D?
Well there are just 8 slots, but yea I don't mind to make this an unsigne=
d int.


>=20
> >                              const char *password,
> > -                            QCryptoCipherAlgorithm cipheralg,
> > -                            QCryptoCipherMode ciphermode,
> > -                            QCryptoHashAlgorithm hash,
> > -                            QCryptoIVGenAlgorithm ivalg,
> > -                            QCryptoCipherAlgorithm ivcipheralg,
> > -                            QCryptoHashAlgorithm ivhash,
> >                              uint8_t *masterkey,
> > -                            size_t masterkeylen,
> >                              QCryptoBlockReadFunc readfunc,
> >                              void *opaque,
> >                              Error **errp)
> >  {
> >      QCryptoBlockLUKS *luks =3D block->opaque;
> > +    QCryptoBlockLUKSKeySlot *slot =3D &luks->header.key_slots[slot_i=
dx];
>=20
> I think this is a great opportunity to make this a const pointer.
Agree. Done.
>=20
> >      uint8_t *splitkey;
> >      size_t splitkeylen;
> >      uint8_t *possiblekey;
>=20
> [...]
>=20
> > @@ -710,6 +696,8 @@ qcrypto_block_luks_open(QCryptoBlock *block,
> >          goto fail;
> >      }
> > =20
> > +    cipher_mode =3D g_strdup(luks->header.cipher_mode);
> > +
>=20
> This should be freed under the fail label.
>=20
> (And maybe the fact that this no longer modifies
> luks->header.cipher_mode should be mentioned in the commit message, I
> don=E2=80=99t know.)

I swear I documented that in the commit message... yea in the next commit=
 (:-()
Fixed that now.

>=20
> >      /*
> >       * The cipher_mode header contains a string that we have
> >       * to further parse, of the format
>=20
> [...]
>=20
> > @@ -730,13 +718,13 @@ qcrypto_block_luks_open(QCryptoBlock *block,
> > =20
> >      ivhash_name =3D strchr(ivgen_name, ':');
> >      if (!ivhash_name) {
> > -        ivhash =3D 0;
> > +        luks->ivgen_hash_alg =3D 0;
>=20
> *luks is initialized to 0 anyway, but it doesn=E2=80=99t hurt, of cours=
e.
>=20
> >      } else {
> >          *ivhash_name =3D '\0';
> >          ivhash_name++;
> > =20
> > -        ivhash =3D qcrypto_block_luks_hash_name_lookup(ivhash_name,
> > -                                                     &local_err);
> > +        luks->ivgen_hash_alg =3D qcrypto_block_luks_hash_name_lookup=
(ivhash_name,
> > +                                                                   &=
local_err);
> >          if (local_err) {
> >              ret =3D -ENOTSUP;
> >              error_propagate(errp, local_err);
> > @@ -744,25 +732,27 @@ qcrypto_block_luks_open(QCryptoBlock *block,
>=20
> [...]
>=20
> > =20
> > -    hash =3D qcrypto_block_luks_hash_name_lookup(luks->header.hash_s=
pec,
> > +    luks->hash_alg =3D
> > +            qcrypto_block_luks_hash_name_lookup(luks->header.hash_sp=
ec,
> >                                                 &local_err);
>=20
> Indentation is off now.
True! But at least as you probably noticed I now am aware of that rule, a=
nd
so I have way less such errors now :-)

>=20
> >      if (local_err) {
> >          ret =3D -ENOTSUP;
>=20
> [...]
>=20
> > @@ -930,6 +922,17 @@ qcrypto_block_luks_create(QCryptoBlock *block,
> >              luks_opts.has_ivgen_hash_alg =3D true;
> >          }
> >      }
> > +
> > +    luks =3D g_new0(QCryptoBlockLUKS, 1);
> > +    block->opaque =3D luks;
> > +
> > +    luks->cipher_alg =3D luks_opts.cipher_alg;
> > +    luks->cipher_mode =3D luks_opts.cipher_mode;
> > +    luks->ivgen_alg =3D luks_opts.ivgen_alg;
> > +    luks->ivgen_hash_alg =3D luks_opts.ivgen_hash_alg;
> > +    luks->hash_alg =3D luks_opts.hash_alg;
> > +
> > +
>=20
> Why did you pull this up?  Now @luks is leaked in both of the next erro=
r
> paths.

This is because the purpose of these fields changed. As Daniel explained =
to me
they were initially added after the fact to serve as a cache of into to p=
resent in qemu-img info callback.
But now I use these everywhere in the code so I won't them to be correct =
as soon as possible to minimize
the risk of calling some function that uses these and would read garbage.

Leak is fixed now, thanks!


>=20
> >      /* Note we're allowing ivgen_hash_alg to be set even for
> >       * non-essiv iv generators that don't need a hash. It will
> >       * be silently ignored, for compatibility with dm-crypt */
>=20
> [...]
>=20
> > @@ -1003,6 +1004,8 @@ qcrypto_block_luks_create(QCryptoBlock *block,
> >          ivcipheralg =3D luks_opts.cipher_alg;
> >      }
> > =20
> > +    luks->ivgen_cipher_alg =3D ivcipheralg;
> > +
>=20
> What=E2=80=99s the point in having a dedicated ivcipheralg variable the=
n?


Leftover, since I added the luks->ivgen_cipher_alg.

The luks->ivgen_cipher_alg is special in the sense that it is not
part of the parsed on-disk header, but rather calculated,
as a workaround for the dm-crypto 'bug'

The long explanation of this is in comment of qcrypto_block_luks_essiv_ci=
pher

I'll remove that local variable, because why not.

>=20
> Max
>=20
> >      strcpy(luks->header.cipher_name, cipher_alg);
> >      strcpy(luks->header.cipher_mode, cipher_mode_spec);
> >      strcpy(luks->header.hash_spec, hash_alg);
>=20
>=20


Best regards,
Thanks for the review,
	Maxim Levitsky



