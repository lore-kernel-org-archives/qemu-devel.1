Received: from eggs.gnu.org ([2001:4830:134:3::10]:36748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dMvmW-00006G-VA
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:27:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dMvmT-0008AM-PJ
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:27:48 -0400
Received: from mail-eopbgr40094.outbound.protection.outlook.com
	([40.107.4.94]:59219
	helo=EUR03-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbutsykin@virtuozzo.com>)
	id 1dMvmT-00088K-6c
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:27:45 -0400
References: <20170615163813.7255-1-stefanha@redhat.com>
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Message-ID: <27a724bc-95c0-9d9f-ea90-015fcdf7dc92@virtuozzo.com>
Date: Mon, 19 Jun 2017 15:26:56 +0300
MIME-Version: 1.0
In-Reply-To: <20170615163813.7255-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/5] qemu-iotests: test savevm/loadvm
 iothread (and make it work!)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Roman Kagan <rkagan@virtuozzo.com>

On 15.06.2017 19:38, Stefan Hajnoczi wrote:
> This series extends qemu-iotests 068 to also run with iothread enabled.  Doing
> so was harder than expected because:
> 
> 1. ioeventfd is disabled without -M accel=kvm even though it should work
> 2. loadvm still has an iothread bug
> 
> Instead of adding a ./check -iothread option I decided to always run the test.
> Kevin recently recommended this approach; the advantage is that iothread *will*
> always be tested iothread mode whereas people won't run ./check -iothread.

Why not just add -iothread option in check-block.sh? We can do an
additional run with -iothread, as it is done for different block
formats.

Because all the test cases already exist, we can just reuse them.
> Stefan Hajnoczi (5):
>    virtio-pci: use ioeventfd even when KVM is disabled
>    migration: hold AioContext lock for loadvm qemu_fclose()
>    qemu-iotests: 068: extract _qemu() function
>    qemu-iotests: 068: use -drive/-device instead of -hda
>    qemu-iotests: 068: test iothread mode
> 
>   hw/virtio/virtio-pci.c     |  2 +-
>   migration/savevm.c         |  2 +-
>   tests/qemu-iotests/068     | 37 +++++++++++++++++++++++++------------
>   tests/qemu-iotests/068.out | 11 ++++++++++-
>   4 files changed, 37 insertions(+), 15 deletions(-)
> 
