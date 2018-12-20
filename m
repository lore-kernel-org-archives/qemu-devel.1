Received: from eggs.gnu.org ([2001:4830:134:3::10]:54143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gZxCa-0000cS-6l
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 07:13:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gZxCX-0008P1-3C
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 07:13:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gZxCW-0008OW-Sb
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 07:13:17 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 30CD4DA337
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 12:13:16 +0000 (UTC)
Date: Thu, 20 Dec 2018 10:13:08 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181220121308.GN19442@habkost.net>
References: <20181220054037.24320-1-peterx@redhat.com>
	<20181220054037.24320-2-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220054037.24320-2-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] q35: set split kernel irqchip as
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Dec 20, 2018 at 01:40:35PM +0800, Peter Xu wrote:
> Starting from QEMU 4.0, let's specify "split" as the default value for
> kernel-irqchip.
> 
> So for QEMU>=4.0 we'll have: allowed=Y,required=N,split=Y
>    for QEMU<=3.1 we'll have: allowed=Y,required=N,split=N
>    (omitting all the "kernel_irqchip_" prefix)
> 
> Note that this will let the default q35 machine type to depend on
> Linux version 4.4 or newer because that's where split irqchip is
> introduced in kernel.  But it's fine since we're boosting supported
> Linux version for QEMU 4.0 to around Linux 4.5.  For more information
> please refer to the discussion on AMD's RDTSCP:
> 
>   https://lore.kernel.org/lkml/20181210181328.GA762@zn.tnic/
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
