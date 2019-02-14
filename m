Received: from eggs.gnu.org ([209.51.188.92]:45373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1guCj4-0000MN-Gb
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 03:50:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1guCj0-0002VW-Ac
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 03:50:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46686)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1guCix-0002Oo-NP
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 03:50:28 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 983EC89AD1
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 08:50:18 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
	(colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 895AE60857
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 08:50:18 +0000 (UTC)
Date: Thu, 14 Feb 2019 03:50:18 -0500 (EST)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <2037886390.964185.1550134218213.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190214031004.32522-1-stefanha@redhat.com>
References: <20190214031004.32522-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/2] hostmem-file: reject invalid pmem
 file sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>



> 
> v3:
>  * Added Patch 1 by Igor [Wei]
>  * Moved pmem size check after mem_path check [Wei]
> 
> Guests started with NVDIMMs larger than the underlying host file produce
> confusing errors inside the guest.  This happens because the guest
> accesses pages beyond the end of the file.
> 
> Check the pmem file size on startup and print a clear error message if
> the size is invalid.
> 
> Igor Mammedov (1):
>   hostmem: simplify ifdef-s in file_backend_memory_alloc()
> 
> Stefan Hajnoczi (1):
>   hostmem-file: reject invalid pmem file sizes
> 
>  include/qemu/osdep.h    | 13 ++++++++++
>  backends/hostmem-file.c | 32 +++++++++++++++++++++----
>  util/oslib-posix.c      | 53 +++++++++++++++++++++++++++++++++++++++++
>  util/oslib-win32.c      |  5 ++++
>  4 files changed, 98 insertions(+), 5 deletions(-)
> 
> --
> 2.20.1

Both the patches look good to me.
Reviewed-by: Pankaj Gupta <pagupta@redhat.com>
