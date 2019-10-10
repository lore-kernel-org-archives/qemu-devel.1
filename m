Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7131C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 15:04:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99E25206A1
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 15:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E25206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIZzg-0004EL-WF
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 11:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57533)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iIZxr-0002t1-JX
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:02:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iIZxq-0006Qz-0t
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:02:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34165)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iIZxl-0006Pu-3l; Thu, 10 Oct 2019 11:02:45 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 51A60C05686D;
 Thu, 10 Oct 2019 15:02:44 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-47.ams2.redhat.com
 [10.36.116.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A32FD1001B36;
 Thu, 10 Oct 2019 15:02:33 +0000 (UTC)
Date: Thu, 10 Oct 2019 17:02:32 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Subject: Re: [Qemu-block] [PATCH v2 1/2] blockdev: release the AioContext at
 drive_backup_prepare
Message-ID: <20191010150232.GD7616@localhost.localdomain>
References: <20190913152507.56197-1-slp@redhat.com>
 <20190913152507.56197-2-slp@redhat.com>
 <f10c8f6d-5ad2-b37c-16b7-659a3f02661c@redhat.com>
 <20190916075303.GA10930@localhost.localdomain>
 <87d0g0h4mo.fsf@redhat.com> <87o8yyi35x.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
In-Reply-To: <87o8yyi35x.fsf@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Thu, 10 Oct 2019 15:02:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: mreitz@redhat.com, John Snow <jsnow@redhat.com>, armbru@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 03.10.2019 um 11:33 hat Sergio Lopez geschrieben:
>=20
> Sergio Lopez <slp@redhat.com> writes:
>=20
> > Kevin Wolf <kwolf@redhat.com> writes:
> >
> >> Am 13.09.2019 um 21:54 hat John Snow geschrieben:
> >>>=20
> >>>=20
> >>> On 9/13/19 11:25 AM, Sergio Lopez wrote:
> >>> > do_drive_backup() already acquires the AioContext, so release it
> >>> > before the call.
> >>> >=20
> >>> > Signed-off-by: Sergio Lopez <slp@redhat.com>
> >>> > ---
> >>> >  blockdev.c | 6 +-----
> >>> >  1 file changed, 1 insertion(+), 5 deletions(-)
> >>> >=20
> >>> > diff --git a/blockdev.c b/blockdev.c
> >>> > index fbef6845c8..3927fdab80 100644
> >>> > --- a/blockdev.c
> >>> > +++ b/blockdev.c
> >>> > @@ -1783,20 +1783,16 @@ static void drive_backup_prepare(BlkActionS=
tate *common, Error **errp)
> >>> > =20
> >>> >      aio_context =3D bdrv_get_aio_context(bs);
> >>> >      aio_context_acquire(aio_context);
> >>> > -
> >>
> >> Are you removing this unrelated empty line intentionally?
> >
> > Yes. In the sense of that whole set of lines being a "open drained
> > section" block.
> >
> >>> >      /* Paired with .clean() */
> >>> >      bdrv_drained_begin(bs);
> >>>=20
> >>> Do we need to make this change to blockdev_backup_prepare as well?
> >>
> >> Actually, the whole structure feels a bit wrong. We get the bs here and
> >> take its lock, then release the lock again and forget the reference,
> >> only to do both things again inside do_drive_backup().
> >>
> >> The way snapshots work is that the "normal" snapshot commands are
> >> wrappers that turn it into a single-entry transaction. Then you have
> >> only one code path where you can resolve the ID and take the lock just
> >> once. So maybe backup should work like this, too?
> >
> > I'm neither opposed nor in favor, but I think this is outside the scope
> > of this patch series.
>=20
> Kevin, do you think we should attempt to just fix this issue (which
> would make a possible backport easier) or try to move all blockdev
> actions to be transaction-based?

Maybe fix it and then do the cleanup on top, though possibly in the same
series?

Kevin

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdn0gIAAoJEH8JsnLIjy/WOHgP/AnmAuPGt9ck5HMHZeTyt3dw
Swh/KnUcKToeOkAgGfFus1KHGAC9Z9vmV8QZSPya3/hgxK93ESQ941tdb5WBF8Qn
MpuAgRYc7TMck3a4VyKTKsuYfwvvHIKyTjLFmiRCwyrWV6pi/e6qYVUS+rq6IaKi
kObF8etDts/FAAC/kQD67oKPAH0Bz7uEK89UyAgAx1lt84VuKHLenNm9InOrq3Mg
03cvKmCGkAPyR4oXcyClhWBsnFxA6VG645l2nbJ6zudjlOi1jt+CgO9VGTKnmZBF
cSTjVTzvmumRxMkd3DCocyrkIT7AXgp55TXKIySoopMsXtyYZ0CwYyG6whBn5UzB
lu0vLKfKrDhhdGhwH+db+dEm4ejiP6618msr6/R3+GCpW5AKylV5JReFJ3T+oye7
tTwNZR+fVaP4mb65uJC8wRS2YQ/fQGFPKzJkzSTwhxxLiJ7qcsV6x21/7Ya0O3Zo
vCDICzg3U6Iz0zG/QoPdnMdtO5S5THcdXmMY8/XZ/hZkUSjHLdsdCrzf8uCaoSTf
3lcU30RlPr2JDEr4D4lCW5mWBmMMg27gbiV4mwpjuf7w8YPdgas7dzeqDnGbK402
EVB+HgZOV2QzYR74SZ5cjzQowynpenUUFFyHCYnsd2g2JQcqqTp5SHgnB1Qmiwmz
gFqmEzlHUM1CWf3JPEPZ
=ObJ3
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--

