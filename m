Received: from eggs.gnu.org ([2001:4830:134:3::10]:58145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ftBht-0003aE-MG
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 09:00:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ftBhq-0004Uu-CX
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 09:00:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44750 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ftBhq-0004UO-7B
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 09:00:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9F10140216E8
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 13:00:49 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <51139c7c-9592-d5ac-8541-b9d54febfd2a@redhat.com> (Thomas Huth's
	message of "Thu, 9 Aug 2018 08:10:00 +0200")
References: <20180808114830.7169-1-quintela@redhat.com>
	<20180808114830.7169-12-quintela@redhat.com>
	<51139c7c-9592-d5ac-8541-b9d54febfd2a@redhat.com>
Reply-To: quintela@redhat.com
Date: Fri, 24 Aug 2018 15:00:38 +0200
Message-ID: <875zzzrkax.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 11/22] virtio: split host bits from
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
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

Thomas Huth <thuth@redhat.com> wrote:
> On 08/08/2018 01:48 PM, Juan Quintela wrote:
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  default-configs/virtio.mak        |  3 +++
>>  hw/virtio/Makefile.objs           |  1 +
>>  hw/virtio/virtio-input-host-pci.c | 42 +++++++++++++++++++++++++++++++
>>  hw/virtio/virtio-pci.c            | 20 ---------------
>>  4 files changed, 46 insertions(+), 20 deletions(-)
>>  create mode 100644 hw/virtio/virtio-input-host-pci.c
>> 
>> diff --git a/default-configs/virtio.mak b/default-configs/virtio.mak
>> index 1304849018..6309dbf938 100644
>> --- a/default-configs/virtio.mak
>> +++ b/default-configs/virtio.mak
>> @@ -12,3 +12,6 @@ CONFIG_VIRTIO_RNG=y
>>  CONFIG_SCSI=y
>>  CONFIG_VIRTIO_SCSI=y
>>  CONFIG_VIRTIO_SERIAL=y
>> +CONFIG_VIRTIO_VSOCK=y
>> +CONFIG_VIRTIO_INPUT_HOST=$(CONFIG_LINUX)
>
> What's the VIRTIO_VSOCK good for? You don't seem to use it in this patch?

Trash from previous rebases.  Removed.  Thanks.
