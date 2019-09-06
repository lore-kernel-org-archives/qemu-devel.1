Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66770C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 13:36:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CDD620650
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 13:36:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CDD620650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6EPG-0007qL-Ce
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 09:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39143)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i6EOW-0007Bz-SA
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 09:35:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i6EOV-0000q4-IY
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 09:35:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38604)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1i6EOR-0000mr-AO; Fri, 06 Sep 2019 09:35:15 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3661FA28732;
 Fri,  6 Sep 2019 13:35:14 +0000 (UTC)
Received: from redhat.com (ovpn-112-50.ams2.redhat.com [10.36.112.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3BE0160BAD;
 Fri,  6 Sep 2019 13:34:57 +0000 (UTC)
Date: Fri, 6 Sep 2019 14:34:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Message-ID: <20190906133454.GI5119@redhat.com>
References: <20190826135103.22410-1-mlevitsk@redhat.com>
 <20190826135103.22410-14-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190826135103.22410-14-mlevitsk@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Fri, 06 Sep 2019 13:35:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 13/13] qcrypto-luks: implement more
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

On Mon, Aug 26, 2019 at 04:51:03PM +0300, Maxim Levitsky wrote:
> Check that keyslots don't overlap with the data,
> and check that keyslots don't overlap with each other.
> (this is done using naive O(n^2) nested loops,
> but since there are just 8 keyslots, this doesn't really matter.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  crypto/block-luks.c | 46 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 44 insertions(+), 2 deletions(-)
> 
> diff --git a/crypto/block-luks.c b/crypto/block-luks.c
> index db0fb764b4..fdf4c41f8a 100644
> --- a/crypto/block-luks.c
> +++ b/crypto/block-luks.c
> @@ -541,12 +541,12 @@ fail:
>  static int
>  qcrypto_block_luks_check_header(const QCryptoBlockLUKS *luks, Error **errp)
>  {
> -    int ret;
> +    int ret = -EINVAL;

As before, no need to use errnos, just return -1 immediately.

> +    size_t i, j;
>  
>      if (memcmp(luks->header.magic, qcrypto_block_luks_magic,
>                 QCRYPTO_BLOCK_LUKS_MAGIC_LEN) != 0) {
>          error_setg(errp, "Volume is not in LUKS format");
> -        ret = -EINVAL;
>          goto fail;
>      }
>  
> @@ -557,6 +557,48 @@ qcrypto_block_luks_check_header(const QCryptoBlockLUKS *luks, Error **errp)
>          goto fail;
>      }
>  
> +    /* Check all keyslots for corruption  */
> +    for (i = 0 ; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS ; i++) {
> +
> +        const QCryptoBlockLUKSKeySlot *slot1 = &luks->header.key_slots[i];
> +        unsigned int start1 = slot1->key_offset_sector;
> +        unsigned int len1 =
> +            qcrypto_block_luks_splitkeylen_sectors(luks, slot1->stripes);
> +
> +        if (slot1->stripes == 0) {
> +            error_setg(errp, "Keyslot %zu is corrupted (stripes == 0)", i);
> +            goto fail;
> +        }

How about checking stripes != QCRYPTO_BLOCK_LUKS_STRIPES because
AFAIR, you're required to use 4k stripes in luks v1.

Also how about  checking    iters >= MIN_SLOT_KEY_ITERS

> +
> +        if (slot1->active != QCRYPTO_BLOCK_LUKS_KEY_SLOT_DISABLED &&
> +                slot1->active != QCRYPTO_BLOCK_LUKS_KEY_SLOT_ENABLED) {

Align the two lines with (

> +            error_setg(errp,
> +                       "Keyslot %zu state (active/disable) is corrupted", i);
> +            goto fail;
> +        }
> +
> +        if (start1 + len1 > luks->header.payload_offset_sector) {
> +            error_setg(errp,
> +                       "Keyslot %zu is overlapping with the encrypted payload",
> +                       i);
> +            goto fail;
> +        }
> +
> +        for (j = i + 1 ; j < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS ; j++) {
> +            const QCryptoBlockLUKSKeySlot *slot2 = &luks->header.key_slots[j];
> +            unsigned int start2 = slot2->key_offset_sector;
> +            unsigned int len2 =
> +                qcrypto_block_luks_splitkeylen_sectors(luks, slot2->stripes);
> +
> +            if (start1 + len1 > start2 && start2 + len2 > start1) {
> +                error_setg(errp,
> +                           "Keyslots %zu and %zu are overlapping in the header",
> +                           i, j);
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

