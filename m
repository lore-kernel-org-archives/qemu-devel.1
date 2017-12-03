Received: from eggs.gnu.org ([2001:4830:134:3::10]:33608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eLMKQ-0005oe-6G
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 23:56:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eLMKN-0008GR-5S
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 23:56:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eLMKM-0008Dv-VE
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 23:56:31 -0500
Date: Sun, 3 Dec 2017 06:56:27 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171203064856-mutt-send-email-mst@kernel.org>
References: <1512148088-28733-1-git-send-email-mst@redhat.com>
	<CAFEAcA-B7nMNTj6+HOSu=qUzaK3+Me83v_OG04=a2W4MU-KziA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAFEAcA-B7nMNTj6+HOSu=qUzaK3+Me83v_OG04=a2W4MU-KziA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/7] pc, pci, virtio: fixes for rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Fri, Dec 01, 2017 at 06:05:25PM +0000, Peter Maydell wrote:
> On 1 December 2017 at 17:08, Michael S. Tsirkin <mst@redhat.com> wrote:
> > The following changes since commit c11d61271b9e6e7a1f0479ef1ca8fb55fa=
457a62:
> >
> >   Update version for v2.11.0-rc3 release (2017-11-29 17:59:34 +0000)
> >
> > are available in the git repository at:
> >
> >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstrea=
m
> >
> > for you to fetch changes up to 75ba2ddb188fa07c3442446766782036e3085c=
ba:
> >
> >   pc: fix crash on attempted cpu unplug (2017-12-01 19:05:58 +0200)
> >
> > ----------------------------------------------------------------
> > pc, pci, virtio: fixes for rc3
> >
> > A bunch of fixes all over the place.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > ----------------------------------------------------------------
>=20
> You can't send fixes for rc3 2 days after rc3 has been tagged :-)

Bad wording. I meant they are for bugs present in rc3.

> > Chao Gao (1):
> >       i386/msi: Correct mask of destination ID in MSI address
> >
> > Greg Kurz (1):
> >       vhost: fix error check in vhost_verify_ring_mappings()
> >
> > Igor Mammedov (1):
> >       pc: fix crash on attempted cpu unplug
> >
> > Marc-Andr=E9 Lureau (1):
> >       dump-guest-memory.py: fix No symbol "vmcoreinfo_find"
> >
> > Maxime Coquelin (2):
> >       virtio: Add queue interface to restore avail index from vring u=
sed index
> >       vhost: restore avail index from vring used index on disconnecti=
on
> >
> > Prasad J Pandit (1):
> >       virtio: check VirtQueue Vring object is set
>=20
> Are any of these so important that we would absolutely refuse
> to release without the fixes (ie they justify rolling an rc4
> that we would otherwise not have needed) ?
>=20
> thanks
> -- PMM

The msi one is less important it just happened to be queued a while ago
and I didn't want to rebase all testing. Others are crashers but they
don't affect everyone. So I wouldn't be sure, but there's also a
security fix in there, so yes, I suspect we are better off with rc4, and
if we do I think including others is justified (except maybe the msi
one, if you feel strongly I'll rebase and drop it).

--=20
MST
