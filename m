Received: from eggs.gnu.org ([209.51.188.92]:44470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ghzCg-0000R7-EZ
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:58:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ghzCf-0000Bh-EG
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:58:38 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:51526)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ghzCf-0008VZ-4a
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:58:37 -0500
Received: by mail-wm1-x332.google.com with SMTP id b11so2883422wmj.1
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 07:58:27 -0800 (PST)
Date: Fri, 11 Jan 2019 15:58:24 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190111155824.GB14776@stefanha-x1.localdomain>
References: <20190110083753.GA31730@yangzhon-Virtual>
	<20190110103636.GG19025@stefanha-x1.localdomain>
	<20190111054604.GA1038@yangzhon-Virtual>
	<a7e15215-e2df-309b-b1f6-6741bfff7247@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hQiwHBbRI9kgIhsi"
Content-Disposition: inline
In-Reply-To: <a7e15215-e2df-309b-b1f6-6741bfff7247@redhat.com>
Subject: Re: [Qemu-devel] If Qemu support NVMe over Fabrics ?y
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Yang Zhong <yang.zhong@intel.com>, QEMU Developers <qemu-devel@nongnu.org>, fam@euphon.net, keith.busch@intel.com


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 11, 2019 at 11:48:52AM +0100, Paolo Bonzini wrote:
> On 11/01/19 06:46, Yang Zhong wrote:
> > On Thu, Jan 10, 2019 at 10:36:37AM +0000, Stefan Hajnoczi wrote:
> >> On Thu, Jan 10, 2019 at 04:37:53PM +0800, Yang Zhong wrote:
> >>> Do you know if Qemu support NVMe over Fabrics(NVMe-oF)?
> >>> https://nvmexpress.org/wp-content/uploads/NVMe_Over_Fabrics.pdf
> >>>
> >>> The Qemu has enabled RDMA in last year, and i am not sure if Qemu=20
> >>> should support NVME-oF. If Qemu support it, would you please share
> >>> me the qemu related command or guides? thanks a lot!
> >>
> >> QEMU supports many different storage configurations.  Can you be more
> >> specific?
> >>
> >> For example, if your host has NVMe-oF set up then you can give the NVMe
> >> block devices to QEMU just like any other host block device (-drive
> >> file=3D/dev/sdc,...).
> >>
> >> But maybe you are thinking about other configurations, like exposing
> >> NVMe-oF to the guest?
> >>
> >   Thanks Stefan's comments. We only want Qemu as NVMe-oF initiator to
> >   access remote target's resource.
> >=20
> >   I checked the block/nvme.c and hw/block/nvme.c code, which seems do
> >   not support NVMe-oF . If i am wrong please correct me.
> >=20
> >   If Qemu support NVMe-oF initiator, please share me how to use it.=20
> >   If Qemu does not support it, please tell me if community has plan=20
> >   to implement it. thanks a lot!
>=20
> QEMU's native NVMe driver only supports NVMe over PCI, but it should be
> possible to extract common code if you want to add a native NVMe over
> RDMA driver to QEMU.  There are currently no plans to add such a driver,
> but it would certainly be a welcome addition.

Before investing time in doing that, what is the goal?

Is this for test and bring-up of NVMe-oF?  Or why does the guest need to
know that the storage is NVMe-oF?

As I mentioned before, if your host supports NVMe-oF you can simply give
the block device to QEMU and let the guest access it via virtio-blk,
virtio-scsi, NVMe, etc.

Stefan

--hQiwHBbRI9kgIhsi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcOL0gAAoJEJykq7OBq3PIoysIAKj/5EcDXomgZmeuw0f34Lg+
jGfqZOG6R8qWtZWgBBI9M4gJZhxQoMS15FJYinlPtkiHfLaeMPhis8zVYyuxbTOz
iZbRLGeQvYDPr+lhzQ5Meri8iIzMHX7kk4EG0Qzx6oNY4gbNAr8sjMi1lKjP/ApD
1pSQ6JmmXlB/SQDBCdGsxDMWHWR2AxqxK2wP7qju6p6wW0wi3BwNY1HvUp9XE563
VePmylxNB/N+g2catiqKLevZubduaI+XDnj7nY7+bIr8gzYbwv49W1LZ7EYZ9r/o
wX1ckRd0btcnu2FwOq5Wc3EZQz3hxvc9i3I6AzzOCL4azqcb7dUzxzc5BQf+6jo=
=xtIe
-----END PGP SIGNATURE-----

--hQiwHBbRI9kgIhsi--
