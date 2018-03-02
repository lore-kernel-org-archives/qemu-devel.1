Received: from eggs.gnu.org ([2001:4830:134:3::10]:39511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1erow8-0007Md-CY
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 12:57:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1erow5-0003xu-61
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 12:57:40 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58738 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1erow4-0003xT-Vw
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 12:57:37 -0500
Date: Fri, 2 Mar 2018 19:57:25 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180302195625-mutt-send-email-mst@kernel.org>
References: <cover.1519961667.git.jbaron@akamai.com>
	<ee94e55496562390786ad924f750de1cf3472644.1519961667.git.jbaron@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee94e55496562390786ad924f750de1cf3472644.1519961667.git.jbaron@akamai.com>
Subject: Re: [Qemu-devel] [PATCH 2/4] rocker: drop local duplex definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Baron <jbaron@akamai.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, Jiri Pirko <jiri@resnulli.us>, virtio-dev@lists.oasis-open.org

On Thu, Mar 01, 2018 at 10:46:34PM -0500, Jason Baron wrote:
> Make use of duplex definitions from net/eth.h.
> 
> Signed-off-by: Jason Baron <jbaron@akamai.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Jiri Pirko <jiri@resnulli.us>
> Cc: virtio-dev@lists.oasis-open.org
> ---
>  hw/net/rocker/rocker_fp.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/hw/net/rocker/rocker_fp.c b/hw/net/rocker/rocker_fp.c
> index 4b3c984..13a14a0 100644
> --- a/hw/net/rocker/rocker_fp.c
> +++ b/hw/net/rocker/rocker_fp.c
> @@ -16,17 +16,13 @@
>  
>  #include "qemu/osdep.h"
>  #include "net/clients.h"
> +#include "net/eth.h"
>  
>  #include "rocker.h"
>  #include "rocker_hw.h"
>  #include "rocker_fp.h"
>  #include "rocker_world.h"
>  
> -enum duplex {
> -    DUPLEX_HALF = 0,
> -    DUPLEX_FULL
> -};
> -

This is hardware emulation, so I actually suspect it
should be renamed ROCKER_FP_HALF/ROCKER_FP_FULL.

>  struct fp_port {
>      Rocker *r;
>      World *world;
> -- 
> 2.7.4
