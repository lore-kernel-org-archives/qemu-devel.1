Received: from eggs.gnu.org ([2001:4830:134:3::10]:34807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1d5v0f-00069c-PW
	for qemu-devel@nongnu.org; Wed, 03 May 2017 10:12:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1d5v0b-0005HB-Pf
	for qemu-devel@nongnu.org; Wed, 03 May 2017 10:12:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1d5v0b-0005FW-Jd
	for qemu-devel@nongnu.org; Wed, 03 May 2017 10:12:01 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A661D80F93
	for <qemu-devel@nongnu.org>; Wed,  3 May 2017 14:12:00 +0000 (UTC)
Received: from [10.36.117.10] (ovpn-117-10.ams2.redhat.com [10.36.117.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 36B4B189CB
	for <qemu-devel@nongnu.org>; Wed,  3 May 2017 14:12:00 +0000 (UTC)
References: <20170503115909.4490-1-pbonzini@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <7d777d87-af30-1bb1-86f3-eeeec498ebac@redhat.com>
Date: Wed, 3 May 2017 16:11:59 +0200
MIME-Version: 1.0
In-Reply-To: <20170503115909.4490-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Update paths for main loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 03/05/2017 13:59, Paolo Bonzini wrote:
> Moved by c2b38b2 ("block: move AioContext, QEMUTimer, main-loop to
> libqemuutil"), let's update MAINTAINERS too.
> 
> Reported-by: Laurent Vivier <lvivier@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 62d62a6675..b54c0568c6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1307,8 +1307,8 @@ Main loop
>  M: Paolo Bonzini <pbonzini@redhat.com>
>  S: Maintained
>  F: cpus.c
> -F: main-loop.c
> -F: qemu-timer.c
> +F: util/main-loop.c
> +F: util/qemu-timer.c
>  F: vl.c
>  
>  Human Monitor (HMP)
> 
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
