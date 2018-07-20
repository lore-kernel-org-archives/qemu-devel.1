Received: from eggs.gnu.org ([2001:4830:134:3::10]:53874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fgbnW-0007QW-Cf
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 16:14:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fgbnV-0004PK-ML
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 16:14:42 -0400
References: <20180609153217.19683-1-vsementsov@virtuozzo.com>
	<20180609153217.19683-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9c7ea69f-3ef6-70b7-cc5c-5f4f39a1c67f@redhat.com>
Date: Fri, 20 Jul 2018 15:14:33 -0500
MIME-Version: 1.0
In-Reply-To: <20180609153217.19683-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 01/11] block/nbd-client: split channel
 errors from export errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

On 06/09/2018 10:32 AM, Vladimir Sementsov-Ogievskiy wrote:
> To implement nbd reconnect in further patches, we need to distinguish
> error codes, returned by nbd server, from channel errors, to reconnect
> only in the latter case.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/nbd-client.c | 83 +++++++++++++++++++++++++++++++-----------------------
>   1 file changed, 47 insertions(+), 36 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
