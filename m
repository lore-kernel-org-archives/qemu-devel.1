Received: from eggs.gnu.org ([209.51.188.92]:48213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjnYA-0008GT-Rk
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 10:56:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjnYA-0000j5-3s
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 10:56:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gjnY9-0000ih-LW
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 10:56:17 -0500
Date: Wed, 16 Jan 2019 10:56:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190116105547-mutt-send-email-mst@kernel.org>
References: <cover.1547624239.git.yi.z.zhang@linux.intel.com>
	<5a9ab3832eacb1e4bc6649f72bcf2969074573f1.1547624239.git.yi.z.zhang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a9ab3832eacb1e4bc6649f72bcf2969074573f1.1547624239.git.yi.z.zhang@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH V9 1/6] numa: Fixed the memory leak of numa
 error message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Yi <yi.z.zhang@linux.intel.com>
Cc: xiaoguangrong.eric@gmail.com, stefanha@redhat.com, pbonzini@redhat.com, pagupta@redhat.com, yu.c.zhang@linux.intel.com, ehabkost@redhat.com, qemu-devel@nongnu.org, imammedo@redhat.com, dan.j.williams@intel.com

On Wed, Jan 16, 2019 at 04:10:17PM +0800, Zhang Yi wrote:
> object_get_canonical_path_component() returns a string which
> must be freed using g_free().
> 
> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> Reviewed-by: Pankaj gupta <pagupta@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Pls post this separately as it's just a bugfix that
is not a dependency of map_sync.

> ---
>  numa.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/numa.c b/numa.c
> index 50ec016..3875e1e 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -533,6 +533,7 @@ void memory_region_allocate_system_memory(MemoryRegion *mr, Object *owner,
>              error_report("memory backend %s is used multiple times. Each "
>                           "-numa option must use a different memdev value.",
>                           path);
> +            g_free(path);
>              exit(1);
>          }
>  
> -- 
> 2.7.4
