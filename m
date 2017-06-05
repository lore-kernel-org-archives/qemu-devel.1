Received: from eggs.gnu.org ([2001:4830:134:3::10]:51778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dHv1G-0007tW-HQ
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 12:38:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dHv1C-0007SQ-Gg
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 12:38:18 -0400
Received: from us-smtp-delivery-101.mimecast.com ([63.128.21.101]:45030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1dHv1C-0007RH-2J
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 12:38:14 -0400
From: Felipe Franciosi <felipe@nutanix.com>
Date: Mon, 5 Jun 2017 16:38:03 +0000
Message-ID: <EE0BCD97-9983-4753-B690-FE9BD68A6E3A@nutanix.com>
References: <1496320911-51305-1-git-send-email-pbonzini@redhat.com>
	<1496320911-51305-18-git-send-email-pbonzini@redhat.com>
	<c39f198a-1b68-5d39-1c9a-7eaecb8d96d9@redhat.com>
In-Reply-To: <c39f198a-1b68-5d39-1c9a-7eaecb8d96d9@redhat.com>
Content-Language: en-US
Content-ID: <9A1AC4C776F9FD4FB1DB3353AC7AC1AF@namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 17/33] vhost-user-scsi: Introduce
 vhost-user-scsi host device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>


> On 5 Jun 2017, at 17:28, Eric Blake <eblake@redhat.com> wrote:
>=20
> On 06/01/2017 07:41 AM, Paolo Bonzini wrote:
>> From: Felipe Franciosi <felipe@nutanix.com>
>>=20
>> This commit introduces a vhost-user device for SCSI. This is based
>> on the existing vhost-scsi implementation, but done over vhost-user
>> instead. It also uses a chardev to connect to the backend. Unlike
>> vhost-scsi (today), VMs using vhost-user-scsi can be live migrated.
>>=20
>> To use it, start Qemu with a command line equivalent to:
>>=20
>> qemu-system-x86_64 \
>>       -chardev socket,id=3Dvus0,path=3D/tmp/vus.sock \
>>       -device vhost-user-scsi-pci,chardev=3Dvus0,bus=3Dpci.0,addr=3D...
>>=20
>> A separate commit presents a sample application linked with libiscsi to
>> provide a backend for vhost-user-scsi.
>>=20
>> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
>> Message-Id: <1488479153-21203-4-git-send-email-felipe@nutanix.com>
>> ---
>=20
> This pull request still hasn't landed, and now it needs a rebase:

Hi Eric,

Thanks for the report. Looks simple. Part of the series have been merged. S=
hould I rebase+resend just the two missing patches (as a new series?) or sh=
ould Paolo do this? I'm not sure what's the workflow here.

Cheers,
Felipe

>=20
>> +++ b/hw/scsi/vhost-user-scsi.c
>=20
>> +#include "hw/virtio/virtio-access.h"
>> +#include "sysemu/char.h"
>=20
> Now that commit 6b10e573 is on mainline, sysemu/char.h has been renamed
> to chardev/char.h (there may be other changes needed, too).
>=20
> --=20
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
