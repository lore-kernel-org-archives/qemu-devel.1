Received: from eggs.gnu.org ([2001:4830:134:3::10]:54551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dAZ3n-0001qW-VT
	for qemu-devel@nongnu.org; Tue, 16 May 2017 05:46:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dAZ3k-00052Z-3t
	for qemu-devel@nongnu.org; Tue, 16 May 2017 05:46:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dAZ3j-00051z-UH
	for qemu-devel@nongnu.org; Tue, 16 May 2017 05:46:28 -0400
Date: Tue, 16 May 2017 10:46:08 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170516094607.GA2839@work-vm>
References: <1494595886-30912-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170512133145eucas1p2cad4c4efe46e6f1b757d97dd9d301dbe@eucas1p2.samsung.com>
	<1494595886-30912-4-git-send-email-a.perevalov@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1494595886-30912-4-git-send-email-a.perevalov@samsung.com>
Subject: Re: [Qemu-devel] [PATCH V5 3/9] migration: fix hardcoded function
 name in error report
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: qemu-devel@nongnu.org, i.maximets@samsung.com, peterx@redhat.com

* Alexey Perevalov (a.perevalov@samsung.com) wrote:
> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>



Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/postcopy-ram.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 4c859b4..0f75700 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -68,7 +68,7 @@ static bool ufd_version_check(int ufd, MigrationIncomingState *mis)
>      api_struct.api = UFFD_API;
>      api_struct.features = 0;
>      if (ioctl(ufd, UFFDIO_API, &api_struct)) {
> -        error_report("postcopy_ram_supported_by_host: UFFDIO_API failed: %s",
> +        error_report("%s: UFFDIO_API failed: %s", __func__
>                       strerror(errno));
>          return false;
>      }
> -- 
> 1.9.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
