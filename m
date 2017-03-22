Received: from eggs.gnu.org ([2001:4830:134:3::10]:38398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cqeeW-0002GJ-9t
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 07:42:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cqeeQ-00060D-CQ
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 07:42:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cqeeQ-000609-7B
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 07:42:02 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1272E1556C
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 11:42:02 +0000 (UTC)
Date: Wed, 22 Mar 2017 11:41:55 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170322114155.GD2406@work-vm>
References: <1490168303-24588-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490168303-24588-1-git-send-email-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] cirrus: fix PUTPIXEL macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

* Gerd Hoffmann (kraxel@redhat.com) wrote:
> Should be "c" not "col".  The macro is used with "col" as third parameter
> everywhere, so this tyops doesn't break something.
> 
> Fixes: 026aeffcb4752054830ba203020ed6eb05bcaba8
> Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  hw/display/cirrus_vga_rop2.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/display/cirrus_vga_rop2.h b/hw/display/cirrus_vga_rop2.h
> index b86bcd6..b208b73 100644
> --- a/hw/display/cirrus_vga_rop2.h
> +++ b/hw/display/cirrus_vga_rop2.h
> @@ -29,8 +29,8 @@
>  #elif DEPTH == 24
>  #define PUTPIXEL(s, a, c)    do {          \
>          ROP_OP(s, a,     c);               \
> -        ROP_OP(s, a + 1, (col >> 8));      \
> -        ROP_OP(s, a + 2, (col >> 16));     \
> +        ROP_OP(s, a + 1, (c >> 8));        \
> +        ROP_OP(s, a + 2, (c >> 16));       \
>      } while (0)
>  #elif DEPTH == 32
>  #define PUTPIXEL(s, a, c)    ROP_OP_32(s, a, c)
> -- 
> 1.8.3.1
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
