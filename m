Received: from eggs.gnu.org ([2001:4830:134:3::10]:47173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ePRgi-0002k3-VM
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 06:28:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ePRgd-0003UG-BV
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 06:28:28 -0500
References: <b630fe8c-6905-6743-d29d-ded450d5d10b@redhat.com>
	<20171211114129.GC3350@lemon>
	<c57f063f-a95b-4a82-8b5e-a713ba61d734@redhat.com>
	<7ee9e2f2-9690-9f6d-6952-d96953501c0f@redhat.com>
	<f63d71f0-4de1-354b-f45f-05c37580f3d7@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <47f23d1f-e25a-f0fe-4f88-959532a3d391@redhat.com>
Date: Thu, 14 Dec 2017 12:28:12 +0100
MIME-Version: 1.0
In-Reply-To: <f63d71f0-4de1-354b-f45f-05c37580f3d7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] QEMU not honouring bootorder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Privoznik <mprivozn@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-block@nongnu.org

On 14/12/2017 09:48, Michal Privoznik wrote:
> On 12/13/2017 10:21 PM, Paolo Bonzini wrote:
>> On 11/12/2017 13:14, Michal Privoznik wrote:
>>>>>   qemu-system-x86_64 \
>>>>>   -boot menu=3Don,strict=3Don \
>>>>>   -device lsi,id=3Dscsi0,bus=3Dpci.0 \
>>>>>   -drive file=3D/var/lib/libvirt/images/fedora.qcow2,format=3Dqcow2=
,if=3Dnone,id=3Ddrive-scsi0 \
>>>>>   -device scsi-hd,bus=3Dscsi0.0,drive=3Ddrive-scsi0,bootindex=3D1 \
>>>>>   -drive file=3D/dev/sde,format=3Draw,if=3Dnone,id=3Ddrive-scsi1 \
>>>>>   -device scsi-block,bus=3Dscsi0.0,drive=3Ddrive-scsi1,bootindex=3D=
2
>>>>>
>>>>> It was found that if 'drive-scsi1' is scsi-hd instead of scsi-block
>>>>> everything works as expected and I can boot my guest successfully.
>>>> Does it help if you add SCSI level ordering with "lun=3D{0,1},channe=
l=3D0,scsi-id=3D0"
>>>> for both devices?
>>> Setting lun helps. On the other hand, I had to change from LSI
>>> controller to virtio-scsi as LSI doesn't support more than 1 LUNs.
>>
>> Does it help to use virtio-scsi and keep the default assignment?
>=20
> Yes. If I s/lsi/virtio-scsi-pci/ on the cmd line it does help too.

Cool, then it's an lsi bug. :)

Paolo
