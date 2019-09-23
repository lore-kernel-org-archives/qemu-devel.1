Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C114AC04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 14:11:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9181020578
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 14:11:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9181020578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCP40-0003Fj-Ll
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 10:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35783)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iCP36-0002g8-Sq
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:10:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iCP35-0004SB-0C
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:10:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5520)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iCP34-0004Rd-NX
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:10:42 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 62471C049E32
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 14:10:41 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id c1so4904650wrb.12
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 07:10:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=wZ9Am3xjNOcITRpZcEMQUWZd224R3lH/D0A3UUoperE=;
 b=ZAYc889VMXUNdGnwFG5FSK4rJk2HJ/ihH0bBLpzt+7gmCfez+QPje3VJcIr5vGZ4oc
 aHBHvkFfeZ8HbD64xloz7+ijQmLgVCL00oUUNOW7SqlYsPA6sEC1Apa3YMxNM/I8De/L
 DP18RBWO7p3ao0XBjeCLMioZQ2+tR4wgaAY5tHCJe1nPTI0X+DOBsWrG1SuNOJ2e5+5i
 qIt+qgvf7BNE84cH9oPOZVpaTRvzeYd4vSUAvdP0M/f+0AYLVM3aH18pxMMNJx0E0Kkd
 FsSAojOPsoDrvP6FHWWrnVUEcdTNLzPj/zh47hzSgwRFaCVyJe8kC5nt8sQiFVNNcvYC
 BoBg==
X-Gm-Message-State: APjAAAWtYAVhoefoyleRoasfsxrlvzzL6Fbc/+pQ2HzIJVW0ygfhDpmu
 THZuumdTWDS/yuFSfXsif3Q8KcnzlUnR5sSn3ccQ0HYkoWr4QagCGkJrWx+4Usocxw8s3+rL1e1
 qOzk42HLrioKGhlA=
X-Received: by 2002:a1c:9dc1:: with SMTP id g184mr13573957wme.77.1569247840028; 
 Mon, 23 Sep 2019 07:10:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyd1cdtlPobZ6azC/gQefHCTThxx0bTxzq74uXrU6uP/il6w8PtUgkGLfU6xSd3DVqYfYzyuQ==
X-Received: by 2002:a1c:9dc1:: with SMTP id g184mr13573933wme.77.1569247839723; 
 Mon, 23 Sep 2019 07:10:39 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id y13sm14708990wrg.8.2019.09.23.07.10.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2019 07:10:39 -0700 (PDT)
References: <20190917023917.32226-1-eblake@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] nbd: Grab aio context lock in more places
In-reply-to: <20190917023917.32226-1-eblake@redhat.com>
Date: Mon, 23 Sep 2019 16:10:27 +0200
Message-ID: <87d0frcdd8.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain


Eric Blake <eblake@redhat.com> writes:

> When iothreads are in use, the failure to grab the aio context results
> in an assertion failure when trying to unlock things during blk_unref,
> when trying to unlock a mutex that was not locked.  In short, all
> calls to nbd_export_put need to done while within the correct aio
> context.  But since nbd_export_put can recursively reach itself via
> nbd_export_close, and recursively grabbing the context would deadlock,
> we can't do the context grab directly in those functions, but must do
> so in their callers.
>
> Hoist the use of the correct aio_context from nbd_export_new() to its
> caller qmp_nbd_server_add().  Then tweak qmp_nbd_server_remove(),
> nbd_eject_notifier(), and nbd_esport_close_all() to grab the right
> context, so that all callers during qemu now own the context before
> nbd_export_put() can call blk_unref().
>
> Remaining uses in qemu-nbd don't matter (since that use case does not
> support iothreads).
>
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>
> With this in place, my emailed formula [1] for causing an iothread
> assertion failure no longer hits, and all the -nbd and -qcow2 iotests
> still pass.  I would still like to update iotests to cover things (I
> could not quickly figure out how to make iotest 222 use iothreads -
> either we modify that one or add a new one), but wanted to get review
> started on this first.
>
> [1] https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg03383.html
>
>  include/block/nbd.h |  1 +
>  blockdev-nbd.c      | 14 ++++++++++++--
>  nbd/server.c        | 23 +++++++++++++++++++----
>  3 files changed, 32 insertions(+), 6 deletions(-)
>
> diff --git a/include/block/nbd.h b/include/block/nbd.h
> index 21550747cf35..316fd705a9e4 100644
> --- a/include/block/nbd.h
> +++ b/include/block/nbd.h
> @@ -340,6 +340,7 @@ void nbd_export_put(NBDExport *exp);
>
>  BlockBackend *nbd_export_get_blockdev(NBDExport *exp);
>
> +AioContext *nbd_export_aio_context(NBDExport *exp);
>  NBDExport *nbd_export_find(const char *name);
>  void nbd_export_close_all(void);
>
> diff --git a/blockdev-nbd.c b/blockdev-nbd.c
> index 213f226ac1c4..6a8b206e1d74 100644
> --- a/blockdev-nbd.c
> +++ b/blockdev-nbd.c
> @@ -151,6 +151,7 @@ void qmp_nbd_server_add(const char *device, bool has_name, const char *name,
>      BlockBackend *on_eject_blk;
>      NBDExport *exp;
>      int64_t len;
> +    AioContext *aio_context;
>
>      if (!nbd_server) {
>          error_setg(errp, "NBD server not running");
> @@ -173,11 +174,13 @@ void qmp_nbd_server_add(const char *device, bool has_name, const char *name,
>          return;
>      }
>
> +    aio_context = bdrv_get_aio_context(bs);
> +    aio_context_acquire(aio_context);
>      len = bdrv_getlength(bs);
>      if (len < 0) {
>          error_setg_errno(errp, -len,
>                           "Failed to determine the NBD export's length");
> -        return;
> +        goto out;
>      }
>
>      if (!has_writable) {
> @@ -190,13 +193,16 @@ void qmp_nbd_server_add(const char *device, bool has_name, const char *name,
>      exp = nbd_export_new(bs, 0, len, name, NULL, bitmap, !writable, !writable,
>                           NULL, false, on_eject_blk, errp);
>      if (!exp) {
> -        return;
> +        goto out;
>      }
>
>      /* The list of named exports has a strong reference to this export now and
>       * our only way of accessing it is through nbd_export_find(), so we can drop
>       * the strong reference that is @exp. */
>      nbd_export_put(exp);
> +
> + out:
> +    aio_context_release(aio_context);
>  }
>
>  void qmp_nbd_server_remove(const char *name,
> @@ -204,6 +210,7 @@ void qmp_nbd_server_remove(const char *name,
>                             Error **errp)
>  {
>      NBDExport *exp;
> +    AioContext *aio_context;
>
>      if (!nbd_server) {
>          error_setg(errp, "NBD server not running");
> @@ -220,7 +227,10 @@ void qmp_nbd_server_remove(const char *name,
>          mode = NBD_SERVER_REMOVE_MODE_SAFE;
>      }
>
> +    aio_context = nbd_export_aio_context(exp);
> +    aio_context_acquire(aio_context);
>      nbd_export_remove(exp, mode, errp);
> +    aio_context_release(aio_context);
>  }
>
>  void qmp_nbd_server_stop(Error **errp)
> diff --git a/nbd/server.c b/nbd/server.c
> index 378784c1e54a..3003381c86b4 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -1458,7 +1458,12 @@ static void blk_aio_detach(void *opaque)
>  static void nbd_eject_notifier(Notifier *n, void *data)
>  {
>      NBDExport *exp = container_of(n, NBDExport, eject_notifier);
> +    AioContext *aio_context;
> +
> +    aio_context = exp->ctx;
> +    aio_context_acquire(aio_context);
>      nbd_export_close(exp);
> +    aio_context_release(aio_context);
>  }
>
>  NBDExport *nbd_export_new(BlockDriverState *bs, uint64_t dev_offset,
> @@ -1477,12 +1482,11 @@ NBDExport *nbd_export_new(BlockDriverState *bs, uint64_t dev_offset,
>       * NBD exports are used for non-shared storage migration.  Make sure
>       * that BDRV_O_INACTIVE is cleared and the image is ready for write
>       * access since the export could be available before migration handover.
> +     * ctx was acquired in the caller.
>       */
>      assert(name);
>      ctx = bdrv_get_aio_context(bs);
> -    aio_context_acquire(ctx);
>      bdrv_invalidate_cache(bs, NULL);
> -    aio_context_release(ctx);
>
>      /* Don't allow resize while the NBD server is running, otherwise we don't
>       * care what happens with the node. */
> @@ -1490,7 +1494,7 @@ NBDExport *nbd_export_new(BlockDriverState *bs, uint64_t dev_offset,
>      if (!readonly) {
>          perm |= BLK_PERM_WRITE;
>      }
> -    blk = blk_new(bdrv_get_aio_context(bs), perm,
> +    blk = blk_new(ctx, perm,
>                    BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED |
>                    BLK_PERM_WRITE | BLK_PERM_GRAPH_MOD);
>      ret = blk_insert_bs(blk, bs, errp);
> @@ -1557,7 +1561,7 @@ NBDExport *nbd_export_new(BlockDriverState *bs, uint64_t dev_offset,
>      }
>
>      exp->close = close;
> -    exp->ctx = blk_get_aio_context(blk);
> +    exp->ctx = ctx;
>      blk_add_aio_context_notifier(blk, blk_aio_attached, blk_aio_detach, exp);
>
>      if (on_eject_blk) {
> @@ -1590,11 +1594,18 @@ NBDExport *nbd_export_find(const char *name)
>      return NULL;
>  }
>
> +AioContext *
> +nbd_export_aio_context(NBDExport *exp)
> +{
> +    return exp->ctx;
> +}
> +
>  void nbd_export_close(NBDExport *exp)
>  {
>      NBDClient *client, *next;
>
>      nbd_export_get(exp);
> +

I'm not sure if this new line was added here on purpose.

>      /*
>       * TODO: Should we expand QMP NbdServerRemoveNode enum to allow a
>       * close mode that stops advertising the export to new clients but
> @@ -1684,9 +1695,13 @@ BlockBackend *nbd_export_get_blockdev(NBDExport *exp)
>  void nbd_export_close_all(void)
>  {
>      NBDExport *exp, *next;
> +    AioContext *aio_context;
>
>      QTAILQ_FOREACH_SAFE(exp, &exports, next, next) {
> +        aio_context = exp->ctx;
> +        aio_context_acquire(aio_context);
>          nbd_export_close(exp);
> +        aio_context_release(aio_context);
>      }
>  }

Otherwise, LGTM.

Reviewed-by: Sergio Lopez <slp@redhat.com>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl2I0lMACgkQ9GknjS8M
AjVYVQ/8C4p7akWa3o0KSBvTAJPZQtlDDGJp4cdnvlfbPawkt4S6qCg4lmfjT6c3
Q/1Ai6ACMwZuea7t4+//1lCFeMAfXT07ZeLbkwCrUXTyoux1sSpxkVP1cQhGve17
R/TUUGUUu0IIZygISqXuxE84p9ZQiOhPsYM7stGzDeX69DqTOv2yw2fVpYqsBtrd
rusGex4HKSoiR9Lyj5e2pWSI0N1/ArvrpHcQYUHSoKWCWGdlkJh6l8A8tDeWka/q
BqfvB1vM3MnfD85OAJrXbq7gDH2qHxMx2Lkj5EkHNzzMA8piRUwSGUY1ARHgkuhr
6P2YMj0Fuaqa0tmcu0OyXIkwE1B+6oKV1+Pa6zaW01Nz0W/7euQZKyzeVeAwBNJK
jIQceVk0RoxrsCDc2KRaQyiqFWt4OSD5UDq635LQwn1gm0Bv1Eom1xjTrK16aHcj
x+RhYEyvYe8Mx5cLpzMTAznd3krXj+k4aIk5TsZ/0va3g6Hu7JJC7Ug2MYwAkto3
t00MwBaGfxAw4EU3x++/tJKfI0/Dl8zSOKazY2AEtdbC+O5z2B86pdC0xNwxswjw
bBS+QOO/BWqMAv29VxJzcgLkYd9UTs9lZw74gl6bOHSt4NmMK8Roukopmyx9O/Ew
xAD59uoLf0L1ozxB2eqetddw1ZN6mayxnccKrBF8z73sov6aQfM=
=f2nz
-----END PGP SIGNATURE-----
--=-=-=--

