Received: from eggs.gnu.org ([2001:4830:134:3::10]:57331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fwnhL-00038J-C4
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 08:11:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fwnhH-0000HZ-CW
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 08:11:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43788 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fwnhH-0000HF-7I
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 08:11:11 -0400
Date: Mon, 3 Sep 2018 13:11:07 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180903121107.GC14377@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180830142708.14311-1-sameeh@daynix.com>
	<20180830142708.14311-7-sameeh@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180830142708.14311-7-sameeh@daynix.com>
Subject: Re: [Qemu-devel] [RFC 6/6] virtio-net: rss: Add bpf filter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sameeh Jubran <sameeh@daynix.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Yan Vugenfirer <yan@daynix.com>

On Thu, Aug 30, 2018 at 05:27:08PM +0300, Sameeh Jubran wrote:
> From: Sameeh Jubran <sjubran@redhat.com>
> 
> Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
> ---
>  hw/net/rss_bpf_insns.h       | 3992 ++++++++++++++++++++++++++++++++++++++++++
>  hw/net/rss_tap_bpf.h         |   40 +
>  hw/net/rss_tap_bpf_program.c |  175 ++
>  hw/net/virtio-net.c          |   99 +-
>  4 files changed, 4305 insertions(+), 1 deletion(-)
>  create mode 100644 hw/net/rss_bpf_insns.h
>  create mode 100644 hw/net/rss_tap_bpf.h
>  create mode 100644 hw/net/rss_tap_bpf_program.c
> 

> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 4a52a6a1d0..66b2140cc7 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -27,6 +27,10 @@
>  #include "hw/virtio/virtio-access.h"
>  #include "migration/misc.h"
>  #include "standard-headers/linux/ethtool.h"
> +#include <sys/syscall.h>
> +#include <linux/bpf.h>

This breaks the build on platforms without bpf.h - you checked for
this in configure, but then never made use of the CONFIG_BPF conditional
in the code.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
