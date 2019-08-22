Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E2FC3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 10:39:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 691F3205ED
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 10:39:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 691F3205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0kUn-0008Me-J3
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 06:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40400)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i0kU1-0007ls-5H
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:38:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i0kTz-0006vi-RJ
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:38:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40228)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1i0kTw-0006tK-Om; Thu, 22 Aug 2019 06:38:17 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 000AA30860C1;
 Thu, 22 Aug 2019 10:38:15 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3051D10016E8;
 Thu, 22 Aug 2019 10:38:12 +0000 (UTC)
Date: Thu, 22 Aug 2019 11:38:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Message-ID: <20190822103810.GH3267@redhat.com>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <20190814202219.1870-4-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190814202219.1870-4-mlevitsk@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Thu, 22 Aug 2019 10:38:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 03/13] qcrypto-luks: refactoring: extract
 load/store/check/parse header functions
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

On Wed, Aug 14, 2019 at 11:22:09PM +0300, Maxim Levitsky wrote:
> With upcoming key management, the header will
> need to be stored after the image is created.
> 
> Extracting load header isn't strictly needed, but
> do this anyway for the symmetry.
> 
> Also I extracted a function that does basic sanity
> checks on the just read header, and a function
> which parses all the crypto format to make the
> code a bit more readable, plus now the code
> doesn't destruct the in-header cipher-mode string,
> so that the header now can be stored many times,
> which is needed for the key management.
> 
> Also this allows to contain the endianess conversions
> in these functions alone
> 
> The header is no longer endian swapped in place,
> to prevent (mostly theoretical races I think)
> races where someone could see the header in the
> process of beeing byteswapped.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  crypto/block-luks.c | 756 ++++++++++++++++++++++++++------------------
>  1 file changed, 440 insertions(+), 316 deletions(-)

>      if (!(flags & QCRYPTO_BLOCK_OPEN_NO_IO)) {
>          /* Try to find which key slot our password is valid for
>           * and unlock the master key from that slot.
>           */
> -
>          masterkey = g_new0(uint8_t, masterkeylen(luks));
>  
>          if (qcrypto_block_luks_find_key(block,
> @@ -845,12 +1132,10 @@ qcrypto_block_luks_open(QCryptoBlock *block,
>      }
>  
>      block->sector_size = QCRYPTO_BLOCK_LUKS_SECTOR_SIZE;
> -    block->payload_offset = luks->header.payload_offset *
> -        block->sector_size;
> +    block->payload_offset = luks->header.payload_offset * block->sector_size;
>  
>      g_free(masterkey);
>      g_free(password);
> -
>      return 0;

Smoe unrelated whitespace changes here.


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
> -    }
> +     }

Indent is off by 1


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

