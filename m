Received: from eggs.gnu.org ([2001:4830:134:3::10]:59338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1df3Zd-0004JA-DS
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 08:25:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1df3ZY-0007iG-7C
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 08:25:25 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:37631)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1df3ZY-0007h0-0d
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 08:25:20 -0400
Received: by mail-wm0-x234.google.com with SMTP id t201so5780719wmt.0
	for <qemu-devel@nongnu.org>; Tue, 08 Aug 2017 05:25:19 -0700 (PDT)
Date: Tue, 8 Aug 2017 13:25:15 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170808122515.GL16801@stefanha-x1.localdomain>
References: <150142369849.12995.11229612194223213120.stgit@frigg.lan>
	<20170804153453.GG14565@stefanha-x1.localdomain>
	<87mv7fkwue.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B92bTrfKjyax39gr"
Content-Disposition: inline
In-Reply-To: <87mv7fkwue.fsf@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH v8 0/5] hypertrace: Lightweight
 guest-to-QEMU trace channel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Luiz Capitulino <lcapitulino@redhat.com>


--B92bTrfKjyax39gr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 04, 2017 at 09:32:25PM +0300, Llu=EDs Vilanova wrote:
> Stefan Hajnoczi writes:
>=20
> > On Sun, Jul 30, 2017 at 05:08:18PM +0300, Llu=EDs Vilanova wrote:
> >> The hypertrace channel allows guest code to emit events in QEMU (the h=
ost) using
> >> its tracing infrastructure (see "docs/trace.txt"). This works in both =
'system'
> >> and 'user' modes, is architecture-agnostic and introduces minimal nois=
e on the
> >> guest.
> >>=20
> >> See first commit for a full description, use-cases and an example.
> >>=20
> >> Signed-off-by: Llu=EDs Vilanova <vilanova@ac.upc.edu>
> >> ---
> >>=20
> >> Changes in v8
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>=20
> >> * Do not use 'seq' when there's no extra hypertrace arguments (BSD beh=
aves
> >> differently for "seq 0").
> >> * Fix compilation for bsd-user.
>=20
> > Hi Llu=EDs,
> > Any changes regarding the fundamental approach since September 2016?
>=20
> > Back then I had the following concerns about hypertrace for full-system
> > virtualization:
>=20
> > Going to QEMU for every guest trace event has high overhead under
> > virtualization.  The alternative approach is recording separate traces
> > and merging them for analysis.  This is possible with trace-cmd [1] and
> > LTTng [2].
>=20
> > Merging traces eliminates the performance bottleneck and does not
> > require new paravirt interfaces or guest tracing libraries.  I think it
> > it would be a distraction to support hypertrace for the virtualization
> > use case because it fundamentally has a high overhead.
>=20
> > I see promise in using hypertrace for TCG because it is low-overhead
> > when running inside the QEMU process.  I'll review the patches again
> > with this in mind and not focus on virtualization.
>=20
> > [1] https://lists.nongnu.org/archive/html/qemu-devel/2016-03/msg00887.h=
tml
> > [2] http://archive.eclipse.org/tracecompass/doc/stable/org.eclipse.trac=
ecompass.doc.user/Virtual-Machine-Analysis.html
> >     and also generic trace synchronization
> >     http://archive.eclipse.org/tracecompass/doc/stable/org.eclipse.trac=
ecompass.doc.user/Trace-synchronization.html#Trace_synchronization
>=20
> There's been no fundamental changes since then (just the few bits listed =
in the
> v5-v8 changelog).
>=20
> But I'm kind of split on this one.
>=20
> If you want high-performance trace correlation, this will work much bette=
r for
> TCG than virtualization (where [1] will probably be more efficient).
>=20
> If you want a hook to trigger other operations (like in the docs example)=
, I
> think this is the right approach. In fact, my initial interest in hypertr=
ace was
> for instrumentation, so maybe this should be subsumed into the proposal o=
f a
> stable instrumentation API.
>=20
> What do you think?

That sounds good.

Stefan

--B92bTrfKjyax39gr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZia2rAAoJEJykq7OBq3PIzIQH/Amzv2CZTqacruhR5KteO8mL
agtUU09hGrbtcCLWocnuf/524jYUfQ5nUKoHAq1Awy2/PrrE5QWv1a5ahyKSPBxe
p/zrJGdmJW/JOEiix2MH3nV4BtIBLoThyO08Gmk+r/POES9OA4BxOuWhiaaw4j6x
V+QOnm2Zssjtflijp7CrfnYgrx8zmMWa6VZ93/upGD9VMUozY9gOWLmNUR4j6o08
gm729q/B0q6O+ykQrGSaKoLwegEkZKwTCaPiQjBSQ4eVU/q2ELQSQ91G9ZwoIt3m
qHBb5k0QKrCQlPPl8ef6i93V3UfuhdrEuzshFNWYZ2iWqR+oEuODFHbbCCSOp3c=
=vzQQ
-----END PGP SIGNATURE-----

--B92bTrfKjyax39gr--
