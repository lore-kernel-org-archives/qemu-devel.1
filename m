Received: from eggs.gnu.org ([2001:4830:134:3::10]:39601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gPOpz-0000mx-To
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 04:30:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gPOpz-0005mL-1x
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 04:30:23 -0500
Date: Wed, 21 Nov 2018 09:30:02 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181121093002.GF26577@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181116155325.22428-1-berrange@redhat.com>
	<20181116155325.22428-7-berrange@redhat.com>
	<20181120172701.GC7513@localhost.localdomain>
	<60be62b6-86aa-f6fa-3b5f-c37f9d051d8c@redhat.com>
	<20181120175333.GB25047@redhat.com>
	<a56dbf66-14f1-5a57-0f0f-28877072d176@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Tue, Nov 20, 2018 at 12:22:39PM -0600, Eric Blake wrote:
> On 11/20/18 11:53 AM, Daniel P. Berrang=C3=A9 wrote:
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

Yes, I just assumed that the iotests could expect a fully featured instal=
l

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
