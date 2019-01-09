Received: from eggs.gnu.org ([209.51.188.92]:52370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dongli.zhang@oracle.com>) id 1gh1U6-0003Gk-DI
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 19:12:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dongli.zhang@oracle.com>) id 1gh1U5-0005mn-LP
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 19:12:38 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:60446)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dongli.zhang@oracle.com>)
	id 1gh1U5-0005jf-7o
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 19:12:37 -0500
References: <1546900184-27403-1-git-send-email-venu.busireddy@oracle.com>
	<1546900184-27403-2-git-send-email-venu.busireddy@oracle.com>
	<6f5632f5-1469-7000-9b92-ef2564a63f63@oracle.com>
	<20190108172522.GA28457@troi>
From: Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <41b85d40-0711-a0f3-6b45-bacd20644186@oracle.com>
Date: Wed, 9 Jan 2019 08:14:57 +0800
MIME-Version: 1.0
In-Reply-To: <20190108172522.GA28457@troi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/5] virtio_net: Add
 VIRTIO_NET_F_STANDBY feature bit.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Venu Busireddy <venu.busireddy@oracle.com>
Cc: virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, si-wei.liu@oracle.com

Hi Venu,

On 2019/1/9 =E4=B8=8A=E5=8D=881:25, Venu Busireddy wrote:
> On 2019-01-09 00:56:38 +0800, Dongli Zhang wrote:
>> I am not familiar with libvirt and I would like to play with this only=
 with qemu.
>>
>> With failover, we need to hotplug the VF on destination server to VM a=
fter live
>> migration. However, the VF on destination server would have different =
mac address.
>>
>> How can we specify the mac for the new VF to hotplug via qemu, as VF i=
s only a
>> vfio pci device?
>=20
> How is the VF device on the destination host any different from the VF
> on the source host?
>=20
> As you do on the source host, you first assign the MAC address of
> 00:00:00:00:00:00 to the VF. After the migration, you assign the same
> MAC address as that of the virtio_net device to the VF, and hotadd the =
VF

This was what I was wondering.

How the mac address is configured for VF (or any NIC like PF) after it is
assigned to vfio?

Thank you very much!

Dongli Zhang


> device to the VM. And then, after you receive the FAILOVER_PRIMARY_CHAN=
GED
> event, set the macvtap device to down state.
>=20
> Venu
>=20
>>
>> I am trying to play with this with only qemu (w/o libvirt).
>>
>> Thank you very much!
>>
>> Dongli Zhang
>>
>> On 01/08/2019 06:29 AM, Venu Busireddy wrote:
>>> From: Sridhar Samudrala <sridhar.samudrala@intel.com>
>>>
>>> This feature bit can be used by a hypervisor to indicate to the virti=
o_net
>>> device that it can act as a standby for another device with the same =
MAC
>>> address.
>>>
>>> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>>> Signed-off-by: Venu Busireddy <venu.busireddy@oracle.com>
>>> ---
>>>  hw/net/virtio-net.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>>> index 385b1a0..411f8fb 100644
>>> --- a/hw/net/virtio-net.c
>>> +++ b/hw/net/virtio-net.c
>>> @@ -2198,6 +2198,8 @@ static Property virtio_net_properties[] =3D {
>>>                       true),
>>>      DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_UNKN=
OWN),
>>>      DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
>>> +    DEFINE_PROP_BIT64("standby", VirtIONet, host_features, VIRTIO_NE=
T_F_STANDBY,
>>> +                      false),
>>>      DEFINE_PROP_END_OF_LIST(),
>>>  };
>>> =20
>>>
>=20
