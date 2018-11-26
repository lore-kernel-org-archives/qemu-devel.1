Received: from eggs.gnu.org ([2001:4830:134:3::10]:57588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gRGeu-0001Ts-0w
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 08:10:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gRGep-0006pE-8D
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 08:10:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43899)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gRGep-0006oA-2d
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 08:10:35 -0500
Date: Mon, 26 Nov 2018 14:10:26 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181126141026.36986d6c@redhat.com>
In-Reply-To: <4773dd7667ce53e3894ac705badd6e580808c6ce.1542699775.git.yi.z.zhang@linux.intel.com>
References: <cover.1542699775.git.yi.z.zhang@linux.intel.com>
	<4773dd7667ce53e3894ac705badd6e580808c6ce.1542699775.git.yi.z.zhang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V5_resend 1/7] numa: Fixed the memory leak
 of numa error message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Yi <yi.z.zhang@linux.intel.com>
Cc: xiaoguangrong.eric@gmail.com, dan.j.williams@intel.com, stefanha@redhat.com, pbonzini@redhat.com, yu.c.zhang@linux.intel.com, qemu-devel@nongnu.org, ehabkost@redhat.com, mst@redhat.com

On Tue, 20 Nov 2018 15:48:06 +0800
Zhang Yi <yi.z.zhang@linux.intel.com> wrote:

> object_get_canonical_path_component() returns a string which
> must be freed using g_free().
> 
> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

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
