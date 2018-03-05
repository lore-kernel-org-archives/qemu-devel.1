Received: from eggs.gnu.org ([2001:4830:134:3::10]:42794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=595409ade=anthony.perard@citrix.com>)
	id 1esvDK-0005p4-1D
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 13:51:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=595409ade=anthony.perard@citrix.com>)
	id 1esvDF-0003ZG-TT
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 13:51:58 -0500
Received: from smtp.citrix.com ([66.165.176.89]:51044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=595409ade=anthony.perard@citrix.com>)
	id 1esvDF-0003YJ-Lk
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 13:51:53 -0500
Date: Mon, 5 Mar 2018 18:51:49 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20180305185149.GA1921@perard.uk.xensource.com>
References: <20180305112732.26471-1-f4bug@amsat.org>
	<20180305112732.26471-9-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180305112732.26471-9-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH v2 08/30] hw/i386: use the BYTE-based
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, "open list:X86" <xen-devel@lists.xenproject.org>

On Mon, Mar 05, 2018 at 08:27:10AM -0300, Philippe Mathieu-Daudé wrote:
> It eases code review, unit is explicit.
> 
> Patch generated using:
> 
>   $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include/hw/
> 
> and modified manually.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/i386/xen/xen-mapcache.c |  2 +-
> 
> diff --git a/hw/i386/xen/xen-mapcache.c b/hw/i386/xen/xen-mapcache.c
> index efa35dc6e0..5f48fde799 100644
> --- a/hw/i386/xen/xen-mapcache.c
> +++ b/hw/i386/xen/xen-mapcache.c
> @@ -47,7 +47,7 @@
>   * From empirical tests I observed that qemu use 75MB more than the
>   * max_mcache_size.
>   */
> -#define NON_MCACHE_MEMORY_SIZE (80 * 1024 * 1024)
> +#define NON_MCACHE_MEMORY_SIZE (80 * M_BYTE)
>  
>  typedef struct MapCacheEntry {
>      hwaddr paddr_index;

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

-- 
Anthony PERARD
