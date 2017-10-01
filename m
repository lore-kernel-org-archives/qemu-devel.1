Received: from eggs.gnu.org ([2001:4830:134:3::10]:41533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dyTKh-0008A1-T4
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 21:46:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dyTKe-00052K-Ca
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 21:46:15 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:34515)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dyTKe-000525-6U
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 21:46:12 -0400
Received: by mail-qk0-x242.google.com with SMTP id a128so301326qkc.1
	for <qemu-devel@nongnu.org>; Sat, 30 Sep 2017 18:46:12 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1506730372.git.alistair.francis@xilinx.com>
	<1ff71065271df7d2b92af3008c7592ba20e2ed0c.1506730372.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b341336e-0821-7b74-2623-1d028f4c87f4@amsat.org>
Date: Sat, 30 Sep 2017 22:46:01 -0300
MIME-Version: 1.0
In-Reply-To: <1ff71065271df7d2b92af3008c7592ba20e2ed0c.1506730372.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 27/47] hw/net: Replace fprintf(stderr,
 "*\n" with error_report()
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Alexander Graf <agraf@suse.de>, armbru@redhat.com, alistair23@gmail.com
List-ID: <qemu-devel.nongnu.org>

On 09/29/2017 09:16 PM, Alistair Francis wrote:
> Replace a large number of the fprintf(stderr, "*\n" calls with
> error_report(). The functions were renamed with these commands and then
> compiler issues where manually fixed.
> 
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> 
> Some lines where then manually tweaked to pass checkpatch.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> ---
> V2:
>   - Split hw patch into individual directories
> 
>   hw/net/fsl_etsec/etsec.c |  2 +-
>   hw/net/pcnet.c           |  2 +-
>   hw/net/smc91c111.c       |  5 +++--
>   hw/net/vhost_net.c       | 16 ++++++++--------
>   4 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
> index 9da1932970..965effa314 100644
> --- a/hw/net/fsl_etsec/etsec.c
> +++ b/hw/net/fsl_etsec/etsec.c
> @@ -347,7 +347,7 @@ static ssize_t etsec_receive(NetClientState *nc,
>       eTSEC *etsec = qemu_get_nic_opaque(nc);
>   
>   #if defined(HEX_DUMP)
> -    fprintf(stderr, "%s receive size:%zd\n", nc->name, size);
> +    error_report("%s receive size:%zd", nc->name, size);
>       qemu_hexdump((void *)buf, stderr, "", size);
>   #endif
>       /* Flush is unnecessary as are already in receiving path */
> diff --git a/hw/net/pcnet.c b/hw/net/pcnet.c
> index 654455355f..5f2b5fe046 100644
> --- a/hw/net/pcnet.c
> +++ b/hw/net/pcnet.c
> @@ -1070,7 +1070,7 @@ ssize_t pcnet_receive(NetClientState *nc, const uint8_t *buf, size_t size_)
>               if (!s->looptest) {
>                   if (size > 4092) {
>   #ifdef PCNET_DEBUG_RMD
> -                    fprintf(stderr, "pcnet: truncates rx packet.\n");
> +                    error_report("pcnet: truncates rx packet.");

drop trailing dot to unify?

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>   #endif
>                       size = 4092;
>                   }
> diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
> index 3b16dcf5a1..ae40fd6e6e 100644
> --- a/hw/net/smc91c111.c
> +++ b/hw/net/smc91c111.c
> @@ -8,6 +8,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>   #include "hw/sysbus.h"
>   #include "net/net.h"
>   #include "hw/devices.h"
> @@ -362,9 +363,9 @@ static void smc91c111_writeb(void *opaque, hwaddr offset,
>               return;
>           case 12: /* Control */
>               if (value & 1)
> -                fprintf(stderr, "smc91c111:EEPROM store not implemented\n");
> +                error_report("smc91c111:EEPROM store not implemented");
>               if (value & 2)
> -                fprintf(stderr, "smc91c111:EEPROM reload not implemented\n");
> +                error_report("smc91c111:EEPROM reload not implemented");
>               value &= ~3;
>               SET_LOW(ctr, value);
>               return;
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index e037db63a3..37d0cce560 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -135,7 +135,7 @@ static int vhost_net_get_fd(NetClientState *backend)
>       case NET_CLIENT_DRIVER_TAP:
>           return tap_get_fd(backend);
>       default:
> -        fprintf(stderr, "vhost-net requires tap backend\n");
> +        error_report("vhost-net requires tap backend");
>           return -EBADFD;
>       }
>   }
> @@ -148,7 +148,7 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
>       uint64_t features = 0;
>   
>       if (!options->net_backend) {
> -        fprintf(stderr, "vhost-net requires net backend to be setup\n");
> +        error_report("vhost-net requires net backend to be setup");
>           goto fail;
>       }
>       net->nc = options->net_backend;
> @@ -186,8 +186,8 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
>               net->dev.features &= ~(1ULL << VIRTIO_NET_F_MRG_RXBUF);
>           }
>           if (~net->dev.features & net->dev.backend_features) {
> -            fprintf(stderr, "vhost lacks feature mask %" PRIu64
> -                   " for backend\n",
> +            error_report("vhost lacks feature mask %" PRIu64
> +                   " for backend",
>                      (uint64_t)(~net->dev.features & net->dev.backend_features));
>               goto fail;
>           }
> @@ -197,8 +197,8 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
>       if (net->nc->info->type == NET_CLIENT_DRIVER_VHOST_USER) {
>           features = vhost_user_get_acked_features(net->nc);
>           if (~net->dev.features & features) {
> -            fprintf(stderr, "vhost lacks feature mask %" PRIu64
> -                    " for backend\n",
> +            error_report("vhost lacks feature mask %" PRIu64
> +                    " for backend",
>                       (uint64_t)(~net->dev.features & features));
>               goto fail;
>           }
> @@ -349,7 +349,7 @@ err_start:
>       }
>       e = k->set_guest_notifiers(qbus->parent, total_queues * 2, false);
>       if (e < 0) {
> -        fprintf(stderr, "vhost guest notifier cleanup failed: %d\n", e);
> +        error_report("vhost guest notifier cleanup failed: %d", e);
>           fflush(stderr);
>       }
>   err:
> @@ -370,7 +370,7 @@ void vhost_net_stop(VirtIODevice *dev, NetClientState *ncs,
>   
>       r = k->set_guest_notifiers(qbus->parent, total_queues * 2, false);
>       if (r < 0) {
> -        fprintf(stderr, "vhost guest notifier cleanup failed: %d\n", r);
> +        error_report("vhost guest notifier cleanup failed: %d", r);
>           fflush(stderr);
>       }
>       assert(r >= 0);
> 
