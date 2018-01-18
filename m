Received: from eggs.gnu.org ([2001:4830:134:3::10]:48250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ec9rk-0008Vg-Sy
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:04:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ec9rh-00046K-Mo
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:04:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ec9rh-00045w-Ht
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:04:21 -0500
Date: Thu, 18 Jan 2018 13:03:36 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20180118130336.GL19695@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1513877118-3149-1-git-send-email-jack.schwartz@oracle.com>
	<20180115155413.GJ32271@localhost.localdomain>
	<2f56a075-ba01-4329-b46c-33b3d40000cb@oracle.com>
	<20180118113500.GA4853@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180118113500.GA4853@localhost.localdomain>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH QEMU v1 0/4] multiboot: bss_end_addr can be
 zero / cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Jack Schwartz <jack.schwartz@oracle.com>, ehabkost@redhat.com, Anatol Pomozov <anatol.pomozov@gmail.com>, mst@redhat.com, daniel.kiper@oracle.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net

On Thu, Jan 18, 2018 at 12:35:00PM +0100, Kevin Wolf wrote:
> Am 17.01.2018 um 21:06 hat Jack Schwartz geschrieben:
> > Before I proceed with adding my multiboot test file, I'll clarify her=
e that
> > I started with a version from the grub2 tree.=C2=A0 In that file I ex=
panded a
> > header file, also from the same tree.=C2=A0 Neither file had any lice=
nse header,
> > though the tree I got them from (Dated October 2017) contains the GNU=
 GPLv3
> > license file.
>=20
> I see. QEMU as a whole is GPLv2, so this might be a problem. It's
> probably not as bad as merging GPLv3 code into QEMU proper because it's
> a standalone test kernel that I suppose could have a different license.
> But IANAL and maybe it's safer not to go there.

As long as the GPLv3 code is not linked / otherwise combined with any
of the GPLv2 code in QEMU that will be ok. Since it is a self-contained
test kernel, that would not be an issue in this case - it only interfaces
to QEMU via the x86 machine ABI.

It just means that the QEMU source tar.gz will be under a conjunction
of licenses  "GPLv2 and GPLv2+ and GPLv3 and ...all our other licenss..."

The resulting binaries for emulators/tools will still be GPLv2 as they're
only linking in the GPLv2 + GPLv2+ source, never linking the GPlv3 test
image.

For simplicity of understanding though, it could be desirable to avoid
this if not an unreasonable amount of extra work

> Maybe it would be less hassle to just reimplement the tests, based on
> the MIT licensed tests that are already in tests/multiboot/.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
