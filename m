Received: from eggs.gnu.org ([2001:4830:134:3::10]:44496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dLufr-0006hc-PT
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:04:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dLufo-0000hi-Lt
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:04:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1dLufo-0000hM-CH
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:04:40 -0400
References: <593F9187.6040800@intel.com>
	<9f196d71-f06b-7520-ca03-e94bf3b5a986@redhat.com>
	<593FB550.6090903@intel.com>
	<26250da7-b394-4964-8842-5c45bbe85e09@redhat.com>
	<6547dfcf-ea3a-f5f6-222d-40ff274654df@redhat.com>
	<20170614180459-mutt-send-email-mst@kernel.org>
	<b59be2f1-ee8c-e660-4f82-bbe63e22b603@redhat.com>
	<59422E91.7080407@intel.com>
	<20170616061949-mutt-send-email-mst@kernel.org>
	<40a12829-6e84-e63e-ac47-6f09cc85c3cc@redhat.com>
	<20170616181607-mutt-send-email-mst@kernel.org>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <199a82f9-b122-08de-696a-04f7c6a369c6@redhat.com>
Date: Fri, 16 Jun 2017 19:04:27 +0200
MIME-Version: 1.0
In-Reply-To: <20170616181607-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [virtio-dev] Re: [virtio-dev] Re: [virtio-dev] Re:
 [PATCH v1] virtio-net: enable configurable tx queue size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Wei Wang <wei.w.wang@intel.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "stefanha@gmail.com" <stefanha@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jan.scheurich@ericsson.com" <jan.scheurich@ericsson.com>, "armbru@redhat.com" <armbru@redhat.com>, "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>



On 06/16/2017 05:19 PM, Michael S. Tsirkin wrote:
> On Fri, Jun 16, 2017 at 04:57:01PM +0800, Jason Wang wrote:
>>
>>
>> On 2017=E5=B9=B406=E6=9C=8816=E6=97=A5 11:22, Michael S. Tsirkin wrote=
:
>>>> I think the issues can be solved by VIRTIO_F_MAX_CHAIN_SIZE.
>>>>
>>>> For now, how about splitting it into two series of patches:
>>>> 1) enable 1024 tx queue size for vhost-user, to let the users of vho=
st-user
>>>> to easily use 1024 queue size.
>>> Fine with me. 1) will get property from user but override it on
>>> !vhost-user. Do we need a protocol flag? It seems prudent but we get
>>> back to cross-version migration issues that a04re still pending solut=
ion.
>>> Marc Andre, what's the status of that work?
>>>
>>>> 2) enable VIRTIO_F_MAX_CHAIN_SIZE,  to enhance robustness.
>>> Rather, to support it for more backends.
>>
>> Ok, if we want to support different values of max chain size in the fu=
ture.
>> It would be problematic for migration of cross backends, consider the =
case
>> when migrating from 2048 (vhost-user) to 1024 (qemu/vhost-kernel).
>>
>> Thanks
>=20
> That's already a problem, and it's growing with each new feature.
> Maxime looked at supporting vhost-user backends cross-version migration=
,
> I think we must merge some solution sooner rather than later, preferabl=
y
> by the next release.
>=20
> Maxime, any update here? Do we need a meeting to reach consensus?

No update, I haven't found time to progress on the topic yet.

For those who aren't aware of my initial proposal, you may find it here:
https://www.spinics.net/linux/fedora/libvir/msg142668.html

If my understanding is correct, you were concerned about the complexity=20
of my
proposal which involved too many layers. Your suggestion was to have a to=
ol
provided with qemu that would connect to vhost-user socket and query the
backend capabilities.
I'm not 100% clear how it would work, as the trend is to start the=20
backend in
client mode, meaning QEMU creates the socket. In this case, should the to=
ol
create the socket and management tool request the backend to connect to i=
t?

I think it could make sense to have a meeting, but maybe we should first
discuss the solutions on the list for efficiency.

For the delivery, what is QEMU v2.10 planned release date?

Note that my solution doesn't involve QEMU, so it would not be tight to Q=
EMU
release date. But, that doesn't mean it would be delivered sooner than
your solution.

Maxime
