Received: from eggs.gnu.org ([209.51.188.92]:47555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gvq7t-0007yi-FG
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 16:06:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gvq7s-0007FO-N6
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 16:06:57 -0500
References: <20190218180646.30282-1-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b78203cc-0348-23b9-97fc-ba1a263b5f09@redhat.com>
Date: Mon, 18 Feb 2019 15:06:48 -0600
MIME-Version: 1.0
In-Reply-To: <20190218180646.30282-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] iotests: Skip 211 on insufficient memory
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

On 2/18/19 12:06 PM, Max Reitz wrote:
> VDI keeps the whole bitmap in memory, and the maximum size (which is
> tested here) is 2 GB.  This may not be available on all machines, and it
> rarely is available when running a 32 bit build.
> 
> Fix this by making VM.run_job() return the error string if an error
> occurred, and checking whether that contains "Could not allocate bmap"
> in 211.  If so, the test is skipped.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/211        | 4 +++-
>  tests/qemu-iotests/iotests.py | 5 ++++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
