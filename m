Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5310C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 11:37:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B504722BEF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 11:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B504722BEF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqyXF-00085P-Rh
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 07:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57492)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hqyX2-0007fX-HQ
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 07:37:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hqyWz-00056h-9z
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 07:37:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36728)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hqyWw-0004jM-59; Fri, 26 Jul 2019 07:36:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 392B446674;
 Fri, 26 Jul 2019 11:36:56 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-109.ams2.redhat.com
 [10.36.116.109])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A0F0C62667;
 Fri, 26 Jul 2019 11:36:54 +0000 (UTC)
Date: Fri, 26 Jul 2019 13:36:53 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190726113653.GC6295@localhost.localdomain>
References: <20190725162704.12622-1-kwolf@redhat.com>
 <20190725162704.12622-4-kwolf@redhat.com>
 <d6466e56-b57b-7cf7-1a39-8cd38db14ede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <d6466e56-b57b-7cf7-1a39-8cd38db14ede@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Fri, 26 Jul 2019 11:36:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/4] mirror: Keep target drained until
 graph changes are done
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
Cc: dplotnikov@virtuozzo.com, vsementsov@virtuozzo.com, den@virtuozzo.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 26.07.2019 um 11:52 hat Max Reitz geschrieben:
> On 25.07.19 18:27, Kevin Wolf wrote:
> > Calling bdrv_drained_end() for target_bs can restarts requests too
> > early, so that they would execute on mirror_top_bs, which however has
> > already dropped all permissions.
> >=20
> > Keep the target node drained until all graph changes have completed.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  block/mirror.c | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/block/mirror.c b/block/mirror.c
> > index 8cb75fb409..7483051f8d 100644
> > --- a/block/mirror.c
> > +++ b/block/mirror.c
> > @@ -644,6 +644,11 @@ static int mirror_exit_common(Job *job)
> >      bdrv_ref(mirror_top_bs);
> >      bdrv_ref(target_bs);
> > =20
> > +    /* The mirror job has no requests in flight any more, but we need =
to
> > +     * drain potential other users of the BDS before changing the grap=
h. */
> > +    assert(s->in_drain);
> > +    bdrv_drained_begin(target_bs);
> > +
>=20
> In contrast to what Eric said, I think it is a problem that this is just
> code motion.
>=20
> The comment doesn=E2=80=99t tell the reason why the target needs to be dr=
ained
> here.  Other users of the BDS have their own BdrvChild and thus their
> own permissions, their requests do not go through mirror.
>=20
> So in addition to why the target needs to be drained around
> bdrv_replace_node(), the comment should tell why we need to drain it
> here, like the commit message does.
>=20
> Now, the thing is, I don=E2=80=99t quite understand the connection betwee=
n the
> target and mirror_top_bs that the commit message wants to establish.
>=20
> I see the following problem:
> (1) We drain src (at the end of mirror_run()).
> (2) This implicitly drains mirror_top_bs.
> (3) We drain target.
> (4) bdrv_replace_node() replaces src by target, thus replacing the drain
>     on mirror_top_bs from src by the one from target.
> (5) We undrain target, thus also undraining mirror_top_bs.

(5.5) Remove mirror_top_bs from the target chain

> (6) After all is done, we undrain src, which has no effect on
>     mirror_top_bs, because they haven=E2=80=99t been connected since (4).
>=20
> I suppose (5) is the problem.  This patch moves it down to (6), so
> mirror_top_bs is drained as long as src is drained.

The problem is that (5) happens before (5.5), so we can start requests
on a node that we're about to remove (without draining it again before).

> (If to_replace is not src, then src will stay attached, which keeps
> mirror_top_bs drained, too.)
>=20
> This makes it seem to me like the actually important thing is to drain
> mirror_top_bs, not target.  If so, it would seem more obvious to me to
> just add a drain on mirror_top_bs than to move the existing target drain.

Do you really think having a third drained section makes things easier
to understand? Draining both source and target while we're modifying the
graph seems pretty intuitive to me - which is also why I moved the
bdrv_drained_begin() to the very start instead of looking for the first
operation that actually strictly needs it.

> >      /* Remove target parent that still uses BLK_PERM_WRITE/RESIZE befo=
re
> >       * inserting target_bs at s->to_replace, where we might not be abl=
e to get
> >       * these permissions.
> > @@ -684,12 +689,7 @@ static int mirror_exit_common(Job *job)
> >              bdrv_reopen_set_read_only(target_bs, ro, NULL);
> >          }
> > =20
> > -        /* The mirror job has no requests in flight any more, but we n=
eed to
> > -         * drain potential other users of the BDS before changing the =
graph. */
> > -        assert(s->in_drain);
> > -        bdrv_drained_begin(target_bs);
>=20
> By the way, don=E2=80=99t we need to drain to_replace also?  In case it i=
sn=E2=80=99t src?

I think to_replace is required to be in the subtree of src, no?

Though maybe it could have another parent, so you might be right.

Kevin

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdOuXVAAoJEH8JsnLIjy/WxScQAIVjO5VZZG0OoLeC1EdcmhsT
K1zolppXMyUnnuKHe3uSqvE4O5Aov14YHlpzddUhn6+57LL4IJXw5xRG6WRYT13w
b9r4LQspzJanCJn3TJNYeC6bhuC9+9ViFFa2N9iwFXag3ofnRxlBYpFjb30hDNWp
U8p/6HgQYCNl2elXbWFIcd3cHVKykrl6saFq25vzqKu9Qk9xPQn4Lg13um4GPTis
I0ux9lWzL2XxXhxCIq148Ad75SK8PwnJvwPjBG7QxpqnQzlYnqnxMsM6RTgYPA+x
b4Z8b06VQjxfRXpvU1scdUTmebzyKakzrZ5/5C0gndFbSgq2PKuQ29f/eZ4Rfw6X
pGhvJogcpOI5M71JLSKCTe4gMWmEYbmDEp8U/0+CZ3CxIt3PoDfqusnqRQnS/cRP
RsKU55gdT1bwliF9KRV+nEWXwhEOLe0j4lWNhypNDYV1Ei/1XU11ekQmZOOQIlON
uBJpGDrSRONI3LSegNXhgD4jCa++Y8V1uxLL/jy9+keMMNzZmUlhh4ipIyYoWpR0
xQ1kkCsWCdnjaP3Aom7eN6w0E6eEbGqxOq0t/PCTdX7VOOJuEwvbXv45zhJpzJzp
MEaOXR2fZZn4xRgKDtPsGzkEgvFb9QzBneEySGRo7BImlXr6bp/ppHefizoi24MI
dtxZe06TE14Js4yWWObI
=xuPr
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--

