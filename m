Received: from eggs.gnu.org ([2001:4830:134:3::10]:39723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fk1BS-0003C6-57
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 01:57:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fk1BO-0007IB-37
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 01:57:30 -0400
Received: from ozlabs.org ([203.11.71.1]:50017)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1fk1BN-0007Hl-56
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 01:57:26 -0400
Date: Mon, 30 Jul 2018 15:57:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180730055715.GD2708@umbus.fritz.box>
References: <153252992640.319494.8451297710133862507.stgit@bahia.lan>
	<20180727052724.GJ3694@umbus.fritz.box>
	<20180727095452.45edee8b@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NklN7DEeGtkPCoo3"
Content-Disposition: inline
In-Reply-To: <20180727095452.45edee8b@bahia>
Subject: Re: [Qemu-devel] [PATCH for-3.1] tests/cpu-plug-test: check CPU
 hotplug on ppc64 with KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>


--NklN7DEeGtkPCoo3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 27, 2018 at 09:54:52AM +0200, Greg Kurz wrote:
> On Fri, 27 Jul 2018 15:27:24 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Wed, Jul 25, 2018 at 04:45:26PM +0200, Greg Kurz wrote:
> > > Commit b585395b655 fixed a regression introduced by some recent chang=
es
> > > in the XICS code, that was causing QEMU to crash instantly during CPU
> > > hotplug with KVM. This is typically the kind of bug we'd like our
> > > test suite to detect before it gets merged. Unfortunately, the current
> > > tests run with '-machine accel=3Dqtest' and don't exercise KVM specif=
ic
> > > paths in QEMU.
> > >=20
> > > This patch hence changes add_pseries_test_case() to launch QEMU with
> > > '-machine accel=3Dkvm' if KVM is available.
> > >=20
> > > A notable consequence is that the guest will execute SLOF, but for so=
me
> > > reasons SLOF sometimes hits a program exception. This causes the guest
> > > to loop forever and the test to be stuck.  Since we don't need the gu=
est
> > > to be truely running, let's pass -S to QEMU to avoid that.
> > >=20
> > > Also disable machine capabilities that could be unavailable in KVM, e=
g,
> > > when using PR KVM.
> > >=20
> > > Signed-off-by: Greg Kurz <groug@kaod.org> =20
> >=20
> > I'm pretty sure trying to change the accelerator on a qtest test just
> > doesn't make sense.  We'd need a different approach for testing cpu
> > hotplug against kvm & tcg backends.
> >=20
>=20
> The test starts QEMU, triggers the CPU hotplug code with a QMP command
> and checks the command didn't fail (or QEMU didn't crash, as it would
> have before commit b585395b655a)... I really don't understand what
> is wrong with that... Please elaborate.

Well, ok, let me turn that around.  A test that doesn't rely on
controlling the guest side behaviour at all probably shouldn't be a
qtest based test, since that's what qtest is all about.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NklN7DEeGtkPCoo3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlteqLkACgkQbDjKyiDZ
s5KcmA/+KSvN5KYNsCcZxpOn+ano7vdaafaaa0y30blN6ICodZ3t0XxXbfzySaUW
78lFZeqLyPuhC2+zhRTmjCmC9jUhAaPLz+uuBNuA2Jr8LW9biv0hZWZI6vCT7DVl
7ln3UsqBgRjnxU29Q4rR92S+0UrRYuZxDHIff38Rcs1E770LAS17XZgMCOZWSxh8
KUHa3v5l4ZbQ+fbgYnaRuLh8W8LLtppnq9nZ4mMzQsAlRDc1Ub3qo07vkAiG6NbG
IAEOc+wgNs4uE1Eak52hqWtRggcd4jH9XdohdoyLqYhCqoLKUHHTSh2znQoYVCnm
XuUABSFl255VyWbQ2nluVVZF37+ZxWHMOMIZ3A6LNa1iUlF8XYDjDpPYcxKn0USq
P459M/SQRBIpqolQlBshT76GfJhdzcZwZ1U5I1engML29fUKB7/KhxHspA8FmaAo
prt3yhqRy9yxeTYLQcVSaVWUBhLK8WDurOmoC8+aPFDaPbLjJetsPuxxAC15NkZq
bkz+ShoQ6eQez4fG5Ui/yXJ8yB6nsTIaQyIvB8hImO/Q4o0PC9Dcmq6H/1D1AKCs
ikQaG1Tmt/FdrGOwQaX6BlZbW4JeiyNUSWU5+zFAG/UFmW1bmQ/ox5++UPz+vdLr
nwm1VrLQIJUTN9RLxymKqDW4OBhCLE5FHOonin5L+KZ6odfFwTY=
=t77W
-----END PGP SIGNATURE-----

--NklN7DEeGtkPCoo3--
