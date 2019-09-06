Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECBAC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 14:05:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34C8520854
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 14:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34C8520854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6Ern-0005l1-BE
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 10:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47173)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i6Eqv-0005DI-TQ
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 10:04:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i6Equ-0003Y9-EY
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 10:04:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34405)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1i6Eqm-0003NS-HM; Fri, 06 Sep 2019 10:04:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CAC82C08E2A3;
 Fri,  6 Sep 2019 14:04:31 +0000 (UTC)
Received: from redhat.com (ovpn-112-50.ams2.redhat.com [10.36.112.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EF6CF5C1D8;
 Fri,  6 Sep 2019 14:04:26 +0000 (UTC)
Date: Fri, 6 Sep 2019 15:04:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Message-ID: <20190906140423.GN5119@redhat.com>
References: <20190830205608.18192-1-mlevitsk@redhat.com>
 <20190830205608.18192-6-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190830205608.18192-6-mlevitsk@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 06 Sep 2019 14:04:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 05/10] block/crypto: implement the
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

On Fri, Aug 30, 2019 at 11:56:03PM +0300, Maxim Levitsky wrote:
> This implements the encryption key management
> using the generic code in qcrypto layer
> (currently only for qemu-img amend)
> 
> This code adds another 'write_func' because the initialization
> write_func works directly on the underlying file,
> because during the creation, there is no open instance
> of the luks driver, but during regular use, we have it,
> and should use it instead.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  block/crypto.c | 106 +++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 103 insertions(+), 3 deletions(-)
> 
> diff --git a/block/crypto.c b/block/crypto.c
> index a6a3e1f1d8..dbd95a99ba 100644
> --- a/block/crypto.c
> +++ b/block/crypto.c
> @@ -36,6 +36,7 @@ typedef struct BlockCrypto BlockCrypto;
>  
>  struct BlockCrypto {
>      QCryptoBlock *block;
> +    bool updating_keys;
>  };
>  
>  
> @@ -70,6 +71,24 @@ static ssize_t block_crypto_read_func(QCryptoBlock *block,
>      return ret;
>  }
>  
> +static ssize_t block_crypto_write_func(QCryptoBlock *block,
> +                                      size_t offset,
> +                                      const uint8_t *buf,
> +                                      size_t buflen,
> +                                      void *opaque,
> +                                      Error **errp)

Indent off-by-1 - align with param on the first line

> +{
> +    BlockDriverState *bs = opaque;
> +    ssize_t ret;
> +
> +    ret = bdrv_pwrite(bs->file, offset, buf, buflen);
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret, "Could not write encryption header");
> +        return ret;
> +    }
> +    return ret;
> +}
> +
>  
>  struct BlockCryptoCreateData {
>      BlockBackend *blk;
> @@ -647,6 +666,88 @@ block_crypto_get_specific_info_luks(BlockDriverState *bs, Error **errp)
>      return spec_info;
>  }
>  
> +
> +static int
> +block_crypto_amend_options(BlockDriverState *bs,
> +                           QemuOpts *opts,
> +                           BlockDriverAmendStatusCB *status_cb,
> +                           void *cb_opaque,
> +                           bool force,
> +                           Error **errp)
> +{
> +    BlockCrypto *crypto = bs->opaque;
> +    QDict *cryptoopts = NULL;
> +    QCryptoBlockCreateOptions *amend_options = NULL;
> +    int ret;
> +
> +    assert(crypto);
> +    assert(crypto->block);
> +
> +    crypto->updating_keys = true;
> +
> +    ret = bdrv_child_refresh_perms(bs, bs->file, errp);
> +    if (ret) {

I can;'t remember - does this need to be "ret < 0" or
does refresh_perms return positive errnos ?

> +        goto cleanup;
> +    }
> +
> +    cryptoopts = qemu_opts_to_qdict_filtered(opts, NULL,
> +                                             &block_crypto_create_opts_luks,
> +                                             true);
> +
> +    qdict_put_str(cryptoopts, "format", "luks");
> +    amend_options = block_crypto_create_opts_init(cryptoopts, errp);
> +    if (!amend_options) {
> +        ret = -EINVAL;
> +        goto cleanup;
> +    }
> +
> +    ret = qcrypto_block_amend_options(crypto->block,
> +                                      block_crypto_read_func,
> +                                      block_crypto_write_func,
> +                                      bs,
> +                                      amend_options,
> +                                      force,
> +                                      errp);
> +cleanup:
> +    crypto->updating_keys = false;
> +    bdrv_child_refresh_perms(bs, bs->file, errp);
> +    qapi_free_QCryptoBlockCreateOptions(amend_options);
> +    qobject_unref(cryptoopts);
> +    return ret;
> +}
> +
> +
> +static void
> +block_crypto_child_perms(BlockDriverState *bs, BdrvChild *c,
> +                         const BdrvChildRole *role,
> +                         BlockReopenQueue *reopen_queue,
> +                         uint64_t perm, uint64_t shared,
> +                         uint64_t *nperm, uint64_t *nshared)
> +{
> +
> +    BlockCrypto *crypto = bs->opaque;
> +
> +    /*
> +     * This driver doesn't modify LUKS metadata except
> +     * when updating the encryption slots.
> +     * Allow share-rw=on as a special case.
> +     *
> +     * Encryption update will set the crypto->updating_keys
> +     * during that period and refresh permissions
> +     *
> +     * */
> +
> +    if (crypto->updating_keys) {
> +        /*need exclusive write access for header update  */
> +        perm |= BLK_PERM_WRITE;
> +        shared &= ~BLK_PERM_WRITE;
> +    }
> +
> +    bdrv_filter_default_perms(bs, c, role, reopen_queue,
> +            perm, shared, nperm, nshared);
> +}
> +
> +
>  static const char *const block_crypto_strong_runtime_opts[] = {
>      BLOCK_CRYPTO_OPT_LUKS_KEY_SECRET,
>  
> @@ -659,9 +760,7 @@ static BlockDriver bdrv_crypto_luks = {
>      .bdrv_probe         = block_crypto_probe_luks,
>      .bdrv_open          = block_crypto_open_luks,
>      .bdrv_close         = block_crypto_close,
> -    /* This driver doesn't modify LUKS metadata except when creating image.
> -     * Allow share-rw=on as a special case. */
> -    .bdrv_child_perm    = bdrv_filter_default_perms,
> +    .bdrv_child_perm    = block_crypto_child_perms,
>      .bdrv_co_create     = block_crypto_co_create_luks,
>      .bdrv_co_create_opts = block_crypto_co_create_opts_luks,
>      .bdrv_co_truncate   = block_crypto_co_truncate,
> @@ -674,6 +773,7 @@ static BlockDriver bdrv_crypto_luks = {
>      .bdrv_getlength     = block_crypto_getlength,
>      .bdrv_get_info      = block_crypto_get_info_luks,
>      .bdrv_get_specific_info = block_crypto_get_specific_info_luks,
> +    .bdrv_amend_options = block_crypto_amend_options,
>  
>      .strong_runtime_opts = block_crypto_strong_runtime_opts,
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

