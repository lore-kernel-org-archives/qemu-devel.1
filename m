Received: from eggs.gnu.org ([2001:4830:134:3::10]:59316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhengui@huawei.com>) id 1faWU6-0003Yt-Qc
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 21:21:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhengui@huawei.com>) id 1faWU3-0000Ax-N2
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 21:21:30 -0400
Received: from [45.249.212.35] (port=40595 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lizhengui@huawei.com>)
	id 1faWU3-00007D-9N
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 21:21:27 -0400
References: <86b43998-fc9e-75bf-564c-a64d72163793@huawei.com>
	<20180702131518.GF2155@stefanha-x1.localdomain>
	<c3e76f29-9259-f56d-6829-8abd6dd7da88@huawei.com>
	<65ada9e4-0495-ce50-1404-3ee6b74d0607@redhat.com>
From: l00284672 <lizhengui@huawei.com>
Message-ID: <e4e12bdd-0fa6-e61a-70cf-2a42c5d6371d@huawei.com>
Date: Wed, 4 Jul 2018 09:20:18 +0800
MIME-Version: 1.0
In-Reply-To: <65ada9e4-0495-ce50-1404-3ee6b74d0607@redhat.com>
Content-Type: multipart/mixed; boundary="------------7D698DB826F08679C57BED0D"
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
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: famz@redhat.com, kwolf@redhat.com, "Fangyi (C)" <eric.fangyi@huawei.com>, qemu-devel@nongnu.org

--------------7D698DB826F08679C57BED0D
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

yes=EF=BC=8C I also think so.


On 2018/7/4 0:27, Paolo Bonzini wrote:
> On 03/07/2018 09:20, l00284672 wrote:
>> }
>>
>> The scsi inqury request from guest is cancelled by qemu. The qemu bt i=
s
>> below:
>>
>> (gdb) bt
>> #0=C2=A0 scsi_req_cancel_async (req=3D0x7f86d00055c0, notifier=3D0x0) =
at
>> hw/scsi/scsi-bus.c:1825
>> #1=C2=A0 0x000055b50ac254c7 in scsi_device_purge_requests
>> (sdev=3Dsdev@entry=3D0x55b50f9a8990, sense=3D...) at hw/scsi/scsi-bus.=
c:1925
>> #2=C2=A0 0x000055b50ac1d337 in scsi_disk_reset (dev=3D0x55b50f9a8990) =
at
>> hw/scsi/scsi-disk.c:2186
>> #3=C2=A0 0x000055b50ab95d91 in device_set_realized (obj=3D<optimized o=
ut>,
>> value=3D<optimized out>, errp=3D0x7ffedda81898) at hw/core/qdev.c:949
>> #4=C2=A0 0x000055b50acd167e in property_set_bool (obj=3D0x55b50f9a8990=
,
>> v=3D<optimized out>, name=3D<optimized out>, opaque=3D0x55b50f9c1b50,
>> errp=3D0x7ffedda81898) at qom/object.c:1854
>> #5=C2=A0 0x000055b50acd5091 in object_property_set_qobject
>> (obj=3Dobj@entry=3D0x55b50f9a8990, value=3Dvalue@entry=3D0x55b50f99735=
0,
>> name=3Dname@entry=3D0x55b50ae0260b "realized",
>>  =C2=A0=C2=A0=C2=A0 errp=3Derrp@entry=3D0x7ffedda81898) at qom/qom-qob=
ject.c:27
>> #6=C2=A0 0x000055b50acd3210 in object_property_set_bool (obj=3D0x55b50=
f9a8990,
>> value=3D<optimized out>, name=3D0x55b50ae0260b "realized",
>> errp=3D0x7ffedda81898) at qom/object.c:1157
>> #7=C2=A0 0x000055b50ab1e0b5 in qdev_device_add
>> (opts=3Dopts@entry=3D0x55b50ceb9880, errp=3Derrp@entry=3D0x7ffedda8197=
8) at
>> qdev-monitor.c:627
> It looks like the hotplug event is sent too early to the guest?
>
> Paolo
>
>


--------------7D698DB826F08679C57BED0D
Content-Type: text/x-vcard; name="lizhengui.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="lizhengui.vcf"

bnVsbA==
--------------7D698DB826F08679C57BED0D--
