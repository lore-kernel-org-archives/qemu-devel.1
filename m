Received: from eggs.gnu.org ([2001:4830:134:3::10]:60880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dLoAp-0004J9-1y
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 06:08:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dLoAl-0005nE-Ra
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 06:08:15 -0400
Received: from mga03.intel.com ([134.134.136.65]:14472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1dLoAl-0005kr-Hv
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 06:08:11 -0400
Message-ID: <5943AE93.7020502@intel.com>
Date: Fri, 16 Jun 2017 18:10:27 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <593F8153.7080209@intel.com>
	<f8a64b2c-e769-4e9c-1cc6-ad31ea266010@redhat.com>
	<593F9187.6040800@intel.com>
	<9f196d71-f06b-7520-ca03-e94bf3b5a986@redhat.com>
	<593FB550.6090903@intel.com>
	<26250da7-b394-4964-8842-5c45bbe85e09@redhat.com>
	<6547dfcf-ea3a-f5f6-222d-40ff274654df@redhat.com>
	<20170614180459-mutt-send-email-mst@kernel.org>
	<b59be2f1-ee8c-e660-4f82-bbe63e22b603@redhat.com>
	<59422E91.7080407@intel.com>
	<20170616061949-mutt-send-email-mst@kernel.org>
	<40a12829-6e84-e63e-ac47-6f09cc85c3cc@redhat.com>
In-Reply-To: <40a12829-6e84-e63e-ac47-6f09cc85c3cc@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "stefanha@gmail.com" <stefanha@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jan.scheurich@ericsson.com" <jan.scheurich@ericsson.com>, "armbru@redhat.com" <armbru@redhat.com>, "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>

On 06/16/2017 04:57 PM, Jason Wang wrote:
>
>
> On 2017年06月16日 11:22, Michael S. Tsirkin wrote:
>>> I think the issues can be solved by VIRTIO_F_MAX_CHAIN_SIZE.
>>>
>>> For now, how about splitting it into two series of patches:
>>> 1) enable 1024 tx queue size for vhost-user, to let the users of 
>>> vhost-user
>>> to easily use 1024 queue size.
>> Fine with me. 1) will get property from user but override it on
>> !vhost-user. Do we need a protocol flag? It seems prudent but we get
>> back to cross-version migration issues that are still pending solution.
What do you have in mind about the protocol flag?

Btw, I just tested the patch of 1), and it works fine with migration 
from the
patched to non-patched version of QEMU. I'll send it out. Please have a 
check.


>> Marc Andre, what's the status of that work?
>>
>>> 2) enable VIRTIO_F_MAX_CHAIN_SIZE,  to enhance robustness.
>> Rather, to support it for more backends.
>
> Ok, if we want to support different values of max chain size in the 
> future. It would be problematic for migration of cross backends, 
> consider the case when migrating from 2048 (vhost-user) to 1024 
> (qemu/vhost-kernel).
>

I think that wouldn't be a problem. If there is a possibility to change the
backend resulting in a change of config.max_change_size, a configuration
change notification can be injected to the guest, then guest will read and
get the new value.

Best,
Wei
