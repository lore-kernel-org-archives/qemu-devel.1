Received: from eggs.gnu.org ([2001:4830:134:3::10]:50851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gPE0U-0005eb-GW
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 16:56:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gPE0S-0003iD-Pu
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 16:56:30 -0500
Date: Tue, 20 Nov 2018 22:56:17 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181120215617.GG7513@localhost.localdomain>
References: <20181116155325.22428-1-berrange@redhat.com>
	<20181116155325.22428-7-berrange@redhat.com>
	<20181120172701.GC7513@localhost.localdomain>
	<60be62b6-86aa-f6fa-3b5f-c37f9d051d8c@redhat.com>
	<20181120175333.GB25047@redhat.com>
	<a56dbf66-14f1-5a57-0f0f-28877072d176@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <a56dbf66-14f1-5a57-0f0f-28877072d176@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 6/6] tests: exercise NBD server in TLS mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 20.11.2018 um 19:22 hat Eric Blake geschrieben:
> On 11/20/18 11:53 AM, Daniel P. Berrang=E9 wrote:
>=20
> > > > > +echo
> > > > > +echo "=3D=3D preparing TLS creds =3D=3D"
> > > > > +
> > > > > +tls_x509_create_root_ca "ca1"
> > > > > +tls_x509_create_root_ca "ca2"
> > > > > +tls_x509_create_server "ca1" "server1"
> > > > > +tls_x509_create_client "ca1" "client1"
> > > > > +tls_x509_create_client "ca2" "client2"
> > > >=20
> > > > Looks like we can't blindly assume that certtool exists. This tes=
t case
> > > > fails for me, starting with the following diff:
> > >=20
> > > Looks like we'll need a followup patch to skip the test if certtool=
 is not
> > > found. (I already did the same in common.nbd if 'ss' was not found;=
 so it
> > > should be easy to copy...)
> >=20
> > FWIW certtool is part of gnutls-utils and is available on every platf=
orm
> > that QEMU officially supports as a build target.
>=20
> Ported to the build target !=3D installed on the build machine. The fai=
lure is
> happening on machines that do not have all the build prerequisites (sin=
ce it
> should still be possible to configure qemu to build without TLS, right?=
)

It happens on my laptop, and qemu builds just fine.

Kevin
