Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF84C5ACAE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 09:53:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA8BD206A5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 09:53:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA8BD206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Lmu-0006T2-1o
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 05:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48169)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i8Li3-0000oX-5w
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 05:48:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i8Li1-0001IR-KM
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 05:48:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47516)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i8Lhx-0001F0-44; Thu, 12 Sep 2019 05:48:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5855418CB8E1;
 Thu, 12 Sep 2019 09:48:08 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D43D75D9CA;
 Thu, 12 Sep 2019 09:48:03 +0000 (UTC)
Message-ID: <f86f16f86445dbe67c4292155348eb2bf9ba4caa.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Date: Thu, 12 Sep 2019 12:48:02 +0300
In-Reply-To: <20190906135535.GL5119@redhat.com>
References: <20190830205608.18192-1-mlevitsk@redhat.com>
 <20190830205608.18192-4-mlevitsk@redhat.com>
 <20190906135535.GL5119@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Thu, 12 Sep 2019 09:48:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 03/10] qcrypto-luks: implement the
 encryption key management
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2019-09-06 at 14:55 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Aug 30, 2019 at 11:56:01PM +0300, Maxim Levitsky wrote:
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  crypto/block-luks.c | 366 ++++++++++++++++++++++++++++++++++++++++++=
+-
> >  1 file changed, 364 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/crypto/block-luks.c b/crypto/block-luks.c
> > index ba20d55246..21325fbc79 100644
> > --- a/crypto/block-luks.c
> > +++ b/crypto/block-luks.c
> > @@ -70,6 +70,9 @@ typedef struct QCryptoBlockLUKSKeySlot QCryptoBlock=
LUKSKeySlot;
> > =20
> >  #define QCRYPTO_BLOCK_LUKS_SECTOR_SIZE 512LL
> > =20
> > +#define QCRYPTO_BLOCK_LUKS_DEFAULT_ITER_TIME 2000
>=20
> Perhaps use  ITER_TIME_MS to make it clear it is millisecs
Why not... done.

>=20
> > +#define QCRYPTO_BLOCK_LUKS_ERASE_ITERATIONS 40
> > +
> >  static const char qcrypto_block_luks_magic[QCRYPTO_BLOCK_LUKS_MAGIC_=
LEN] =3D {
> >      'L', 'U', 'K', 'S', 0xBA, 0xBE
> >  };
> > @@ -219,6 +222,9 @@ struct QCryptoBlockLUKS {
> > =20
> >      /* Hash algorithm used in pbkdf2 function */
> >      QCryptoHashAlgorithm hash_alg;
> > +
> > +    /* Name of the secret that was used to open the image */
> > +    char *secret;
> > +
> > +/*
> > + * Returns true if a slot i is marked as active
> > + * (contains encrypted copy of the master key)
> > + */
> > +
> > +static bool
>=20
> No blank line is wanted between the comment & function.
> Likewise for the rest of this patch series
No problem!


>=20
> > +qcrypto_block_luks_slot_active(const QCryptoBlockLUKS *luks,
> > +                               unsigned int slot_idx)
> > +{
> > +    uint32_t val =3D luks->header.key_slots[slot_idx].active;
> > +    return val =3D=3D  QCRYPTO_BLOCK_LUKS_KEY_SLOT_ENABLED;
> > +}
>=20
>=20
>=20
> > +static int
> > +qcrypto_block_luks_erase_key(QCryptoBlock *block,
> > +                             unsigned int slot_idx,
> > +                             QCryptoBlockWriteFunc writefunc,
> > +                             void *opaque,
> > +                             Error **errp)
> > +{
> > +    QCryptoBlockLUKS *luks =3D block->opaque;
> > +    QCryptoBlockLUKSKeySlot *slot =3D &luks->header.key_slots[slot_i=
dx];
> > +    g_autofree uint8_t *garbagesplitkey =3D NULL;
> > +    size_t splitkeylen =3D luks->header.master_key_len * slot->strip=
es;
> > +    size_t i;
> > +
> > +    assert(slot_idx < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS);
> > +    assert(splitkeylen > 0);
> > +
> > +    garbagesplitkey =3D g_malloc0(splitkeylen);
>=20
> I'd prefer   g_new0(uint8_t, splitkeylen)
Done.

>=20
> > +
> > +    /* Reset the key slot header */
> > +    memset(slot->salt, 0, QCRYPTO_BLOCK_LUKS_SALT_LEN);
> > +    slot->iterations =3D 0;
> > +    slot->active =3D QCRYPTO_BLOCK_LUKS_KEY_SLOT_DISABLED;
> > +
>=20
>=20
> > @@ -1522,6 +1700,187 @@ qcrypto_block_luks_create(QCryptoBlock *block=
,
> >  }
> > =20
> > =20
> > +#define CHECK_NON_AMEND_OPTION(luks, luks_opts, name) \
> > +    if (luks_opts.has_##name && luks_opts.name !=3D luks->name) { \
> > +            error_setg(errp, "Option \"" #name "\" can't be amended"=
); \
> > +            goto cleanup; \
> > +    }
> > +
> > +static int
> > +qcrypto_block_luks_amend_options(QCryptoBlock *block,
> > +                                 QCryptoBlockReadFunc readfunc,
> > +                                 QCryptoBlockWriteFunc writefunc,
> > +                                 void *opaque,
> > +                                 QCryptoBlockCreateOptions *options,
> > +                                 bool force,
> > +                                 Error **errp)
> > +{
> > +    QCryptoBlockLUKS *luks =3D block->opaque;
> > +    QCryptoBlockCreateOptionsLUKS luks_opts;
> > +    g_autofree char *old_password =3D NULL;
> > +    g_autofree char *password =3D NULL;
> > +    const char *unlock_secret =3D luks->secret;
> > +    g_autofree uint8_t *masterkey =3D NULL;
> > +    int slot =3D -1;
> > +    int ret =3D -1;
> > +    bool active =3D true;
> > +    int64_t iter_time =3D QCRYPTO_BLOCK_LUKS_DEFAULT_ITER_TIME;
> > +
> > +    memcpy(&luks_opts, &options->u.luks, sizeof(luks_opts));
> > +
> > +    CHECK_NON_AMEND_OPTION(luks, luks_opts, cipher_alg);
> > +    CHECK_NON_AMEND_OPTION(luks, luks_opts, cipher_mode);
> > +    CHECK_NON_AMEND_OPTION(luks, luks_opts, ivgen_alg);
> > +    CHECK_NON_AMEND_OPTION(luks, luks_opts, ivgen_hash_alg);
> > +    CHECK_NON_AMEND_OPTION(luks, luks_opts, hash_alg);
> > +
> > +    /* Read given slot and check it */
> > +    if (luks_opts.has_slot) {
> > +        slot =3D luks_opts.slot;
> > +        if (slot < 0 || slot >=3D QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS) =
{
> > +            error_setg(errp,
> > +                       "Given key slot %i is not supported by LUKS",=
 slot);
> > +             goto cleanup;
>=20
> Off by 1 one indent
Sorry about that.
>=20
> > +        }
> > +    }
> > +
> > +    if (luks_opts.has_iter_time) {
> > +        iter_time =3D luks_opts.iter_time;
> > +    }
> > +
> > +    if (luks_opts.has_active && luks_opts.active =3D=3D false) {
> > +        active =3D false;
> > +    }
> > +
> > +    if (active) {
> > +
> > +        /* Check that we are not overwriting an active slot */
> > +        if (!force && slot !=3D -1 &&
> > +            qcrypto_block_luks_slot_active(luks, slot)) {
> > +
> > +            error_setg(errp, "Can't update an active key slot %i",
> > +                       slot);
> > +            goto cleanup;
> > +        }
> > +
> > +        /* check that we have the passwords*/
> > +        if (!luks_opts.has_key_secret) {
> > +            error_setg(errp, "Can't add a key slot without a  passwo=
rd");
> > +            goto cleanup;
> > +        }
> > +
> > +        if (luks_opts.has_unlock_secret) {
> > +            unlock_secret =3D luks_opts.unlock_secret;
> > +        }
> > +
> > +        /* Read the old password */
> > +        old_password =3D qcrypto_secret_lookup_as_utf8(unlock_secret=
, errp);
> > +        if (!old_password) {
> > +            goto cleanup;
> > +        }
> > +
> > +        masterkey =3D g_new0(uint8_t, luks->header.master_key_len);
> > +
> > +        /* Retrieve the master key*/
> > +        if (qcrypto_block_luks_find_key(block, old_password, masterk=
ey,
> > +                                        readfunc, opaque,
> > +                                        errp) < 0) {
> > +            error_append_hint(errp,
> > +                              "unlock secret, doesn't unlock the ima=
ge");
>=20
> No need for the ',' in this msg I think.
Fixed and reworded a bit.

>=20
> > +            goto cleanup;
> > +        }
> > +
> > +        /* Read the new password*/
> > +        password =3D qcrypto_secret_lookup_as_utf8(luks_opts.key_sec=
ret, errp);
> > +        if (!password) {
> > +            goto cleanup;
> > +        }
> > +
> > +        /* Find the new slot to write to */
> > +        if (slot =3D=3D -1) {
> > +            slot =3D qcrypto_block_luks_find_free_keyslot(luks);
> > +
> > +            if (slot =3D=3D -1) {
> > +                error_setg(errp,
> > +                           "Can't add a keyslot - all key slots are =
in use");
> > +                goto cleanup;
> > +
> > +            }
>=20
> Extra blank line
Agree
>=20
> > +        }
> > +
> > +        /* Store the master key to the new slot */
> > +        if (qcrypto_block_luks_store_key(block, slot, password, mast=
erkey,
> > +                                         iter_time, writefunc, opaqu=
e,
> > +                                         errp)) {
> > +
>=20
>=20
> Extra blank line
>=20
> > +            error_append_hint(errp, "Failed to store the keyslot %i"=
, slot);
> > +            goto cleanup;
> > +        }
> > +
> > +    } else {
> > +
> > +        /* Check that we are not erasing last key slot */
> > +        if (qcrypto_block_luks_count_active_slots(luks) <=3D 1) {
> > +
>=20
> Extra blank line(s)

I hope I cleaned all blank lines, sorry about that.

Best regards,
	Maxim Levitsky


