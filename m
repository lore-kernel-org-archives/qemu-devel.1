Received: from eggs.gnu.org ([2001:4830:134:3::10]:49743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cHp8N-0005kq-D8
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 04:49:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cHp8I-0006fg-UL
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 04:48:59 -0500
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:37820)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cHp8I-0006f5-LN
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 04:48:54 -0500
Received: by mail-wm0-x22f.google.com with SMTP id t79so25931065wmt.0
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 01:48:54 -0800 (PST)
Date: Fri, 16 Dec 2016 09:48:50 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161216094850.GA4129@stefanha-x1.localdomain>
References: <CA+scX6=9y4wDBWzXyqpGh9U__usKUa6sxwdc63iA8YRmpWFPqA@mail.gmail.com>
	<20161214193107.GB20648@stefanha-x1.localdomain>
	<CA+scX6=oc_eGteY8A0d8tuwzJFSu9M_6wnXBd5Tp=XGrg8FotQ@mail.gmail.com>
	<CA+scX6n+xcY7qi=XbBcno=OQOfUfJf77ZGfS2s5FbhUCEHQp3A@mail.gmail.com>
	<20161215080634.GF26169@stefanha-x1.localdomain>
	<CA+scX6=Lk8Ea=vkFt_3c5v+n8gbr+uAb7hZ8vM1svzBZWwX7nQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <CA+scX6=Lk8Ea=vkFt_3c5v+n8gbr+uAb7hZ8vM1svzBZWwX7nQ@mail.gmail.com>
Subject: Re: [Qemu-devel] Lock contention in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Weiwei Jia <harrynjit@gmail.com>
Cc: qemu-devel@nongnu.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 15, 2016 at 11:04:23AM -0500, Weiwei Jia wrote:
> On Thu, Dec 15, 2016 at 3:06 AM, Stefan Hajnoczi <stefanha@gmail.com> wro=
te:
> > On Thu, Dec 15, 2016 at 12:17:09AM -0500, Weiwei Jia wrote:
> >> BTW, do we have an example to show users how to config following
> >> virtio-blk dataplane commands into XML configuration file?
> >>
> >> qemu -object iothread,id=3Diothread0 \
> >>       -drive if=3Dnone,id=3Ddrive0,file=3Dtest.img,format=3Draw,cache=
=3Dnone \
> >>       -device virtio-blk-pci,iothread=3Diothread0,drive=3Ddrive0
> >
> > https://libvirt.org/formatdomain.html#elementsIOThreadsAllocation
> >
> > See also <cputune><iothreadpin> and <driver iothread=3D>.
>=20
> It seems that the libvirt XML configuration in above link [1] is
> different from the configuration which you said in your blog [2]. Your
> blog just said how to use x-data-plane for virtio-blk but libvirt XML
> configuration doesn't say anything about x-data-plane. Does it in
> default support by latest QEMU version. If I want to test virtio-blk
> or virtio-scsi data-plane to make timeslice more stable, what version
> of QEMU/KVM should I use? Would you please give me some suggestions?
> Thank you.
>=20
> [1] https://libvirt.org/formatdomain.html#elementsIOThreadsAllocation
> [2] http://blog.vmsplice.net/2013/03/new-in-qemu-14-high-performance-virt=
io.html

I will update the blog post (from 2013) with the modern libvirt XML
syntax.

Please use the
https://libvirt.org/formatdomain.html#elementsIOThreadsAllocation
documentation (unless you are using a really old QEMU and libvirt!).

Stefan

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYU7iCAAoJEJykq7OBq3PI/vAH/3hqbE6bbI07l4Ao/muMds/S
GZu+VTTVs7oQ/eOzXEtZxz8ZrUxeNXCJXHV8aGHSWiOKMTOVMhqoZ1/W66RHC292
sfJXTuSmoviBqln7zs+xgAUvobHhO8SSNBCLP58PZCNjwuSEfdDIy5YgfYuIMmPU
X3iaZl+x6H/wPESmRP/U41t35w/Nt2DMCcTRWzphRzgJyyxoLA6+cQhHaxnXk4Q6
spaGDIzoj1ObBhRFPt6dluCMWoB79hBn1BWIS2US2entGFbffilovjXWxb4NpYtN
XZa/7xurb39FRIBQlrl8qJxBriRkLNLC5fX8F5lYUUoTjwWatDZep4Py7AbwDqQ=
=8onB
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
