Received: from eggs.gnu.org ([2001:4830:134:3::10]:57614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eCMQB-0006eH-48
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 04:13:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eCMQ6-00038A-RT
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 04:13:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eCMQ6-00037z-J2
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 04:13:14 -0500
Date: Wed, 8 Nov 2017 09:13:03 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171108091303.GH12670@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171108022828.7242-1-f4bug@amsat.org>
	<20171108022828.7242-6-f4bug@amsat.org>
	<b49e3557-7593-44ac-3337-41ee95451457@ozlabs.ru>
	<17a9e801-0f13-a438-e57d-f511c5ed92ee@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <17a9e801-0f13-a438-e57d-f511c5ed92ee@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 5/6] hw/i386: deprecate the pc-0.10 and
 pc-0.11 machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

On Wed, Nov 08, 2017 at 12:28:00AM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> Hi Alexey,
>=20
> On 11/07/2017 11:48 PM, Alexey Kardashevskiy wrote:
> > On 08/11/17 13:28, Philippe Mathieu-Daud=C3=A9 wrote:
> >> Both are deprecated since 2.9.0
> >=20
> > May be so but I could not find where this happened in git history:
> >=20
> > [vpl1 qemu]$ git log -n1 --grep 'pc-0.10'
> > f6d5a0bad2 2 years, 5 months ago Eduardo Habkost piix: Define PC_COMP=
AT_0_10
> >=20
> > Having some pointers in the commit log would be helpful imho, like [2=
/6].
>=20
> Ok! If there is positive feedback on this series I'll respin trying to
> be more verbose.
>=20
> I took "2.9.0" from the wiki history [1], which is the formal way to go
> as I understand:

No, the wiki page content was just an initial jumping off point for
discussions.  The formal list of what's deprecated is kept in the
qemu-doc.texi file in the "Deprecated features" appendix.

We really ought to remove most of the content from that wiki page
and just point to the formal docs,  to avoid continued confusion
like this.

>=20
> Before an "interface" can be removed, there needs to be a clear
> transition plan for doing so. This means it should be added to this wik=
i
> page, and that there have to be at least two public releases of QEMU
> where the interface still works, but issues a warning when used. Two
> public releases are required so that the users have at least one
> development cycle to complain if they think that there is a good reason
> that the interface should not be removed. The warning should say that
> the interface is deprecated / going away soon, with a pointer to
> documentation or similar information about its replacement syntax.
>=20
> [1]
> https://wiki.qemu.org/index.php?title=3DFeatures/LegacyRemoval&action=3D=
history
>=20
> >>
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >> ---
> >>  hw/i386/pc_piix.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> >> index f79d5cb694..c462b702ff 100644
> >> --- a/hw/i386/pc_piix.c
> >> +++ b/hw/i386/pc_piix.c
> >> @@ -941,6 +941,7 @@ static void pc_i440fx_0_11_machine_options(Machi=
neClass *m)
> >>      pc_i440fx_0_12_machine_options(m);
> >>      m->hw_version =3D "0.11";
> >>      SET_MACHINE_COMPAT(m, PC_COMPAT_0_11);
> >> +    m->deprecated_reason =3D "Too old";
> >>  }
> >> =20
> >>  DEFINE_I440FX_MACHINE(v0_11, "pc-0.11", pc_compat_0_13,
> >> @@ -976,6 +977,7 @@ static void pc_i440fx_0_10_machine_options(Machi=
neClass *m)
> >>      pc_i440fx_0_11_machine_options(m);
> >>      m->hw_version =3D "0.10";
> >>      SET_MACHINE_COMPAT(m, PC_COMPAT_0_10);
> >> +    m->deprecated_reason =3D "Too old";
> >>  }
> >> =20
> >>  DEFINE_I440FX_MACHINE(v0_10, "pc-0.10", pc_compat_0_13,
> >>
>=20
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
