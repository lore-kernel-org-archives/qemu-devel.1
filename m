Received: from eggs.gnu.org ([2001:4830:134:3::10]:49962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVLXA-0002S8-Lz
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 14:39:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVLX9-0001Mo-O1
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 14:39:16 -0400
References: <20180609151758.17343-1-vsementsov@virtuozzo.com>
	<20180609151758.17343-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dfcd6a27-1cf5-0971-364f-3c054222bf85@redhat.com>
Date: Tue, 19 Jun 2018 13:39:09 -0500
MIME-Version: 1.0
In-Reply-To: <20180609151758.17343-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 1/6] nbd/server: fix trace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

On 06/09/2018 10:17 AM, Vladimir Sementsov-Ogievskiy wrote:
> Return code = 1 doesn't mean that we parsed base:allocation. Use
> correct traces in both -parsed and -skipped cases.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   nbd/server.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)

> 
> diff --git a/nbd/server.c b/nbd/server.c
> index 9e1f227178..8e02e077ec 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -741,7 +741,10 @@ static int nbd_negotiate_send_meta_context(NBDClient *client,
>    * the current name, after the 'base:' portion has been stripped.
>    *
>    * Return -errno on I/O error, 0 if option was completely handled by
> - * sending a reply about inconsistent lengths, or 1 on success. */
> + * sending a reply about inconsistent lengths, or 1 on success.
> + *
> + * Note: return code = 1 doesn't mean that we've parsed "base:allocation"
> + * namespace. It only means that there are no errors.*/

Space before comment tail (actually, the recent conversation on comment 
style says the tail should be on its own line...)

That's something I can tweak on commit.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
