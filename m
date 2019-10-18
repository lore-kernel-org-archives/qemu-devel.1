Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A972CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 12:44:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5779120820
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 12:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5779120820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLRc5-0000Ir-FK
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 08:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43125)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iLRat-0007rl-I5
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 08:43:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iLRas-0006ka-8z
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 08:42:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47663)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iLRas-0006jz-17
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 08:42:58 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3259019D04A;
 Fri, 18 Oct 2019 12:42:57 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-198.ams2.redhat.com
 [10.36.117.198])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8952660BF4;
 Fri, 18 Oct 2019 12:42:53 +0000 (UTC)
Date: Fri, 18 Oct 2019 14:42:52 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v7 3/4] crypto.c: cleanup created file when
 block_crypto_co_create_opts_luks fails
Message-ID: <20191018124252.GF6122@localhost.localdomain>
References: <20190903135708.21624-1-danielhb413@gmail.com>
 <20190903135708.21624-4-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903135708.21624-4-danielhb413@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Fri, 18 Oct 2019 12:42:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Srikanth Aithal <bssrikanth@in.ibm.com>, jsnow@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 03.09.2019 um 15:57 hat Daniel Henrique Barboza geschrieben:
> When using a non-UTF8 secret to create a volume using qemu-img, the
> following error happens:
> 
> $ qemu-img create -f luks --object secret,id=vol_1_encrypt0,file=vol_resize_pool.vol_1.secret.qzVQrI -o key-secret=vol_1_encrypt0 /var/tmp/pool_target/vol_1 10240K
> 
> Formatting '/var/tmp/pool_target/vol_1', fmt=luks size=10485760 key-secret=vol_1_encrypt0
> qemu-img: /var/tmp/pool_target/vol_1: Data from secret vol_1_encrypt0 is not valid UTF-8
> 
> However, the created file '/var/tmp/pool_target/vol_1' is left behind in the
> file system after the failure. This behavior can be observed when creating
> the volume using Libvirt, via 'virsh vol-create', and then getting "volume
> target path already exist" errors when trying to re-create the volume.
> 
> The volume file is created inside block_crypto_co_create_opts_luks(), in
> block/crypto.c. If the bdrv_create_file() call is successful but any
> succeeding step fails*, the existing 'fail' label does not take into
> account the created file, leaving it behind.
> 
> This patch changes block_crypto_co_create_opts_luks() to delete
> 'filename' in case of failure. A failure in this point means that
> the volume is now truncated/corrupted, so even if 'filename' was an
> existing volume before calling qemu-img, it is now unusable. Deleting
> the file it is not much worse than leaving it in the filesystem in
> this scenario, and we don't have to deal with checking the file
> pre-existence in the code.
> 
> * in our case, block_crypto_co_create_generic calls qcrypto_block_create,
> which calls qcrypto_block_luks_create, and this function fails when
> calling qcrypto_secret_lookup_as_utf8.
> 
> Reported-by: Srikanth Aithal <bssrikanth@in.ibm.com>
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---
>  block/crypto.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/block/crypto.c b/block/crypto.c
> index 7eb698774e..29496d247e 100644
> --- a/block/crypto.c
> +++ b/block/crypto.c
> @@ -30,6 +30,7 @@
>  #include "qapi/error.h"
>  #include "qemu/module.h"
>  #include "qemu/option.h"
> +#include "qemu/cutils.h"
>  #include "crypto.h"
>  
>  typedef struct BlockCrypto BlockCrypto;
> @@ -596,9 +597,30 @@ static int coroutine_fn block_crypto_co_create_opts_luks(const char *filename,
>  
>      ret = 0;
>  fail:
> +    /*
> +     * If an error occurred, delete 'filename'. Even if the file existed
> +     * beforehand, it has been truncated and corrupted in the process.
> +     */
> +    if (ret) {

if (ret && bs)

There are error paths before creating and opening the image, and trying
to delete bs can't succeed then.

> +        Error *local_err;

This shadows the function-scope local_err. Worse, it isn't even
initialised to NULL here.

> +        int r_del = bdrv_delete_file(bs, &local_err);
> +        /*
> +         * ENOTSUP will happen if the block driver doesn't support
> +         * 'bdrv_co_delete_file'. ENOENT will be fired by
> +         * 'raw_co_delete_file' if the file doesn't exist. Both are
> +         * predictable (we're not verifying if the driver supports
> +         * file deletion or if the file was created), thus we
> +         * shouldn't report this back to the user.
> +         */

When you check bs above, you don't have to worry about -ENOENT any more
here.

> +        if ((r_del < 0) && (r_del != -ENOTSUP) && (r_del != -ENOENT)) {
> +            error_reportf_err(local_err, "%s: ", bs->filename);

Hm... This will end up on stderr instead of being reported as an error.
Okay because we already have an error about creating the image, which is
more important to report.

However, don't prepend bs->filename here. You already included the
filename in the file-posix driver, so you'd print the filename twice in
the same message.

> +        }
> +    }
> +
>      bdrv_unref(bs);
>      qapi_free_QCryptoBlockCreateOptions(create_opts);
>      qobject_unref(cryptoopts);
> +
>      return ret;
>  }

This additional empty line looks unrelated.

Kevin

