Received: from eggs.gnu.org ([2001:4830:134:3::10]:33428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fIbqi-0003aW-AJ
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:26:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fIbqf-0006e5-3p
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:26:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35106 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1fIbqe-0006dg-UY
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:26:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8AF3F4022931
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 15:26:44 +0000 (UTC)
Date: Tue, 15 May 2018 17:26:41 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180515152641.7oaxop77wgzokr7h@kamzik.brq.redhat.com>
References: <1526395713-60357-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526395713-60357-1-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] numa: clarify error message when node
 index is out of range in -numa dist, ...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com

On Tue, May 15, 2018 at 04:48:33PM +0200, Igor Mammedov wrote:
> When using following CLI:
>   -numa dist,src=128,dst=1,val=20
> user gets a rather confusing error message:
>    "Invalid node 128, max possible could be 128"
> 
> Where 128 is number of nodes that QEMU supports (MAX_NODES),
> while src/dst is an index up to that limit, so it should be
> MAX_NODES - 1 in error message.
> Make error message to explicitly state valid range for node
> index to be more clear.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> ---
>  numa.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/numa.c b/numa.c
> index a3637cc..9f0c49f 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -142,8 +142,8 @@ static void parse_numa_distance(NumaDistOptions *dist, Error **errp)
>  
>      if (src >= MAX_NODES || dst >= MAX_NODES) {
>          error_setg(errp,
> -                   "Invalid node %d, max possible could be %d",
> -                   MAX(src, dst), MAX_NODES);
> +                   "Invalid node %d, The valid node range is [0 - %d]",
                                      ^ should be a '.'

And maybe need a '.' at the end of the second sentence too, as it's not
an error phrase, but a real sentence.

> +                   MAX(src, dst), MAX_NODES - 1);
>          return;
>      }
>  
> -- 
> 2.7.4
> 
