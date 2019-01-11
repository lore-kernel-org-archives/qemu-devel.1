Received: from eggs.gnu.org ([209.51.188.92]:46679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ghzLN-0004FD-L4
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:07:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ghzLL-0005VJ-CR
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:07:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ghzLL-0005UP-1S
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:07:35 -0500
References: <20190110083753.GA31730@yangzhon-Virtual>
	<20190110103636.GG19025@stefanha-x1.localdomain>
	<20190111054604.GA1038@yangzhon-Virtual>
	<a7e15215-e2df-309b-b1f6-6741bfff7247@redhat.com>
	<20190111155824.GB14776@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <72a500b8-4681-94c5-a258-5ba8b0e8fa9b@redhat.com>
Date: Fri, 11 Jan 2019 17:07:26 +0100
MIME-Version: 1.0
In-Reply-To: <20190111155824.GB14776@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FwTjpQUWj6xytvCy9TEs7Os9azroPbr5l"
Subject: Re: [Qemu-devel] If Qemu support NVMe over Fabrics ?y
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Yang Zhong <yang.zhong@intel.com>, QEMU Developers <qemu-devel@nongnu.org>, fam@euphon.net, keith.busch@intel.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FwTjpQUWj6xytvCy9TEs7Os9azroPbr5l
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Yang Zhong <yang.zhong@intel.com>, QEMU Developers
 <qemu-devel@nongnu.org>, fam@euphon.net, keith.busch@intel.com
Message-ID: <72a500b8-4681-94c5-a258-5ba8b0e8fa9b@redhat.com>
Subject: Re: [Qemu-devel] If Qemu support NVMe over Fabrics ?y
References: <20190110083753.GA31730@yangzhon-Virtual>
 <20190110103636.GG19025@stefanha-x1.localdomain>
 <20190111054604.GA1038@yangzhon-Virtual>
 <a7e15215-e2df-309b-b1f6-6741bfff7247@redhat.com>
 <20190111155824.GB14776@stefanha-x1.localdomain>
In-Reply-To: <20190111155824.GB14776@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 11/01/19 16:58, Stefan Hajnoczi wrote:
> On Fri, Jan 11, 2019 at 11:48:52AM +0100, Paolo Bonzini wrote:
>> On 11/01/19 06:46, Yang Zhong wrote:
>>> On Thu, Jan 10, 2019 at 10:36:37AM +0000, Stefan Hajnoczi wrote:
>>>> On Thu, Jan 10, 2019 at 04:37:53PM +0800, Yang Zhong wrote:
>>>>> Do you know if Qemu support NVMe over Fabrics(NVMe-oF)?
>>>>> https://nvmexpress.org/wp-content/uploads/NVMe_Over_Fabrics.pdf
>>>>>
>>>>> The Qemu has enabled RDMA in last year, and i am not sure if Qemu=20
>>>>> should support NVME-oF. If Qemu support it, would you please share
>>>>> me the qemu related command or guides? thanks a lot!
>>>>
>>>> QEMU supports many different storage configurations.  Can you be mor=
e
>>>> specific?
>>>>
>>>> For example, if your host has NVMe-oF set up then you can give the N=
VMe
>>>> block devices to QEMU just like any other host block device (-drive
>>>> file=3D/dev/sdc,...).
>>>>
>>>> But maybe you are thinking about other configurations, like exposing=

>>>> NVMe-oF to the guest?
>>>>
>>>   Thanks Stefan's comments. We only want Qemu as NVMe-oF initiator to=

>>>   access remote target's resource.
>>>
>>>   I checked the block/nvme.c and hw/block/nvme.c code, which seems do=

>>>   not support NVMe-oF . If i am wrong please correct me.
>>>
>>>   If Qemu support NVMe-oF initiator, please share me how to use it.=20
>>>   If Qemu does not support it, please tell me if community has plan=20
>>>   to implement it. thanks a lot!
>>
>> QEMU's native NVMe driver only supports NVMe over PCI, but it should b=
e
>> possible to extract common code if you want to add a native NVMe over
>> RDMA driver to QEMU.  There are currently no plans to add such a drive=
r,
>> but it would certainly be a welcome addition.
>=20
> Before investing time in doing that, what is the goal?
>=20
> Is this for test and bring-up of NVMe-oF?  Or why does the guest need t=
o
> know that the storage is NVMe-oF?
>=20
> As I mentioned before, if your host supports NVMe-oF you can simply giv=
e
> the block device to QEMU and let the guest access it via virtio-blk,
> virtio-scsi, NVMe, etc.

NVMe-OF is an RDMA protocol, basically a different transport for the
NVMe command set and queue abstraction.  It would allow QEMU to access
the device directly (similar to what block/nvme.c does for PCI using
VFIO) without going through the host kernel.  The guest would see the
device as virtio-blk/scsi, NVMe or anything else.

Paolo


--FwTjpQUWj6xytvCy9TEs7Os9azroPbr5l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlw4vz4ACgkQv/vSX3jH
roOKkAf+Mq4+ucg+yfgqhz4ltadv9Ggv9DcfF/jmi4qKo4HV4Pp+0qNMgTKMZmmM
aaGjkpUPZJI1K1wv1J20gGmvrXx9NufnoP6ZKwm5etABYJF94gE4PNErZDyiizRs
s3NNa/DlMjyx1+PWi+WZwvicpL3lz20TlngdFs0gvy76ffA8wC6ko2sgpNfAr2gP
+iM5E42BSWHkyNlbLRB8gIw4fsgpmTtor0nAtOpOWQgF1cjGojTsLdVJgPELF02Q
L6F9T1OhorX9CbN7vehQf4r8/d9HTZqlM9tuANLF7wT+h7mM93qh34CAuOWrzbnL
KjlX/96s9VMjm0FPgWyoFEtkWJIjfA==
=a+kT
-----END PGP SIGNATURE-----

--FwTjpQUWj6xytvCy9TEs7Os9azroPbr5l--
