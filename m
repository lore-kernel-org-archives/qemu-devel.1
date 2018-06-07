Received: from eggs.gnu.org ([2001:4830:134:3::10]:46869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fQuAV-0004Mt-4s
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 08:37:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fQuAR-0003l9-0F
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 08:37:31 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33512)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fQuAQ-0003kW-O1
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 08:37:26 -0400
Received: by mail-wm0-x241.google.com with SMTP id z6-v6so3029540wma.0
	for <qemu-devel@nongnu.org>; Thu, 07 Jun 2018 05:37:26 -0700 (PDT)
Date: Thu, 7 Jun 2018 13:37:23 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180607123723.GI19032@stefanha-x1.localdomain>
References: <1528143278-247932-1-git-send-email-imammedo@redhat.com>
	<20180605010413.GF3184@localhost.localdomain>
	<20180605102703.6fdee3c5@redhat.com>
	<20180605084744.GG32286@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vs0rQTeTompTJjtd"
Content-Disposition: inline
In-Reply-To: <20180605084744.GG32286@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] vl.c: make default main_loop_wait()
 timeout independed of slirp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, ldoktor@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, jan.kiszka@siemens.com, qemu-devel@nongnu.org, mreitz@redhat.com, mprivozn@redhat.com, pbonzini@redhat.com


--vs0rQTeTompTJjtd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 05, 2018 at 09:47:44AM +0100, Daniel P. Berrang=E9 wrote:
> On Tue, Jun 05, 2018 at 10:27:03AM +0200, Igor Mammedov wrote:
> > On Mon, 4 Jun 2018 22:04:13 -0300
> > Eduardo Habkost <ehabkost@redhat.com> wrote:
> >=20
> > > On Mon, Jun 04, 2018 at 10:14:38PM +0200, Igor Mammedov wrote:
> > > > Since commit (047f7038f58 cli: add --preconfig option) QEMU is
> > > > stuck with indefinite timeout in os_host_main_loop_wait()
> > > > at RUN_STATE_PRECONFIG even if --preconfig option wasn't used
> > > > when it's started with -nodefaults CLI option like this:
> > > >=20
> > > >   ./s390x-softmmu/qemu-system-s390x -nodefaults
> > > >=20
> > > > It's caused by the fact that slirp_pollfds_fill() bails out early
> > > > and slirp_update_timeout() won't be called to update timeout
> > > > to a reasonable value (1 sec) so timeout would be left with
> > > > infinite value (0xFFFFFFFF).
> > > >=20
> > > > Default infinite timeout though doen't make sense and reducing
> > > > it to 1 second as in slirp_update_timeout() won't affect host. =20
> > >=20
> > > I don't get this part.  Why default infinite timeout doesn't make
> > > sense?  Why would a 1 second timeout make sense?
> > I've meant that there is no reason for infinite timeuot,
> > and 1sec is good as any other finite one.
>=20
> I don't really agree - it is better to not wakeup at all if there's
> no work todo rather than pointlessly wake up once a second, to deal
> with a hack for the SLIRP feature that's almost never used in most
> production scenarios..

Right, a host with 1000 VMs should experience 1000 wakeups/second for no
good reason.  QEMU needs to be scalable.

Stefan

--vs0rQTeTompTJjtd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbGScDAAoJEJykq7OBq3PIFDkIAMC30/gFkeQm7k7O1EKaK9MN
IfkuF104mioxSApMgDYgDkQysGh0/InEloH2Uz5F/n71l29KnkhzYqU9iL7lKlzN
BOsIXGMcUXcwEtF5qo2fih4BLyzWA+xr/MJIUVa46zRfz865N0Oc6U1WPu09rovl
6rLyJ9YNkDSuvD3hCTDW/x+bXhSe9IKvleDJsiECqZ6XIWxn3MbHj97/u6uLyIpO
ltS9zyejjWvxbLoaZM+qU0/+v/IR4xlCeoA/bUn+o4DtZCKTsLCBrYu4k2khIEVT
JQBfZUWmry8xF06U3msZaeHniewffzRrEKRO9VRaj2BBYfB6VDQjXR05bw6v/Ks=
=gPi1
-----END PGP SIGNATURE-----

--vs0rQTeTompTJjtd--
