Received: from eggs.gnu.org ([2001:4830:134:3::10]:55324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dFiE0-0000HP-RW
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:34:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dFiDx-0001JF-KS
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:34:20 -0400
Received: from us-smtp-delivery-101.mimecast.com ([216.205.24.101]:52368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1dFiDx-0001Hm-EO
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:34:17 -0400
From: Felipe Franciosi <felipe@nutanix.com>
Date: Tue, 30 May 2017 14:34:09 +0000
Message-ID: <D7028113-99D1-4BE3-960F-D4E2821B02D0@nutanix.com>
References: <20170505101337.4650-1-pbonzini@redhat.com>
	<20170505101337.4650-22-pbonzini@redhat.com>
	<20170530131140.GA11356@stefanha-x1.localdomain>
	<086D6F07-A66C-4DDE-A84F-131EFFB1F56B@nutanix.com>
	<e5ed37e3-832a-8336-ea9e-3e7fd3974596@redhat.com>
	<F2D36A68-D126-4851-8385-E4456CE12121@nutanix.com>
	<dee9cce8-9cf3-373e-0522-6fc93922bac5@redhat.com>
In-Reply-To: <dee9cce8-9cf3-373e-0522-6fc93922bac5@redhat.com>
Content-Language: en-US
Content-ID: <68D8609560F0A145826AB4F4BADA427F@namprd02.prod.outlook.com>
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


> On 30 May 2017, at 15:29, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> On 30/05/2017 16:21, Felipe Franciosi wrote:
>>> default-configs/pci.mak:CONFIG_VHOST_USER_SCSI=3D$(CONFIG_POSIX)
>>> default-configs/s390x-softmmu.mak:CONFIG_VHOST_USER_SCSI=3Dy
>>>=20
>>> Unfortunately, the mingw docker test doesn't build all targets, so I
>>> missed it.
>>>=20
>>> I would like vhost-user to be available on non-Linux POSIX, but this is
>>> not immediately possible because vhost-backend.c includes the kernel
>>> backend.  So we'll have to change CONFIG_POSIX to CONFIG_LINUX too.
>> Sounds good to me. Do you need anything from my end or are you happy to =
take care of this?
>=20
> If you'd like to take a look at breaking vhost-backend.c, that would be
> nice.


Sure. I'll add that to my list and have a stab at it later on^W^W eventuall=
y.

But I meant wrt mingw?

Felipe
