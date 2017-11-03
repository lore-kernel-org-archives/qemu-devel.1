Received: from eggs.gnu.org ([2001:4830:134:3::10]:36932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eAYlP-0001wS-PY
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 05:59:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eAYlM-0000Xc-NX
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 05:59:47 -0400
Date: Fri, 3 Nov 2017 09:59:41 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171103095941.GD5078@stefanha-x1.localdomain>
References: <20171102120223.GI32533@redhat.com>
	<50b7935f-c02f-7d7d-4e8e-fc8967e85d2e@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eheScQNz3K90DVRs"
Content-Disposition: inline
In-Reply-To: <50b7935f-c02f-7d7d-4e8e-fc8967e85d2e@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] RFC: use case for adding QMP,
 block jobs & multiple exports to qemu-nbd ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>


--eheScQNz3K90DVRs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 02, 2017 at 10:38:16PM +0100, Max Reitz wrote:
> On 2017-11-02 13:02, Daniel P. Berrange wrote:
> [...]
> > One alternative approach to doing this would be to suggest that we shou=
ld
> > instead just spawn qemu-system-x86_64 with '--machine none' and use that
> > as a replacement for qemu-nbd, since it already has a built-in NBD serv=
er
> > which can do many exports at once and arbitrary block jobs.
>=20
> As far as I know, we had wanted to add QMP support to qemu-nbd maybe one
> or two years ago, but nobody ever did it.

Beno=EEt Canet worked on this in 2014:
https://lists.gnu.org/archive/html/qemu-devel/2014-08/msg02533.html

> I've had some discussions about this with Markus and Kevin at KVM Forum.
>  They appeared to strongly prefer this approach.  I agree with them that
> design-wise, a qemu with no machine at all (and not even -M none) and
> early QMP is the way we want to go anyway, and then this would be the
> correct tool to use.
>=20
> > I'm concerned that this could end up being a be a game of whack-a-mole
> > though, constantly trying to cut out/down all the bits of system emulat=
ion
> > in the machine emulators to get its resource overhead to match the low
> > overhead of standalone qemu-nbd.
>=20
> However, I personally share your concern.  Especially, I think that
> getting to a point where we can have no machine at all and early QMP
> will take much longer than just adding QMP to qemu-nbd -- or adding a
> qmp command to qemu-img (because you can add NBD exports through QMP, so
> qemu-nbd's hardcoded focus on NBD exports seems kind of weird then)[1].
>=20
> I'm very much torn here.  There are two approaches: Stripping fat qemu
> down, or fattening lean qemu-img (?) up.  The latter is very simple.
> The former is what we want anyway.
>=20
> Markus says it's not too hard to strip down qemu.  If that is true,
> there is no point in fattening qemu-img now.  I personally am not
> convinced at all, but he knows the state of that project much better
> than me, so I cannot reasonably disagree.
>=20
> So my mail is more of a CC to Markus and Kevin -- but I think both are
> on PTO right now.
>=20
> I guess the main question is: If someone were to introduce a qemu-img
> QMP subcommand -- would it be accepted? :-)

I'm in favor of the -machine none approach since it seems inevitable
that both qemu-img and qemu-nbd will become QMP interfaces.  qemu-io has
already become a monitor interface...

> [1] Also, adding QMP should trivially add block jobs and multiple
> exports to whatever tool we are talking about (in fact, qemu-img already
> does perform the mirror block job for committing).
>=20

--eheScQNz3K90DVRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZ/D4NAAoJEJykq7OBq3PIBE0H/2IvcJp25Tf2Q2N2b+wa5klc
efHLen8x4pg2qDmRAFUlTy+qb5JoRCrN2uJvTK3P5jlWLLbeO/H2ujruNhhVtZdR
yjdvS3R+NDcaxDm5/pNUO5RG0wG1Aa0qeG/Lkme0kDhuA8imZ/qRY8dqW8QK7uus
JV4xcpqI/YsDdI5gzZvbPOdQ4o5mbza4fGWqsk8ANEVUT05pcLIvttRS9kD4C9Nd
6jqFPAUOHCdWJKcgEJxg0znycCcv3geUwhddiyreqmk2Bsnuy2aIwJVkZcK8he6q
dl6CjoYufNvIYq2YBKJKeXMsRLzwvPJ2zAJpTGHrmWDC/I/XBHZXYYwUj/RQBec=
=mf3b
-----END PGP SIGNATURE-----

--eheScQNz3K90DVRs--
