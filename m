Received: from eggs.gnu.org ([209.51.188.92]:48120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hIr6P-00074Y-2T
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 04:48:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hIr1y-0007GF-B6
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 04:43:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hIr1x-0007EU-VL
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 04:43:58 -0400
Date: Tue, 23 Apr 2019 09:43:49 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190423084349.GA32465@stefanha-x1.localdomain>
References: <20190418161311.24197-1-stefanha@redhat.com>
	<21091c08-02cf-52de-6d7c-2031dfd38cd5@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <21091c08-02cf-52de-6d7c-2031dfd38cd5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] security.rst: add Security Guide to
 developer docs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Otubo <otubo@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2019 at 06:47:18PM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 4/18/19 6:13 PM, Stefan Hajnoczi wrote:
> > +Virtualization Use Case
> > +~~~~~~~~~~~~~~~~~~~~~~~
> > +The virtualization use case covers cloud and virtual private server (V=
PS)
> > +hosting, as well as traditional data center and desktop virtualization=
=2E  These
> > +use cases rely on hardware virtualization extensions to execute guest =
code
> > +safely on the physical CPU at close-to-native speed.
> > +
> > +The following entities are **untrusted**, meaning that they may be bug=
gy or
> > +malicious:
> > +
> > +* Guest
> > +* User-facing interfaces (e.g. VNC, SPICE, WebSocket)
> > +* Network protocols (e.g. NBD, live migration)
> > +* User-supplied files (e.g. disk images, kernels, device trees)
>=20
> What about pass-thru USB/PCI devices?

Can you give a real-world example?

> > +Guest Isolation
> > +~~~~~~~~~~~~~~~
> > +Guest isolation is the confinement of guest code to the virtual machin=
e.  When
> > +guest code gains control of execution on the host this is called escap=
ing the
> > +virtual machine.  Isolation also includes resource limits such as CPU,=
 memory,
> > +disk, or network throttling.  Guests must be unable to exceed their re=
source
>=20
> I'm unsure but I'd have written "... such as throttling of CPU, memory,
> disk or network".

Will change in v2.

> > +Unexpected Device Accesses
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +The guest may access device registers in unusual orders or at unexpect=
ed
> > +moments.  Device emulation code must not assume that the guest follows=
 the
> > +typical "theory of operation" presented in driver writer manuals.  The=
 guest
> > +may make nonsense accesses to device registers such as starting operat=
ions
> > +before the device has been fully initialized.
> > +
> > +A related issue is that device emulation code must be prepared for une=
xpected
> > +device register accesses while asynchronous operations are in progress=
=2E  A
> > +well-behaved guest might wait for a completion interrupt before access=
ing
> > +certain device registers.  Device emulation code must handle the case =
where the
> > +guest overwrites registers or submits further requests before an ongoi=
ng
> > +request completes.  Unexpected accesses must not cause memory corrupti=
on or
> > +leaks in QEMU.
>=20
> Might worth to tell such unexpected accesses might be logged with
> 'qemu_log_mask(LOG_GUEST_ERROR, ...) and audited with -d guest_errors?

Will add in v2.

Stefan

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcvtBFAAoJEJykq7OBq3PIrLEH/RckOiqXB62LelRG4lu8N+Qj
9sFIV+wy/YMHFkdgde5GhQlxpbAlzdtpIxRri/OJwFZMp/t1ih70B3Q9p75WDZ3X
gqdqKcCUTOIqyTNGbfba4QuLnaLiSg2Sf6O8Rohd9Zgas/KSW9XoH2uK/uxteChY
9jqX3jXjqjW0eZN2VNaxDlouZHXk3tWAaJC9aqMjyWtDf3PWA3LITimdn6ucwE5O
0sdohPYNhgE1gbsfuewJTY6rYTv245iVBPbimQEtE9n5tGiCpw0Cv6mHuh4IbIYg
FrC0drRHaBxfKVBrXRTFZJwBDGOxiZ2dScHVz+PKt4pEV4/Vlmcd8r23kaK36aU=
=rHq6
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
