Received: from eggs.gnu.org ([2001:4830:134:3::10]:56817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1coXdV-0002QX-NQ
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 11:48:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1coXdS-0002lM-JY
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 11:48:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1coXdS-0002jz-CY
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 11:48:18 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5EC068AE72
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 15:48:18 +0000 (UTC)
Date: Thu, 16 Mar 2017 15:48:14 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170316154813.GJ2567@work-vm>
References: <20170315135021.6978-1-quintela@redhat.com>
	<20170315135021.6978-11-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170315135021.6978-11-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 10/31] ram: Remove unused
 dump_mig_dbytes_transferred()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org

* Juan Quintela (quintela@redhat.com) wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Subject has a couple of typos; otherwise;

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>


> ---
>  include/migration/migration.h | 1 -
>  migration/ram.c               | 5 -----
>  2 files changed, 6 deletions(-)
> 
> diff --git a/include/migration/migration.h b/include/migration/migration.h
> index 5720c88..3e6bb68 100644
> --- a/include/migration/migration.h
> +++ b/include/migration/migration.h
> @@ -276,7 +276,6 @@ void free_xbzrle_decoded_buf(void);
>  
>  void acct_update_position(QEMUFile *f, size_t size, bool zero);
>  
> -uint64_t dup_mig_bytes_transferred(void);
>  uint64_t dup_mig_pages_transferred(void);
>  uint64_t skipped_mig_bytes_transferred(void);
>  uint64_t skipped_mig_pages_transferred(void);
> diff --git a/migration/ram.c b/migration/ram.c
> index 059e9f1..83fe20a 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -186,11 +186,6 @@ static void acct_clear(void)
>      memset(&acct_info, 0, sizeof(acct_info));
>  }
>  
> -uint64_t dup_mig_bytes_transferred(void)
> -{
> -    return ram_state.zero_pages * TARGET_PAGE_SIZE;
> -}
> -
>  uint64_t dup_mig_pages_transferred(void)
>  {
>      return ram_state.zero_pages;
> -- 
> 2.9.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
