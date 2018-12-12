Received: from eggs.gnu.org ([2001:4830:134:3::10]:41924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gX8Y5-0007zV-Hr
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 12:43:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gX8Y1-0006Sr-IY
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 12:43:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1gX8Y1-0006SE-CE
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 12:43:49 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A9020C0669D2
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 17:43:48 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <b80018fd-e849-9b3e-5d46-886dbb9da847@redhat.com> (Laurent
	Vivier's message of "Wed, 28 Nov 2018 21:06:30 +0100")
References: <20181126200009.862-1-quintela@redhat.com>
	<20181126200009.862-5-quintela@redhat.com>
	<b80018fd-e849-9b3e-5d46-886dbb9da847@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 12 Dec 2018 18:43:45 +0100
Message-ID: <874lbiwsha.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 04/16] virtio: split virtio rng bits
 from virtio-pci
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
>> 
>> ---
>> 
>> Remove the "contributions after" clause.  This is based on
>> 
>> commit 59ccd20a9ac719cff82180429458728f03ec612f
>> Author: KONRAD Frederic <fred.konrad@greensocs.com>
>> Date:   Wed Apr 24 10:07:56 2013 +0200
>> ---
>>  hw/virtio/Makefile.objs    |  1 +
>>  hw/virtio/virtio-pci.c     | 52 -----------------------
>>  hw/virtio/virtio-pci.h     | 14 -------
>>  hw/virtio/virtio-rng-pci.c | 86 ++++++++++++++++++++++++++++++++++++++
>>  tests/Makefile.include     |  1 +
>>  5 files changed, 88 insertions(+), 66 deletions(-)
>>  create mode 100644 hw/virtio/virtio-rng-pci.c
> ...
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index fb0b449c02..e8235890ec 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -149,6 +149,7 @@ check-qtest-virtio-y += tests/virtio-net-test$(EXESUF)
>>  check-qtest-virtio-y += tests/virtio-balloon-test$(EXESUF)
>>  check-qtest-virtio-y += tests/virtio-blk-test$(EXESUF)
>>  check-qtest-virtio-y += tests/virtio-rng-test$(EXESUF)
>> +check-qtest-virtio-$(CONFIG_VIRTIO_RNG) += tests/virtio-rng-test$(EXESUF)
>
> I think you should remove the line just above.
>
> except that:

Done.

Thanks.

>
> Reviewed-by: Laurent Vivier <lvivier@redhat.com>
