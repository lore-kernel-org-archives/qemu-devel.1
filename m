Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC312C5ACAE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 08:16:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAD6B20650
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 08:16:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAD6B20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8KGr-00089j-Rf
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 04:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59478)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i8KFE-0007Ot-BX
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 04:14:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i8KFD-0007yw-4N
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 04:14:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49540)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i8KFA-0007xb-7y; Thu, 12 Sep 2019 04:14:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 91FBA308212D;
 Thu, 12 Sep 2019 08:14:19 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-179.ams2.redhat.com [10.36.116.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D9E425C22C;
 Thu, 12 Sep 2019 08:14:15 +0000 (UTC)
Date: Thu, 12 Sep 2019 10:14:14 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190912081414.GC5383@linux.fritz.box>
References: <20190911161521.59261-1-slp@redhat.com>
 <d47f7e67-2f6a-0dd6-3ab5-93626bfbb02d@redhat.com>
 <6755b34b-b412-9e63-8d25-b7662d0d3860@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Content-Disposition: inline
In-Reply-To: <6755b34b-b412-9e63-8d25-b7662d0d3860@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Thu, 12 Sep 2019 08:14:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] nbd/server: attach client channel to the
 export's AioContext
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
Cc: qemu-block@nongnu.org, Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 11.09.2019 um 23:33 hat Eric Blake geschrieben:
> On 9/11/19 12:21 PM, Eric Blake wrote:
> > On 9/11/19 11:15 AM, Sergio Lopez wrote:
> >> On creation, the export's AioContext is set to the same one as the
> >> BlockBackend, while the AioContext in the client QIOChannel is left
> >> untouched.
> >>
> >> As a result, when using data-plane, nbd_client_receive_next_request()
> >> schedules coroutines in the IOThread AioContext, while the client's
> >> QIOChannel is serviced from the main_loop, potentially triggering the
> >> assertion at qio_channel_restart_[read|write].
> >>
> >> To fix this, as soon we have the export corresponding to the client,
> >> we call qio_channel_attach_aio_context() to attach the QIOChannel
> >> context to the export's AioContext. This matches with the logic in
> >> blk_aio_attached().
> >>
> >> RHBZ: https://bugzilla.redhat.com/show_bug.cgi?id=3D1748253
> >> Signed-off-by: Sergio Lopez <slp@redhat.com>
> >> ---
> >>  nbd/server.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >=20
> > I'd like a second opinion from Kevin, but the description makes sense to
> > me.  I'm happy to queue this through my NBD tree.
> >=20
> > Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> I tried to test this patch, but even with it applied, I still got an
> aio-context crasher by attempting an nbd-server-start, nbd-server-add,
> nbd-server-stop (intentionally skipping the nbd-server-remove step) on a
> domain using iothreads, with a backtrace of:
>=20
> #0  0x00007ff09d070e35 in raise () from target:/lib64/libc.so.6
> #1  0x00007ff09d05b895 in abort () from target:/lib64/libc.so.6
> #2  0x000055dd03b9ab86 in error_exit (err=3D1, msg=3D0x55dd03d59fb0
> <__func__.15769> "qemu_mutex_unlock_impl")
>     at util/qemu-thread-posix.c:36
> #3  0x000055dd03b9adcf in qemu_mutex_unlock_impl (mutex=3D0x55dd062d5090,
> file=3D0x55dd03d59041 "util/async.c",
>     line=3D523) at util/qemu-thread-posix.c:96
> #4  0x000055dd03b93433 in aio_context_release (ctx=3D0x55dd062d5030) at
> util/async.c:523
> #5  0x000055dd03ac421b in bdrv_do_drained_begin (bs=3D0x55dd0673a2d0,
> recursive=3Dfalse, parent=3D0x0,
>     ignore_bds_parents=3Dfalse, poll=3Dtrue) at block/io.c:428
> #6  0x000055dd03ac4299 in bdrv_drained_begin (bs=3D0x55dd0673a2d0) at
> block/io.c:434
> #7  0x000055dd03aafb54 in blk_drain (blk=3D0x55dd06a3ec40) at
> block/block-backend.c:1605
> #8  0x000055dd03aae054 in blk_remove_bs (blk=3D0x55dd06a3ec40) at
> block/block-backend.c:800
> #9  0x000055dd03aad54a in blk_delete (blk=3D0x55dd06a3ec40) at
> block/block-backend.c:420
> #10 0x000055dd03aad7d6 in blk_unref (blk=3D0x55dd06a3ec40) at
> block/block-backend.c:475
> #11 0x000055dd03aecb68 in nbd_export_put (exp=3D0x55dd0726f920) at
> nbd/server.c:1666
> #12 0x000055dd03aec8fe in nbd_export_close (exp=3D0x55dd0726f920) at
> nbd/server.c:1616
> #13 0x000055dd03aecbf1 in nbd_export_close_all () at nbd/server.c:1689
> #14 0x000055dd03748845 in qmp_nbd_server_stop (errp=3D0x7ffcdf3cb4e8) at
> blockdev-nbd.c:233
> ...
>=20
> Does that sound familiar to what you were seeing?  Does it mean we
> missed another spot where the context is set incorrectly?

I think nbd_export_close_all() or one of the NBD functions called by it
needs to take the AioContext lock of the associated BlockBackend.

The crash is because AIO_POLL_WHILE() wants to temporarily drop the lock
that we're not even holding.

Kevin

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdef5WAAoJEH8JsnLIjy/WVBMP/1D1nwj8h+D7JjWc+ES7VMrS
t5OKJVbXqH6/wlH+9qu9X6O66g5HSM47zMlkUAuFVWUzgS8HDIRfK7M6pv40BK5R
ZNNWUglNxQ9oKImeEtL4/ag09RLjUoDV6jpgMLcDYefze1wLU7TTm95FhXDJnhlv
TJ+1PKeg8OcuiI1yTkDokASCz9h6Lsgm5XKPI7bLYa9jOAM8pBVJJCkN4B8S6SCT
1pmRx/oT+fjPzsk68SyGXFKzA33+OMYHLhKbvzvZteEHUUtjrezK5ESvZTzSVDEN
aF2OAHmnBX52AgVBdQ0ZURUx4aLAA/p4s1kgUxAFNqGrkjCEYzM2PECW8Z5FfdJ5
kt5GSJs1b3v/m/8azttxzEHZ8g7J5QGATpOJEeTSzfcdlRL7RfTh2LgpY+8z3okc
etOBP51k94h43sEyprryTzEyzoheP94mUNl8wwPiVo4cggmAHLYNI/s7mCOAyZ4i
WYSBAWRT9hxFNQijjGVALOmHwmcipxs532OXRHxVuzqaeTnHGH1oJghqHdtdlt0e
Gof5diGoVy0egvTiOO6EqYPsjFVdXSLE9YsDDYrJBnP+Ay59nPWFj1+xSQ4xHCkH
omH9ZpmBS6h1eoiSE2xZoPa7te5XvKi3a7PTfFOl5cmiMgK35HTXGPaXvKIJWEKd
63CEyb28WkWhZTDcb5F9
=AL5q
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--

