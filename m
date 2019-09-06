Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51287C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 13:16:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24E4A20842
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 13:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24E4A20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6E64-0000e4-Cw
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 09:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34202)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i6E4Q-0007ze-Uw
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 09:14:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i6E4O-0000Ru-TZ
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 09:14:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36314)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1i6E4K-0000I8-Oh; Fri, 06 Sep 2019 09:14:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6924885A03;
 Fri,  6 Sep 2019 13:14:26 +0000 (UTC)
Received: from redhat.com (ovpn-112-50.ams2.redhat.com [10.36.112.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E4196600C4;
 Fri,  6 Sep 2019 13:14:17 +0000 (UTC)
Date: Fri, 6 Sep 2019 14:14:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Message-ID: <20190906131414.GG5119@redhat.com>
References: <20190826135103.22410-1-mlevitsk@redhat.com>
 <20190826135103.22410-11-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190826135103.22410-11-mlevitsk@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Fri, 06 Sep 2019 13:14:26 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 10/13] qcrypto-luks: refactoring:
 extract store key function
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

On Mon, Aug 26, 2019 at 04:51:00PM +0300, Maxim Levitsky wrote:
> This function will be used later to store
> new keys to the luks metadata
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  crypto/block-luks.c | 310 ++++++++++++++++++++++++++------------------
>  1 file changed, 184 insertions(+), 126 deletions(-)
> 
> diff --git a/crypto/block-luks.c b/crypto/block-luks.c
> index cc9a52c9af..d713125925 100644
> --- a/crypto/block-luks.c
> +++ b/crypto/block-luks.c
> @@ -650,6 +650,176 @@ out:
>  
>  }
>  
> +/*
> + * Given a key slot,  user password, and the master key,
> + * will store the encrypted master key there, and update the
> + * in-memory header. User must then write the in-memory header
> + *
> + * Returns:
> + *    0 if the keyslot was written successfully
> + *      with the provided password
> + *   -1 if a fatal error occurred while storing the key
> + */
> +static int
> +qcrypto_block_luks_store_key(QCryptoBlock *block,
> +                             unsigned int slot_idx,
> +                             const char *password,
> +                             uint8_t *masterkey,
> +                             uint64_t iter_time,
> +                             QCryptoBlockWriteFunc writefunc,
> +                             void *opaque,
> +                             Error **errp)
> +{
> +    QCryptoBlockLUKS *luks = block->opaque;
> +    QCryptoBlockLUKSKeySlot *slot = &luks->header.key_slots[slot_idx];
> +    g_autofree uint8_t *splitkey = NULL;
> +    size_t splitkeylen;
> +    g_autofree uint8_t *slotkey = NULL;
> +    g_autoptr(QCryptoCipher) cipher = NULL;
> +    g_autoptr(QCryptoIVGen) ivgen = NULL;
> +    Error *local_err = NULL;
> +    uint64_t iters;
> +    int ret = -1;
> +
> +    if (qcrypto_random_bytes(slot->salt,
> +                             QCRYPTO_BLOCK_LUKS_SALT_LEN,
> +                             errp) < 0) {
> +        goto cleanup;
> +    }
> +
> +    splitkeylen = luks->header.master_key_len * slot->stripes;
> +
> +    /*
> +     * Determine how many iterations are required to
> +     * hash the user password while consuming 1 second of compute
> +     * time
> +     */
> +    iters = qcrypto_pbkdf2_count_iters(luks->hash_alg,
> +                                       (uint8_t *)password, strlen(password),
> +                                       slot->salt,
> +                                       QCRYPTO_BLOCK_LUKS_SALT_LEN,
> +                                       luks->header.master_key_len,
> +                                       &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        goto cleanup;
> +    }
> +
> +    if (iters > (ULLONG_MAX / iter_time)) {
> +        error_setg_errno(errp, ERANGE,
> +                         "PBKDF iterations %llu too large to scale",
> +                         (unsigned long long)iters);
> +        goto cleanup;
> +    }
> +
> +    /* iter_time was in millis, but count_iters reported for secs */
> +    iters = iters * iter_time / 1000;
> +
> +    if (iters > UINT32_MAX) {
> +        error_setg_errno(errp, ERANGE,
> +                         "PBKDF iterations %llu larger than %u",
> +                         (unsigned long long)iters, UINT32_MAX);
> +        goto cleanup;
> +    }
> +
> +    slot->iterations =
> +        MAX(iters, QCRYPTO_BLOCK_LUKS_MIN_SLOT_KEY_ITERS);
> +
> +
> +    /*
> +     * Generate a key that we'll use to encrypt the master
> +     * key, from the user's password
> +     */
> +    slotkey = g_new0(uint8_t, luks->header.master_key_len);
> +    if (qcrypto_pbkdf2(luks->hash_alg,
> +                       (uint8_t *)password, strlen(password),
> +                       slot->salt,
> +                       QCRYPTO_BLOCK_LUKS_SALT_LEN,
> +                       slot->iterations,
> +                       slotkey, luks->header.master_key_len,
> +                       errp) < 0) {
> +        goto cleanup;
> +    }
> +
> +
> +    /*
> +     * Setup the encryption objects needed to encrypt the
> +     * master key material
> +     */
> +    cipher = qcrypto_cipher_new(luks->cipher_alg,
> +                                luks->cipher_mode,
> +                                slotkey, luks->header.master_key_len,
> +                                errp);
> +    if (!cipher) {
> +        goto cleanup;
> +    }
> +
> +    ivgen = qcrypto_ivgen_new(luks->ivgen_alg,
> +                              luks->ivgen_cipher_alg,
> +                              luks->ivgen_hash_alg,
> +                              slotkey, luks->header.master_key_len,
> +                              errp);
> +    if (!ivgen) {
> +        goto cleanup;
> +    }
> +
> +    /*
> +     * Before storing the master key, we need to vastly
> +     * increase its size, as protection against forensic
> +     * disk data recovery
> +     */
> +    splitkey = g_new0(uint8_t, splitkeylen);
> +
> +    if (qcrypto_afsplit_encode(luks->hash_alg,
> +                               luks->header.master_key_len,
> +                               slot->stripes,
> +                               masterkey,
> +                               splitkey,
> +                               errp) < 0) {
> +        goto cleanup;
> +    }
> +
> +    /*
> +     * Now we encrypt the split master key with the key generated
> +     * from the user's password, before storing it
> +     */
> +    if (qcrypto_block_cipher_encrypt_helper(cipher, block->niv, ivgen,
> +                                            QCRYPTO_BLOCK_LUKS_SECTOR_SIZE,
> +                                            0,
> +                                            splitkey,
> +                                            splitkeylen,
> +                                            errp) < 0) {
> +        goto cleanup;
> +    }
> +
> +    /* Write out the slot's master key material. */
> +    if (writefunc(block,
> +                  slot->key_offset_sector *
> +                  QCRYPTO_BLOCK_LUKS_SECTOR_SIZE,
> +                  splitkey, splitkeylen,
> +                  opaque,
> +                  errp) != splitkeylen) {
> +        goto cleanup;
> +    }
> +
> +    slot->active = QCRYPTO_BLOCK_LUKS_KEY_SLOT_ENABLED;
> +
> +    if (qcrypto_block_luks_store_header(block,  writefunc, opaque, errp)) {

Check < 0

> +        goto cleanup;
> +    }
> +
> +    ret = 0;
> +
> +cleanup:
> +    if (slotkey) {
> +        memset(slotkey, 0, luks->header.master_key_len);
> +    }
> +    if (splitkey) {
> +        memset(splitkey, 0, splitkeylen);
> +    }
> +    return ret;
> +}
> +

> +    /* populate the slot 0 with the password encrypted master key*/
> +    /* This will also store the header */
> +    if (qcrypto_block_luks_store_key(block,
> +                                     0,
> +                                     password,
> +                                     masterkey,
> +                                     luks_opts.iter_time,
> +                                     writefunc,
> +                                     opaque,
> +                                     errp)) {
>          goto error;

Check < 0

> -    }
> +     }

Indent off by one

>  
> -    memset(masterkey, 0, luks->header.master_key_len);
> -    memset(slotkey, 0, luks->header.master_key_len);
>  
> +    memset(masterkey, 0, luks->header.master_key_len);
>      return 0;

The blank line was moved by accident.

>  
>   error:
>      if (masterkey) {
>          memset(masterkey, 0, luks->header.master_key_len);
>      }
> -    if (slotkey) {
> -        memset(slotkey, 0, luks->header.master_key_len);
> -    }
>  
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

