Received: from eggs.gnu.org ([2001:4830:134:3::10]:46589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fH8WX-0006vj-0P
	for qemu-devel@nongnu.org; Fri, 11 May 2018 09:55:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fH8WT-0001nI-U9
	for qemu-devel@nongnu.org; Fri, 11 May 2018 09:55:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fH8WT-0001n8-Nz
	for qemu-devel@nongnu.org; Fri, 11 May 2018 09:55:49 -0400
Date: Fri, 11 May 2018 10:55:44 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180511135544.GH25013@localhost.localdomain>
References: <20171108022828.7242-1-f4bug@amsat.org>
	<23253f77-ccc8-220d-3028-f27945f9542c@redhat.com>
	<791dd038-8811-6335-75f7-6dd309ff0ff7@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <791dd038-8811-6335-75f7-6dd309ff0ff7@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Publishing binary images for testing (was Re: [RFC
 PATCH 0/6] generic way to deprecate machines)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>, avocado-devel@redhat.com

(CCing Cleber and avocado-devel in case they have suggestions)

On Tue, May 08, 2018 at 12:47:52PM -0300, Philippe Mathieu-Daud=E9 wrote:
[...]
> Ironically I have been using the Gumstix machines quite a lot for the S=
D
> 'subsystem' refactor, using the MMC commands in U-Boot (I am unable to
> reach the Linux userland since the kernel crashes), and plan to add SD
> integration tests via Avocado.
>=20
> This raises:
>=20
> - What will happens if I add tests downloading running on their compile=
d
> u-boot
> (https://downloads.gumstix.com/images/angstrom/developer/2012-01-22-175=
0/u-boot.bin)
> and the company decides to remove this old directory?
> Since sometimes old open-source software are hard to rebuild with recen=
t
> compilers, should we consider to use a public storage to keep
> open-source (signed) blobs we can use for integration testing?

I think a maintained repository of images for testing would be
nice to have.  We need to be careful to comply with the license
of the software being distributed, though.

If the images are very small (like u-boot.bin above), it might be
OK to carry them in qemu.git, just like the images in pc-bios.

>=20
> Avocado has a 'vmimage library' which could be extended, adding support
> for binary url + detached gpg signatures from some QEMU maintainers?

Requiring a signature makes the binaries hard to replace.  Any
specific reason to suggest gpg signatures instead of just a
(e.g.) sha256 hash?

>=20
> (I am also using old Gentoo/Debian packaged HPPA/Alpha Linux kernel for
> Avocado SuperIO tests, which aren't guaranteed to stay downloadable
> forever).

Question for the Avocado folks: how this is normally handled in
avocado/avocado-vt?  Do you maintain a repository for guest
images, or you always point to their original sources?

--=20
Eduardo
