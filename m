Received: from eggs.gnu.org ([2001:4830:134:3::10]:39638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fqNNU-0003Gh-2p
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 14:52:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fqNNN-0004j0-FC
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 14:52:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50210 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fqNNN-0004iU-7M
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 14:52:05 -0400
Date: Thu, 16 Aug 2018 19:51:59 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180816185158.GE2664@work-vm>
References: <0e59c79ddc01e195ddc59d77d9df2b95bf89b600.1523395243.git.simon@ruderich.org>
	<cover.1534409363.git.simon@ruderich.org>
	<fce204f66589995fb1470a9e2a490b2dd24cf551.1534409363.git.simon@ruderich.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fce204f66589995fb1470a9e2a490b2dd24cf551.1534409363.git.simon@ruderich.org>
Subject: Re: [Qemu-devel] [PATCH v4 4/7] hmp: use l for size argument in
 memsave/pmemsave
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
> i is only 32-bit. To prevent possible truncation when dumping large
> memory regions use l which is target long.
> 
> Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Simon Ruderich <simon@ruderich.org>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  hmp-commands.hx | 4 ++--
>  hmp.c           | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 91dfe51c37..79c158a140 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -818,7 +818,7 @@ ETEXI
>  
>      {
>          .name       = "memsave",
> -        .args_type  = "val:l,size:i,filename:s",
> +        .args_type  = "val:l,size:l,filename:s",
>          .params     = "addr size file",
>          .help       = "save to disk virtual memory dump starting at 'addr' of size 'size'",
>          .cmd        = hmp_memsave,
> @@ -832,7 +832,7 @@ ETEXI
>  
>      {
>          .name       = "pmemsave",
> -        .args_type  = "val:l,size:i,filename:s",
> +        .args_type  = "val:l,size:l,filename:s",
>          .params     = "addr size file",
>          .help       = "save to disk physical memory dump starting at 'addr' of size 'size'",
>          .cmd        = hmp_pmemsave,
> diff --git a/hmp.c b/hmp.c
> index 2aafb50e8e..1fb0724107 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -1094,7 +1094,7 @@ void hmp_cpu(Monitor *mon, const QDict *qdict)
>  
>  void hmp_memsave(Monitor *mon, const QDict *qdict)
>  {
> -    uint32_t size = qdict_get_int(qdict, "size");
> +    uint64_t size = qdict_get_int(qdict, "size");
>      const char *filename = qdict_get_str(qdict, "filename");
>      uint64_t addr = qdict_get_int(qdict, "val");
>      Error *err = NULL;
> @@ -1111,7 +1111,7 @@ void hmp_memsave(Monitor *mon, const QDict *qdict)
>  
>  void hmp_pmemsave(Monitor *mon, const QDict *qdict)
>  {
> -    uint32_t size = qdict_get_int(qdict, "size");
> +    uint64_t size = qdict_get_int(qdict, "size");
>      const char *filename = qdict_get_str(qdict, "filename");
>      uint64_t addr = qdict_get_int(qdict, "val");
>      Error *err = NULL;
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
