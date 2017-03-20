Received: from eggs.gnu.org ([2001:4830:134:3::10]:38897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cpzSO-0000eE-6I
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:42:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cpzSM-0001MR-T2
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:42:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cpzSM-0001Lu-LX
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:42:50 -0400
Date: Mon, 20 Mar 2017 15:42:46 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170320154245.GD2401@work-vm>
References: <1490011066479-474158.post@n7.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490011066479-474158.post@n7.nabble.com>
Subject: Re: [Qemu-devel] [PATCH v3]COLO:Fix Colo doc,
 secondeary should be secondary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wangguang <wang.guang55@zte.com.cn>
Cc: qemu-devel@nongnu.org

* wangguang (wang.guang55@zte.com.cn) wrote:
> Subject: [PATCH] Fix Colo doc secondeary should be secondary 
> This is an error in COLO-FT.txt. 
> secondeary-disk0 should be secondary-disk0. 
> 
> Signed-off-by: Guang Wang <wang.guang55@zte.com.cn>
> --- 
>  docs/COLO-FT.txt | 2 +- 
>  1 file changed, 1 insertion(+), 1 deletion(-) 
> 
> diff --git a/docs/COLO-FT.txt b/docs/COLO-FT.txt 
> index e289be2..bec7547 100644 
> --- a/docs/COLO-FT.txt 
> +++ b/docs/COLO-FT.txt 
> @@ -139,7 +139,7 @@ Secondary: 
>  { 'execute': 'nbd-server-start', 
>    'arguments': {'addr': {'type': 'inet', 'data': {'host': 'xx.xx.xx.xx',
> 'port': '8889'} } } 
>  } 
> -{'execute': 'nbd-server-add', 'arguments': {'device': 'secondeary-disk0',
> 'writable': true } } 
> +{'execute': 'nbd-server-add', 'arguments': {'device': 'Secondary-disk0',
> 'writable': true } } 

That should be 's' not 'S' shouldn't it, to match the other uses in the same
doc?

Dave

>   
>  Note: 
>    a. The qmp command nbd-server-start and nbd-server-add must be run 
> -- 
> 2.9.3 
> 
>  
> 
> 
> 
> 
> 
> --
> View this message in context: http://qemu.11.n7.nabble.com/PATCH-v3-COLO-Fix-Colo-doc-secondeary-should-be-secondary-tp474158.html
> Sent from the Developer mailing list archive at Nabble.com.
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
