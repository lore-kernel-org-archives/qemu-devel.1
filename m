Received: from eggs.gnu.org ([2001:4830:134:3::10]:59287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elbXg-0005kP-AC
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 09:26:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elbXd-0007cF-3W
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 09:26:44 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44498 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1elbXc-0007bf-Uj
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 09:26:41 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 951E6EB700
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 14:26:29 +0000 (UTC)
References: <20180213070526.22475-1-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <db9528b7-3965-5c64-31f2-68b12a91cfde@redhat.com>
Date: Tue, 13 Feb 2018 08:26:22 -0600
MIME-Version: 1.0
In-Reply-To: <20180213070526.22475-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vnc: add qapi/error.h include to stubs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On 02/13/2018 01:05 AM, Gerd Hoffmann wrote:
> Fixes --disable-vnc build failure.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   ui/vnc-stubs.c | 1 +
>   1 file changed, 1 insertion(+)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/ui/vnc-stubs.c b/ui/vnc-stubs.c
> index f51280549a..06c4ac6296 100644
> --- a/ui/vnc-stubs.c
> +++ b/ui/vnc-stubs.c
> @@ -1,5 +1,6 @@
>   #include "qemu/osdep.h"
>   #include "ui/console.h"
> +#include "qapi/error.h"
>   
>   int vnc_display_password(const char *id, const char *password)
>   {
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
