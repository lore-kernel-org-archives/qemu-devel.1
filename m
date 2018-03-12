Received: from eggs.gnu.org ([2001:4830:134:3::10]:34604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1evTMo-0004ZE-On
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 15:44:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1evTMl-000261-LB
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 15:44:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1evTMl-00025h-El
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 15:44:15 -0400
Date: Mon, 12 Mar 2018 16:44:06 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180312194406.GX3417@localhost.localdomain>
References: <cover.1520867740.git.x1917x@gmail.com>
	<4a65e8b30fe9d2a6c1c53b85ef2697f02e01d13f.1520867956.git.x1917x@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a65e8b30fe9d2a6c1c53b85ef2697f02e01d13f.1520867956.git.x1917x@gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH 16/30] q35/xen: Add Xen platform device
 support for Q35
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Gerasimenko <x1917x@gmail.com>
Cc: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>

On Tue, Mar 13, 2018 at 04:34:01AM +1000, Alexey Gerasimenko wrote:
> Current Xen/QEMU method to control Xen Platform device on i440 is a bit
> odd -- enabling/disabling Xen platform device actually modifies the QEMU
> emulated machine type, namely xenfv <--> pc.
> 
> In order to avoid multiplying machine types, use a new way to control Xen
> Platform device for QEMU -- "xen-platform-dev" machine property (bool).
> To maintain backward compatibility with existing Xen/QEMU setups, this
> is only applicable to q35 machine currently. i440 emulation still uses the
> old method (i.e. xenfv/pc machine selection) to control Xen Platform
> device, this may be changed later to xen-platform-dev property as well.
> 
> This way we can use a single machine type (q35) and change just
> xen-platform-dev value to on/off to control Xen platform device.
> 
> Signed-off-by: Alexey Gerasimenko <x1917x@gmail.com>
> ---
[...]
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 6585058c6c..cee0b92028 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -38,6 +38,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
>      "                dump-guest-core=on|off include guest memory in a core dump (default=on)\n"
>      "                mem-merge=on|off controls memory merge support (default: on)\n"
>      "                igd-passthru=on|off controls IGD GFX passthrough support (default=off)\n"
> +    "                xen-platform-dev=on|off controls Xen Platform device (default=off)\n"
>      "                aes-key-wrap=on|off controls support for AES key wrapping (default=on)\n"
>      "                dea-key-wrap=on|off controls support for DEA key wrapping (default=on)\n"
>      "                suppress-vmdesc=on|off disables self-describing migration (default=off)\n"

What are the obstacles preventing "-device xen-platform" from
working?  It would be better than adding a new boolean option to
-machine.

-- 
Eduardo
