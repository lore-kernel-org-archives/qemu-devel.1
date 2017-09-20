Received: from eggs.gnu.org ([2001:4830:134:3::10]:60758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1duZhw-0003BJ-OX
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 03:46:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1duZhs-0000Ec-4p
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 03:46:08 -0400
From: Thomas Huth <thuth@redhat.com>
References: <1495613046-6430-1-git-send-email-thuth@redhat.com>
Message-ID: <5e647277-d688-071d-7def-bd8d57dd7e66@redhat.com>
Date: Wed, 20 Sep 2017 09:45:59 +0200
MIME-Version: 1.0
In-Reply-To: <1495613046-6430-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] net: Mark the 'hubport' netdev as
 deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>

On 24.05.2017 10:04, Thomas Huth wrote:
> The 'hubport' netdev is closely tied to the 'vlan' concept which
> has been marked as deprecated in commit a2dbe1356faff3cb6 already.
> Thus we should also mark the hubport netdevs as deprecated to make
> the remaining users aware that they should not use this anymore.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  net/hub.c       | 4 ++++
>  qemu-options.hx | 6 ++++--
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/net/hub.c b/net/hub.c
> index 32d8cf5..85bd5bc 100644
> --- a/net/hub.c
> +++ b/net/hub.c
> @@ -13,6 +13,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "monitor/monitor.h"
>  #include "net/net.h"
>  #include "clients.h"
> @@ -286,6 +287,9 @@ int net_init_hubport(const Netdev *netdev, const char *name,
>  {
>      const NetdevHubPortOptions *hubport;
>  
> +    error_report("hubports are deprecated and will be removed in a "
> +                 "future release");
> +
>      assert(netdev->type == NET_CLIENT_DRIVER_HUBPORT);
>      assert(!peer);
>      hubport = &netdev->u.hubport;
> diff --git a/qemu-options.hx b/qemu-options.hx
> index dc1a48a..efb555c 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1810,7 +1810,7 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
>      "-netdev vhost-user,id=str,chardev=dev[,vhostforce=on|off]\n"
>      "                configure a vhost-user network, backed by a chardev 'dev'\n"
>      "-netdev hubport,id=str,hubid=n\n"
> -    "                configure a hub port on QEMU VLAN 'n'\n", QEMU_ARCH_ALL)
> +    "                configure a hub port on QEMU VLAN 'n' (deprecated)\n", QEMU_ARCH_ALL)
>  DEF("net", HAS_ARG, QEMU_OPTION_net,
>      "-net nic[,vlan=n][,macaddr=mac][,model=type][,name=str][,addr=str][,vectors=v]\n"
>      "                old way to create a new NIC and connect it to VLAN 'n'\n"
> @@ -2239,7 +2239,9 @@ Create a hub port on QEMU "vlan" @var{hubid}.
>  
>  The hubport netdev lets you connect a NIC to a QEMU "vlan" instead of a single
>  netdev.  @code{-net} and @code{-device} with parameter @option{vlan} create the
> -required hub automatically.
> +required hub automatically. Note that the "vlan" concept and thus the hubport
> +option, too, are considered as deprecated and might be removed in a future
> +release of QEMU.
>  
>  @item -netdev vhost-user,chardev=@var{id}[,vhostforce=on|off][,queues=n]
>  
> 

ping?

 Thomas
