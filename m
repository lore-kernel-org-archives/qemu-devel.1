Received: from eggs.gnu.org ([2001:4830:134:3::10]:59645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eJjEr-0006hB-Ej
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 12:00:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eJjEn-0006uI-Js
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 12:00:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eJjEn-0006sd-Em
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 12:00:01 -0500
References: <1511880838-56509-1-git-send-email-imammedo@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <332cc741-ea50-897f-e03e-ada0ab022ce6@redhat.com>
Date: Tue, 28 Nov 2017 10:59:57 -0600
MIME-Version: 1.0
In-Reply-To: <1511880838-56509-1-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] numa: fix missing '-numa cpu' in '-help'
 output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, ehabkost@redhat.com, mjt@tls.msk.ru, armbru@redhat.com

On 11/28/2017 08:53 AM, Igor Mammedov wrote:
> commit 419fcdec3c (numa: add '-numa cpu,...' option for property based node mapping)
> added '-numa cpu' option but forgot to update appropriate section for '--help'.
> Add '-numa cpu' description to '-help' output
> 
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>   qemu-options.hx | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Documentation only; safe for 2.11 if it makes it through someone's tree 
(although we're cutting it close); and harmless if it waits for 2.12 
instead.

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/qemu-options.hx b/qemu-options.hx
> index df19cf2..972a5c6 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -163,7 +163,9 @@ ETEXI
>   DEF("numa", HAS_ARG, QEMU_OPTION_numa,
>       "-numa node[,mem=size][,cpus=firstcpu[-lastcpu]][,nodeid=node]\n"
>       "-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node]\n"
> -    "-numa dist,src=source,dst=destination,val=distance\n", QEMU_ARCH_ALL)
> +    "-numa dist,src=source,dst=destination,val=distance\n"
> +    "-numa cpu,node-id=node[,socket-id=x][,core-id=y][,thread-id=z]\n",
> +    QEMU_ARCH_ALL)
>   STEXI
>   @item -numa node[,mem=@var{size}][,cpus=@var{firstcpu}[-@var{lastcpu}]][,nodeid=@var{node}]
>   @itemx -numa node[,memdev=@var{id}][,cpus=@var{firstcpu}[-@var{lastcpu}]][,nodeid=@var{node}]
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
