Received: from eggs.gnu.org ([2001:4830:134:3::10]:54438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dlDyw-00065p-At
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 08:45:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dlDyr-0003lu-FP
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 08:45:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56448)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dlDyr-0003kM-9D
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 08:44:57 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 21822356E6
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 12:44:55 +0000 (UTC)
Date: Fri, 25 Aug 2017 09:44:50 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170825124450.GD15315@localhost.localdomain>
References: <20170824072202.26818-1-stefanha@redhat.com>
	<20170824072202.26818-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170824072202.26818-2-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] qemu.py: make VM() a context manager
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Daniel Berrange <berrange@redhat.com>

On Thu, Aug 24, 2017 at 08:22:00AM +0100, Stefan Hajnoczi wrote:
> There are a number of ways to ensure that the QEMU process is shut down
> when the test ends, including atexit.register(), try: finally:, or
> unittest.teardown() methods.  All of these require extra code and the
> programmer must remember to add vm.shutdown().
> 
> A nice solution is context managers:
> 
>   with VM(binary) as vm:
>       ...
>   # vm is guaranteed to be shut down here
> 
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
