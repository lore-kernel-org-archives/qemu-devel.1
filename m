Received: from eggs.gnu.org ([2001:4830:134:3::10]:59389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d00lh-0003L9-2h
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 03:08:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d00ld-000278-TR
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 03:08:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1d00ld-00026V-NR
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 03:08:09 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A577A7AE83
	for <qemu-devel@nongnu.org>; Mon, 17 Apr 2017 07:08:08 +0000 (UTC)
Date: Mon, 17 Apr 2017 15:08:06 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170417070806.GB13582@lemon.lan>
References: <20170413160952.29918-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170413160952.29918-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] util/error: Fix leak in error_vprepend()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On Thu, 04/13 18:09, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  util/error.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/util/error.c b/util/error.c
> index 9c40b1f458..020b86b9f0 100644
> --- a/util/error.c
> +++ b/util/error.c
> @@ -134,6 +134,7 @@ void error_vprepend(Error **errp, const char *fmt, va_list ap)
>      newmsg = g_string_new(NULL);
>      g_string_vprintf(newmsg, fmt, ap);
>      g_string_append(newmsg, (*errp)->msg);
> +    g_free((*errp)->msg);
>      (*errp)->msg = g_string_free(newmsg, 0);
>  }
>  
> -- 
> 2.12.2
> 
> 

Reviewed-by: Fam Zheng <famz@redhat.com>
