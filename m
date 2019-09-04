Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B7BC3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 09:35:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86BBC2087E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 09:35:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86BBC2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Rhj-0002VY-GK
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 05:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i5Rh0-0001uW-4J
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 05:35:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i5Rgz-0002PL-1J
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 05:35:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55082)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i5Rgv-0002N5-HZ; Wed, 04 Sep 2019 05:35:05 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 896DC8A1C8C;
 Wed,  4 Sep 2019 09:35:04 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-221.ams2.redhat.com
 [10.36.116.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7865560C18;
 Wed,  4 Sep 2019 09:35:01 +0000 (UTC)
Date: Wed, 4 Sep 2019 11:34:59 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Lieven <pl@kamp.de>
Message-ID: <20190904093459.GA21246@localhost.localdomain>
References: <20190903134442.15653-1-pl@kamp.de>
 <20190903145650.GO4582@localhost.localdomain>
 <1BDCDF9A-2146-43FE-AF4B-145F479AFD2B@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1BDCDF9A-2146-43FE-AF4B-145F479AFD2B@kamp.de>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Wed, 04 Sep 2019 09:35:04 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] block/nfs: add support for nfs_umount
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
Cc: ronniesahlberg@gmail.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 03.09.2019 um 21:52 hat Peter Lieven geschrieben:
> 
> 
> > Am 03.09.2019 um 16:56 schrieb Kevin Wolf <kwolf@redhat.com>:
> > 
> > Am 03.09.2019 um 15:44 hat Peter Lieven geschrieben:
> >> libnfs recently added support for unmounting. Add support
> >> in Qemu too.
> >> 
> >> Signed-off-by: Peter Lieven <pl@kamp.de>
> > 
> > Looks trivial enough to review even for me. :-)
> > 
> > Thanks, applied to the block branch.
> > 
> > Kevin
> 
> I am not sure what the reason is, but with this patch I sometimes run
> into nfs_process_read being called for a cdrom mounted from nfs after
> I ejected it (and the whole nfs client context is already destroyed).

Does this mean that nfs_umount() gets some response, but we don't
properly wait for it? Or is some older request still in flight?

> It seems that the following fixes the issue. It might be that the
> nfs_umount call just reveals this bug. nfs_close is also doing sync
> I/O with the libnfs library. If we mount a nfs share we are doing
> everything with sync calls and then set up the aio stuff with
> nfs_set_events. I think that we need to stop the aio before we are
> executing the sync calls to nfs_close and nfs_umount.

Disabling the fd handlers is probably just papering over the problem. If
there is something in flight, we should wait for its completion. In
theory, block devices are drained before calling .bdrv_close, so
either we have a bug with draining nfs nodes correctly, or .bdrv_close
initiates something new itself that we should wait for.

> Also not sure if holding the mutex is necessary here.

Not for aio_set_fd_handler(), but I don't know the requirements of
nfs_get_fd().

Kevin

> diff --git a/block/nfs.c b/block/nfs.c
> index ffa6484c1a..cb2e0d375a 100644
> --- a/block/nfs.c
> +++ b/block/nfs.c
> @@ -389,6 +389,10 @@ static void nfs_attach_aio_context(BlockDriverState *bs,
>  static void nfs_client_close(NFSClient *client)
>  {
>      if (client->context) {
> +        qemu_mutex_lock(&client->mutex);
> +        aio_set_fd_handler(client->aio_context, nfs_get_fd(client->context),
> +                           false, NULL, NULL, NULL, NULL);
> +        qemu_mutex_unlock(&client->mutex);
>          if (client->fh) {
>              nfs_close(client->context, client->fh);
>              client->fh = NULL;
> @@ -396,8 +400,6 @@ static void nfs_client_close(NFSClient *client)
>  #ifdef LIBNFS_FEATURE_UMOUNT
>          nfs_umount(client->context);
>  #endif
> -        aio_set_fd_handler(client->aio_context, nfs_get_fd(client->context),
> -                           false, NULL, NULL, NULL, NULL);
>          nfs_destroy_context(client->context);
>          client->context = NULL;
>      }

