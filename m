Received: from eggs.gnu.org ([2001:4830:134:3::10]:35374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1etiTi-00040T-Ej
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 18:28:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1etiTh-0004TE-IV
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 18:28:10 -0500
References: <20180306204819.11266-1-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b0babfd7-71b7-c1cb-52a2-994c7cff843b@redhat.com>
Date: Wed, 7 Mar 2018 17:27:45 -0600
MIME-Version: 1.0
In-Reply-To: <20180306204819.11266-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] block: fix nbd-server-stop crash after
 blockdev-snapshot-sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Panella <spanella@gmail.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 03/06/2018 02:48 PM, Stefan Hajnoczi wrote:
> The blockdev-snapshot-sync command uses bdrv_append() to update all parents to
> point at the external snapshot node.  This breaks BlockBackend's
> blk_add/remove_aio_context_notifier(), which doesn't expect a BDS change.
> 
> Patch 1 fixes this by tracking AioContext notifiers in BlockBackend.
> 
> See the test case in Patch 2 for a reproducer.
> 
> Stefan Hajnoczi (2):
>    block: let blk_add/remove_aio_context_notifier() tolerate BDS changes
>    iotests: add 208 nbd-server + blockdev-snapshot-sync test case
> 
>   block/block-backend.c      | 63 ++++++++++++++++++++++++++++++++++++++++++++++
>   block/trace-events         |  2 ++
>   tests/qemu-iotests/208     | 55 ++++++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/208.out |  9 +++++++
>   tests/qemu-iotests/group   |  1 +
>   5 files changed, 130 insertions(+)
>   create mode 100755 tests/qemu-iotests/208
>   create mode 100644 tests/qemu-iotests/208.out

Whose tree should this series go through?  MAINTAINERS didn't flag it as 
directly touching any files that normally affect my NBD queue, but given 
that the iotest that reproduces the problem uses NBD, I'm fine if you 
want it to go through me.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
