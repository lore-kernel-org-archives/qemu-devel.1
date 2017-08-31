Received: from eggs.gnu.org ([2001:4830:134:3::10]:39636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dnKVX-00008u-6p
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 04:07:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dnKVS-0008Cm-A5
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 04:07:23 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:37804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dnKVS-0008CF-2g
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 04:07:18 -0400
Received: by mail-wr0-x243.google.com with SMTP id k9so2674249wre.4
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 01:07:18 -0700 (PDT)
Date: Thu, 31 Aug 2017 09:07:15 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170831080715.GD13619@stefanha-x1.localdomain>
References: <20170830082702.3011-1-Sergio.G.DelReal@gmail.com>
	<20170830082702.3011-8-Sergio.G.DelReal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170830082702.3011-8-Sergio.G.DelReal@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 07/13] apic: add function to apic that
 will be used by hvf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
Cc: qemu-devel@nongnu.org

On Wed, Aug 30, 2017 at 03:26:56AM -0500, Sergio Andres Gomez Del Real wrote:
> This commit adds the function apic_get_highest_priority_irr to
> apic.c and exports it through the interface in apic.h for use by hvf.
> 
> Signed-off-by: Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>
> ---
>  hw/intc/apic.c         | 11 +++++++++++
>  include/hw/i386/apic.h |  1 +
>  2 files changed, 12 insertions(+)
> 
> diff --git a/hw/intc/apic.c b/hw/intc/apic.c
> index fe15fb6024..3de59d07fd 100644
> --- a/hw/intc/apic.c
> +++ b/hw/intc/apic.c
> @@ -305,6 +305,17 @@ static void apic_set_tpr(APICCommonState *s, uint8_t val)
>      }
>  }
>  
> +int apic_get_highest_priority_irr(DeviceState *dev)

Missing doc comments.  -1 means no interrupts.
