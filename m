Received: from eggs.gnu.org ([209.51.188.92]:37480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1guDkU-0005rJ-FX
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 04:56:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1guDkT-00021p-6e
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 04:56:06 -0500
References: <20190212134758.10514-1-dgilbert@redhat.com>
	<20190212134758.10514-3-dgilbert@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <1374bcc2-f297-5b8a-2340-5853376052c2@vivier.eu>
Date: Thu, 14 Feb 2019 10:55:37 +0100
MIME-Version: 1.0
In-Reply-To: <20190212134758.10514-3-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH 2/4] HMP: Prepend errors
 with 'Error:'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, kraxel@redhat.com, mst@redhat.com
Cc: qemu-trivial@nongnu.org

On 12/02/2019 14:47, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Always make error messages start with 'Error:' as a fallback
> to make sure that anything parsing them can tell it failed.
> 
> Note: Some places don't use hmp_handle_error
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hmp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hmp.c b/hmp.c
> index b2a2b1f84e..4d14718fea 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -62,7 +62,7 @@ static void hmp_handle_error(Monitor *mon, Error **errp)
>  {
>      assert(errp);
>      if (*errp) {
> -        error_report_err(*errp);
> +        error_reportf_err(*errp, "Error: ");
>      }
>  }
>  
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
