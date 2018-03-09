Received: from eggs.gnu.org ([2001:4830:134:3::10]:58191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euKZA-0002Er-TJ
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:08:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euKZ9-0000Sw-O3
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:08:20 -0500
References: <20180306204819.11266-1-stefanha@redhat.com>
	<20180306204819.11266-3-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3178a040-eab8-b25d-c766-393439fc060a@redhat.com>
Date: Fri, 9 Mar 2018 10:08:09 -0600
MIME-Version: 1.0
In-Reply-To: <20180306204819.11266-3-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] iotests: add 208 nbd-server +
 blockdev-snapshot-sync test case
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
> This test case adds an NBD server export and then invokes
> blockdev-snapshot-sync, which changes the BlockDriverState node that the

Do we want to test 'blockdev-snapshot' instead (or in addition), given 
the subthread discussion about blockdev-snapshot-sync being the older 
non-preferred form?

> NBD server's BlockBackend points to.  This is an interesting scenario to
> test and exercises the code path fixed by the previous commit.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   tests/qemu-iotests/208     | 55 ++++++++++++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/208.out |  9 ++++++++
>   tests/qemu-iotests/group   |  1 +
>   3 files changed, 65 insertions(+)
>   create mode 100755 tests/qemu-iotests/208
>   create mode 100644 tests/qemu-iotests/208.out
> 

Switching the order of the two patches in this series makes it obvious 
that this patch does tickle the code path in question, so you definitely 
get:

Tested-by: Eric Blake <eblake@redhat.com>

And unless answering the question about blockdev-snapshot causes you to 
change things for more/different QMP commands, I'm also fine with:

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
