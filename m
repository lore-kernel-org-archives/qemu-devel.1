Received: from eggs.gnu.org ([2001:4830:134:3::10]:58332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dIdnX-0000dJ-0P
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:27:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dIdnT-0002a8-2T
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:27:07 -0400
Received: from us-smtp-delivery-101.mimecast.com ([63.128.21.101]:23411)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1dIdnS-0002ZZ-K8
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:27:03 -0400
From: Felipe Franciosi <felipe@nutanix.com>
Date: Wed, 7 Jun 2017 16:26:52 +0000
Message-ID: <0281E149-DE28-4D6D-80E0-1132CAB8ABDB@nutanix.com>
References: <20170607152825.12081-1-pbonzini@redhat.com>
	<20170607152825.12081-2-pbonzini@redhat.com>
	<CAFEAcA8CppP6YEPkGxVEyLnO=Kk1qirpGk2sh0bXedscxct8Jg@mail.gmail.com>
	<8229C6EB-56EA-475E-99D4-6D9B36B5D0A7@nutanix.com>
	<7a06506e-20ba-66b8-8c69-c500efe86301@redhat.com>
In-Reply-To: <7a06506e-20ba-66b8-8c69-c500efe86301@redhat.com>
Content-Language: en-US
Content-ID: <CA93B944EF1C1A408ABAAF09D52E3E44@namprd02.prod.outlook.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>


> On 7 Jun 2017, at 17:21, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
>=20
>=20
> On 07/06/2017 17:39, Felipe Franciosi wrote:
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
> How, since there is no synchronization point between the vhost-user
> server on the source and the destination?

The idea is that the backend should both stop picking up new requests and a=
lso quiesce outstanding requests upon a GET_VRING_BASE vhost message.

>=20
> Can you please send a version of your patch that uses .unmigratable?

Sure I can do that. We can work on the migration later on.

>=20
> I'll send a v6 that momentarily drops vhost-scsi, but I intend to
> include it again in the next pull request.

Sounds good to me.

Felipe

>=20
> Thanks,
>=20
> Paolo
