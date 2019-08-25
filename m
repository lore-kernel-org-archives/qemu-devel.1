Return-Path: <SRS0=aJdJ=WV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4D2C3A5A1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 17:02:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42389206DD
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 17:02:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42389206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1vuF-0004Sd-AQ
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 13:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38423)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i1vtE-0003sY-En
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 13:01:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i1vtC-00054M-Cb
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 13:01:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33826)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i1vt7-00052O-E2; Sun, 25 Aug 2019 13:01:09 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5AD043680A;
 Sun, 25 Aug 2019 17:01:06 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 99218600C4;
 Sun, 25 Aug 2019 17:01:01 +0000 (UTC)
Message-ID: <d07c0ee98b2a08394dbd1a25ab7c9d3d6c0f6cde.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Date: Sun, 25 Aug 2019 20:01:00 +0300
In-Reply-To: <20190822112745.GO3267@redhat.com>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <20190814202219.1870-10-mlevitsk@redhat.com>
 <20190822112745.GO3267@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Sun, 25 Aug 2019 17:01:07 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 09/13] qcrypto-luks: implement the
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2019-08-22 at 12:27 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Aug 14, 2019 at 11:22:15PM +0300, Maxim Levitsky wrote:
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  crypto/block-luks.c | 374 ++++++++++++++++++++++++++++++++++++++++++=
+-
> >  1 file changed, 373 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/crypto/block-luks.c b/crypto/block-luks.c
> > index 1997e92fe1..2c33643b52 100644
> > --- a/crypto/block-luks.c
> > +++ b/crypto/block-luks.c
> > @@ -72,6 +72,8 @@ typedef struct QCryptoBlockLUKSKeySlot QCryptoBlock=
LUKSKeySlot;
> > =20
> >  #define QCRYPTO_BLOCK_LUKS_DEFAULT_ITER_TIME 2000
> > =20
> > +#define QCRYPTO_BLOCK_LUKS_ERASE_ITERATIONS 40
> > +
> >  static const char qcrypto_block_luks_magic[QCRYPTO_BLOCK_LUKS_MAGIC_=
LEN] =3D {
> >      'L', 'U', 'K', 'S', 0xBA, 0xBE
> >  };
> > @@ -221,6 +223,9 @@ struct QCryptoBlockLUKS {
> > =20
> >      /* Hash algorithm used in pbkdf2 function */
> >      QCryptoHashAlgorithm hash_alg;
> > +
> > +    /* Name of the secret that was used to open the image */
> > +    char *secret;
> >  };
> > =20
> > =20
> > @@ -1121,6 +1126,194 @@ qcrypto_block_luks_find_key(QCryptoBlock *blo=
ck,
> >  }
> > =20
> > =20
> > +
> > +/*
> > + * Returns true if a slot i is marked as containing as active
>=20
> s/as containing//
>=20
> > + * (contains encrypted copy of the master key)
> > + */
> > +
> > +static bool
> > +qcrypto_block_luks_slot_active(QCryptoBlockLUKS *luks, int slot_idx)
> > +{
> > +    uint32_t val =3D luks->header.key_slots[slot_idx].active;
> > +    return val =3D=3D  QCRYPTO_BLOCK_LUKS_KEY_SLOT_ENABLED;
> > +}
> > +
> > +/*
> > + * Returns the number of slots that are marked as active
> > + * (contains encrypted copy of the master key)
> > + */
> > +
> > +static int
> > +qcrypto_block_luks_count_active_slots(QCryptoBlockLUKS *luks)
> > +{
> > +    int i, ret =3D 0;
>=20
> I prefer to see 'size_t' for loop iterators=20
Done

>=20
> > +
> > +    for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
> > +        if (qcrypto_block_luks_slot_active(luks, i)) {
> > +            ret++;
> > +        }
> > +    }
> > +    return ret;
> > +}
> > +
> > +
> > +/*
> > + * Finds first key slot which is not active
> > + * Returns the key slot index, or -1 if doesn't exist
> > + */
> > +
> > +static int
> > +qcrypto_block_luks_find_free_keyslot(QCryptoBlockLUKS *luks)
> > +{
> > +    uint i;
> > +
> > +    for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
> > +        if (!qcrypto_block_luks_slot_active(luks, i)) {
> > +            return i;
> > +        }
> > +    }
> > +    return -1;
> > +
> > +}
> > +
> > +/*
> > + * Erases an keyslot given its index
> > + *
> > + * Returns:
> > + *    0 if the keyslot was erased successfully
> > + *   -1 if a error occurred while erasing the keyslot
> > + *
> > + */
> > +
>=20
> Redundant blank line
Done
>=20
> > +static int
> > +qcrypto_block_luks_erase_key(QCryptoBlock *block,
> > +                             uint slot_idx,
> > +                             QCryptoBlockWriteFunc writefunc,
> > +                             void *opaque,
> > +                             Error **errp)
> > +{
> > +    QCryptoBlockLUKS *luks =3D block->opaque;
> > +    QCryptoBlockLUKSKeySlot *slot =3D &luks->header.key_slots[slot_i=
dx];
> > +    uint8_t *garbagekey =3D NULL;
> > +    size_t splitkeylen =3D masterkeylen(luks) * slot->stripes;
> > +    int i;
> > +    int ret =3D -1;
> > +
> > +    assert(slot_idx < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS);
> > +    assert(splitkeylen > 0);
> > +
> > +    garbagekey =3D g_malloc0(splitkeylen);
> > +
> > +    /* Reset the key slot header */
> > +    memset(slot->salt, 0, QCRYPTO_BLOCK_LUKS_SALT_LEN);
> > +    slot->iterations =3D 0;
> > +    slot->active =3D QCRYPTO_BLOCK_LUKS_KEY_SLOT_DISABLED;
> > +
> > +    qcrypto_block_luks_store_header(block,  writefunc, opaque, errp)=
;
> > +
> > +    /*
> > +     * Now try to erase the key material, even if the header
> > +     * update failed
> > +     */
> > +
>=20
> Redundant blank line
Fixed.
>=20
> > +    for (i =3D 0 ; i < QCRYPTO_BLOCK_LUKS_ERASE_ITERATIONS ; i++) {
> > +        if (qcrypto_random_bytes(garbagekey, splitkeylen, errp) < 0)=
 {
> > +
>=20
> Again, many more times beelow.
>=20
> > +                /*
> > +                 * If we failed to get the random data, still write
> > +                 * *something* to the key slot at least once
> > +                 */
>=20
> Specificially  we write all-zeros, since garbagekey was allocated
> with g_malloc0
Clarified.
>=20
> > +
> > +                if (i > 0) {
> > +                    goto cleanup;
> > +                }
> > +        }
> > +
> > +        if (writefunc(block, slot->key_offset * QCRYPTO_BLOCK_LUKS_S=
ECTOR_SIZE,
> > +                  garbagekey,
> > +                  splitkeylen,
> > +                  opaque,
> > +                  errp) !=3D splitkeylen) {
>=20
> Indent is off - align with '('
Fixed.
>=20
> > +            goto cleanup;
> > +        }
> > +    }
> > +
> > +    ret =3D 0;
> > +cleanup:
> > +    g_free(garbagekey);
> > +    return ret;
> > +}
> > +
> > +
> > +/*
> > + * Erase all the keys that match the given password
> > + * Will stop when only one keyslot is remaining
> > + * Returns 0 is some keys were erased or -1 on failure
> > + */
> > +
> > +static int
> > +qcrypto_block_luks_erase_matching_keys(QCryptoBlock *block,
> > +                             const char *password,
> > +                             QCryptoBlockReadFunc readfunc,
> > +                             QCryptoBlockWriteFunc writefunc,
> > +                             void *opaque,
> > +                             bool force,
> > +                             Error **errp)
>=20
> Indent is off again
Fixed. Sorry for all the coding errors.
>=20
> > +{
> > +    QCryptoBlockLUKS *luks =3D block->opaque;
> > +    uint i;
> > +    int rv, ret =3D -1;
> > +    uint8_t *masterkey;
> > +    uint erased_count =3D 0;
> > +    uint active_slot_count =3D qcrypto_block_luks_count_active_slots=
(luks);
> > +
> > +    masterkey =3D g_new0(uint8_t, masterkeylen(luks));
> > +
> > +    for (i =3D 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
> > +
> > +        /* refuse to erase last key if not forced */
> > +        if (!force && active_slot_count =3D=3D 1) {
> > +            break;
> > +        }
>=20
> In the case where there was only 1 keyslot to start with,
> his break will cause us to report
>=20
>         error_setg(errp, "Didn't erase a keyslot, because no keyslots "
>                          "match the given password");
>=20
> which is horribly misleading.
>=20
> Before entering the loop we should check this case and report
> a saner message.

Actually this won't happen, since qcrypto_block_luks_erase_matching_keys
won't be called in this case - the caller right at the start of the erase=
 code
has this:

        if (qcrypto_block_luks_count_active_slots(luks) <=3D 1) {

            if (!force) {
                error_setg(errp, "Only one slot active - can't erase");
                goto cleanup;
            }
        }




>=20
> > +
> > +        rv =3D qcrypto_block_luks_load_key(block,
> > +                                         i,
> > +                                         password,
> > +                                         masterkey,
> > +                                         readfunc,
> > +                                         opaque,
> > +                                         errp);
> > +        if (rv < 0) {
> > +            goto cleanup;
> > +        }
> > +        if (rv =3D=3D 0) {
> > +            continue;
> > +        }
> > +
> > +        rv =3D qcrypto_block_luks_erase_key(block, i, writefunc, opa=
que, errp);
> > +        if (rv < 0) {
> > +            goto cleanup;
> > +        }
> > +
> > +        erased_count++;
> > +        active_slot_count--;
> > +    }
> > +
> > +    if (!erased_count) {
> > +        error_setg(errp, "Didn't erase a keyslot, because no keyslot=
s "
> > +                         "match the given password");
> > +        goto cleanup;
> > +    }
> > +
> > +    ret =3D 0;
> > +cleanup:
> > +    memset(masterkey, 0, masterkeylen(luks));
> > +    g_free(masterkey);
> > +    return ret;
> > +}
> > +
> > +
> >  static int
> >  qcrypto_block_luks_open(QCryptoBlock *block,
> >                          QCryptoBlockOpenOptions *options,
> > @@ -1151,6 +1344,7 @@ qcrypto_block_luks_open(QCryptoBlock *block,
> > =20
> >      luks =3D g_new0(QCryptoBlockLUKS, 1);
> >      block->opaque =3D luks;
> > +    luks->secret =3D g_strdup(options->u.luks.key_secret);
> > =20
> >      ret =3D qcrypto_block_luks_load_header(block, readfunc, opaque, =
errp);
> >      if (ret) {
> > @@ -1320,6 +1514,8 @@ qcrypto_block_luks_create(QCryptoBlock *block,
> >                     optprefix ? optprefix : "");
> >          return -1;
> >      }
> > +    luks->secret =3D options->u.luks.key_secret;
> > +
> >      password =3D qcrypto_secret_lookup_as_utf8(luks_opts.key_secret,=
 errp);
> >      if (!password) {
> >          return -1;
> > @@ -1605,7 +1801,9 @@ static int qcrypto_block_luks_get_info(QCryptoB=
lock *block,
> > =20
> >  static void qcrypto_block_luks_cleanup(QCryptoBlock *block)
> >  {
> > -    g_free(block->opaque);
> > +    QCryptoBlockLUKS *luks =3D block->opaque;
> > +    g_free(luks->secret);
> > +    g_free(luks);
> >  }
> > =20
> > =20
> > @@ -1638,6 +1836,179 @@ qcrypto_block_luks_encrypt(QCryptoBlock *bloc=
k,
> >                                          offset, buf, len, errp);
> >  }
> > =20
> > +static int
> > +qcrypto_block_luks_setup_encryption(QCryptoBlock *block,
> > +                                    QCryptoBlockReadFunc readfunc,
> > +                                    QCryptoBlockWriteFunc writefunc,
> > +                                    void *opaque,
> > +                                    enum BlkSetupEncryptionAction ac=
tion,
> > +                                    QCryptoEncryptionSetupOptions *o=
ptions,
> > +                                    bool force,
> > +                                    Error **errp)
> > +{
> > +    QCryptoBlockLUKS *luks =3D block->opaque;
> > +    char *old_password =3D NULL;
> > +    char *password =3D NULL;
> > +    const char *old_secret =3D luks->secret;
> > +    uint8_t *masterkey =3D NULL;
> > +    int slot =3D -1;
> > +    int ret =3D -1;
> > +    int64_t iter_time =3D QCRYPTO_BLOCK_LUKS_DEFAULT_ITER_TIME;
> > +
> > +    /* Read given slot and check it */
> > +    if (options->has_slot) {
> > +        slot =3D options->slot;
> > +        if (slot < 0 || slot >=3D QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS) =
{
> > +            error_setg(errp,
> > +                       "Given key slot %i is not supported by LUKS",=
 slot);
> > +             goto cleanup;
> > +        }
> > +    }
> > +
> > +    if (options->has_iter_time) {
> > +        iter_time =3D options->iter_time;
> > +    }
> > +
> > +    switch (action) {
> > +
> > +    case BLK_UPDATE_ENCRYPTION:
>=20
>=20
> The fact that the vast majority of code in this method is inside
> a giant switch just reinforces that we should have separate APIs
> for erase vs adding keys.
Both yes and no.
It is true that for luks based encryption we indeed need
two apis. but for other encryptions we might need more or less
Putting it all in one function/callback, with action
allows to hide these details from the rest of the qemu.
This is very different from say a read/write/encrypt/decrypt/create/etc
callbacks where it is obvious that these are common to all the drivers.
I could imagine a encryption format that for instance has some certificat=
es,
which could be changed/revoked/etc, which would need another action
to be added, or something like that.

Anyway if I use amend interface, it is a single interface which
I will have to adapt to all the luks needs.


>=20
> > +
> > +        /* Check that we are not overwriting an active slot */
> > +        if (!force && slot !=3D -1 &&
> > +                    qcrypto_block_luks_slot_active(luks, slot)) {
> > +
> > +            error_setg(errp, "Can't update an active key slot %i",
> > +                       slot);
> > +            goto cleanup;
> > +        }
> > +
> > +        /* check that we have the passwords*/
> > +        if (!options->has_key_secret) {
> > +            error_setg(errp, "Can't add a key slot without a  passwo=
rd");
> > +            goto cleanup;
> > +        }
> > +
> > +        if (options->has_old_key_secret) {
> > +            old_secret =3D options->old_key_secret;
> > +        }
> > +
> > +        /* Read the old password */
> > +        old_password =3D qcrypto_secret_lookup_as_utf8(old_secret, e=
rrp);
> > +        if (!old_password) {
> > +            goto cleanup;
> > +        }
> > +
> > +        masterkey =3D g_new0(uint8_t, masterkeylen(luks));
> > +
> > +        /* Retrieve the master key*/
> > +        if (qcrypto_block_luks_find_key(block, old_password, masterk=
ey,
> > +                                    readfunc, opaque, errp) < 0) {
>=20
> Indent is off
True and sorry about that

>=20
> > +            error_append_hint(errp,
> > +                       "Old password that was given doesn't unlock t=
he image");
>=20
> And again, throughout this patch
True :-(
>=20
> > +            goto cleanup;
> > +        }
> > +
> > +        /* Read the new password*/
> > +        password =3D qcrypto_secret_lookup_as_utf8(options->key_secr=
et, errp);
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
> > +                        "Can't add a keyslot - all key slots are in =
use");
> > +                goto cleanup;
> > +
> > +            }
> > +        }
> > +
> > +        /* Store the master key to the new slot */
> > +        if (qcrypto_block_luks_store_key(block, slot, password,
> > +                                     masterkey, iter_time,
> > +                                     writefunc, opaque, errp)) {
> > +
> > +            error_append_hint(errp, "Failed to store the keyslot %i"=
, slot);
> > +            goto cleanup;
> > +        }
> > +        break;
> > +
> > +    case BLK_ERASE_ENCRYPTION:
> > +
> > +        /* Check that we are not erasing last key slot */
> > +        if (qcrypto_block_luks_count_active_slots(luks) <=3D 1) {
> > +
> > +            if (!force) {
> > +                error_setg(errp, "Only one slot active - can't erase=
");
> > +                goto cleanup;
> > +            }
> > +        }
> > +
> > +        if (slot !=3D -1) {
> > +            /* Check that we are not erasing an inactive slot */
> > +            if (!qcrypto_block_luks_slot_active(luks, options->slot)=
) {
> > +                if (!force) {
> > +                    error_setg(errp, "Can't erase an inactive key sl=
ot %i",
> > +                               slot);
> > +                    goto cleanup;
> > +                }
> > +            }
> > +
> > +            /* Erase the given slot */
> > +            if (qcrypto_block_luks_erase_key(block, slot,
> > +                                             writefunc, opaque, errp=
)) {
> > +                goto cleanup;
> > +            }
> > +
> > +        } else {
> > +            if (!options->has_key_secret) {
> > +                error_setg(errp,
> > +                           "To erase a keyslot you have to specify e=
ither the"
> > +                           "slot index or a password "
> > +                           "(to erase all slots that match it)");
> > +                goto cleanup;
> > +            }
> > +
> > +            password =3D qcrypto_secret_lookup_as_utf8(options->key_=
secret, errp);
> > +            if (!password) {
> > +                goto cleanup;
> > +            }
> > +
> > +            if (qcrypto_block_luks_erase_matching_keys(block, passwo=
rd,
> > +                                                       readfunc, wri=
tefunc,
> > +                                                       opaque, force=
, errp)) {
> > +                goto cleanup;
> > +            }
> > +        }
> > +        break;
> > +
> > +    default:
> > +        goto cleanup;
> > +    }
> > +
> > +    ret =3D 0;
> > +cleanup:
> > +
> > +    if (old_password) {
> > +        memset(old_password, 0, strlen(old_password));
> > +        g_free(old_password);
> > +    }
> > +
> > +    if (password) {
> > +        memset(password, 0, strlen(password));
> > +        g_free(password);
> > +    }
> > +
> > +    if (masterkey) {
> > +        memset(masterkey, 0,  masterkeylen(luks));
> > +        g_free(masterkey);
> > +    }
> > +    return ret;
> > +}
> > +
> > =20
> >  const QCryptoBlockDriver qcrypto_block_driver_luks =3D {
> >      .open =3D qcrypto_block_luks_open,
> > @@ -1647,4 +2018,5 @@ const QCryptoBlockDriver qcrypto_block_driver_l=
uks =3D {
> >      .decrypt =3D qcrypto_block_luks_decrypt,
> >      .encrypt =3D qcrypto_block_luks_encrypt,
> >      .has_format =3D qcrypto_block_luks_has_format,
> > +    .setup_encryption =3D qcrypto_block_luks_setup_encryption,
> >  };
> > --=20
> > 2.17.2
> >=20
>=20
> Regards,
> Daniel


Thank you very much for the review,
	Best regards,
		Maxim Levitsky


