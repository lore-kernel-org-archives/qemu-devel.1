Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F423C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 21:47:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2BBE2086C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 21:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2BBE2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyNal-0003Hh-04
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 17:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60687)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1hyNTs-0004kg-0a
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 17:40:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hyNTp-0007iP-P9
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 17:40:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46556)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hyNTk-0007dy-HA; Thu, 15 Aug 2019 17:40:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 659E1308FEC1;
 Thu, 15 Aug 2019 21:40:15 +0000 (UTC)
Received: from [10.18.17.169] (dhcp-17-169.bos.redhat.com [10.18.17.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2BB4E5DA8B;
 Thu, 15 Aug 2019 21:40:11 +0000 (UTC)
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <20190814202219.1870-3-mlevitsk@redhat.com>
From: John Snow <jsnow@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <6b9b4bf7-5765-400b-7452-e37ec797eed1@redhat.com>
Date: Thu, 15 Aug 2019 17:40:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814202219.1870-3-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 15 Aug 2019 21:40:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 02/13] qcrypto-luks: misc
 refactoring
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
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 8/14/19 4:22 PM, Maxim Levitsky wrote:
> This is also a preparation for key read/write/erase functions
> 

This is a matter of taste and I am not usually reviewing LUKS patches
(So don't take me too seriously), but I would prefer not to have "misc"
patches and instead split things out by individual changes along with a
nice commit message for each change.

> * use master key len from the header

This touches enough lines that you could make it its own patch, I think.

> * prefer to use crypto params in the QCryptoBlockLUKS
>   over passing them as function arguments

I think the same is true here, and highlighting which variables you are
sticking into state instead of leaving as functional parameters would be
nice to see without all the other changes.

> * define QCRYPTO_BLOCK_LUKS_DEFAULT_ITER_TIME

This can likely be squashed with whichever patch of yours first needs to
use it, because it's so short.

> * Add comments to various crypto parameters in the QCryptoBlockLUKS
> 

Can probably be squashed with item #2.


> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  crypto/block-luks.c | 213 ++++++++++++++++++++++----------------------
>  1 file changed, 105 insertions(+), 108 deletions(-)
> 
> diff --git a/crypto/block-luks.c b/crypto/block-luks.c
> index 409ab50f20..48213abde7 100644
> --- a/crypto/block-luks.c
> +++ b/crypto/block-luks.c
> @@ -70,6 +70,8 @@ typedef struct QCryptoBlockLUKSKeySlot QCryptoBlockLUKSKeySlot;
>  
>  #define QCRYPTO_BLOCK_LUKS_SECTOR_SIZE 512LL
>  
> +#define QCRYPTO_BLOCK_LUKS_DEFAULT_ITER_TIME 2000
> +
>  static const char qcrypto_block_luks_magic[QCRYPTO_BLOCK_LUKS_MAGIC_LEN] = {
>      'L', 'U', 'K', 'S', 0xBA, 0xBE
>  };
> @@ -199,13 +201,25 @@ QEMU_BUILD_BUG_ON(sizeof(struct QCryptoBlockLUKSHeader) != 592);
>  struct QCryptoBlockLUKS {
>      QCryptoBlockLUKSHeader header;
>  
> -    /* Cache parsed versions of what's in header fields,
> -     * as we can't rely on QCryptoBlock.cipher being
> -     * non-NULL */
> +    /* Main encryption algorithm used for encryption*/
>      QCryptoCipherAlgorithm cipher_alg;
> +
> +    /* Mode of encryption for the selected encryption algorithm */
>      QCryptoCipherMode cipher_mode;
> +
> +    /* Initialization vector generation algorithm */
>      QCryptoIVGenAlgorithm ivgen_alg;
> +
> +    /* Hash algorithm used for IV generation*/
>      QCryptoHashAlgorithm ivgen_hash_alg;
> +
> +    /*
> +     * Encryption algorithm used for IV generation.
> +     * Usually the same as main encryption algorithm
> +     */
> +    QCryptoCipherAlgorithm ivgen_cipher_alg;
> +
> +    /* Hash algorithm used in pbkdf2 function */
>      QCryptoHashAlgorithm hash_alg;
>  };
>  
> @@ -397,6 +411,12 @@ qcrypto_block_luks_essiv_cipher(QCryptoCipherAlgorithm cipher,
>      }
>  }
>  
> +static int masterkeylen(QCryptoBlockLUKS *luks)
> +{
> +    return luks->header.key_bytes;
> +}
> +
> +

generally QEMU uses snake_case_names; please spell as "master_key_len".

>  /*
>   * Given a key slot, and user password, this will attempt to unlock
>   * the master encryption key from the key slot.
> @@ -410,21 +430,15 @@ qcrypto_block_luks_essiv_cipher(QCryptoCipherAlgorithm cipher,
>   */
>  static int
>  qcrypto_block_luks_load_key(QCryptoBlock *block,
> -                            QCryptoBlockLUKSKeySlot *slot,
> +                            uint slot_idx,
>                              const char *password,
> -                            QCryptoCipherAlgorithm cipheralg,
> -                            QCryptoCipherMode ciphermode,
> -                            QCryptoHashAlgorithm hash,
> -                            QCryptoIVGenAlgorithm ivalg,
> -                            QCryptoCipherAlgorithm ivcipheralg,
> -                            QCryptoHashAlgorithm ivhash,
>                              uint8_t *masterkey,
> -                            size_t masterkeylen,
>                              QCryptoBlockReadFunc readfunc,
>                              void *opaque,
>                              Error **errp)
>  {
>      QCryptoBlockLUKS *luks = block->opaque;
> +    QCryptoBlockLUKSKeySlot *slot = &luks->header.key_slots[slot_idx];
>      uint8_t *splitkey;
>      size_t splitkeylen;
>      uint8_t *possiblekey;
> @@ -439,9 +453,9 @@ qcrypto_block_luks_load_key(QCryptoBlock *block,
>          return 0;
>      }
>  
> -    splitkeylen = masterkeylen * slot->stripes;
> +    splitkeylen = masterkeylen(luks) * slot->stripes;
>      splitkey = g_new0(uint8_t, splitkeylen);
> -    possiblekey = g_new0(uint8_t, masterkeylen);
> +    possiblekey = g_new0(uint8_t, masterkeylen(luks));
>  
>      /*
>       * The user password is used to generate a (possible)
> @@ -450,11 +464,11 @@ qcrypto_block_luks_load_key(QCryptoBlock *block,
>       * the key is correct and validate the results of
>       * decryption later.
>       */
> -    if (qcrypto_pbkdf2(hash,
> +    if (qcrypto_pbkdf2(luks->hash_alg,
>                         (const uint8_t *)password, strlen(password),
>                         slot->salt, QCRYPTO_BLOCK_LUKS_SALT_LEN,
>                         slot->iterations,
> -                       possiblekey, masterkeylen,
> +                       possiblekey, masterkeylen(luks),
>                         errp) < 0) {
>          goto cleanup;
>      }
> @@ -478,19 +492,19 @@ qcrypto_block_luks_load_key(QCryptoBlock *block,
>  
>      /* Setup the cipher/ivgen that we'll use to try to decrypt
>       * the split master key material */
> -    cipher = qcrypto_cipher_new(cipheralg, ciphermode,
> -                                possiblekey, masterkeylen,
> +    cipher = qcrypto_cipher_new(luks->cipher_alg, luks->cipher_mode,
> +                                possiblekey, masterkeylen(luks),
>                                  errp);
>      if (!cipher) {
>          goto cleanup;
>      }
>  
> -    niv = qcrypto_cipher_get_iv_len(cipheralg,
> -                                    ciphermode);
> -    ivgen = qcrypto_ivgen_new(ivalg,
> -                              ivcipheralg,
> -                              ivhash,
> -                              possiblekey, masterkeylen,
> +    niv = qcrypto_cipher_get_iv_len(luks->cipher_alg,
> +                                    luks->cipher_mode);
> +    ivgen = qcrypto_ivgen_new(luks->ivgen_alg,
> +                              luks->ivgen_cipher_alg,
> +                              luks->ivgen_hash_alg,
> +                              possiblekey, masterkeylen(luks),
>                                errp);
>      if (!ivgen) {
>          goto cleanup;
> @@ -519,8 +533,8 @@ qcrypto_block_luks_load_key(QCryptoBlock *block,
>       * Now we've decrypted the split master key, join
>       * it back together to get the actual master key.
>       */
> -    if (qcrypto_afsplit_decode(hash,
> -                               masterkeylen,
> +    if (qcrypto_afsplit_decode(luks->hash_alg,
> +                               masterkeylen(luks),
>                                 slot->stripes,
>                                 splitkey,
>                                 masterkey,
> @@ -537,8 +551,8 @@ qcrypto_block_luks_load_key(QCryptoBlock *block,
>       * then comparing that to the hash stored in the key slot
>       * header
>       */
> -    if (qcrypto_pbkdf2(hash,
> -                       masterkey, masterkeylen,
> +    if (qcrypto_pbkdf2(luks->hash_alg,
> +                       masterkey, masterkeylen(luks),
>                         luks->header.master_key_salt,
>                         QCRYPTO_BLOCK_LUKS_SALT_LEN,
>                         luks->header.master_key_iterations,
> @@ -577,37 +591,19 @@ qcrypto_block_luks_load_key(QCryptoBlock *block,
>  static int
>  qcrypto_block_luks_find_key(QCryptoBlock *block,
>                              const char *password,
> -                            QCryptoCipherAlgorithm cipheralg,
> -                            QCryptoCipherMode ciphermode,
> -                            QCryptoHashAlgorithm hash,
> -                            QCryptoIVGenAlgorithm ivalg,
> -                            QCryptoCipherAlgorithm ivcipheralg,
> -                            QCryptoHashAlgorithm ivhash,
> -                            uint8_t **masterkey,
> -                            size_t *masterkeylen,
> +                            uint8_t *masterkey,
>                              QCryptoBlockReadFunc readfunc,
>                              void *opaque,
>                              Error **errp)
>  {
> -    QCryptoBlockLUKS *luks = block->opaque;
>      size_t i;
>      int rv;
>  
> -    *masterkey = g_new0(uint8_t, luks->header.key_bytes);
> -    *masterkeylen = luks->header.key_bytes;
> -
>      for (i = 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
>          rv = qcrypto_block_luks_load_key(block,
> -                                         &luks->header.key_slots[i],
> +                                         i,
>                                           password,
> -                                         cipheralg,
> -                                         ciphermode,
> -                                         hash,
> -                                         ivalg,
> -                                         ivcipheralg,
> -                                         ivhash,
> -                                         *masterkey,
> -                                         *masterkeylen,
> +                                         masterkey,
>                                           readfunc,
>                                           opaque,
>                                           errp);
> @@ -620,11 +616,7 @@ qcrypto_block_luks_find_key(QCryptoBlock *block,
>      }
>  
>      error_setg(errp, "Invalid password, cannot unlock any keyslot");
> -
>   error:
> -    g_free(*masterkey);
> -    *masterkey = NULL;
> -    *masterkeylen = 0;
>      return -1;
>  }
>  
> @@ -639,21 +631,15 @@ qcrypto_block_luks_open(QCryptoBlock *block,
>                          size_t n_threads,
>                          Error **errp)
>  {
> -    QCryptoBlockLUKS *luks;
> +    QCryptoBlockLUKS *luks = NULL;
>      Error *local_err = NULL;
>      int ret = 0;
>      size_t i;
>      ssize_t rv;
>      uint8_t *masterkey = NULL;
> -    size_t masterkeylen;
>      char *ivgen_name, *ivhash_name;
> -    QCryptoCipherMode ciphermode;
> -    QCryptoCipherAlgorithm cipheralg;
> -    QCryptoIVGenAlgorithm ivalg;
> -    QCryptoCipherAlgorithm ivcipheralg;
> -    QCryptoHashAlgorithm hash;
> -    QCryptoHashAlgorithm ivhash;
>      char *password = NULL;
> +    char *cipher_mode = NULL;
>  
>      if (!(flags & QCRYPTO_BLOCK_OPEN_NO_IO)) {
>          if (!options->u.luks.key_secret) {
> @@ -710,6 +696,8 @@ qcrypto_block_luks_open(QCryptoBlock *block,
>          goto fail;
>      }
>  
> +    cipher_mode = g_strdup(luks->header.cipher_mode);
> +
>      /*
>       * The cipher_mode header contains a string that we have
>       * to further parse, of the format
> @@ -718,7 +706,7 @@ qcrypto_block_luks_open(QCryptoBlock *block,
>       *
>       * eg  cbc-essiv:sha256, cbc-plain64
>       */
> -    ivgen_name = strchr(luks->header.cipher_mode, '-');
> +    ivgen_name = strchr(cipher_mode, '-');
>      if (!ivgen_name) {
>          ret = -EINVAL;
>          error_setg(errp, "Unexpected cipher mode string format %s",
> @@ -730,13 +718,13 @@ qcrypto_block_luks_open(QCryptoBlock *block,
>  
>      ivhash_name = strchr(ivgen_name, ':');
>      if (!ivhash_name) {
> -        ivhash = 0;
> +        luks->ivgen_hash_alg = 0;
>      } else {
>          *ivhash_name = '\0';
>          ivhash_name++;
>  
> -        ivhash = qcrypto_block_luks_hash_name_lookup(ivhash_name,
> -                                                     &local_err);
> +        luks->ivgen_hash_alg = qcrypto_block_luks_hash_name_lookup(ivhash_name,
> +                                                                   &local_err);
>          if (local_err) {
>              ret = -ENOTSUP;
>              error_propagate(errp, local_err);
> @@ -744,25 +732,27 @@ qcrypto_block_luks_open(QCryptoBlock *block,
>          }
>      }
>  
> -    ciphermode = qcrypto_block_luks_cipher_mode_lookup(luks->header.cipher_mode,
> -                                                       &local_err);
> +    luks->cipher_mode = qcrypto_block_luks_cipher_mode_lookup(cipher_mode,
> +                                                              &local_err);
>      if (local_err) {
>          ret = -ENOTSUP;
>          error_propagate(errp, local_err);
>          goto fail;
>      }
>  
> -    cipheralg = qcrypto_block_luks_cipher_name_lookup(luks->header.cipher_name,
> -                                                      ciphermode,
> -                                                      luks->header.key_bytes,
> -                                                      &local_err);
> +    luks->cipher_alg =
> +            qcrypto_block_luks_cipher_name_lookup(luks->header.cipher_name,
> +                                                  luks->cipher_mode,
> +                                                  luks->header.key_bytes,
> +                                                  &local_err);
>      if (local_err) {
>          ret = -ENOTSUP;
>          error_propagate(errp, local_err);
>          goto fail;
>      }
>  
> -    hash = qcrypto_block_luks_hash_name_lookup(luks->header.hash_spec,
> +    luks->hash_alg =
> +            qcrypto_block_luks_hash_name_lookup(luks->header.hash_spec,
>                                                 &local_err);
>      if (local_err) {
>          ret = -ENOTSUP;
> @@ -770,23 +760,24 @@ qcrypto_block_luks_open(QCryptoBlock *block,
>          goto fail;
>      }
>  
> -    ivalg = qcrypto_block_luks_ivgen_name_lookup(ivgen_name,
> -                                                 &local_err);
> +    luks->ivgen_alg = qcrypto_block_luks_ivgen_name_lookup(ivgen_name,
> +                                                           &local_err);
>      if (local_err) {
>          ret = -ENOTSUP;
>          error_propagate(errp, local_err);
>          goto fail;
>      }
>  
> -    if (ivalg == QCRYPTO_IVGEN_ALG_ESSIV) {
> +    if (luks->ivgen_alg == QCRYPTO_IVGEN_ALG_ESSIV) {
>          if (!ivhash_name) {
>              ret = -EINVAL;
>              error_setg(errp, "Missing IV generator hash specification");
>              goto fail;
>          }
> -        ivcipheralg = qcrypto_block_luks_essiv_cipher(cipheralg,
> -                                                      ivhash,
> -                                                      &local_err);
> +        luks->ivgen_cipher_alg =
> +                qcrypto_block_luks_essiv_cipher(luks->cipher_alg,
> +                                                luks->ivgen_hash_alg,
> +                                                &local_err);
>          if (local_err) {
>              ret = -ENOTSUP;
>              error_propagate(errp, local_err);
> @@ -800,21 +791,25 @@ qcrypto_block_luks_open(QCryptoBlock *block,
>           * ignore hash names with these ivgens rather than report
>           * an error about the invalid usage
>           */
> -        ivcipheralg = cipheralg;
> +        luks->ivgen_cipher_alg = luks->cipher_alg;
>      }
>  
> +
> +    g_free(cipher_mode);
> +    cipher_mode = NULL;
> +    ivgen_name = NULL;
> +    ivhash_name = NULL;
> +
>      if (!(flags & QCRYPTO_BLOCK_OPEN_NO_IO)) {
>          /* Try to find which key slot our password is valid for
>           * and unlock the master key from that slot.
>           */
> +
> +        masterkey = g_new0(uint8_t, masterkeylen(luks));
> +
>          if (qcrypto_block_luks_find_key(block,
>                                          password,
> -                                        cipheralg, ciphermode,
> -                                        hash,
> -                                        ivalg,
> -                                        ivcipheralg,
> -                                        ivhash,
> -                                        &masterkey, &masterkeylen,
> +                                        masterkey,
>                                          readfunc, opaque,
>                                          errp) < 0) {
>              ret = -EACCES;
> @@ -824,21 +819,24 @@ qcrypto_block_luks_open(QCryptoBlock *block,
>          /* We have a valid master key now, so can setup the
>           * block device payload decryption objects
>           */
> -        block->kdfhash = hash;
> -        block->niv = qcrypto_cipher_get_iv_len(cipheralg,
> -                                               ciphermode);
> -        block->ivgen = qcrypto_ivgen_new(ivalg,
> -                                         ivcipheralg,
> -                                         ivhash,
> -                                         masterkey, masterkeylen,
> +        block->kdfhash = luks->hash_alg;
> +        block->niv = qcrypto_cipher_get_iv_len(luks->cipher_alg,
> +                                               luks->cipher_mode);
> +
> +        block->ivgen = qcrypto_ivgen_new(luks->ivgen_alg,
> +                                         luks->ivgen_cipher_alg,
> +                                         luks->ivgen_hash_alg,
> +                                         masterkey, masterkeylen(luks),
>                                           errp);
>          if (!block->ivgen) {
>              ret = -ENOTSUP;
>              goto fail;
>          }
>  
> -        ret = qcrypto_block_init_cipher(block, cipheralg, ciphermode,
> -                                        masterkey, masterkeylen, n_threads,
> +        ret = qcrypto_block_init_cipher(block, luks->cipher_alg,
> +                                        luks->cipher_mode,
> +                                        masterkey, masterkeylen(luks),
> +                                        n_threads,
>                                          errp);
>          if (ret < 0) {
>              ret = -ENOTSUP;
> @@ -850,12 +848,6 @@ qcrypto_block_luks_open(QCryptoBlock *block,
>      block->payload_offset = luks->header.payload_offset *
>          block->sector_size;
>  
> -    luks->cipher_alg = cipheralg;
> -    luks->cipher_mode = ciphermode;
> -    luks->ivgen_alg = ivalg;
> -    luks->ivgen_hash_alg = ivhash;
> -    luks->hash_alg = hash;
> -
>      g_free(masterkey);
>      g_free(password);
>  
> @@ -910,7 +902,7 @@ qcrypto_block_luks_create(QCryptoBlock *block,
>  
>      memcpy(&luks_opts, &options->u.luks, sizeof(luks_opts));
>      if (!luks_opts.has_iter_time) {
> -        luks_opts.iter_time = 2000;
> +        luks_opts.iter_time = QCRYPTO_BLOCK_LUKS_DEFAULT_ITER_TIME;
>      }
>      if (!luks_opts.has_cipher_alg) {
>          luks_opts.cipher_alg = QCRYPTO_CIPHER_ALG_AES_256;
> @@ -930,6 +922,17 @@ qcrypto_block_luks_create(QCryptoBlock *block,
>              luks_opts.has_ivgen_hash_alg = true;
>          }
>      }
> +
> +    luks = g_new0(QCryptoBlockLUKS, 1);
> +    block->opaque = luks;
> +
> +    luks->cipher_alg = luks_opts.cipher_alg;
> +    luks->cipher_mode = luks_opts.cipher_mode;
> +    luks->ivgen_alg = luks_opts.ivgen_alg;
> +    luks->ivgen_hash_alg = luks_opts.ivgen_hash_alg;
> +    luks->hash_alg = luks_opts.hash_alg;
> +
> +
>      /* Note we're allowing ivgen_hash_alg to be set even for
>       * non-essiv iv generators that don't need a hash. It will
>       * be silently ignored, for compatibility with dm-crypt */
> @@ -944,8 +947,6 @@ qcrypto_block_luks_create(QCryptoBlock *block,
>          return -1;
>      }
>  
> -    luks = g_new0(QCryptoBlockLUKS, 1);
> -    block->opaque = luks;
>  
>      memcpy(luks->header.magic, qcrypto_block_luks_magic,
>             QCRYPTO_BLOCK_LUKS_MAGIC_LEN);
> @@ -1003,6 +1004,8 @@ qcrypto_block_luks_create(QCryptoBlock *block,
>          ivcipheralg = luks_opts.cipher_alg;
>      }
>  
> +    luks->ivgen_cipher_alg = ivcipheralg;
> +
>      strcpy(luks->header.cipher_name, cipher_alg);
>      strcpy(luks->header.cipher_mode, cipher_mode_spec);
>      strcpy(luks->header.hash_spec, hash_alg);
> @@ -1304,12 +1307,6 @@ qcrypto_block_luks_create(QCryptoBlock *block,
>          goto error;
>      }
>  
> -    luks->cipher_alg = luks_opts.cipher_alg;
> -    luks->cipher_mode = luks_opts.cipher_mode;
> -    luks->ivgen_alg = luks_opts.ivgen_alg;
> -    luks->ivgen_hash_alg = luks_opts.ivgen_hash_alg;
> -    luks->hash_alg = luks_opts.hash_alg;
> -
>      memset(masterkey, 0, luks->header.key_bytes);
>      g_free(masterkey);
>      memset(slotkey, 0, luks->header.key_bytes);
> 

