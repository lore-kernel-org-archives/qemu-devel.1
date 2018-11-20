Received: from eggs.gnu.org ([2001:4830:134:3::10]:49618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gPADg-0004sM-MN
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 12:53:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gPADf-0005uv-Oe
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 12:53:52 -0500
Date: Tue, 20 Nov 2018 17:53:33 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181120175333.GB25047@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181116155325.22428-1-berrange@redhat.com>
	<20181116155325.22428-7-berrange@redhat.com>
	<20181120172701.GC7513@localhost.localdomain>
	<60be62b6-86aa-f6fa-3b5f-c37f9d051d8c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60be62b6-86aa-f6fa-3b5f-c37f9d051d8c@redhat.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Tue, Nov 20, 2018 at 11:45:54AM -0600, Eric Blake wrote:
> On 11/20/18 11:27 AM, Kevin Wolf wrote:
> > Am 16.11.2018 um 16:53 hat Daniel P. Berrang=C3=A9 geschrieben:
> > > Add tests that validate it is possible to connect to an NBD server
> > > running TLS mode. Also test mis-matched TLS vs non-TLS connections
> > > correctly fail.
> >=20
> > > +echo
> > > +echo "=3D=3D preparing TLS creds =3D=3D"
> > > +
> > > +tls_x509_create_root_ca "ca1"
> > > +tls_x509_create_root_ca "ca2"
> > > +tls_x509_create_server "ca1" "server1"
> > > +tls_x509_create_client "ca1" "client1"
> > > +tls_x509_create_client "ca2" "client2"
> >=20
> > Looks like we can't blindly assume that certtool exists. This test ca=
se
> > fails for me, starting with the following diff:
>=20
> Looks like we'll need a followup patch to skip the test if certtool is =
not
> found. (I already did the same in common.nbd if 'ss' was not found; so =
it
> should be easy to copy...)

FWIW certtool is part of gnutls-utils and is available on every platform
that QEMU officially supports as a build target.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
