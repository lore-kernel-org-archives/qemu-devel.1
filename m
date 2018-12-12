Received: from eggs.gnu.org ([2001:4830:134:3::10]:42043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gX8YN-0008AN-Ag
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 12:44:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gX8YJ-0006c9-9d
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 12:44:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1gX8YI-0006bA-LG
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 12:44:06 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 54F2B307D844
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 17:44:05 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <217e09f2-f374-9d26-561d-e6d660d52320@redhat.com> (Laurent
	Vivier's message of "Wed, 28 Nov 2018 21:15:36 +0100")
References: <20181126200009.862-1-quintela@redhat.com>
	<20181126200009.862-7-quintela@redhat.com>
	<217e09f2-f374-9d26-561d-e6d660d52320@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 12 Dec 2018 18:44:02 +0100
Message-ID: <87zhtavdwd.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 06/16] virtio: split virtio 9p bits from
 virtio-pci
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
>>  hw/virtio/Makefile.objs   |  1 +
>>  hw/virtio/virtio-9p-pci.c | 86 +++++++++++++++++++++++++++++++++++++++
>>  hw/virtio/virtio-pci.c    | 52 -----------------------
>>  hw/virtio/virtio-pci.h    | 20 ---------
>>  4 files changed, 87 insertions(+), 72 deletions(-)
>>  create mode 100644 hw/virtio/virtio-9p-pci.c
>> 
>
> And what about tests/virtio-9p-test ?

You are right.

Fixed.

> except that:
>
> Reviewed-by: Laurent Vivier <lvivier@redhat.com>
