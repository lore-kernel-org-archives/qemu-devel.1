Received: from eggs.gnu.org ([2001:4830:134:3::10]:60646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jbaron@akamai.com>) id 1etGpp-0008Cw-Qv
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 12:57:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jbaron@akamai.com>) id 1etGpm-00038e-LI
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 12:57:09 -0500
Received: from mx0b-00190b01.pphosted.com ([2620:100:9005:57f::1]:51560)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jbaron@akamai.com>) id 1etGpm-00038R-GL
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 12:57:06 -0500
References: <cover.1519961667.git.jbaron@akamai.com>
	<c9d3cf2fbc3c64bb28e0438185d85d95b2088127.1519961667.git.jbaron@akamai.com>
	<7fc612d0-9610-9b07-d054-bb1438898f47@redhat.com>
	<c01a1ccd-a864-00a8-edf9-4a16c5dd6c32@akamai.com>
	<20180302222015-mutt-send-email-mst@kernel.org>
From: Jason Baron <jbaron@akamai.com>
Message-ID: <c1399806-7e2a-7560-ca8f-3ea99ec2c5ad@akamai.com>
Date: Tue, 6 Mar 2018 12:57:03 -0500
MIME-Version: 1.0
In-Reply-To: <20180302222015-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/4] virtio-net: add linkspeed and duplex
 settings to virtio-net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org



On 03/02/2018 03:22 PM, Michael S. Tsirkin wrote:
> On Fri, Mar 02, 2018 at 11:59:00AM -0500, Jason Baron wrote:
>> On 03/02/2018 02:14 AM, Jason Wang wrote:
>>>
>>>
>>> On 2018=E5=B9=B403=E6=9C=8802=E6=97=A5 11:46, Jason Baron wrote:
>>>> Although linkspeed and duplex can be set in a linux guest via 'ethto=
ol
>>>> -s',
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
>>> type of backends.
>>>
>>> E.g userspace and vhost-kernel implement a in fact half duplex. But d=
pdk
>>> implement a full duplex.
>>
>> Interesting - could this be derived only from the backend 'type'. IE:
>> NET_CLIENT_DRIVER_TAP, NET_CLIENT_DRIVER_VHOST_USER...
>>
>>
>> I was also thinking this could be specified as 'duplex=3Dbackend', in
>> addition to the proposed 'duplex=3Dfull' or 'duplex=3Dhalf'?
>>
>> Thanks,
>>
>> -Jason
>=20
> I'd say it would make more sense to teach backends to obey what's
> specified by the user. E.g. if vhost gets a duplex config,
> create two threads.
>=20
> But I think all that's for future, we can just fake it for
> now - the current uses don't seem to particularly care about whether
> virtio actually is or isn't a duplex.
>=20
>=20

Ok, I wouldn't add 'duplex=3Dbackend' when I re-post, and will leave any
automatic settings of duplex to 'future work'.

Thanks,

-Jason
