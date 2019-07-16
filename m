Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F9FC7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 16:38:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A2C220449
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 16:38:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A2C220449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnQT1-0007RZ-0j
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 12:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55343)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hnQSn-0006nS-2N
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 12:38:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hnQSl-0007A4-TW
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 12:38:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38976)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hnQSe-00070X-Oc; Tue, 16 Jul 2019 12:37:54 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 25955308330C;
 Tue, 16 Jul 2019 16:37:51 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-24.ams2.redhat.com [10.36.117.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CFADB1001B00;
 Tue, 16 Jul 2019 16:37:47 +0000 (UTC)
Date: Tue, 16 Jul 2019 18:37:46 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190716163746.GH7297@linux.fritz.box>
References: <20190619152603.5937-1-mreitz@redhat.com>
 <20190716144016.GE7297@linux.fritz.box>
 <82ce3044-e228-2453-5da2-9f86e4627066@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Content-Disposition: inline
In-Reply-To: <82ce3044-e228-2453-5da2-9f86e4627066@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Tue, 16 Jul 2019 16:37:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 0/9] block: Delay poll when ending
 drained sections
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


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 16.07.2019 um 18:24 hat Max Reitz geschrieben:
> On 16.07.19 16:40, Kevin Wolf wrote:
> > Am 19.06.2019 um 17:25 hat Max Reitz geschrieben:
> >> Hi,
> >>
> >> This is v2 to =E2=80=9Cblock: Keep track of parent quiescing=E2=80=9D.
> >>
> >> Please read this cover letter, because I=E2=80=99m very unsure about t=
he design
> >> in this series and I=E2=80=99d appreciate some comments.
> >>
> >> As Kevin wrote in his reply to that series, the actual problem is that
> >> bdrv_drain_invoke() polls on every node whenever ending a drain.  This
> >> may cause graph changes, which is actually forbidden.
> >>
> >> To solve that problem, this series makes the drain code construct a li=
st
> >> of undrain operations that have been initiated, and then polls all of
> >> them on the root level once graph changes are acceptable.
> >>
> >> Note that I don=E2=80=99t like this list concept very much, so I=E2=80=
=99m open to
> >> alternatives.
> >=20
> > So drain_end is different from drain_begin in that it wants to wait only
> > for all bdrv_drain_invoke() calls to complete, but not for other
> > requests that are in flight. Makes sense.
> >=20
> > Though instead of managing a whole list, wouldn't a counter suffice?
> >=20
> >> Furthermore, all BdrvChildRoles with BDS parents have a broken
> >> .drained_end() implementation.  The documentation clearly states that
> >> this function is not allowed to poll, but it does.  So this series
> >> changes it to a variant (using the new code) that does not poll.
> >>
> >> There is a catch, which may actually be a problem, I don=E2=80=99t kno=
w: The new
> >> variant of that .drained_end() does not poll at all, never.  As
> >> described above, now every bdrv_drain_invoke() returns an object that
> >> describes when it will be done and which can thus be polled for.  These
> >> objects are just discarded when using BdrvChildRole.drained_end().  Th=
at
> >> does not feel quite right.  It would probably be more correct to let
> >> BdrvChildRole.drained_end() return these objects so the top level
> >> bdrv_drained_end() can poll for their completion.
> >>
> >> I decided not to do this, for two reasons:
> >> (1) Doing so would spill the =E2=80=9Clist of objects to poll for=E2=
=80=9D design to
> >>     places outside of block/io.c.  I don=E2=80=99t like the design ver=
y much as
> >>     it is, but I can live with it as long as it=E2=80=99s constrained =
to the
> >>     core drain code in block/io.c.
> >>     This is made worse by the fact that currently, those objects are of
> >>     type BdrvCoDrainData.  But it shouldn=E2=80=99t be a problem to ad=
d a new
> >>     type that is externally visible (we only need the AioContext and
> >>     whether bdrv_drain_invoke_entry() is done).
> >>
> >> (2) It seems to work as it is.
> >>
> >> The alternative would be to add the same GSList ** parameter to
> >> BdrvChildRole.drained_end() that I added in the core drain code in pat=
ch
> >> 2, and then let the .drained_end() implementation fill that with objec=
ts
> >> to poll for.  (Which would be accomplished by adding a frontend to
> >> bdrv_do_drained_end() that lets bdrv_child_cb_drained_poll() pass the
> >> parameter through.)
> >>
> >> Opinions?
> >=20
> > I think I would add an int* to BdrvChildRole.drained_end() so that we
> > can just increase the counter whereever we need to.
>=20
> So you mean just polling the @bs for which a caller gave poll=3Dtrue until
> the counter reaches 0?  I=E2=80=99ll try, sounds good (if I can get it to=
 work).

Yes, that's what I have in mind.

We expect graph changes to happen during the polling, but I think the
caller is responsible for making sure that the top-level @bs stays
around, so we don't need to be extra careful here.

Also, bdrv_drain_invoke() is always called in the same AioContext as the
top-level drain operation, so the whole aio_context_acquire/release
stuff from this series should become unnecessary, and we don't need
atomics to access the counter either.

So I think this should really simplify the series a lot.

Kevin

--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdLf1aAAoJEH8JsnLIjy/WMWAP/jIJmeXmZ9FytP79Hf1ONlRg
7SOP+fDUc/Y9q5Le4JaQpIov/EYpCLvyQRdRMU5/qfW8dfbQt4e4Gmd1VanHTgDI
TBOlahc1eezy7f+VopxNWrYk6jjHf0SU2uGkafM04rLhhIRZuvZrDs8gZRUKwE97
XRKjzlmfTxwxWDyqszTcQ4ld39SQJ7O0MZ8CaSxRGmd4c1Px1BGhK0i49Bmazaqr
BtMySzEqVDZixWQWAYZmwz/9rLNbonWIhHSse/RmgvuqYwRHmv3ywLT0ZPYI3DV0
aQMZz+Fi7toIy6i5MTSB5KpwxRqqU3vBgYCh3nsFq4R+DnNr0V17p58cMehwCuZ4
kHjkypRplHBwkNGrS3kWnerpa8pjI0KtCjDHr4lVTDzjX2h6rLzh4zRsEzHIqrid
IvooBp7Ros4ryQyUF0FXn607nFkc2ku3Qz8BpDfUXHAeuLTfnKLCbL/DKBs86s1j
5YVzKOLc+anSUsJG3jLsmXEmHGnihXOgvdVJnFy4tdqoSjX637AazYgkMM0Pm2up
Sqo5iVqg4RcEy0iXmdcenZryCkjpVAvKl6DFyh/EYcScTX5P607iJmBS1DV3tIua
WtWt74HzAN6KGQYyeZzGFXsGB671edV51xZ7sWHZT6/DSUCYHlD+u5hFiHSt4Da9
slHhGoXsjqUCwZo2XCPE
=OdpM
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--

