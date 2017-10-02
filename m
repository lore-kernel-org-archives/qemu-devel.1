Received: from eggs.gnu.org ([2001:4830:134:3::10]:46208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dz1ar-0004n3-W9
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:21:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dz1an-0000Kw-G3
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:21:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dz1an-0000KQ-9E
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:21:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 33A99267F5
	for <qemu-devel@nongnu.org>; Mon,  2 Oct 2017 14:21:08 +0000 (UTC)
Date: Mon, 2 Oct 2017 15:21:04 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171002142104.GC2218@work-vm>
References: <20171002134538.23332-1-armbru@redhat.com>
	<20171002134538.23332-2-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171002134538.23332-2-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] hmp-commands-info: Fix "info
 rocker-FOO" misspellings
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>

* Markus Armbruster (armbru@redhat.com) wrote:
> Screwed up in commit da76ee7.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  hmp-commands-info.hx | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index 4f1ece93e5..574db7d24e 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -730,8 +730,8 @@ ETEXI
>      },
>  
>  STEXI
> -@item info rocker_ports @var{name}-ports
> -@findex ocker-ports
> +@item info rocker-ports @var{name}-ports
> +@findex rocker-ports
>  Show rocker ports.
>  ETEXI
>  
> @@ -744,7 +744,7 @@ ETEXI
>      },
>  
>  STEXI
> -@item info rocker_of_dpa_flows @var{name} [@var{tbl_id}]
> +@item info rocker-of-dpa-flows @var{name} [@var{tbl_id}]
>  @findex rocker-of-dpa-flows
>  Show rocker OF-DPA flow tables.
>  ETEXI
> -- 
> 2.13.6
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
