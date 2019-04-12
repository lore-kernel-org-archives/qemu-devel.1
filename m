Received: from eggs.gnu.org ([209.51.188.92]:53893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hEzQW-0008PW-MZ
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:53:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hEzQV-0003r6-Ni
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:53:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hEzQV-0003p6-Fa
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:53:19 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1EA0881E15
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 16:53:18 +0000 (UTC)
Date: Fri, 12 Apr 2019 17:53:14 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190412165314.GG2906@work-vm>
References: <20190411152520.10061-1-armbru@redhat.com>
	<20190411152520.10061-2-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411152520.10061-2-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/17] include: Include fprintf-fn.h only
 where needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

* Markus Armbruster (armbru@redhat.com) wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  include/qemu-common.h | 2 --
>  include/qemu/cutils.h | 2 --
>  include/sysemu/cpus.h | 1 +
>  3 files changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/include/qemu-common.h b/include/qemu-common.h
> index a102245519..f891e05e7e 100644
> --- a/include/qemu-common.h
> +++ b/include/qemu-common.h
> @@ -12,8 +12,6 @@
>  #ifndef QEMU_COMMON_H
>  #define QEMU_COMMON_H
>  
> -#include "qemu/fprintf-fn.h"
> -
>  #define TFR(expr) do { if ((expr) != -1) break; } while (errno == EINTR)
>  
>  /* Copyright string for -version arguments, About dialogs, etc */
> diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
> index d2dad3057c..12301340a4 100644
> --- a/include/qemu/cutils.h
> +++ b/include/qemu/cutils.h
> @@ -1,8 +1,6 @@
>  #ifndef QEMU_CUTILS_H
>  #define QEMU_CUTILS_H
>  
> -#include "qemu/fprintf-fn.h"
> -
>  /**
>   * pstrcpy:
>   * @buf: buffer to copy string into
> diff --git a/include/sysemu/cpus.h b/include/sysemu/cpus.h
> index 731756d948..eea0010b53 100644
> --- a/include/sysemu/cpus.h
> +++ b/include/sysemu/cpus.h
> @@ -1,6 +1,7 @@
>  #ifndef QEMU_CPUS_H
>  #define QEMU_CPUS_H
>  
> +#include "qemu/fprintf-fn.h"
>  #include "qemu/timer.h"
>  
>  /* cpus.c */
> -- 
> 2.17.2
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
