Received: from eggs.gnu.org ([2001:4830:134:3::10]:54267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZMMq-0002e5-1U
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 15:53:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZMMm-0008R8-4b
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 15:53:26 -0500
References: <20181102151152.288399-1-vsementsov@virtuozzo.com>
	<20181102151152.288399-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cbdeb57e-145c-e10f-084a-7273e73c17e0@redhat.com>
Date: Tue, 18 Dec 2018 14:53:07 -0600
MIME-Version: 1.0
In-Reply-To: <20181102151152.288399-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] nbd: publish _lookup functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

On 11/2/18 10:11 AM, Vladimir Sementsov-Ogievskiy wrote:
> These functions are used for formatting pretty trace points. We are
> going to add some in block/nbd-client, so, let's publish all these
> functions at once. Note, that nbd_reply_type_lookup is already
> published, and constants, "named" by these functions live in
> include/block/nbd.h too.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   include/block/nbd.h | 5 +++++
>   nbd/nbd-internal.h  | 5 -----
>   2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/block/nbd.h b/include/block/nbd.h
> index 6a5bfe5d55..65402d3396 100644
> --- a/include/block/nbd.h
> +++ b/include/block/nbd.h
> @@ -343,5 +343,10 @@ static inline bool nbd_reply_is_structured(NBDReply *reply)
>   }
>   
>   const char *nbd_reply_type_lookup(uint16_t type);
> +const char *nbd_opt_lookup(uint32_t opt);
> +const char *nbd_rep_lookup(uint32_t rep);
> +const char *nbd_info_lookup(uint16_t info);
> +const char *nbd_cmd_lookup(uint16_t info);
> +const char *nbd_err_lookup(int err);

Reviewed-by: Eric Blake <eblake@redhat.com>

Side note: We could even go further, and have code to auto-generate the 
tables; see how nbdkit did it:

https://github.com/libguestfs/nbdkit/commit/d198cf9c

But for now, the protocol doesn't grow all that frequently, so keeping 
the lists up to date by hand doesn't bother me.


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
