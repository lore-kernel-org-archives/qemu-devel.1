Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E215FC04AB1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 07:55:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B77DA2086A
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 07:55:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B77DA2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52752 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ5oJ-0000MC-Vn
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 03:55:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hQ5nS-0008Lq-OP
	for qemu-devel@nongnu.org; Mon, 13 May 2019 03:54:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hQ5nR-0006Rn-M6
	for qemu-devel@nongnu.org; Mon, 13 May 2019 03:54:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35873)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hQ5nR-0006RM-Fe
	for qemu-devel@nongnu.org; Mon, 13 May 2019 03:54:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id o4so14060034wra.3
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 00:54:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=Y3bQn+2hFVism8P1rRj9tk66o7j27KMQJe52Wsh3QO8=;
	b=V2f6wIcrmv3hx8XtIthfjfUajk6sCGwQvWmns74B3naQaL8Yt868Jhg8mxuKPstfVl
	d0Mxc2HTyf8iLpBKLsVxBs34pBuMJKQgRDURIZXt0KHCEQyhnib7zyS3dkpASs/ecqGP
	//CJjiBu4UM/Ko+sre7+H7AR4DxBj4AMfBPCGonZz3yZIsxDg0Uma/thLjn4mKfXlBxa
	2T6jn7qHwcuTJ4kax/zv7VJwjWfUTH1f2R48RJgYjsf/AArsN+MVGnp3ykKKaX8/8ZnD
	dWfqU7gA6XHpudXocJzNoR6xHTBovhCSjRMQl7Vi636gQHPUukBddoxrpw/XCI+sgrWP
	C9Yg==
X-Gm-Message-State: APjAAAUWeHG8g2/OJVJQNdy4QQQ+QRCv+t16VoOlHcZCIiT+JXts/g5Z
	NE+3FpPaf/AE36yjYx/WoTYOgw==
X-Google-Smtp-Source: APXvYqypTx3b33kCZrv+aKXb8lyZ5dRO0Q1w6/CR6aHqVqW3iOU/K0pENBggvDtfXN+wnj7iWAlRZw==
X-Received: by 2002:adf:9221:: with SMTP id 30mr16943847wrj.110.1557734091186; 
	Mon, 13 May 2019 00:54:51 -0700 (PDT)
Received: from steredhat (host151-251-static.12-87-b.business.telecomitalia.it.
	[87.12.251.151]) by smtp.gmail.com with ESMTPSA id
	g127sm5211712wme.21.2019.05.13.00.54.49
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 13 May 2019 00:54:50 -0700 (PDT)
Date: Mon, 13 May 2019 09:54:47 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190513075447.5omkyml2b42xsrhj@steredhat>
References: <20190510151735.29687-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510151735.29687-1-eblake@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] nbd/server: Nicer spelling of
 max BLOCK_STATUS reply length
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
	"open list:Network Block Dev..." <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 10, 2019 at 10:17:35AM -0500, Eric Blake wrote:
> Commit 3d068aff (3.0) introduced NBD_MAX_BITMAP_EXTENTS as a limit on
> how large we would allow a reply to NBD_CMD_BLOCK_STATUS to grow when
> it is visiting a qemu:dirty-bitmap: context.  Later, commit fb7afc79
> (3.1) reused the constant to limit base:allocation context replies,
> although the name is now less appropriate in that situation.
> 
> Rename things, and improve the macro to use units.h for better
> legibility. Then reformat the comment to comply with checkpatch rules
> added in the meantime. No semantic change.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  nbd/server.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/nbd/server.c b/nbd/server.c
> index e21bd501dc6..2c49744fc43 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -21,15 +21,18 @@
>  #include "qapi/error.h"
>  #include "trace.h"
>  #include "nbd-internal.h"
> +#include "qemu/units.h"
> 
>  #define NBD_META_ID_BASE_ALLOCATION 0
>  #define NBD_META_ID_DIRTY_BITMAP 1
> 
> -/* NBD_MAX_BITMAP_EXTENTS: 1 mb of extents data. An empirical
> +/*
> + * NBD_MAX_BLOCK_STATUS_EXTENTS: 1 mb of extents data. An empirical

Since we are here, what about using MiB also in this comment block?

>   * constant. If an increase is needed, note that the NBD protocol
>   * recommends no larger than 32 mb, so that the client won't consider
> - * the reply as a denial of service attack. */
> -#define NBD_MAX_BITMAP_EXTENTS (0x100000 / 8)
> + * the reply as a denial of service attack.
> + */
> +#define NBD_MAX_BLOCK_STATUS_EXTENTS (1 * MiB / 8)
> 
>  static int system_errno_to_nbd_errno(int err)
>  {
> @@ -1958,7 +1961,7 @@ static int nbd_co_send_block_status(NBDClient *client, uint64_t handle,
>                                      Error **errp)
>  {
>      int ret;
> -    unsigned int nb_extents = dont_fragment ? 1 : NBD_MAX_BITMAP_EXTENTS;
> +    unsigned int nb_extents = dont_fragment ? 1 : NBD_MAX_BLOCK_STATUS_EXTENTS;
>      NBDExtent *extents = g_new(NBDExtent, nb_extents);
>      uint64_t final_length = length;
> 
> @@ -2043,7 +2046,7 @@ static int nbd_co_send_bitmap(NBDClient *client, uint64_t handle,
>                                uint32_t context_id, Error **errp)
>  {
>      int ret;
> -    unsigned int nb_extents = dont_fragment ? 1 : NBD_MAX_BITMAP_EXTENTS;
> +    unsigned int nb_extents = dont_fragment ? 1 : NBD_MAX_BLOCK_STATUS_EXTENTS;
>      NBDExtent *extents = g_new(NBDExtent, nb_extents);
>      uint64_t final_length = length;

With or without changing the comment:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

