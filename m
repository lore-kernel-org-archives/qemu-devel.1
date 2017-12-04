Received: from eggs.gnu.org ([2001:4830:134:3::10]:33904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eLu5x-0002se-9A
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 11:59:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eLu5s-0007FV-FK
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 11:59:53 -0500
References: <A6478011-CD5E-4FDF-A212-6D9BB0E70028@mykolab.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <0fdf8830-4202-59f4-59c0-a99506cde4d9@redhat.com>
Date: Mon, 4 Dec 2017 11:59:45 -0500
MIME-Version: 1.0
In-Reply-To: <A6478011-CD5E-4FDF-A212-6D9BB0E70028@mykolab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] mmap(2) returns MAP_FAILED, not NULL,
 on failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael McConville <mmcco@mykolab.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org



On 12/01/2017 01:31 PM, Michael McConville wrote:
> Signed-off-by: Michael McConville <mmcco@mykolab.com>
> ---
>  hw/i386/xen/xen-mapcache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/xen/xen-mapcache.c b/hw/i386/xen/xen-mapcache.c
> index baab93b614..efa35dc6e0 100644
> --- a/hw/i386/xen/xen-mapcache.c
> +++ b/hw/i386/xen/xen-mapcache.c
> @@ -199,7 +199,7 @@ static void xen_remap_bucket(MapCacheEntry *entry,
>           */
>          vaddr_base = mmap(vaddr, size, PROT_READ | PROT_WRITE,
>                            MAP_ANON | MAP_SHARED, -1, 0);
> -        if (vaddr_base == NULL) {
> +        if (vaddr_base == MAP_FAILED) {
>              perror("mmap");
>              exit(-1);
>          }
> 

Reviewed-by: John Snow <jsnow@redhat.com>
