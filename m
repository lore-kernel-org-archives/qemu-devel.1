Received: from eggs.gnu.org ([2001:4830:134:3::10]:42358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eK9om-0003hj-Gh
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 16:22:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eK9ol-0001Rc-Kv
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 16:22:56 -0500
References: <20171129185102.29390-1-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e9c05c56-b374-cb42-e703-7f0a05b5927b@redhat.com>
Date: Wed, 29 Nov 2017 15:22:48 -0600
MIME-Version: 1.0
In-Reply-To: <20171129185102.29390-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12] qemu-iotests: Fix locking issue
 in 102
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On 11/29/2017 12:51 PM, Max Reitz wrote:
> 102 truncates a qcow2 file (the raw file) on purpose while a VM is
> running.  However, image locking will usually prevent exactly this.
> 
> The fact that most people have not noticed until now (I suppose you may
> have seen sporadic failures, but not taken them too seriously, like me)
> further shows that this truncation is actually not really done
> concurrently, but that the VM is still starting up by this point and has
> not yet opened the image.  Remedy this by waiting for the monitor shell
> to appear before the qemu-img invocation so we know the VM is up.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/qemu-iotests/102     | 7 ++++++-
>   tests/qemu-iotests/102.out | 3 ++-
>   2 files changed, 8 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
