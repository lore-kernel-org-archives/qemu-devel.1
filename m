Received: from eggs.gnu.org ([2001:4830:134:3::10]:52434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gXPQB-0001aY-Hd
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:44:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gXPQ8-0008Oq-Dd
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:44:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1gXPQ8-0008Od-81
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:44:48 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 719B2307D96E
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 11:44:47 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <c52f04d6-dced-1cb7-23b8-f301254dc366@redhat.com> (Laurent
	Vivier's message of "Wed, 28 Nov 2018 21:48:04 +0100")
References: <20181126200009.862-1-quintela@redhat.com>
	<20181126200009.862-17-quintela@redhat.com>
	<c52f04d6-dced-1cb7-23b8-f301254dc366@redhat.com>
Reply-To: quintela@redhat.com
Date: Thu, 13 Dec 2018 12:44:38 +0100
Message-ID: <87r2elveft.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 16/16] virtio: virtio 9p really requires
 CONFIG_VIRTFS to work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, peterx@redhat.com

Laurent Vivier <lvivier@redhat.com> wrote:
> On 26/11/2018 21:00, Juan Quintela wrote:
>> Otherwise, it has no implementation.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  default-configs/virtio.mak | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/default-configs/virtio.mak b/default-configs/virtio.mak
>> index 5ae4a61018..ecb4420e74 100644
>> --- a/default-configs/virtio.mak
>> +++ b/default-configs/virtio.mak
>> @@ -1,7 +1,7 @@
>>  CONFIG_VHOST_USER_SCSI=$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX))
>>  CONFIG_VHOST_USER_BLK=$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX))
>>  CONFIG_VIRTIO=y
>> -CONFIG_VIRTIO_9P=y
>> +CONFIG_VIRTIO_9P=$(CONFIG_VIRTFS)
>>  CONFIG_VIRTIO_BALLOON=y
>>  CONFIG_VIRTIO_BLK=y
>>  CONFIG_VIRTIO_CRYPTO=y
>> 
>
> I think you should also replace "#ifdef CONFIG_VIRTFS" by "#ifdef
> CONFIG_VIRTIO_9P" in:
>
> hw/s390x/virtio-ccw.h
> include/hw/xen/xen_backend.h
> hw/xen/xen_backend.c

After trying again, I remember why it failed.

CONFIG_VIRTFS is defined in config-host.mak (and everyting in
config-host.mak is defined also in config-host.h).

CONFIG_VIRTIO_* is defined on config-devices.mak, and that is not
defined in any include file.

Sniff.

Removed (again) that bit.

Later, Juan.
