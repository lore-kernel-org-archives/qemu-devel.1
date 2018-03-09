Received: from eggs.gnu.org ([2001:4830:134:3::10]:38919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euL3x-0001TG-HV
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:40:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euL3t-0008U8-NI
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:40:09 -0500
References: <20180308184636.178534-1-vsementsov@virtuozzo.com>
	<20180308184636.178534-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0196fa0d-28f7-85d4-9b9c-cdc024005f38@redhat.com>
Date: Fri, 9 Mar 2018 10:39:57 -0600
MIME-Version: 1.0
In-Reply-To: <20180308184636.178534-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/5] nbd/server: move
 nbd_co_send_structured_error up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org

On 03/08/2018 12:46 PM, Vladimir Sementsov-Ogievskiy wrote:
> To be reused in nbd_co_send_sparse_read() in the following patch.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   nbd/server.c | 48 ++++++++++++++++++++++++------------------------
>   1 file changed, 24 insertions(+), 24 deletions(-)
> 
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
