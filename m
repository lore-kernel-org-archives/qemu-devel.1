Received: from eggs.gnu.org ([2001:4830:134:3::10]:33610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ftBv0-00081b-NA
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 09:14:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ftBux-0006yg-GX
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 09:14:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60224 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ftBuv-0006u5-0r
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 09:14:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2D0768010FDF
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 13:14:18 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <8725e03c-6734-47bb-3efe-74fd4b57eca8@redhat.com> (Thomas Huth's
	message of "Thu, 9 Aug 2018 08:17:15 +0200")
References: <20180808114830.7169-1-quintela@redhat.com>
	<20180808114830.7169-13-quintela@redhat.com>
	<8725e03c-6734-47bb-3efe-74fd4b57eca8@redhat.com>
Reply-To: quintela@redhat.com
Date: Fri, 24 Aug 2018 15:14:05 +0200
Message-ID: <871sanrjoi.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 12/22] virtio: split input bits from
 virtio-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com, Gerd Hoffmann <kraxel@redhat.com>

Thomas Huth <thuth@redhat.com> wrote:
> On 08/08/2018 01:48 PM, Juan Quintela wrote:
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  hw/virtio/Makefile.objs      |   1 +
>>  hw/virtio/virtio-input-pci.c | 136 +++++++++++++++++++++++++++++++++++
>>  hw/virtio/virtio-pci.c       | 112 -----------------------------
>>  3 files changed, 137 insertions(+), 112 deletions(-)
>>  create mode 100644 hw/virtio/virtio-input-pci.c
>> 
>> diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
>> index 685ae1d866..6819ed4e14 100644
>> --- a/hw/virtio/Makefile.objs
>> +++ b/hw/virtio/Makefile.objs
>> @@ -12,6 +12,7 @@ obj-$(call
>> land,$(CONFIG_VIRTIO_CRYPTO),$(CONFIG_VIRTIO_PCI)) +=
>> virtio-crypto-p
>>  obj-$(CONFIG_LINUX) += vhost.o vhost-backend.o vhost-user.o
>>  obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock.o vhost-vsock-pci.o
>>  obj-$(CONFIG_VIRTIO_INPUT_HOST) += virtio-input-host-pci.o
>> +obj-$(CONFIG_VIRTIO_INPUT) += virtio-input-pci.o
>>  endif
>>  
>>  common-obj-$(call lnot,$(call
>> land,$(CONFIG_VIRTIO),$(CONFIG_LINUX))) += vhost-stub.o
>> diff --git a/hw/virtio/virtio-input-pci.c b/hw/virtio/virtio-input-pci.c
>> new file mode 100644
>> index 0000000000..3198a505e9
>> --- /dev/null
>> +++ b/hw/virtio/virtio-input-pci.c
>> @@ -0,0 +1,136 @@
>> +/*
>> + * Virtio input PCI Bindings
>> + *
>> + * Copyright IBM, Corp. 2007
>> + * Copyright (c) 2009 CodeSourcery
>> + *
>> + * Authors:
>> + *  Anthony Liguori   <aliguori@us.ibm.com>
>> + *  Paul Brook        <paul@codesourcery.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2.  See
>> + * the COPYING file in the top-level directory.
>> + *
>> + * Contributions after 2012-01-13 are licensed under the terms of the
>> + * GNU GPL, version 2 or (at your option) any later version.
>> + */
>
> virtio-input had been added by Gerd in 2015, so I think you can now
> switch to the GPLv2+ text only. Apart from that, patch looks fine to me.

Done.
Thanks.
