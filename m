Received: from eggs.gnu.org ([2001:4830:134:3::10]:42374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1gSHtK-0000Dy-CI
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 03:41:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1gSHtG-0004Y5-5I
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 03:41:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1gSHtC-0004SQ-4h
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 03:41:40 -0500
Date: Thu, 29 Nov 2018 03:41:33 -0500 (EST)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <2086832273.37377459.1543480893515.JavaMail.zimbra@redhat.com>
In-Reply-To: <4773dd7667ce53e3894ac705badd6e580808c6ce.1542699775.git.yi.z.zhang@linux.intel.com>
References: <cover.1542699775.git.yi.z.zhang@linux.intel.com>
	<4773dd7667ce53e3894ac705badd6e580808c6ce.1542699775.git.yi.z.zhang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, dan j williams <dan.j.williams@intel.com>, stefanha@redhat.com, pbonzini@redhat.com, yu c zhang <yu.c.zhang@linux.intel.com>, imammedo@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com, mst@redhat.com


> 
> object_get_canonical_path_component() returns a string which
> must be freed using g_free().
> 
> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> ---
>  numa.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/numa.c b/numa.c
> index 50ec016..3875e1e 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -533,6 +533,7 @@ void memory_region_allocate_system_memory(MemoryRegion
> *mr, Object *owner,
>              error_report("memory backend %s is used multiple times. Each "
>                           "-numa option must use a different memdev value.",
>                           path);
> +            g_free(path);
>              exit(1);
>          }
>  
> --

Reviewed-by: Pankaj gupta <pagupta@redhat.com>

> 2.7.4
