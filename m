Received: from eggs.gnu.org ([2001:4830:134:3::10]:39341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eSAUY-0005re-Ow
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 18:43:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eSAUW-0002le-57
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 18:43:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eSAUV-0002jI-UA
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 18:43:08 -0500
Date: Fri, 22 Dec 2017 01:43:06 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171222014258-mutt-send-email-mst@kernel.org>
References: <1513866427-27125-1-git-send-email-mst@redhat.com>
	<CAFEAcA_pt7XhXOhL2jSxwH9ooL7xjShmp6eBAYpRLc=dY-=TXQ@mail.gmail.com>
	<20171221223704-mutt-send-email-mst@kernel.org>
	<CAAdtpL74ZyVsLwgBjpbsdSHbWdY_Uq6ouRAvgo00UdVevTKq8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAAdtpL74ZyVsLwgBjpbsdSHbWdY_Uq6ouRAvgo00UdVevTKq8A@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/25] pc, pci, virtio: features, fixes,
 cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philippe@mathieu-daude.net>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, Dec 21, 2017 at 08:05:51PM -0300, Philippe Mathieu-Daud=E9 wrote:
> Hi Peter, Michael,
>=20
> On Thu, Dec 21, 2017 at 5:37 PM, Michael S. Tsirkin <mst@redhat.com> wr=
ote:
> > On Thu, Dec 21, 2017 at 08:26:47PM +0000, Peter Maydell wrote:
> >> On 21 December 2017 at 14:27, Michael S. Tsirkin <mst@redhat.com> wr=
ote:
> >> > The following changes since commit 2babfe0c9241c239272a03fec785165=
a50e8288c:
> >> >
> >> >   Update version for v2.11.0-rc4 release (2017-12-05 16:36:46 +000=
0)
> >> >
> >> > are available in the git repository at:
> >> >
> >> >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upst=
ream
> >> >
> >> > for you to fetch changes up to 664ed92706ff6e66fa278c3163b5387f11d=
6daca:
> >> >
> >> >   smbus: do not immediately complete commands (2017-12-21 16:24:44=
 +0200)
> >> >
> >> > ----------------------------------------------------------------
> >> > pc, pci, virtio: features, fixes, cleanups
> >> >
> >> > A bunch of fixes, cleanus and new features all over the place.
> >> >
> >> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >> >
> >>
> >> Conflicts in hw/block/nvme.c -- can you fix and resend, please?
> >>
> > Done and pushed - I dropped the conflicting patch.
>=20
> NACK :(
>=20
> you also need to drop "hw/pci: remove obsolete PCIDevice->init()"
> (applied in your tree as 18951fce55d5aa58cd1629b4cb704ee51bab4420)
> else the not-yet-QOM'ified NVME won't work anymore.

Done that too, thanks a lot
