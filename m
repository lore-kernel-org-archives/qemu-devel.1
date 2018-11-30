Received: from eggs.gnu.org ([2001:4830:134:3::10]:55528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gSebR-0002Su-8q
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 03:56:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gSebO-000135-2x
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 03:56:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1gSebN-00012n-Sj
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 03:56:46 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A4ED689AE9
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 08:56:44 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <63ab2448-5e57-6d0a-8218-664e9da86b55@redhat.com> (Thomas Huth's
	message of "Thu, 29 Nov 2018 07:32:41 +0100")
References: <20181126200009.862-1-quintela@redhat.com>
	<20181126200009.862-2-quintela@redhat.com>
	<a48b8028-6127-dabd-e9e5-8e90fa0d7360@redhat.com>
	<63ab2448-5e57-6d0a-8218-664e9da86b55@redhat.com>
Reply-To: quintela@redhat.com
Date: Fri, 30 Nov 2018 09:56:26 +0100
Message-ID: <875zwf0wqt.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 01/16] virtio: split vhost vsock bits
 from virtio-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com, "Michael S . Tsirkin" <mst@redhat.com>

Thomas Huth <thuth@redhat.com> wrote:
> On 2018-11-29 07:30, Thomas Huth wrote:
>> On 2018-11-26 20:59, Juan Quintela wrote:
>>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>>>
>>> ---
>>>
>>> Updated copyright info
>>> Also split virtio-pci.h bits
>>> ---
>>>  hw/virtio/Makefile.objs     |  2 +-
>>>  hw/virtio/vhost-vsock-pci.c | 82 +++++++++++++++++++++++++++++++++++++
>>>  hw/virtio/virtio-pci.c      | 51 -----------------------
>>>  hw/virtio/virtio-pci.h      | 18 --------
>>>  4 files changed, 83 insertions(+), 70 deletions(-)
>>>  create mode 100644 hw/virtio/vhost-vsock-pci.c
>>>
>>> diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
>>> index 1b2799cfd8..4fbf7de84b 100644
>>> --- a/hw/virtio/Makefile.objs
>>> +++ b/hw/virtio/Makefile.objs
>>> @@ -10,7 +10,7 @@ obj-$(CONFIG_VIRTIO_CRYPTO) += virtio-crypto.o
>>>  obj-$(call land,$(CONFIG_VIRTIO_CRYPTO),$(CONFIG_VIRTIO_PCI)) +=
>>> virtio-crypto-pci.o
>>>  
>>>  obj-$(CONFIG_LINUX) += vhost.o vhost-backend.o vhost-user.o
>>> -obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock.o
>>> +obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock.o vhost-vsock-pci.o
>> 
>> Please change this into:
>> 
>> obj-$(call land,$(CONFIG_VHOST_VSOCK),$(CONFIG_VIRTIO_PCI)) += vhost-vsock-pci.o
>
> ... or alternatively, wrap the new lines in a "ifeq
> ($(CONFIG_VIRTIO_PCI),y)" block, that's maybe easier.

Good catch.
Agreed that the ifeq is the best approach.

Thanks, Juan.
