Received: from eggs.gnu.org ([2001:4830:134:3::10]:42294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dxuXW-00050j-DB
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 08:37:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dxuXS-0002RC-1k
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 08:37:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dxuXR-0002Pp-Sa
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 08:37:05 -0400
References: <1502808257-17395-1-git-send-email-matt.redfearn@imgtec.com>
	<8f87ef69-f93e-d05e-00db-0a68dba85356@redhat.com>
	<eda76580-a54a-868d-5b70-d9c6ba75adac@imgtec.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <4939a30b-6e6d-0634-533f-02630cc5cd3a@redhat.com>
Date: Fri, 29 Sep 2017 15:37:00 +0300
MIME-Version: 1.0
In-Reply-To: <eda76580-a54a-868d-5b70-d9c6ba75adac@imgtec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] PCI: PCIe access should always be little
 endian
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Matt Redfearn <matt.redfearn@imgtec.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Yongbok Kim <Yongbok.Kim@imgtec.com>
List-ID: <qemu-devel.nongnu.org>

On 27/09/2017 11:27, Matt Redfearn wrote:
> ping?
>=20

Hi Matt,

I think Michael is in PTO, he'll pick up
the patch as soon he is back.

Thanks,
Marcel

>=20
> On 16/08/17 11:25, Marcel Apfelbaum wrote:
>> On 15/08/2017 17:44, Matt Redfearn wrote:
>>> PCIe busses are always little endian, so set the endianness of the
>>> memory region to little endian rather than native such that operation=
s
>>> work as expected on big endian targets.
>>>
>>> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
>>
>>
>> Hi Matt,
>> Thanks for the patch.
>>
>>> ---
>>>
>>> =C2=A0 hw/pci/pcie_host.c | 2 +-
>>> =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/pci/pcie_host.c b/hw/pci/pcie_host.c
>>> index dcebf57ed45e..553db56778b6 100644
>>> --- a/hw/pci/pcie_host.c
>>> +++ b/hw/pci/pcie_host.c
>>> @@ -81,7 +81,7 @@ static uint64_t pcie_mmcfg_data_read(void *opaque,
>>> =C2=A0 static const MemoryRegionOps pcie_mmcfg_ops =3D {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .read =3D pcie_mmcfg_data_read,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .write =3D pcie_mmcfg_data_write,
>>> -=C2=A0=C2=A0=C2=A0 .endianness =3D DEVICE_NATIVE_ENDIAN,
>>> +=C2=A0=C2=A0=C2=A0 .endianness =3D DEVICE_LITTLE_ENDIAN,
>>> =C2=A0 };
>>> =C2=A0=C2=A0=C2=A0 static void pcie_host_init(Object *obj)
>>>
>>
>>
>> Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
>>
>> Thanks,
>> Marcel
>=20
