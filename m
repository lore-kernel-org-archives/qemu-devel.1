Received: from eggs.gnu.org ([2001:4830:134:3::10]:43053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fhzAk-0004Eb-UJ
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 11:24:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fhzAk-0001HB-5D
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 11:24:22 -0400
References: <20180724121753.5753-1-lbloch@janustech.com>
	<20180724121753.5753-5-lbloch@janustech.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8c96b257-4867-be60-acaa-843cd08bf456@redhat.com>
Date: Tue, 24 Jul 2018 10:24:09 -0500
MIME-Version: 1.0
In-Reply-To: <20180724121753.5753-5-lbloch@janustech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/4] iotests: Add tests for the new
 l2-cache-full option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 07/24/2018 07:17 AM, Leonid Bloch wrote:
> This patch adds tests for the l2-cache-full option, and also intcoduces

s/intcoduces/introduces/

> a small change due to a grammar fix in block/qcow2.c
> 
> Signed-off-by: Leonid Bloch <lbloch@janustech.com>
> ---
>   tests/qemu-iotests/103     | 6 ++++++
>   tests/qemu-iotests/103.out | 4 +++-
>   tests/qemu-iotests/137     | 2 ++
>   tests/qemu-iotests/137.out | 4 +++-
>   4 files changed, 14 insertions(+), 2 deletions(-)
> 

> +++ b/tests/qemu-iotests/103.out
> @@ -5,7 +5,9 @@ wrote 65536/65536 bytes at offset 0
>   
>   === Testing invalid option combinations ===
>   
> -can't open device TEST_DIR/t.IMGFMT: cache-size, l2-cache-size and refcount-cache-size may not be set the same time
> +can't open device TEST_DIR/t.IMGFMT: l2-cache-full and l2-cache-size may not be set at the same time
> +can't open device TEST_DIR/t.IMGFMT: cache-size, l2-cache-size and refcount-cache-size may not be set at the same time

This should be squashed into the patch that introduces the changed 
output (when bisecting, we don't want to land on a known-broken iotests 
state).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
