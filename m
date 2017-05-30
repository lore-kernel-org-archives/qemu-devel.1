Received: from eggs.gnu.org ([2001:4830:134:3::10]:51805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dFi22-00068j-QB
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:21:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dFi1y-0005gP-Jl
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:21:58 -0400
Received: from us-smtp-delivery-101.mimecast.com ([63.128.21.101]:22692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1dFi1y-0005g5-7o
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:21:54 -0400
From: Felipe Franciosi <felipe@nutanix.com>
Date: Tue, 30 May 2017 14:21:46 +0000
Message-ID: <F2D36A68-D126-4851-8385-E4456CE12121@nutanix.com>
References: <20170505101337.4650-1-pbonzini@redhat.com>
	<20170505101337.4650-22-pbonzini@redhat.com>
	<20170530131140.GA11356@stefanha-x1.localdomain>
	<086D6F07-A66C-4DDE-A84F-131EFFB1F56B@nutanix.com>
	<e5ed37e3-832a-8336-ea9e-3e7fd3974596@redhat.com>
In-Reply-To: <e5ed37e3-832a-8336-ea9e-3e7fd3974596@redhat.com>
Content-Language: en-US
Content-ID: <3E8EDC953D35F441BC5B6E2B7B26225C@namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 21/21] vhost-scsi: create a
 vhost-scsi-common abstraction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>


> On 30 May 2017, at 15:16, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
>=20
>=20
> On 30/05/2017 16:06, Felipe Franciosi wrote:
>>> This breaks the mingw build:
>>>=20
>>> hw/scsi/vhost-scsi-common.c:19:25: fatal error: linux/vhost.h: No such =
file or directory
>>>  #include <linux/vhost.h>
>>>                        ^
>>> compilation terminated.
>> Thanks for the report.
>>=20
>> Paolo: I know you wanted this enabled by default whenever virtio was bui=
lt, but maybe we should stick to a configure switch live vhost-net, vhost-s=
csi and vhost-vsock?
>>=20
>> Let me know what you think and I'll send an extra patch for it straight =
away.
>=20
> This was my mistake.  Your patch broke s390, and when I fixed it I
> copied the wrong setting:
>=20
> default-configs/pci.mak:CONFIG_VHOST_USER_SCSI=3D$(CONFIG_POSIX)
> default-configs/s390x-softmmu.mak:CONFIG_VHOST_USER_SCSI=3Dy
>=20
> Unfortunately, the mingw docker test doesn't build all targets, so I
> missed it.
>=20
> I would like vhost-user to be available on non-Linux POSIX, but this is
> not immediately possible because vhost-backend.c includes the kernel
> backend.  So we'll have to change CONFIG_POSIX to CONFIG_LINUX too.

Sounds good to me. Do you need anything from my end or are you happy to tak=
e care of this?

Thanks,
Felipe

>=20
> Paolo
