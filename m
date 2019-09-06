Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406C9C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 14:07:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1888C20854
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 14:07:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1888C20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6Etm-00071R-AY
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 10:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i6Et0-0006Vn-7P
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 10:06:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i6Esy-0005El-W5
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 10:06:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54828)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1i6Esv-0005Bj-Pw; Fri, 06 Sep 2019 10:06:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 161D330860BA;
 Fri,  6 Sep 2019 14:06:45 +0000 (UTC)
Received: from redhat.com (ovpn-112-50.ams2.redhat.com [10.36.112.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 06E765D9CA;
 Fri,  6 Sep 2019 14:06:36 +0000 (UTC)
Date: Fri, 6 Sep 2019 15:06:34 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Message-ID: <20190906140634.GO5119@redhat.com>
References: <20190830205608.18192-1-mlevitsk@redhat.com>
 <20190830205608.18192-7-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190830205608.18192-7-mlevitsk@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Fri, 06 Sep 2019 14:06:45 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 06/10] qcow2: implement crypto amend options
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

On Fri, Aug 30, 2019 at 11:56:04PM +0300, Maxim Levitsky wrote:
> ---
>  block/qcow2.c | 79 ++++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 63 insertions(+), 16 deletions(-)
> 

> @@ -4888,9 +4899,22 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
>                  return -ENOTSUP;
>              }
>          } else if (g_str_has_prefix(desc->name, "encrypt.")) {
> -            error_setg(errp,
> -                       "Changing the encryption parameters is not supported");
> -            return -ENOTSUP;
> +
> +            if (!s->crypto) {
> +                error_setg(errp,
> +                           "Can't amend encryption options - encryption not supported");
> +                return -ENOTSUP;
> +
> +            }

Perhaps  ' - encryption not present', and -EINVAL

> +
> +            if (s->crypt_method_header != QCOW_CRYPT_LUKS) {
> +                error_setg(errp,
> +                           "Only LUKS encryption options can be amended");
> +                return -ENOTSUP;
> +            }
> +
> +            encryption_update = true;
> +
>          } else if (!strcmp(desc->name, BLOCK_OPT_CLUSTER_SIZE)) {
>              cluster_size = qemu_opt_get_size(opts, BLOCK_OPT_CLUSTER_SIZE,
>                                               cluster_size);
> @@ -4927,7 +4951,7 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
>                                   "images");
>                  return -EINVAL;
>              }
> -        } else {
> +        } else  {

Accidental change

>              /* if this point is reached, this probably means a new option was
>               * added without having it covered here */
>              abort();
> @@ -4940,7 +4964,8 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
>          .original_status_cb = status_cb,
>          .original_cb_opaque = cb_opaque,
>          .total_operations = (new_version < old_version)
> -                          + (s->refcount_bits != refcount_bits)
> +                          + (s->refcount_bits != refcount_bits) +
> +                          (encryption_update == true)
>      };
>  
>      /* Upgrade first (some features may require compat=1.1) */
> @@ -4954,6 +4979,28 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
>          }
>      }
>  
> +    if (encryption_update) {
> +

Redundant blank line

> +        QCryptoBlockCreateOptions *cryptoopts;
> +
> +        cryptoopts = qcow2_extract_crypto_create_opts(opts, "luks", errp);
> +        if (!cryptoopts)
> +            return -EINVAL;
> +
> +        helper_cb_info.current_operation = QCOW2_UPDATING_ENCRYPTION;
> +
> +        ret = qcrypto_block_amend_options(s->crypto,
> +                                          qcow2_crypto_hdr_read_func,
> +                                          qcow2_crypto_hdr_write_func,
> +                                          bs,
> +                                          cryptoopts,
> +                                          force,
> +                                          errp);
> +        if (ret) {

Check  ret < 0

> +            return ret;
> +        }
> +    }
> +

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

