Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94FDC3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 11:17:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD1E42339F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 11:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD1E42339F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0l5v-0004mE-R7
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 07:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53543)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i0l4m-0003nn-A6
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:16:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i0l4k-00050I-N1
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:16:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33778)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1i0l4h-0004wl-Hp; Thu, 22 Aug 2019 07:16:15 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C2D0F69081;
 Thu, 22 Aug 2019 11:16:14 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E6D8160603;
 Thu, 22 Aug 2019 11:16:10 +0000 (UTC)
Date: Thu, 22 Aug 2019 12:16:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Message-ID: <20190822111608.GN3267@redhat.com>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <20190814202219.1870-9-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190814202219.1870-9-mlevitsk@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Thu, 22 Aug 2019 11:16:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 08/13] qcrypto: add the plumbing for
 encryption management
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

On Wed, Aug 14, 2019 at 11:22:14PM +0300, Maxim Levitsky wrote:
> This adds qcrypto_block_manage_encryption, which
>  is thin wrapper around manage_encryption of the crypto driver
>  which is also added
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  crypto/block.c         | 29 +++++++++++++++++++++++++++++
>  crypto/blockpriv.h     |  9 +++++++++
>  include/crypto/block.h | 27 +++++++++++++++++++++++++++
>  3 files changed, 65 insertions(+)
> 
> diff --git a/crypto/block.c b/crypto/block.c
> index ee96759f7d..5916e49aba 100644
> --- a/crypto/block.c
> +++ b/crypto/block.c
> @@ -20,6 +20,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
> +
>  #include "blockpriv.h"
>  #include "block-qcow.h"
>  #include "block-luks.h"
> @@ -282,6 +283,34 @@ void qcrypto_block_free(QCryptoBlock *block)
>  }
>  
>  
> +int qcrypto_block_setup_encryption(QCryptoBlock *block,
> +                                   QCryptoBlockReadFunc readfunc,
> +                                   QCryptoBlockWriteFunc writefunc,
> +                                   void *opaque,
> +                                   enum BlkSetupEncryptionAction action,
> +                                   QCryptoEncryptionSetupOptions *options,
> +                                   bool force,
> +                                   Error **errp)
> +{
> +    if (!block->driver->setup_encryption) {
> +        error_setg(errp,
> +                "Crypto format %s doesn't support management of encryption keys",
> +                QCryptoBlockFormat_str(block->format));
> +        return -1;
> +    }
> +
> +    return block->driver->setup_encryption(block,
> +                                           readfunc,
> +                                           writefunc,
> +                                           opaque,
> +                                           action,
> +                                           options,
> +                                           force,
> +                                           errp);
> +}
> +
> +
> +
>  typedef int (*QCryptoCipherEncDecFunc)(QCryptoCipher *cipher,
>                                          const void *in,
>                                          void *out,
> diff --git a/crypto/blockpriv.h b/crypto/blockpriv.h
> index 71c59cb542..804965dca3 100644
> --- a/crypto/blockpriv.h
> +++ b/crypto/blockpriv.h
> @@ -81,6 +81,15 @@ struct QCryptoBlockDriver {
>  
>      bool (*has_format)(const uint8_t *buf,
>                         size_t buflen);
> +
> +    int (*setup_encryption)(QCryptoBlock *block,
> +                            QCryptoBlockReadFunc readfunc,
> +                            QCryptoBlockWriteFunc writefunc,
> +                            void *opaque,
> +                            enum BlkSetupEncryptionAction action,
> +                            QCryptoEncryptionSetupOptions *options,
> +                            bool force,
> +                            Error **errp);
>  };
>  
>  
> diff --git a/include/crypto/block.h b/include/crypto/block.h
> index fe12899831..60d46e3efc 100644
> --- a/include/crypto/block.h
> +++ b/include/crypto/block.h
> @@ -23,6 +23,7 @@
>  
>  #include "crypto/cipher.h"
>  #include "crypto/ivgen.h"
> +#include "block/block.h"
>  
>  typedef struct QCryptoBlock QCryptoBlock;
>  
> @@ -268,4 +269,30 @@ uint64_t qcrypto_block_get_sector_size(QCryptoBlock *block);
>   */
>  void qcrypto_block_free(QCryptoBlock *block);
>  
> +
> +/**
> + * qcrypto_block_setup_encryption:
> + * @block: the block encryption object
> + *
> + * @readfunc: callback for reading data from the volume header
> + * @writefunc: callback for writing data to the volume header
> + * @opaque: data to pass to @readfunc and @writefunc
> + * @action: tell the driver the setup action (add/erase currently)
> + * @options: driver specific options, that specify
> + *           what encryption settings to manage
> + * @force: hint for the driver to allow unsafe operation
> + * @errp: error pointer
> + *
> + * Adds/Erases a new encryption key using @options

I'd prefer to see separate APIs for add + erase instead
of overloading. It'll lead to a clearer API from callers
POV to see exactly which parameters are for each action.

> + *
> + */
> +int qcrypto_block_setup_encryption(QCryptoBlock *block,
> +                                   QCryptoBlockReadFunc readfunc,
> +                                   QCryptoBlockWriteFunc writefunc,
> +                                   void *opaque,
> +                                   enum BlkSetupEncryptionAction action,
> +                                   QCryptoEncryptionSetupOptions *options,
> +                                   bool force,
> +                                   Error **errp);
> +

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

