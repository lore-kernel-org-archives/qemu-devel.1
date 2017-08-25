Received: from eggs.gnu.org ([2001:4830:134:3::10]:44570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dlG7u-00020B-9e
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 11:02:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dlG7p-0004sx-FK
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 11:02:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dlG7p-0004sV-9f
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 11:02:21 -0400
Date: Fri, 25 Aug 2017 16:02:15 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170825150215.GH2090@work-vm>
References: <20170824192315.5897-1-ehabkost@redhat.com>
	<20170824192315.5897-3-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170824192315.5897-3-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/3] osdep: Define QEMU_MADV_REMOVE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Zack Cornelius <zack.cornelius@kove.net>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Igor Mammedov <imammedo@redhat.com>

* Eduardo Habkost (ehabkost@redhat.com) wrote:
> Define QEMU_MADV_REMOVE, so we can use it with qemu_madvise().
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
> Changes v1 -> v2:
> * New patch added to series
> ---
>  include/qemu/osdep.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 6855b94..e9fa217 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -257,6 +257,11 @@ void qemu_anon_ram_free(void *ptr, size_t size);
>  #else
>  #define QEMU_MADV_NOHUGEPAGE QEMU_MADV_INVALID
>  #endif
> +#ifdef MADV_REMOVE
> +#define QEMU_MADV_REMOVE MADV_REMOVE
> +#else
> +#define QEMU_MADV_REMOVE QEMU_MADV_INVALID
> +#endif
>  
>  #elif defined(CONFIG_POSIX_MADVISE)
>  
> @@ -269,6 +274,7 @@ void qemu_anon_ram_free(void *ptr, size_t size);
>  #define QEMU_MADV_DONTDUMP QEMU_MADV_INVALID
>  #define QEMU_MADV_HUGEPAGE  QEMU_MADV_INVALID
>  #define QEMU_MADV_NOHUGEPAGE  QEMU_MADV_INVALID
> +#define QEMU_MADV_REMOVE QEMU_MADV_INVALID
>  
>  #else /* no-op */
>  
> @@ -281,6 +287,7 @@ void qemu_anon_ram_free(void *ptr, size_t size);
>  #define QEMU_MADV_DONTDUMP QEMU_MADV_INVALID
>  #define QEMU_MADV_HUGEPAGE  QEMU_MADV_INVALID
>  #define QEMU_MADV_NOHUGEPAGE  QEMU_MADV_INVALID
> +#define QEMU_MADV_REMOVE QEMU_MADV_INVALID
>  
>  #endif
>  
> -- 
> 2.9.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
