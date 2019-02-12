Received: from eggs.gnu.org ([209.51.188.92]:53042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtYmd-00068y-Ci
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 09:11:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtYma-0003Rd-W3
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 09:11:34 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56293)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gtYmW-0003JX-QL
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 09:11:30 -0500
Received: by mail-wm1-f67.google.com with SMTP id r17so3071960wmh.5
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 06:11:26 -0800 (PST)
References: <20190212134758.10514-1-dgilbert@redhat.com>
	<20190212134758.10514-3-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fa71e7e8-b5b4-2d30-2914-a79b15ba1bf3@redhat.com>
Date: Tue, 12 Feb 2019 15:11:23 +0100
MIME-Version: 1.0
In-Reply-To: <20190212134758.10514-3-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/4] HMP: Prepend errors with 'Error:'
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

On 2/12/19 2:47 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Always make error messages start with 'Error:' as a fallback
> to make sure that anything parsing them can tell it failed.
> 
> Note: Some places don't use hmp_handle_error
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

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
