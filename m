Received: from eggs.gnu.org ([2001:4830:134:3::10]:56681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1fH91W-0007aH-3Z
	for qemu-devel@nongnu.org; Fri, 11 May 2018 10:27:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1fH91S-0001Ad-5N
	for qemu-devel@nongnu.org; Fri, 11 May 2018 10:27:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60294 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1fH91R-00019H-Vh
	for qemu-devel@nongnu.org; Fri, 11 May 2018 10:27:50 -0400
References: <20171108022828.7242-1-f4bug@amsat.org>
	<23253f77-ccc8-220d-3028-f27945f9542c@redhat.com>
	<791dd038-8811-6335-75f7-6dd309ff0ff7@amsat.org>
	<20180511135544.GH25013@localhost.localdomain>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <4e72cde3-8475-2964-b834-f74d15d66cae@redhat.com>
Date: Fri, 11 May 2018 10:27:41 -0400
MIME-Version: 1.0
In-Reply-To: <20180511135544.GH25013@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Publishing binary images for testing (was Re: [RFC
 PATCH 0/6] generic way to deprecate machines)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, avocado-devel@redhat.com



On 05/11/2018 09:55 AM, Eduardo Habkost wrote:
> (CCing Cleber and avocado-devel in case they have suggestions)
>=20
> On Tue, May 08, 2018 at 12:47:52PM -0300, Philippe Mathieu-Daud=C3=A9 w=
rote:
> [...]
>> Ironically I have been using the Gumstix machines quite a lot for the =
SD
>> 'subsystem' refactor, using the MMC commands in U-Boot (I am unable to
>> reach the Linux userland since the kernel crashes), and plan to add SD
>> integration tests via Avocado.
>>
>> This raises:
>>
>> - What will happens if I add tests downloading running on their compil=
ed
>> u-boot
>> (https://downloads.gumstix.com/images/angstrom/developer/2012-01-22-17=
50/u-boot.bin)
>> and the company decides to remove this old directory?
>> Since sometimes old open-source software are hard to rebuild with rece=
nt
>> compilers, should we consider to use a public storage to keep
>> open-source (signed) blobs we can use for integration testing?
>=20
> I think a maintained repository of images for testing would be
> nice to have.  We need to be careful to comply with the license
> of the software being distributed, though.
>=20
> If the images are very small (like u-boot.bin above), it might be
> OK to carry them in qemu.git, just like the images in pc-bios.
>=20
>>
>> Avocado has a 'vmimage library' which could be extended, adding suppor=
t
>> for binary url + detached gpg signatures from some QEMU maintainers?
>=20
> Requiring a signature makes the binaries hard to replace.  Any
> specific reason to suggest gpg signatures instead of just a
> (e.g.) sha256 hash?
>=20
>>
>> (I am also using old Gentoo/Debian packaged HPPA/Alpha Linux kernel fo=
r
>> Avocado SuperIO tests, which aren't guaranteed to stay downloadable
>> forever).
>=20
> Question for the Avocado folks: how this is normally handled in
> avocado/avocado-vt?  Do you maintain a repository for guest
> images, or you always point to their original sources?
>=20

For pure Avocado, the vmimage library attempts to fetch, by default, the
latest version of a guest image directly from the original sources.
Say, a Fedora image will be downloaded by default from the Fedora
servers.  Because of that, we don't pay too much attention to the
availability of specific (old?) versions of guest images.

For Avocado-VT, there are the JeOS images[1], which we keep on a test
"assets" directory.  We have a lot of storage/bandwidth availability, so
it can be used for other assets proven to be necessary for tests.

As long as distribution rights and licensing are not issues, we can
definitely use the same server for kernels, u-boot images and what not.

[1] - https://avocado-project.org/data/assets/

--=20
Cleber Rosa
[ Sr Software Engineer - Virtualization Team - Red Hat ]
[ Avocado Test Framework - avocado-framework.github.io ]
[  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]
