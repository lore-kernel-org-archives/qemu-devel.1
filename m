Received: from eggs.gnu.org ([2001:4830:134:3::10]:55291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhengui@huawei.com>) id 1fYVGk-0002gl-9F
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 07:39:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhengui@huawei.com>) id 1fYVGh-0001k3-47
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 07:39:22 -0400
Received: from [45.249.212.35] (port=37304 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lizhengui@huawei.com>)
	id 1fYVGg-0001Ws-CR
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 07:39:19 -0400
References: <86b43998-fc9e-75bf-564c-a64d72163793@huawei.com>
From: l00284672 <lizhengui@huawei.com>
Message-ID: <63986da7-f987-7a68-903b-0667ac3a0881@huawei.com>
Date: Thu, 28 Jun 2018 19:37:41 +0800
MIME-Version: 1.0
In-Reply-To: <86b43998-fc9e-75bf-564c-a64d72163793@huawei.com>
Content-Type: multipart/mixed; boundary="------------E240C1F02E301CFE7F9718C3"
Content-Language: en-US
Subject: Re: [Qemu-devel] question: disk missing in the guest contingently
 when hotplug several virtio scsi disks consecutively.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: famz@redhat.com, stefanha@gmail.com, kwolf@redhat.com, pbonzini@redhat.compbonzini@redhat.com
Cc: qemu-devel@nongnu.org, lizhengui@huawei.comqemu-devel@nongnu.org

--------------E240C1F02E301CFE7F9718C3
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

ping


On 2018/6/27 18:33, l00284672 wrote:
>
> Hi, I found a bug that disk missing (not all disks missing ) in the=20
> guest contingently when hotplug several virtio scsi disks=20
> consecutively.=C2=A0 After rebooting the guest,
>
> the missing disks appear again.
>
> The guest is centos7.3 running on a centos7.3 host and the scsi=20
> controllers are configed with iothread. The scsi controller xml is belo=
w:
>
> =C2=A0=C2=A0=C2=A0 <controller type=3D'scsi' index=3D'0' model=3D'virti=
o-scsi'>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <driver iothread=3D'26'/>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <alias name=3D'scsi0'/>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <address type=3D'pci' domain=3D'0x0000' =
bus=3D'0x00' slot=3D'0x07'=20
> function=3D'0x0'/>
> =C2=A0=C2=A0=C2=A0 </controller>
> =C2=A0=C2=A0=C2=A0 <controller type=3D'scsi' index=3D'1' model=3D'virti=
o-scsi'>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <driver iothread=3D'27'/>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <alias name=3D'scsi1'/>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <address type=3D'pci' domain=3D'0x0000' =
bus=3D'0x00' slot=3D'0x0a'=20
> function=3D'0x0'/>
> =C2=A0=C2=A0=C2=A0 </controller>
> =C2=A0=C2=A0=C2=A0 <controller type=3D'scsi' index=3D'2' model=3D'virti=
o-scsi'>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <driver iothread=3D'28'/>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <alias name=3D'scsi2'/>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <address type=3D'pci' domain=3D'0x0000' =
bus=3D'0x00' slot=3D'0x0b'=20
> function=3D'0x0'/>
> =C2=A0=C2=A0=C2=A0 </controller>
> =C2=A0=C2=A0=C2=A0 <controller type=3D'scsi' index=3D'3' model=3D'virti=
o-scsi'>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <driver iothread=3D'29'/>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <alias name=3D'scsi3'/>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <address type=3D'pci' domain=3D'0x0000' =
bus=3D'0x00' slot=3D'0x0c'=20
> function=3D'0x0'/>
> =C2=A0=C2=A0=C2=A0 </controller>
>
>
> If the scsi controllers are configed without iothread,=C2=A0 disks are =
all=20
> can be seen in the guest when hotplug several virtio scsi disks=20
> consecutively.
>
> I think the biggest difference between them is that scsi controllers=20
> with iothread call virtio_notify_irqfd to notify guest and scsi=20
> controllers without
>
> iothread call virtio_notify instead.=C2=A0 What make it difference? Wil=
l=C2=A0=20
> interrupts are lost when call virtio_notify_irqfd due to=C2=A0 race=20
> condition for some
>
> unknow reasons? Maybe guys more familiar with scsi dataplane can help.=20
> Thanks for your reply!
>
>


--------------E240C1F02E301CFE7F9718C3
Content-Type: text/x-vcard; name="lizhengui.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="lizhengui.vcf"

bnVsbA==
--------------E240C1F02E301CFE7F9718C3--
