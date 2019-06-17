Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AA9C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 16:52:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A515120863
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 16:52:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A515120863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49520 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcurg-0005z4-06
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 12:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51124)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hcuS9-0007a7-7p
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:25:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hcuS5-0007ud-Ii
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:25:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43526)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hcuS0-0007oP-2J; Mon, 17 Jun 2019 12:25:44 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3AD4181DEC;
 Mon, 17 Jun 2019 16:25:40 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-99.ams2.redhat.com [10.36.117.99])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 664745C2F5;
 Mon, 17 Jun 2019 16:25:33 +0000 (UTC)
Date: Mon, 17 Jun 2019 18:25:31 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190617162531.GM7397@linux.fritz.box>
References: <20190529154654.95870-5-vsementsov@virtuozzo.com>
 <c31e0d6e-3754-8b22-ccee-84c772eca404@redhat.com>
 <7b401fba-36dd-d80e-966a-15fdd72ac335@virtuozzo.com>
 <825995ac-488e-b25c-c551-526812046caf@redhat.com>
 <46ad242a-3aa5-bfa1-1d64-5f2e98f4ed32@virtuozzo.com>
 <46f18bb5-f123-b20a-7cb9-97caedae8290@redhat.com>
 <13b8c3d7-dd95-d42f-e7bc-86907444b78a@virtuozzo.com>
 <9a6a5790-c9ff-e8a4-3a41-4aebe554ae1c@redhat.com>
 <20190617155315.GK7397@linux.fritz.box>
 <b86c6a8f-7a89-58ca-6966-b2f00aff0f2b@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="gr/z0/N6AeWAPJVB"
Content-Disposition: inline
In-Reply-To: <b86c6a8f-7a89-58ca-6966-b2f00aff0f2b@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Mon, 17 Jun 2019 16:25:40 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v8 4/7] block: introduce backup-top filter
 driver
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
Cc: "fam@euphon.net" <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--gr/z0/N6AeWAPJVB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 17.06.2019 um 18:01 hat Max Reitz geschrieben:
> >>> Should new implicit/explicit
> >>> filters be created above or under them?
> >>
> >> That was always the most difficult question we had when we introduced
> >> filters.
> >>
> >> The problem is that we never answered it in our code base.
> >>
> >> One day, we just added filters (=E2=80=9Clet=E2=80=99s see what happen=
s=E2=80=9D), and in the
> >> beginning, they were all explicit, so we still didn=E2=80=99t have to =
answer
> >> this question (in code).  Then job filters were added, and we still
> >> didn=E2=80=99t have to, because they set blockers so the graph couldn=
=E2=80=99t be
> >> reorganized with them in place anyway.
> >>
> >> If we converted copy-on-read=3Don to a COR node, we would have to answ=
er
> >> that question.
> >=20
> > That's why we shouldn't do that, but just remove copy-on-read=3Don. :-)
>=20
> And BB-level throttling, fair enough.
>=20
> (Although the first step would be probably to make throttle groups
> non-experimental?  Like, drop the x- prefix for all their parameters.)

The first step would be making the block drivers full replacements of
the old things, which unfortunately isn't true today.

After your "deal with filters" series, we should be a lot closer for the
core infrastructure at least.

Not sure about copy-on-read, but I know that throttle still doesn't have
feature parity with -drive throttling. At least I'm pretty sure that
something about changing the group or group options at runtime (and not
just dropping the x-) was missing.

> >>>>> But should really filter do that job, or it is here only to do CBW?=
 Maybe target
> >>>>> must have another parent which will care about flushing.
> >>>>>
> >>>>> Ok, I think I'll flush target here too for safety, and leave a comm=
ent, that something
> >>>>> smarter would be better.
> >>>>> (or, if we decide to flush all children by default in generic code,=
 I'll drop this handler)
> >>>>
> >>>> [1] Thinking more about this, for normal backups the target file does
> >>>> not reflect a valid disk state until the backup is done; just like f=
or
> >>>> qemu-img convert.  Just like qemu-img convert, there is therefore no
> >>>> reason to flush the target until the job is done.
> >=20
> > Depends, the target could have the source as its backing file (like
> > fleecing, but without exporting it right now), and then you could always
> > have a consistent view on the target. Well, almost.
> >=20
> > Almost because to guarantee this, we'd have to flush between each CBW
> > and the corresponding write to the same block, to make sure that the old
> > data is backed up before it is overwritten.
>=20
> Yes, that=E2=80=99s what I meant by =E2=80=9Cenforce on the host that the=
 target is
> always flushed before the source=E2=80=9D.  Well, I meant to say there is=
 no
> good way of doing that, and I kind of don=E2=80=99t consider this a good =
way.
>=20
> > Of course, this would perform about as badly as internal COW in qcow2...
> > So probably not a guarantee we should be making by default. But it might
> > make sense as an option.
>=20
> I don=E2=80=99t know.  =E2=80=9CUse this option so your data isn=E2=80=99=
t lost in case of a
> power failure, but it makes everything pretty slow=E2=80=9D?  Who is goin=
g to do
> explicitly enable that (before their first data loss)?

Maybe the backup job wasn't that clever after all. At least if you care
about keeping the point-in-time snapshot at the start of the backup job
instead of just retrying and getting a snapshot of a different point in
time that is just as good.

If you do care about the specific point in time, the safe way to do it
is to take a snapshot and copy that away, and then delete the snapshot
again.

The only problem is that merging external snapshots is slow and you end
up writing the new data twice. If only we had a COW image format... :-)

Kevin

--gr/z0/N6AeWAPJVB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdB777AAoJEH8JsnLIjy/WOLAQAKM2sRkVdF2zFttSbwGWpGcO
roVW3451+kLJjTiIhS6e6IaC1z7UGhq/NCAWdiMR3Nbi20i++MXiY2sQEH1+6PBM
JP10I3bS1i+sLs+ZN0UjcUHkjDvebT5fAa2EO6FNUsmUYnpfbSFYQXSpEgM21uUU
2Laf20NiLuj+kPSMEZJKFU6okcSeWseAOnKz9Q4hcWpDnJc5hfL2Kr9Bkn7ly+hF
11TjTMaJq/TSmzWrNnmmhMz1BrqOhA0itVNd/sfq9sLL7YQfuO2VzDIM+WyATEmU
eaLt8ymUicOWzIis1j0+MEF45OLlBvlt44AC/gT0/wAnWgVRe0NENULQL3II4Rdy
ftWYqgqPsTgSGdXmCU+5Yo1Pp7m8896vXQD3eYAboP3pKOQq2JB2+AYewLqbfnWI
KTQ5TymGfbRYXTkK77fUXmLUWrVDTk1I4gKFns5pKjEuf+LEI/9bP3CfXymw4JkB
GANVncZ1fZgl1RdYnm+Ix01gBAIDcNfBRDYVC+FT9leuvOPH97jybWEG/UVXBmyx
ljI2jksppeK0tWReroTR5nrrJePxaJ7nzfZaE8go/PZppluxFaQt1YmoR53XZLFe
SzflJm4+SHy2giOn14dKcDz3yeTiqnIXVuV6saH7HIF4SYnVt0f0g45fOuvVu8nR
Ru7dzT3IgCMrX4oVFdjQ
=n0g3
-----END PGP SIGNATURE-----

--gr/z0/N6AeWAPJVB--

