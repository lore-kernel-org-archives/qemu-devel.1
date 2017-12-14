Received: from eggs.gnu.org ([2001:4830:134:3::10]:60328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1ePPBn-0006O5-0b
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 03:48:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1ePPBm-0002SX-84
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 03:48:23 -0500
References: <b630fe8c-6905-6743-d29d-ded450d5d10b@redhat.com>
	<20171211114129.GC3350@lemon>
	<c57f063f-a95b-4a82-8b5e-a713ba61d734@redhat.com>
	<7ee9e2f2-9690-9f6d-6952-d96953501c0f@redhat.com>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <f63d71f0-4de1-354b-f45f-05c37580f3d7@redhat.com>
Date: Thu, 14 Dec 2017 09:48:08 +0100
MIME-Version: 1.0
In-Reply-To: <7ee9e2f2-9690-9f6d-6952-d96953501c0f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] QEMU not honouring bootorder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-block@nongnu.org

On 12/13/2017 10:21 PM, Paolo Bonzini wrote:
> On 11/12/2017 13:14, Michal Privoznik wrote:
>>>>   qemu-system-x86_64 \
>>>>   -boot menu=on,strict=on \
>>>>   -device lsi,id=scsi0,bus=pci.0 \
>>>>   -drive file=/var/lib/libvirt/images/fedora.qcow2,format=qcow2,if=none,id=drive-scsi0 \
>>>>   -device scsi-hd,bus=scsi0.0,drive=drive-scsi0,bootindex=1 \
>>>>   -drive file=/dev/sde,format=raw,if=none,id=drive-scsi1 \
>>>>   -device scsi-block,bus=scsi0.0,drive=drive-scsi1,bootindex=2
>>>>
>>>> It was found that if 'drive-scsi1' is scsi-hd instead of scsi-block
>>>> everything works as expected and I can boot my guest successfully.
>>> Does it help if you add SCSI level ordering with "lun={0,1},channel=0,scsi-id=0"
>>> for both devices?
>> Setting lun helps. On the other hand, I had to change from LSI
>> controller to virtio-scsi as LSI doesn't support more than 1 LUNs.
> 
> Does it help to use virtio-scsi and keep the default assignment?

Yes. If I s/lsi/virtio-scsi-pci/ on the cmd line it does help too.

Michal
