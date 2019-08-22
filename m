Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71016C3A5A2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 11:07:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49E9C22CE3
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 11:07:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49E9C22CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0kwF-0006Ns-I5
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 07:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49800)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i0ktn-0003L0-Jq
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:05:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i0ktm-0005vZ-6U
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:04:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37776)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1i0ktj-0005rr-6b; Thu, 22 Aug 2019 07:04:55 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8834A300180E;
 Thu, 22 Aug 2019 11:04:54 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DBEA01001B17;
 Thu, 22 Aug 2019 11:04:50 +0000 (UTC)
Date: Thu, 22 Aug 2019 12:04:48 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Message-ID: <20190822110448.GK3267@redhat.com>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <20190814202219.1870-7-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190814202219.1870-7-mlevitsk@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 22 Aug 2019 11:04:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 06/13] qcrypto-luks: implement more
 rigorous header checking
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

On Wed, Aug 14, 2019 at 11:22:12PM +0300, Maxim Levitsky wrote:
> Check that keyslots don't overlap with the data,
> and check that keyslots don't overlap with each other.
> (this is done using naive O(n^2) nested loops,
> but since there are just 8 keyslots, this doens't really matter.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  crypto/block-luks.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/crypto/block-luks.c b/crypto/block-luks.c
> index 336e633df4..1997e92fe1 100644
> --- a/crypto/block-luks.c
> +++ b/crypto/block-luks.c
> @@ -551,6 +551,8 @@ static int
>  qcrypto_block_luks_check_header(QCryptoBlockLUKS *luks, Error **errp)
>  {
>      int ret;
> +    int i, j;
> +
>  
>      if (memcmp(luks->header.magic, qcrypto_block_luks_magic,
>                 QCRYPTO_BLOCK_LUKS_MAGIC_LEN) != 0) {
> @@ -566,6 +568,46 @@ qcrypto_block_luks_check_header(QCryptoBlockLUKS *luks, Error **errp)
>          goto fail;
>      }
>  
> +    /* Check all keyslots for corruption  */
> +    for (i = 0 ; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS ; i++) {
> +
> +        QCryptoBlockLUKSKeySlot *slot1 = &luks->header.key_slots[i];
> +        uint start1 = slot1->key_offset;
> +        uint len1 = splitkeylen_sectors(luks, slot1->stripes);

Using 'uint' is not normal QEMU style.

Either use 'unsigned int'  or if a specific size is needed
then one of the 'guintNN' types from glib.

This applies elsewhere in this patch series too, but
I'll only comment here & let you find the other cases.

> +
> +        if (slot1->stripes == 0 ||
> +                (slot1->active != QCRYPTO_BLOCK_LUKS_KEY_SLOT_DISABLED &&
> +                slot1->active != QCRYPTO_BLOCK_LUKS_KEY_SLOT_ENABLED)) {
> +

Redundant blank line

> +            error_setg(errp, "Keyslot %i is corrupted", i);

I'd do a separate check for stripes and active fields, and then give a
specific error message for each. That way if this does ever trigger
in practice will immediately understand which check failed.

Also using '%d' rather than '%i' is more common convention


> +            ret = -EINVAL;
> +            goto fail;
> +        }
> +
> +        if (start1 + len1 > luks->header.payload_offset) {
> +            error_setg(errp,
> +                       "Keyslot %i is overlapping with the encrypted payload",
> +                       i);
> +            ret = -EINVAL;
> +            goto fail;
> +        }
> +
> +        for (j = i + 1 ; j < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS ; j++) {
> +

Redundant blank

> +            QCryptoBlockLUKSKeySlot *slot2 = &luks->header.key_slots[j];
> +            uint start2 = slot2->key_offset;
> +            uint len2 = splitkeylen_sectors(luks, slot2->stripes);
> +
> +            if (start1 + len1 > start2 && start2 + len2 > start1) {
> +                error_setg(errp,
> +                           "Keyslots %i and %i are overlapping in the header",

%d

> +                           i, j);
> +                ret = -EINVAL;
> +                goto fail;
> +            }
> +        }
> +
> +    }
>      return 0;
>  fail:
>      return ret;
> -- 
> 2.17.2
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

