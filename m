Received: from eggs.gnu.org ([209.51.188.92]:48413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gwtH4-0004y5-AP
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:40:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gwtGx-0006PJ-Oc
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:40:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gwtGw-00063T-1c
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:40:38 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 17630307C941
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 18:40:35 +0000 (UTC)
Date: Thu, 21 Feb 2019 18:40:30 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190221184030.GP2605@work-vm>
References: <20190220115611.3192-1-quintela@redhat.com>
	<20190220115611.3192-7-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220115611.3192-7-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 6/8] multifd: Change default packet size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>

* Juan Quintela (quintela@redhat.com) wrote:
> We moved from 64KB to 512KB, as it makes less locking contention
> without any downside in testing.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

That arbitrary number seems better than the previous arbitrary number,
so:

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/ram.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 75a8fc21f8..d57db00ce4 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -521,7 +521,7 @@ exit:
>  #define MULTIFD_FLAG_SYNC (1 << 0)
>  
>  /* This value needs to be a multiple of qemu_target_page_size() */
> -#define MULTIFD_PACKET_SIZE (64 * 1024)
> +#define MULTIFD_PACKET_SIZE (512 * 1024)
>  
>  typedef struct {
>      uint32_t magic;
> -- 
> 2.20.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
