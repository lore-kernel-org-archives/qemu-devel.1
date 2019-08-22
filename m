Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCD6C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 11:29:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FDFE206DD
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 11:29:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FDFE206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0lHi-0005Z6-7A
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 07:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56380)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i0lG5-0004R5-Cc
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:28:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i0lG3-0002dr-AQ
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:28:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55346)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1i0lFx-0002bS-0A; Thu, 22 Aug 2019 07:27:53 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9A1DB309B688;
 Thu, 22 Aug 2019 11:27:51 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 835648080;
 Thu, 22 Aug 2019 11:27:47 +0000 (UTC)
Date: Thu, 22 Aug 2019 12:27:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Message-ID: <20190822112745.GO3267@redhat.com>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <20190814202219.1870-10-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190814202219.1870-10-mlevitsk@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Thu, 22 Aug 2019 11:27:51 +0000 (UTC)
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 14, 2019 at 11:22:15PM +0300, Maxim Levitsky wrote:
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  crypto/block-luks.c | 374 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 373 insertions(+), 1 deletion(-)
> 
> diff --git a/crypto/block-luks.c b/crypto/block-luks.c
> index 1997e92fe1..2c33643b52 100644
> --- a/crypto/block-luks.c
> +++ b/crypto/block-luks.c
> @@ -72,6 +72,8 @@ typedef struct QCryptoBlockLUKSKeySlot QCryptoBlockLUKSKeySlot;
>  
>  #define QCRYPTO_BLOCK_LUKS_DEFAULT_ITER_TIME 2000
>  
> +#define QCRYPTO_BLOCK_LUKS_ERASE_ITERATIONS 40
> +
>  static const char qcrypto_block_luks_magic[QCRYPTO_BLOCK_LUKS_MAGIC_LEN] = {
>      'L', 'U', 'K', 'S', 0xBA, 0xBE
>  };
> @@ -221,6 +223,9 @@ struct QCryptoBlockLUKS {
>  
>      /* Hash algorithm used in pbkdf2 function */
>      QCryptoHashAlgorithm hash_alg;
> +
> +    /* Name of the secret that was used to open the image */
> +    char *secret;
>  };
>  
>  
> @@ -1121,6 +1126,194 @@ qcrypto_block_luks_find_key(QCryptoBlock *block,
>  }
>  
>  
> +
> +/*
> + * Returns true if a slot i is marked as containing as active

s/as containing//

> + * (contains encrypted copy of the master key)
> + */
> +
> +static bool
> +qcrypto_block_luks_slot_active(QCryptoBlockLUKS *luks, int slot_idx)
> +{
> +    uint32_t val = luks->header.key_slots[slot_idx].active;
> +    return val ==  QCRYPTO_BLOCK_LUKS_KEY_SLOT_ENABLED;
> +}
> +
> +/*
> + * Returns the number of slots that are marked as active
> + * (contains encrypted copy of the master key)
> + */
> +
> +static int
> +qcrypto_block_luks_count_active_slots(QCryptoBlockLUKS *luks)
> +{
> +    int i, ret = 0;

I prefer to see 'size_t' for loop iterators 

> +
> +    for (i = 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
> +        if (qcrypto_block_luks_slot_active(luks, i)) {
> +            ret++;
> +        }
> +    }
> +    return ret;
> +}
> +
> +
> +/*
> + * Finds first key slot which is not active
> + * Returns the key slot index, or -1 if doesn't exist
> + */
> +
> +static int
> +qcrypto_block_luks_find_free_keyslot(QCryptoBlockLUKS *luks)
> +{
> +    uint i;
> +
> +    for (i = 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
> +        if (!qcrypto_block_luks_slot_active(luks, i)) {
> +            return i;
> +        }
> +    }
> +    return -1;
> +
> +}
> +
> +/*
> + * Erases an keyslot given its index
> + *
> + * Returns:
> + *    0 if the keyslot was erased successfully
> + *   -1 if a error occurred while erasing the keyslot
> + *
> + */
> +

Redundant blank line

> +static int
> +qcrypto_block_luks_erase_key(QCryptoBlock *block,
> +                             uint slot_idx,
> +                             QCryptoBlockWriteFunc writefunc,
> +                             void *opaque,
> +                             Error **errp)
> +{
> +    QCryptoBlockLUKS *luks = block->opaque;
> +    QCryptoBlockLUKSKeySlot *slot = &luks->header.key_slots[slot_idx];
> +    uint8_t *garbagekey = NULL;
> +    size_t splitkeylen = masterkeylen(luks) * slot->stripes;
> +    int i;
> +    int ret = -1;
> +
> +    assert(slot_idx < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS);
> +    assert(splitkeylen > 0);
> +
> +    garbagekey = g_malloc0(splitkeylen);
> +
> +    /* Reset the key slot header */
> +    memset(slot->salt, 0, QCRYPTO_BLOCK_LUKS_SALT_LEN);
> +    slot->iterations = 0;
> +    slot->active = QCRYPTO_BLOCK_LUKS_KEY_SLOT_DISABLED;
> +
> +    qcrypto_block_luks_store_header(block,  writefunc, opaque, errp);
> +
> +    /*
> +     * Now try to erase the key material, even if the header
> +     * update failed
> +     */
> +

Redundant blank line

> +    for (i = 0 ; i < QCRYPTO_BLOCK_LUKS_ERASE_ITERATIONS ; i++) {
> +        if (qcrypto_random_bytes(garbagekey, splitkeylen, errp) < 0) {
> +

Again, many more times beelow.

> +                /*
> +                 * If we failed to get the random data, still write
> +                 * *something* to the key slot at least once
> +                 */

Specificially  we write all-zeros, since garbagekey was allocated
with g_malloc0

> +
> +                if (i > 0) {
> +                    goto cleanup;
> +                }
> +        }
> +
> +        if (writefunc(block, slot->key_offset * QCRYPTO_BLOCK_LUKS_SECTOR_SIZE,
> +                  garbagekey,
> +                  splitkeylen,
> +                  opaque,
> +                  errp) != splitkeylen) {

Indent is off - align with '('

> +            goto cleanup;
> +        }
> +    }
> +
> +    ret = 0;
> +cleanup:
> +    g_free(garbagekey);
> +    return ret;
> +}
> +
> +
> +/*
> + * Erase all the keys that match the given password
> + * Will stop when only one keyslot is remaining
> + * Returns 0 is some keys were erased or -1 on failure
> + */
> +
> +static int
> +qcrypto_block_luks_erase_matching_keys(QCryptoBlock *block,
> +                             const char *password,
> +                             QCryptoBlockReadFunc readfunc,
> +                             QCryptoBlockWriteFunc writefunc,
> +                             void *opaque,
> +                             bool force,
> +                             Error **errp)

Indent is off again

> +{
> +    QCryptoBlockLUKS *luks = block->opaque;
> +    uint i;
> +    int rv, ret = -1;
> +    uint8_t *masterkey;
> +    uint erased_count = 0;
> +    uint active_slot_count = qcrypto_block_luks_count_active_slots(luks);
> +
> +    masterkey = g_new0(uint8_t, masterkeylen(luks));
> +
> +    for (i = 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
> +
> +        /* refuse to erase last key if not forced */
> +        if (!force && active_slot_count == 1) {
> +            break;
> +        }

In the case where there was only 1 keyslot to start with,
his break will cause us to report

        error_setg(errp, "Didn't erase a keyslot, because no keyslots "
                         "match the given password");

which is horribly misleading.

Before entering the loop we should check this case and report
a saner message.

> +
> +        rv = qcrypto_block_luks_load_key(block,
> +                                         i,
> +                                         password,
> +                                         masterkey,
> +                                         readfunc,
> +                                         opaque,
> +                                         errp);
> +        if (rv < 0) {
> +            goto cleanup;
> +        }
> +        if (rv == 0) {
> +            continue;
> +        }
> +
> +        rv = qcrypto_block_luks_erase_key(block, i, writefunc, opaque, errp);
> +        if (rv < 0) {
> +            goto cleanup;
> +        }
> +
> +        erased_count++;
> +        active_slot_count--;
> +    }
> +
> +    if (!erased_count) {
> +        error_setg(errp, "Didn't erase a keyslot, because no keyslots "
> +                         "match the given password");
> +        goto cleanup;
> +    }
> +
> +    ret = 0;
> +cleanup:
> +    memset(masterkey, 0, masterkeylen(luks));
> +    g_free(masterkey);
> +    return ret;
> +}
> +
> +
>  static int
>  qcrypto_block_luks_open(QCryptoBlock *block,
>                          QCryptoBlockOpenOptions *options,
> @@ -1151,6 +1344,7 @@ qcrypto_block_luks_open(QCryptoBlock *block,
>  
>      luks = g_new0(QCryptoBlockLUKS, 1);
>      block->opaque = luks;
> +    luks->secret = g_strdup(options->u.luks.key_secret);
>  
>      ret = qcrypto_block_luks_load_header(block, readfunc, opaque, errp);
>      if (ret) {
> @@ -1320,6 +1514,8 @@ qcrypto_block_luks_create(QCryptoBlock *block,
>                     optprefix ? optprefix : "");
>          return -1;
>      }
> +    luks->secret = options->u.luks.key_secret;
> +
>      password = qcrypto_secret_lookup_as_utf8(luks_opts.key_secret, errp);
>      if (!password) {
>          return -1;
> @@ -1605,7 +1801,9 @@ static int qcrypto_block_luks_get_info(QCryptoBlock *block,
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
> @@ -1638,6 +1836,179 @@ qcrypto_block_luks_encrypt(QCryptoBlock *block,
>                                          offset, buf, len, errp);
>  }
>  
> +static int
> +qcrypto_block_luks_setup_encryption(QCryptoBlock *block,
> +                                    QCryptoBlockReadFunc readfunc,
> +                                    QCryptoBlockWriteFunc writefunc,
> +                                    void *opaque,
> +                                    enum BlkSetupEncryptionAction action,
> +                                    QCryptoEncryptionSetupOptions *options,
> +                                    bool force,
> +                                    Error **errp)
> +{
> +    QCryptoBlockLUKS *luks = block->opaque;
> +    char *old_password = NULL;
> +    char *password = NULL;
> +    const char *old_secret = luks->secret;
> +    uint8_t *masterkey = NULL;
> +    int slot = -1;
> +    int ret = -1;
> +    int64_t iter_time = QCRYPTO_BLOCK_LUKS_DEFAULT_ITER_TIME;
> +
> +    /* Read given slot and check it */
> +    if (options->has_slot) {
> +        slot = options->slot;
> +        if (slot < 0 || slot >= QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS) {
> +            error_setg(errp,
> +                       "Given key slot %i is not supported by LUKS", slot);
> +             goto cleanup;
> +        }
> +    }
> +
> +    if (options->has_iter_time) {
> +        iter_time = options->iter_time;
> +    }
> +
> +    switch (action) {
> +
> +    case BLK_UPDATE_ENCRYPTION:


The fact that the vast majority of code in this method is inside
a giant switch just reinforces that we should have separate APIs
for erase vs adding keys.

> +
> +        /* Check that we are not overwriting an active slot */
> +        if (!force && slot != -1 &&
> +                    qcrypto_block_luks_slot_active(luks, slot)) {
> +
> +            error_setg(errp, "Can't update an active key slot %i",
> +                       slot);
> +            goto cleanup;
> +        }
> +
> +        /* check that we have the passwords*/
> +        if (!options->has_key_secret) {
> +            error_setg(errp, "Can't add a key slot without a  password");
> +            goto cleanup;
> +        }
> +
> +        if (options->has_old_key_secret) {
> +            old_secret = options->old_key_secret;
> +        }
> +
> +        /* Read the old password */
> +        old_password = qcrypto_secret_lookup_as_utf8(old_secret, errp);
> +        if (!old_password) {
> +            goto cleanup;
> +        }
> +
> +        masterkey = g_new0(uint8_t, masterkeylen(luks));
> +
> +        /* Retrieve the master key*/
> +        if (qcrypto_block_luks_find_key(block, old_password, masterkey,
> +                                    readfunc, opaque, errp) < 0) {

Indent is off

> +            error_append_hint(errp,
> +                       "Old password that was given doesn't unlock the image");

And again, throughout this patch

> +            goto cleanup;
> +        }
> +
> +        /* Read the new password*/
> +        password = qcrypto_secret_lookup_as_utf8(options->key_secret, errp);
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
> +                        "Can't add a keyslot - all key slots are in use");
> +                goto cleanup;
> +
> +            }
> +        }
> +
> +        /* Store the master key to the new slot */
> +        if (qcrypto_block_luks_store_key(block, slot, password,
> +                                     masterkey, iter_time,
> +                                     writefunc, opaque, errp)) {
> +
> +            error_append_hint(errp, "Failed to store the keyslot %i", slot);
> +            goto cleanup;
> +        }
> +        break;
> +
> +    case BLK_ERASE_ENCRYPTION:
> +
> +        /* Check that we are not erasing last key slot */
> +        if (qcrypto_block_luks_count_active_slots(luks) <= 1) {
> +
> +            if (!force) {
> +                error_setg(errp, "Only one slot active - can't erase");
> +                goto cleanup;
> +            }
> +        }
> +
> +        if (slot != -1) {
> +            /* Check that we are not erasing an inactive slot */
> +            if (!qcrypto_block_luks_slot_active(luks, options->slot)) {
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
> +            if (!options->has_key_secret) {
> +                error_setg(errp,
> +                           "To erase a keyslot you have to specify either the"
> +                           "slot index or a password "
> +                           "(to erase all slots that match it)");
> +                goto cleanup;
> +            }
> +
> +            password = qcrypto_secret_lookup_as_utf8(options->key_secret, errp);
> +            if (!password) {
> +                goto cleanup;
> +            }
> +
> +            if (qcrypto_block_luks_erase_matching_keys(block, password,
> +                                                       readfunc, writefunc,
> +                                                       opaque, force, errp)) {
> +                goto cleanup;
> +            }
> +        }
> +        break;
> +
> +    default:
> +        goto cleanup;
> +    }
> +
> +    ret = 0;
> +cleanup:
> +
> +    if (old_password) {
> +        memset(old_password, 0, strlen(old_password));
> +        g_free(old_password);
> +    }
> +
> +    if (password) {
> +        memset(password, 0, strlen(password));
> +        g_free(password);
> +    }
> +
> +    if (masterkey) {
> +        memset(masterkey, 0,  masterkeylen(luks));
> +        g_free(masterkey);
> +    }
> +    return ret;
> +}
> +
>  
>  const QCryptoBlockDriver qcrypto_block_driver_luks = {
>      .open = qcrypto_block_luks_open,
> @@ -1647,4 +2018,5 @@ const QCryptoBlockDriver qcrypto_block_driver_luks = {
>      .decrypt = qcrypto_block_luks_decrypt,
>      .encrypt = qcrypto_block_luks_encrypt,
>      .has_format = qcrypto_block_luks_has_format,
> +    .setup_encryption = qcrypto_block_luks_setup_encryption,
>  };
> -- 
> 2.17.2
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

