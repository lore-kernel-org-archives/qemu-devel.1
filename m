Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9B6C00307
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 13:56:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A666420854
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 13:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A666420854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6Ej3-000284-QH
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 09:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45082)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i6EiP-0001fU-Jb
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 09:55:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i6EiN-0004LX-Ou
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 09:55:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35846)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1i6EiJ-0004JF-Cn; Fri, 06 Sep 2019 09:55:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2FA4C3086246;
 Fri,  6 Sep 2019 13:55:46 +0000 (UTC)
Received: from redhat.com (ovpn-112-50.ams2.redhat.com [10.36.112.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 00A465D9CA;
 Fri,  6 Sep 2019 13:55:38 +0000 (UTC)
Date: Fri, 6 Sep 2019 14:55:35 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Message-ID: <20190906135535.GL5119@redhat.com>
References: <20190830205608.18192-1-mlevitsk@redhat.com>
 <20190830205608.18192-4-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190830205608.18192-4-mlevitsk@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 06 Sep 2019 13:55:46 +0000 (UTC)
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 30, 2019 at 11:56:01PM +0300, Maxim Levitsky wrote:
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  crypto/block-luks.c | 366 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 364 insertions(+), 2 deletions(-)
> 
> diff --git a/crypto/block-luks.c b/crypto/block-luks.c
> index ba20d55246..21325fbc79 100644
> --- a/crypto/block-luks.c
> +++ b/crypto/block-luks.c
> @@ -70,6 +70,9 @@ typedef struct QCryptoBlockLUKSKeySlot QCryptoBlockLUKSKeySlot;
>  
>  #define QCRYPTO_BLOCK_LUKS_SECTOR_SIZE 512LL
>  
> +#define QCRYPTO_BLOCK_LUKS_DEFAULT_ITER_TIME 2000

Perhaps use  ITER_TIME_MS to make it clear it is millisecs

> +#define QCRYPTO_BLOCK_LUKS_ERASE_ITERATIONS 40
> +
>  static const char qcrypto_block_luks_magic[QCRYPTO_BLOCK_LUKS_MAGIC_LEN] = {
>      'L', 'U', 'K', 'S', 0xBA, 0xBE
>  };
> @@ -219,6 +222,9 @@ struct QCryptoBlockLUKS {
>  
>      /* Hash algorithm used in pbkdf2 function */
>      QCryptoHashAlgorithm hash_alg;
> +
> +    /* Name of the secret that was used to open the image */
> +    char *secret;

> +
> +/*
> + * Returns true if a slot i is marked as active
> + * (contains encrypted copy of the master key)
> + */
> +
> +static bool

No blank line is wanted between the comment & function.
Likewise for the rest of this patch series

> +qcrypto_block_luks_slot_active(const QCryptoBlockLUKS *luks,
> +                               unsigned int slot_idx)
> +{
> +    uint32_t val = luks->header.key_slots[slot_idx].active;
> +    return val ==  QCRYPTO_BLOCK_LUKS_KEY_SLOT_ENABLED;
> +}



> +static int
> +qcrypto_block_luks_erase_key(QCryptoBlock *block,
> +                             unsigned int slot_idx,
> +                             QCryptoBlockWriteFunc writefunc,
> +                             void *opaque,
> +                             Error **errp)
> +{
> +    QCryptoBlockLUKS *luks = block->opaque;
> +    QCryptoBlockLUKSKeySlot *slot = &luks->header.key_slots[slot_idx];
> +    g_autofree uint8_t *garbagesplitkey = NULL;
> +    size_t splitkeylen = luks->header.master_key_len * slot->stripes;
> +    size_t i;
> +
> +    assert(slot_idx < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS);
> +    assert(splitkeylen > 0);
> +
> +    garbagesplitkey = g_malloc0(splitkeylen);

I'd prefer   g_new0(uint8_t, splitkeylen)

> +
> +    /* Reset the key slot header */
> +    memset(slot->salt, 0, QCRYPTO_BLOCK_LUKS_SALT_LEN);
> +    slot->iterations = 0;
> +    slot->active = QCRYPTO_BLOCK_LUKS_KEY_SLOT_DISABLED;
> +


> @@ -1522,6 +1700,187 @@ qcrypto_block_luks_create(QCryptoBlock *block,
>  }
>  
>  
> +#define CHECK_NON_AMEND_OPTION(luks, luks_opts, name) \
> +    if (luks_opts.has_##name && luks_opts.name != luks->name) { \
> +            error_setg(errp, "Option \"" #name "\" can't be amended"); \
> +            goto cleanup; \
> +    }
> +
> +static int
> +qcrypto_block_luks_amend_options(QCryptoBlock *block,
> +                                 QCryptoBlockReadFunc readfunc,
> +                                 QCryptoBlockWriteFunc writefunc,
> +                                 void *opaque,
> +                                 QCryptoBlockCreateOptions *options,
> +                                 bool force,
> +                                 Error **errp)
> +{
> +    QCryptoBlockLUKS *luks = block->opaque;
> +    QCryptoBlockCreateOptionsLUKS luks_opts;
> +    g_autofree char *old_password = NULL;
> +    g_autofree char *password = NULL;
> +    const char *unlock_secret = luks->secret;
> +    g_autofree uint8_t *masterkey = NULL;
> +    int slot = -1;
> +    int ret = -1;
> +    bool active = true;
> +    int64_t iter_time = QCRYPTO_BLOCK_LUKS_DEFAULT_ITER_TIME;
> +
> +    memcpy(&luks_opts, &options->u.luks, sizeof(luks_opts));
> +
> +    CHECK_NON_AMEND_OPTION(luks, luks_opts, cipher_alg);
> +    CHECK_NON_AMEND_OPTION(luks, luks_opts, cipher_mode);
> +    CHECK_NON_AMEND_OPTION(luks, luks_opts, ivgen_alg);
> +    CHECK_NON_AMEND_OPTION(luks, luks_opts, ivgen_hash_alg);
> +    CHECK_NON_AMEND_OPTION(luks, luks_opts, hash_alg);
> +
> +    /* Read given slot and check it */
> +    if (luks_opts.has_slot) {
> +        slot = luks_opts.slot;
> +        if (slot < 0 || slot >= QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS) {
> +            error_setg(errp,
> +                       "Given key slot %i is not supported by LUKS", slot);
> +             goto cleanup;

Off by 1 one indent

> +        }
> +    }
> +
> +    if (luks_opts.has_iter_time) {
> +        iter_time = luks_opts.iter_time;
> +    }
> +
> +    if (luks_opts.has_active && luks_opts.active == false) {
> +        active = false;
> +    }
> +
> +    if (active) {
> +
> +        /* Check that we are not overwriting an active slot */
> +        if (!force && slot != -1 &&
> +            qcrypto_block_luks_slot_active(luks, slot)) {
> +
> +            error_setg(errp, "Can't update an active key slot %i",
> +                       slot);
> +            goto cleanup;
> +        }
> +
> +        /* check that we have the passwords*/
> +        if (!luks_opts.has_key_secret) {
> +            error_setg(errp, "Can't add a key slot without a  password");
> +            goto cleanup;
> +        }
> +
> +        if (luks_opts.has_unlock_secret) {
> +            unlock_secret = luks_opts.unlock_secret;
> +        }
> +
> +        /* Read the old password */
> +        old_password = qcrypto_secret_lookup_as_utf8(unlock_secret, errp);
> +        if (!old_password) {
> +            goto cleanup;
> +        }
> +
> +        masterkey = g_new0(uint8_t, luks->header.master_key_len);
> +
> +        /* Retrieve the master key*/
> +        if (qcrypto_block_luks_find_key(block, old_password, masterkey,
> +                                        readfunc, opaque,
> +                                        errp) < 0) {
> +            error_append_hint(errp,
> +                              "unlock secret, doesn't unlock the image");

No need for the ',' in this msg I think.

> +            goto cleanup;
> +        }
> +
> +        /* Read the new password*/
> +        password = qcrypto_secret_lookup_as_utf8(luks_opts.key_secret, errp);
> +        if (!password) {
> +            goto cleanup;
> +        }
> +
> +        /* Find the new slot to write to */
> +        if (slot == -1) {
> +            slot = qcrypto_block_luks_find_free_keyslot(luks);
> +
> +            if (slot == -1) {
> +                error_setg(errp,
> +                           "Can't add a keyslot - all key slots are in use");
> +                goto cleanup;
> +
> +            }

Extra blank line

> +        }
> +
> +        /* Store the master key to the new slot */
> +        if (qcrypto_block_luks_store_key(block, slot, password, masterkey,
> +                                         iter_time, writefunc, opaque,
> +                                         errp)) {
> +


Extra blank line

> +            error_append_hint(errp, "Failed to store the keyslot %i", slot);
> +            goto cleanup;
> +        }
> +
> +    } else {
> +
> +        /* Check that we are not erasing last key slot */
> +        if (qcrypto_block_luks_count_active_slots(luks) <= 1) {
> +

Extra blank line(s)

> +            if (!force) {
> +                error_setg(errp, "Only one slot active - can't erase");
> +                goto cleanup;
> +            }
> +        }
> +
> +        if (slot != -1) {
> +            /* Check that we are not erasing an inactive slot */
> +            if (!qcrypto_block_luks_slot_active(luks, luks_opts.slot)) {
> +                if (!force) {
> +                    error_setg(errp, "Can't erase an inactive key slot %i",
> +                               slot);
> +                    goto cleanup;
> +                }
> +            }
> +
> +            /* Erase the given slot */
> +            if (qcrypto_block_luks_erase_key(block, slot,
> +                                             writefunc, opaque, errp)) {
> +                goto cleanup;
> +            }
> +
> +        } else {
> +            if (!luks_opts.has_key_secret) {
> +                error_setg(errp,
> +                           "To erase a keyslot you have to specify either the"
> +                           "slot index or a password "
> +                           "(to erase all slots that match it)");
> +                goto cleanup;
> +            }
> +
> +            password = qcrypto_secret_lookup_as_utf8(luks_opts.key_secret,
> +                                                     errp);
> +            if (!password) {
> +                goto cleanup;
> +            }
> +
> +            ret = qcrypto_block_luks_erase_matching_keys(block, password,
> +                                                       readfunc, writefunc,
> +                                                       opaque, force, errp);
> +            if (ret == 0) {
> +                error_setg(errp,
> +                           "Didn't erase a keyslot, because no keyslots match"
> +                           " the given password");
> +                ret = -EINVAL;
> +                goto cleanup;
> +            }
> +
> +            if (ret < 0) {
> +                goto cleanup;
> +            }
> +        }
> +    }
> +    ret = 0;
> +cleanup:
> +    return ret;
> +}
> +
> +
>  static int qcrypto_block_luks_get_info(QCryptoBlock *block,
>                                         QCryptoBlockInfo *info,
>                                         Error **errp)
> @@ -1569,7 +1928,9 @@ static int qcrypto_block_luks_get_info(QCryptoBlock *block,
>  
>  static void qcrypto_block_luks_cleanup(QCryptoBlock *block)
>  {
> -    g_free(block->opaque);
> +    QCryptoBlockLUKS *luks = block->opaque;
> +    g_free(luks->secret);
> +    g_free(luks);
>  }
>  
>  
> @@ -1606,6 +1967,7 @@ qcrypto_block_luks_encrypt(QCryptoBlock *block,
>  const QCryptoBlockDriver qcrypto_block_driver_luks = {
>      .open = qcrypto_block_luks_open,
>      .create = qcrypto_block_luks_create,
> +    .amend = qcrypto_block_luks_amend_options,
>      .get_info = qcrypto_block_luks_get_info,
>      .cleanup = qcrypto_block_luks_cleanup,
>      .decrypt = qcrypto_block_luks_decrypt,
> -- 
> 2.17.2
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

