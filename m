Received: from eggs.gnu.org ([2001:4830:134:3::10]:33612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jbaron@akamai.com>) id 1etGun-0002Xs-Ud
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 13:02:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jbaron@akamai.com>) id 1etGuk-0004wB-Nz
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 13:02:18 -0500
Received: from mx0b-00190b01.pphosted.com ([2620:100:9005:57f::1]:52466)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jbaron@akamai.com>) id 1etGuk-0004ue-IP
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 13:02:14 -0500
References: <cover.1519961667.git.jbaron@akamai.com>
	<c9d3cf2fbc3c64bb28e0438185d85d95b2088127.1519961667.git.jbaron@akamai.com>
	<7fc612d0-9610-9b07-d054-bb1438898f47@redhat.com>
	<20180302221831-mutt-send-email-mst@kernel.org>
	<258F88CA-D946-4804-A65D-2EA0790A66AF@redhat.com>
From: Jason Baron <jbaron@akamai.com>
Message-ID: <09cbf694-907e-dd68-60ff-eeb169925a5e@akamai.com>
Date: Tue, 6 Mar 2018 13:02:06 -0500
MIME-Version: 1.0
In-Reply-To: <258F88CA-D946-4804-A65D-2EA0790A66AF@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [virtio-dev] [PATCH 4/4] virtio-net: add linkspeed
 and duplex settings to virtio-net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yan Vugenfirer <yvugenfi@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org



On 03/04/2018 08:05 AM, Yan Vugenfirer wrote:
>=20
>=20
>> On 2 Mar 2018, at 22:19, Michael S. Tsirkin <mst@redhat.com
>> <mailto:mst@redhat.com>> wrote:
>>
>> On Fri, Mar 02, 2018 at 03:14:01PM +0800, Jason Wang wrote:
>>>
>>>
>>> On 2018=E5=B9=B403=E6=9C=8802=E6=97=A5 11:46, Jason Baron wrote:
>>>> Although linkspeed and duplex can be set in a linux guest via
>>>> 'ethtool -s',
>>>> this requires custom ethtool commands for virtio-net by default.
>>>>
>>>> Introduce a new feature flag, VIRTIO_NET_F_SPEED_DUPLEX, which allow=
s
>>>> the hypervisor to export a linkspeed and duplex setting. The user ca=
n
>>>> subsequently overwrite it later if desired via: 'ethtool -s'.
>>>>
>>>> Linkspeed and duplex settings can be set as:
>>>> '-device virtio-net,speed=3D10000,duplex=3Dfull'
>>>
>>> I was thinking whether or not it's better to decide the duplex by the
>>> type
>>> of backends.
>>>
>>> E.g userspace and vhost-kernel implement a in fact half duplex. But d=
pdk
>>> implement a full duplex.
>>>
>>> Thanks
>>
>> OTOH it's a priority for some people to be able to support migration
>> between different backend types. Breaking that won't be nice.
>=20
> I think that in this case we need a way to update the settings of link
> speed and link duplex (maybe add QMP command). Migration between
> different backend types should cause link down\link up events. And this
> is a time for a driver to re-read the settings and update the OS.
>=20
> Best regards,
> Yan.
>=20

So the virtio_net driver in linux will re-read these settings on link up
events. So I could add a qmp command to set these (in addition to the
command-line) interface, if desired. Is there a consensus that we need
to add a qmp command here? Or can that be treated as a future item, if
somebody wants it?

Thanks,

-Jason
