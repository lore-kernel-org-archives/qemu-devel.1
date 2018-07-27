Received: from eggs.gnu.org ([2001:4830:134:3::10]:40891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj4MP-0002w2-So
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:08:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj4MP-0003KQ-22
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:08:53 -0400
References: <20180727141539.506-1-kwolf@redhat.com>
	<20180727141539.506-3-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7763b4bf-e796-55bf-7773-d9e62dda0bbb@redhat.com>
Date: Fri, 27 Jul 2018 10:08:45 -0500
MIME-Version: 1.0
In-Reply-To: <20180727141539.506-3-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.0 2/3] block/qapi: Include anonymous
 BBs in query-blockstats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org

On 07/27/2018 09:15 AM, Kevin Wolf wrote:
> Consistent with query-block, query-blockstats should not only include
> named BlockBackends, but also those that are anonmyous, but belong to a

s/anonmyous/anonymous/

> device model.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/qapi.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
