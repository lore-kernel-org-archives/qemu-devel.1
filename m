Received: from eggs.gnu.org ([2001:4830:134:3::10]:42315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eM1XX-0002mL-UD
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 19:56:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eM1XT-00006R-1y
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 19:56:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eM1XS-00006I-RP
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 19:56:46 -0500
Date: Tue, 5 Dec 2017 02:56:41 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171204161112-mutt-send-email-mst@kernel.org>
References: <1512148088-28733-1-git-send-email-mst@redhat.com>
	<CAFEAcA-B7nMNTj6+HOSu=qUzaK3+Me83v_OG04=a2W4MU-KziA@mail.gmail.com>
	<20171203064856-mutt-send-email-mst@kernel.org>
	<CAFEAcA_yWQqGAzDuaPZo9vgwVywq9QazToVy7CYncVvSfhxDKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAFEAcA_yWQqGAzDuaPZo9vgwVywq9QazToVy7CYncVvSfhxDKw@mail.gmail.com>
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

On Mon, Dec 04, 2017 at 10:16:08AM +0000, Peter Maydell wrote:
> On 3 December 2017 at 04:56, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Fri, Dec 01, 2017 at 06:05:25PM +0000, Peter Maydell wrote:
> >> On 1 December 2017 at 17:08, Michael S. Tsirkin <mst@redhat.com> wro=
te:
> >> > Chao Gao (1):
> >> >       i386/msi: Correct mask of destination ID in MSI address
> >> >
> >> > Greg Kurz (1):
> >> >       vhost: fix error check in vhost_verify_ring_mappings()
> >> >
> >> > Igor Mammedov (1):
> >> >       pc: fix crash on attempted cpu unplug
> >> >
> >> > Marc-Andr=E9 Lureau (1):
> >> >       dump-guest-memory.py: fix No symbol "vmcoreinfo_find"
> >> >
> >> > Maxime Coquelin (2):
> >> >       virtio: Add queue interface to restore avail index from vrin=
g used index
> >> >       vhost: restore avail index from vring used index on disconne=
ction
> >> >
> >> > Prasad J Pandit (1):
> >> >       virtio: check VirtQueue Vring object is set
> >>
> >> Are any of these so important that we would absolutely refuse
> >> to release without the fixes (ie they justify rolling an rc4
> >> that we would otherwise not have needed) ?
>=20
> > The msi one is less important it just happened to be queued a while a=
go
> > and I didn't want to rebase all testing. Others are crashers but they
> > don't affect everyone. So I wouldn't be sure, but there's also a
> > security fix in there, so yes, I suspect we are better off with rc4, =
and
> > if we do I think including others is justified (except maybe the msi
> > one, if you feel strongly I'll rebase and drop it).
>=20
> The bar has to be set quite high here, because if it turns out
> that there are problems with a bug fix then we are out of time
> to rework or revert it. And the more fixes we throw in at the
> last minute, even if they're individually simple, the more
> likely that one of them turns out to have unexpected consequences.
>=20
> So: were any of these bugs present in the 2.10 release? If so,
> that strongly argues for not trying to fix them at this point.
>=20
> With all of these patches plus David Gibson's, that would be
> 10 new patches in rc4. That is definitely more than would be
> ideal.
>=20
> thanks
> -- PMM

None of these are regressions. Except for the msix one, they
do fix major bugs for features new in this release though.
I'll resend it without msix, pls go ahead and ignore if
you think a .1 stable release is a better place to put them.

--=20
MST
