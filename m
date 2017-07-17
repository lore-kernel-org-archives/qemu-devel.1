Received: from eggs.gnu.org ([2001:4830:134:3::10]:47602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dX2Kg-0000uj-FD
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:28:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dX2Kb-0003E9-Hh
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:28:50 -0400
References: <1500035226-6530-1-git-send-email-jasowang@redhat.com>
	<20170714172631-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f2e868dd-c845-aae4-2eba-13c6715dc1eb@redhat.com>
Date: Mon, 17 Jul 2017 17:28:35 +0800
MIME-Version: 1.0
In-Reply-To: <20170714172631-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio-net: fix offload ctrl endian
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Dmitry Fleytman <dfleytma@redhat.com>



On 2017=E5=B9=B407=E6=9C=8814=E6=97=A5 22:26, Michael S. Tsirkin wrote:
> On Fri, Jul 14, 2017 at 08:27:06PM +0800, Jason Wang wrote:
>> Spec said offloads should be le64, so use virtio_ldq_p() to guarantee
>> valid endian.
>>
>> Fixes: 644c98587d4c ("virtio-net: dynamic network offloads configurati=
on")
>> Cc: qemu-stable@nongnu.org
>> Cc: Dmitry Fleytman <dfleytma@redhat.com>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>   hw/net/virtio-net.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>> index 657d099..eb8f5b6 100644
>> --- a/hw/net/virtio-net.c
>> +++ b/hw/net/virtio-net.c
>> @@ -757,6 +757,7 @@ static int virtio_net_handle_offloads(VirtIONet *n=
, uint8_t cmd,
>>  =20
>>       if (cmd =3D=3D VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET) {
>>           uint64_t supported_offloads;
> An empty line wouldn't hurt here.

I apply this patch by adding a new line here.

Thanks

>
>> +        offloads =3D virtio_ldq_p(vdev, &offloads);
>>  =20
>>           if (!n->has_vnet_hdr) {
>>               return VIRTIO_NET_ERR;
>> --=20
>> 2.7.4
