Received: from eggs.gnu.org ([2001:4830:134:3::10]:41865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gX8Xo-0007pc-CG
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 12:43:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gX8Xk-0006J0-C8
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 12:43:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1gX8Xk-0006I9-4t
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 12:43:32 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8B842C04958C
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 17:43:30 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <5fc8385c-6943-dc08-805e-9e9718cc8926@redhat.com> (Laurent
	Vivier's message of "Wed, 28 Nov 2018 19:00:47 +0100")
References: <20181126200009.862-1-quintela@redhat.com>
	<20181126200009.862-3-quintela@redhat.com>
	<5fc8385c-6943-dc08-805e-9e9718cc8926@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 12 Dec 2018 18:43:25 +0100
Message-ID: <878t0uwshu.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 02/16] virtio: split virtio input host
 bits from virtio-pci
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
> On 26/11/2018 20:59, Juan Quintela wrote:
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  default-configs/virtio.mak        |  1 +
>>  hw/virtio/Makefile.objs           |  1 +
>>  hw/virtio/virtio-input-host-pci.c | 45 +++++++++++++++++++++++++++++++
>>  hw/virtio/virtio-pci.c            | 20 --------------
>>  hw/virtio/virtio-pci.h            | 14 ----------
>>  5 files changed, 47 insertions(+), 34 deletions(-)
>>  create mode 100644 hw/virtio/virtio-input-host-pci.c
>> 
>
> Reviewed-by: Laurent Vivier <lvivier@redhat.com>
>
> You should add a note in the commit message you have renamed
> virtio_host_initfn and virtio_host_pci_info to virtio_input_host_initfn
> and virtio_input_host_info.

Done.
