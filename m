Received: from eggs.gnu.org ([2001:4830:134:3::10]:35628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dIffD-00008i-Og
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 14:26:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dIff7-0002sr-Ur
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 14:26:38 -0400
Received: from us-smtp-delivery-101.mimecast.com ([216.205.24.101]:32160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1dIff7-0002sl-Ju
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 14:26:33 -0400
From: Felipe Franciosi <felipe@nutanix.com>
Date: Wed, 7 Jun 2017 18:26:22 +0000
Message-ID: <4FA9B5EC-B9B0-49A3-ADD8-AF1113B6144C@nutanix.com>
References: <20170607152825.12081-1-pbonzini@redhat.com>
	<20170607152825.12081-2-pbonzini@redhat.com>
	<CAFEAcA8CppP6YEPkGxVEyLnO=Kk1qirpGk2sh0bXedscxct8Jg@mail.gmail.com>
	<8229C6EB-56EA-475E-99D4-6D9B36B5D0A7@nutanix.com>
	<CAFEAcA-r6uC0zO6uYH38XztZfWqLVphRUXA5ffgGw-cFKL+QHg@mail.gmail.com>
In-Reply-To: <CAFEAcA-r6uC0zO6uYH38XztZfWqLVphRUXA5ffgGw-cFKL+QHg@mail.gmail.com>
Content-Language: en-US
Content-ID: <D452117A6F66F744A070B3CFD81DA440@namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 18/33] vhost-user-scsi: Introduce
 vhost-user-scsi host device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>


> On 7 Jun 2017, at 16:47, Peter Maydell <peter.maydell@linaro.org> wrote:
>=20
> On 7 June 2017 at 16:39, Felipe Franciosi <felipe@nutanix.com> wrote:
>>=20
>>> On 7 Jun 2017, at 16:37, Peter Maydell <peter.maydell@linaro.org> wrote=
:
>>>=20
>>> On 7 June 2017 at 16:28, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>> From: Felipe Franciosi <felipe@nutanix.com>
>>>>=20
>>>> This commit introduces a vhost-user device for SCSI. This is based
>>>> on the existing vhost-scsi implementation, but done over vhost-user
>>>> instead. It also uses a chardev to connect to the backend. Unlike
>>>> vhost-scsi (today), VMs using vhost-user-scsi can be live migrated.
>>>>=20
>>>> To use it, start Qemu with a command line equivalent to:
>>>>=20
>>>> qemu-system-x86_64 \
>>>>      -chardev socket,id=3Dvus0,path=3D/tmp/vus.sock \
>>>>      -device vhost-user-scsi-pci,chardev=3Dvus0,bus=3Dpci.0,addr=3D...
>>>>=20
>>>> A separate commit presents a sample application linked with libiscsi t=
o
>>>> provide a backend for vhost-user-scsi.
>>>>=20
>>>> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
>>>> Message-Id: <1488479153-21203-4-git-send-email-felipe@nutanix.com>
>>>> [Disable migration for now, since it does not support bdrv_drain. - Pa=
olo]
>>>=20
>>> I was expecting this to mean a VMStateDescription with a
>>> ".unmigratable =3D 1" field, but it doesn't seem to have one.
>>> Does it disable migration some other way?
>>=20
>> Hi Peter,
>>=20
>> vhost-user-scsi supports migration.
>=20
> Paolo's change comment in the commit message quoted above
> says it does not, which is what I was remarking on.
>=20
> (Your original patches use register_savevm(), which is a function
> that has just gone away. They'd need to use VMStateDescription
> structs instead to support migration.)

Oh thanks for pointing that out, I missed it at the bottom of the commit me=
ssage.

F.

>=20
> thanks
> -- PMM
