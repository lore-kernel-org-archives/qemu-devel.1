Received: from eggs.gnu.org ([2001:4830:134:3::10]:40071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fqNPN-0003tj-BC
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 14:54:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fqNPH-0005TQ-UJ
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 14:54:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56084 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fqNPH-0005T8-Ib
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 14:54:03 -0400
Date: Thu, 16 Aug 2018 19:53:59 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180816185359.GF2664@work-vm>
References: <0e59c79ddc01e195ddc59d77d9df2b95bf89b600.1523395243.git.simon@ruderich.org>
	<cover.1534409363.git.simon@ruderich.org>
	<12e3dce21ed5ef0d527528b7b237bcf2906621ca.1534409363.git.simon@ruderich.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12e3dce21ed5ef0d527528b7b237bcf2906621ca.1534409363.git.simon@ruderich.org>
Subject: Re: [Qemu-devel] [PATCH v4 5/7] hmp: use F for filename arguments
 in memsave/pmemsave
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Simon Ruderich <simon@ruderich.org>
Cc: qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaitepeter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>

* Simon Ruderich (simon@ruderich.org) wrote:
> This enables completion for the filename arguments.
> 
> Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Simon Ruderich <simon@ruderich.org>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  hmp-commands.hx | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 79c158a140..5715bd7b51 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -818,7 +818,7 @@ ETEXI
>  
>      {
>          .name       = "memsave",
> -        .args_type  = "val:l,size:l,filename:s",
> +        .args_type  = "val:l,size:l,filename:F",
>          .params     = "addr size file",
>          .help       = "save to disk virtual memory dump starting at 'addr' of size 'size'",
>          .cmd        = hmp_memsave,
> @@ -832,7 +832,7 @@ ETEXI
>  
>      {
>          .name       = "pmemsave",
> -        .args_type  = "val:l,size:l,filename:s",
> +        .args_type  = "val:l,size:l,filename:F",
>          .params     = "addr size file",
>          .help       = "save to disk physical memory dump starting at 'addr' of size 'size'",
>          .cmd        = hmp_pmemsave,
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
