Received: from eggs.gnu.org ([2001:4830:134:3::10]:44245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evocD-0003mh-1J
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 14:25:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evocC-0006Xw-8U
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 14:25:37 -0400
References: <cover.1520952419.git.berto@igalia.com>
	<b0f41d78fb61352d58e1f3442c3eec8f94ec6e16.1520952419.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c328607b-edcc-b452-388f-3b95d951b3f4@redhat.com>
Date: Tue, 13 Mar 2018 13:25:30 -0500
MIME-Version: 1.0
In-Reply-To: <b0f41d78fb61352d58e1f3442c3eec8f94ec6e16.1520952419.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] docs: Document the new default sizes
 of the qcow2 caches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 03/13/2018 10:02 AM, Alberto Garcia wrote:
> We have just reduced the refcount cache size to the minimum unless
> the user explicitly requests a larger one, so we have to update the
> documentation to reflect this change.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>   docs/qcow2-cache.txt | 31 ++++++++++++++-----------------
>   1 file changed, 14 insertions(+), 17 deletions(-)
> 

> +Before QEMU 2.12 the refcount cache had a default size of 1/4 of the
> +L2 cache size. This resulted in unnecessarily large caches, so now the
> +refcount cache is as small as possible unless overriden by the user.

s/overriden/overridden/

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
