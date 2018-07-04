Received: from eggs.gnu.org ([2001:4830:134:3::10]:39109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1faogv-0008SX-4z
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 16:47:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1faogr-0002vX-VS
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 16:47:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1faogr-0002uu-M3
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 16:47:53 -0400
Date: Wed, 4 Jul 2018 17:47:47 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180704204746.GF7451@localhost.localdomain>
References: <20180622004435.10291-1-f4bug@amsat.org>
	<20180622004435.10291-5-f4bug@amsat.org>
	<87in62vq15.fsf@linaro.org>
	<543f19ab-385c-4e77-b243-d6740b456360@amsat.org>
	<87bmbuvjvl.fsf@linaro.org>
	<2a4024fa-dcc7-701d-dd9c-0777aa02869b@amsat.org>
	<643265a1-f613-e14f-ac25-900133e52528@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <643265a1-f613-e14f-ac25-900133e52528@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/6] tests/acceptance: Add a
 BootLinuxConsoleMips test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, BALATON Zoltan <balaton@eik.bme.hu>, Laurent Vivier <laurent@vivier.eu>

On Wed, Jul 04, 2018 at 04:56:44PM -0300, Philippe Mathieu-Daud=E9 wrote:
> On 06/28/2018 07:45 PM, Philippe Mathieu-Daud=E9 wrote:
> > On 06/28/2018 03:36 PM, Alex Benn=E9e wrote:
> >> Philippe Mathieu-Daud=E9 <f4bug@amsat.org> writes:
> >>> On 06/28/2018 01:23 PM, Alex Benn=E9e wrote:
[...]
> >>>>> +    def test(self):
> >>>>> +        kernel_url =3D ('http://people.debian.org/~aurel32/qemu/=
mips/'
> >>>>> +                      'vmlinux-3.2.0-4-4kc-malta')
> >>>>> +        kernel_hash =3D '592e384a4edc16dade52a6cd5c785c637bcbc9a=
d'
> >>>>> +        kernel_path =3D self.fetch_asset(kernel_url,
> >>>>> asset_hash=3Dkernel_hash)
> >>>>
> >>>> I'm uncomfortable using "random" binaries of websites as the sourc=
e of
> >>>> our test kernels. I can see the justification for distro kernels a=
s they
> >>>> at least have the infrastructure to rebuild from source if you rea=
lly
> >>>> want to, but even then the distros don't cover a lot of the
> >>>> architectures.
>=20
> Alex: I could find all the Linux kernel I'm interested to console-test
> with Avocado on the http://snapshot.debian.org/ archive website.
>=20
> For example Aurelien's one (more up-to-date) is available here:
> http://snapshot.debian.org/package/linux-2.6/2.6.32-48/#linux-image-2.6=
.32-5-4kc-malta_2.6.32-48
>=20
> I also added a SH-4 test for the SM501 series of Zoltan BALATON using
> the kernel extracted from this distrib built kernel:
> http://snapshot.debian.org/package/linux-2.6/2.6.32-30/#linux-image-2.6=
.32-5-sh7751r_2.6.32-30
>=20
> The Debian distribution also provide the source package and the kernels
> can be simply rebuilt using make-kpkg or (make bindeb-pkg with more
> recent kernels).
>=20
> Would it be enough to satisfy the GPL requirements to provided that inf=
o
> in the header and use these handy pre-compiled kernels?

(IANAL, etc.)

Personally, I would try to avoid dealing with the "written offer"
option of the GPL, and just publish the sources in the same
medium (HTTP download repository, git repository, etc) as the
binary.

There was a related discussion about distribution of firmware
binaries at <https://www.mail-archive.com/qemu-devel@nongnu.org/msg475674=
.html>.
It looks like we never applied the docs/firmware.txt patch,
though.

--=20
Eduardo
