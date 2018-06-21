Received: from eggs.gnu.org ([2001:4830:134:3::10]:41054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fVy0F-0002N1-6u
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:43:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fVy0C-0005uE-3l
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:43:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33410 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fVy0B-0005u6-VM
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:43:48 -0400
Date: Thu, 21 Jun 2018 12:43:43 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180621114342.GB10744@work-vm>
References: <20180620003202.10546-1-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620003202.10546-1-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] [RESEND] hmp-commands: use long for begin
 and length in dump-guest-memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com

* Suraj Jitindar Singh (sjitindarsingh@gmail.com) wrote:
> The dump-guest-memory command is used to dump an area of guest memory
> to a file, the piece of memory is specified by a begin address and
> a length. These parameters are specified as ints and thus have a maximum
> value of 4GB. This means you can't dump the guest memory past the first
> 4GB and instead get:
> (qemu) dump-guest-memory tmp 0x100000000 0x100000000
> 'dump-guest-memory' has failed: integer is for 32-bit values
> Try "help dump-guest-memory" for more information
> 
> This limitation is imposed in monitor_parse_arguments() since they are
> both ints. hmp_dump_guest_memory() uses 64 bit quantities to store both
> the begin and length values. Thus specify begin and length as long so
> that the entire guest memory space can be dumped.
> 
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

and queued

> ---
>  hmp-commands.hx | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 0734fea931..3b5c1f65db 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -1116,7 +1116,7 @@ ETEXI
>  
>      {
>          .name       = "dump-guest-memory",
> -        .args_type  = "paging:-p,detach:-d,zlib:-z,lzo:-l,snappy:-s,filename:F,begin:i?,length:i?",
> +        .args_type  = "paging:-p,detach:-d,zlib:-z,lzo:-l,snappy:-s,filename:F,begin:l?,length:l?",
>          .params     = "[-p] [-d] [-z|-l|-s] filename [begin length]",
>          .help       = "dump guest memory into file 'filename'.\n\t\t\t"
>                        "-p: do paging to get guest's memory mapping.\n\t\t\t"
> -- 
> 2.13.6
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
