Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6A4C742B3
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 11:01:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 370F12084B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 11:01:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 370F12084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hltJ2-00017N-LT
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 07:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42470)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hltIo-0000ij-Ie
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 07:01:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hltIm-0004cf-Sj
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 07:01:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49542)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hltIj-0004Yl-2Z; Fri, 12 Jul 2019 07:01:17 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8FE1783F40;
 Fri, 12 Jul 2019 11:01:14 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 551E660BFB;
 Fri, 12 Jul 2019 11:01:11 +0000 (UTC)
Date: Fri, 12 Jul 2019 13:01:10 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190712110110.GE4514@dhcp-200-226.str.redhat.com>
References: <20190711195804.30703-1-mreitz@redhat.com>
 <20190711195804.30703-2-mreitz@redhat.com>
 <20190712092419.GB4514@dhcp-200-226.str.redhat.com>
 <8ce2ce78-833e-c98f-ad3a-d44f6432ae4c@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <8ce2ce78-833e-c98f-ad3a-d44f6432ae4c@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Fri, 12 Jul 2019 11:01:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC 1/5] block/nbd: Fix hang in .bdrv_close()
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 12.07.2019 um 12:47 hat Max Reitz geschrieben:
> On 12.07.19 11:24, Kevin Wolf wrote:
> > Am 11.07.2019 um 21:58 hat Max Reitz geschrieben:
> >> When nbd_close() is called from a coroutine, the connection_co never
> >> gets to run, and thus nbd_teardown_connection() hangs.
> >>
> >> This is because aio_co_enter() only puts the connection_co into the ma=
in
> >> coroutine's wake-up queue, so this main coroutine needs to yield and
> >> reschedule itself to let the connection_co run.
> >>
> >> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >> ---
> >>  block/nbd.c | 12 +++++++++++-
> >>  1 file changed, 11 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/block/nbd.c b/block/nbd.c
> >> index 81edabbf35..b83b6cd43e 100644
> >> --- a/block/nbd.c
> >> +++ b/block/nbd.c
> >> @@ -135,7 +135,17 @@ static void nbd_teardown_connection(BlockDriverSt=
ate *bs)
> >>      qio_channel_shutdown(s->ioc,
> >>                           QIO_CHANNEL_SHUTDOWN_BOTH,
> >>                           NULL);
> >> -    BDRV_POLL_WHILE(bs, s->connection_co);
> >> +
> >> +    if (qemu_in_coroutine()) {
> >> +        /* Let our caller poll and just yield until connection_co is =
done */
> >> +        while (s->connection_co) {
> >> +            aio_co_schedule(qemu_get_current_aio_context(),
> >> +                            qemu_coroutine_self());
> >> +            qemu_coroutine_yield();
> >> +        }
> >=20
> > Isn't this busy waiting? Why not let s->connection_co wake us up when
> > it's about to terminate instead of immediately rescheduling ourselves?
>=20
> Yes, it is busy waiting, but I didn=E2=80=99t find that bad.  The connect=
ion_co
> will be invoked in basically every iteration, and once there is no
> pending data, it will quit.
>=20
> The answer to =E2=80=9Cwhy not...=E2=80=9D of course is because it=E2=80=
=99d be more complicated.
>=20
> But anyway.
>=20
> Adding a new function qemu_coroutine_run_after(target) that adds
> qemu_coroutine_self() to the given @target coroutine=E2=80=99s wake-up qu=
eue and
> then using that instead of scheduling works, too, yes.
>=20
> I don=E2=80=99t really like being responsible for coroutine code, though.=
=2E.
>=20
> (And maybe it=E2=80=99d be better to make it qemu_coroutine_yield_for(tar=
get),
> which does the above and then yields?)

Or just do something like this, which is arguably not only a fix for the
busy wait, but also a code simplification:

diff --git a/block/nbd.c b/block/nbd.c
index b83b6cd43e..c061bd1bfc 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -61,6 +61,7 @@ typedef struct BDRVNBDState {
     CoMutex send_mutex;
     CoQueue free_sema;
     Coroutine *connection_co;
+    Coroutine *teardown_co;
     int in_flight;

     NBDClientRequest requests[MAX_NBD_REQUESTS];
@@ -137,12 +138,9 @@ static void nbd_teardown_connection(BlockDriverState *=
bs)
                          NULL);

     if (qemu_in_coroutine()) {
-        /* Let our caller poll and just yield until connection_co is done =
*/
-        while (s->connection_co) {
-            aio_co_schedule(qemu_get_current_aio_context(),
-                            qemu_coroutine_self());
-            qemu_coroutine_yield();
-        }
+        /* just yield until connection_co is done */
+        s->teardown_co =3D qemu_coroutine_self();
+        qemu_coroutine_yield();
     } else {
         BDRV_POLL_WHILE(bs, s->connection_co);
     }
@@ -217,6 +215,9 @@ static coroutine_fn void nbd_connection_entry(void *opa=
que)
     bdrv_dec_in_flight(s->bs);

     s->connection_co =3D NULL;
+    if (s->teardown_co) {
+        aio_co_wake(s->teardown_co);
+    }
     aio_wait_kick();
 }

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdKGh1AAoJEH8JsnLIjy/Wo4EQAJL94aC7j74DtzNHlH5yFIr4
0p5z/Cni/LIiZPsId7rw4XdkAAkc1bIHm0v3aydQkCK671EhWSKRK01mkw17rytk
hYxPWaWeA3taPkHJ1yoMz4Vao0iTCs9TiM2d+PVppvHn2am2n3bwUkq+IbYiTbFf
LNBeV2jaU4LabrAh55immVToLrrGwR0TigLoYYlv+msCLXVvtG0N1m+LWJW0NYSl
we+ztPLenWjhuQdyG+L9xqykR9yeXYVAx4WIBtFQNOGK0SdnS5os+uZTnjmSQYJe
Z5Bsg5sDcoshy4kqSpEhqR0CmdzDuweXxu2e2hsmuvJX4SLAjqT7spgVnKBvspgu
RTJAgj1JkKYqOOrH+OivMbRjwzz9K592I/xQ+8vVekIi3bmXe/PiX7Yjw1Ez/iBZ
vflHfelMTV26Ab5mbX167oQWcZ9oF18J7nd+6QfaU8B0snmuWDZ5oM+7rn6CDBX9
9v9A2WkDiB7p60bsqeI48DyvluO6CxOdJsbrp/bRZfJXYmFPf+xc7ck0pi+cbFW4
53pUlaWT/jcexpUuNrxy0JjhtaW3QB82OHtVkEl8W+VRHS1DeshLnPTzIdbjj53C
8Fp34bAveOY5Iquuvm3Fi06T2eZYnSB+ZZNkl2XnvM81/dT0ntrCr0Ozw+If+39m
doxxoSX03Qyab6EnieiD
=hkvt
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--

