Received: from eggs.gnu.org ([2001:4830:134:3::10]:41711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1g0q9O-0006NX-GB
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 11:36:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1g0q9L-0001TU-3r
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 11:36:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:54036)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1g0q9K-0001Rt-Tc
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 11:36:51 -0400
Date: Fri, 14 Sep 2018 08:36:49 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <20180914111830.28466-3-anthony.perard@citrix.com>
Message-ID: <alpine.DEB.2.10.1809140836420.4255@sstabellini-ThinkPad-X260>
References: <20180914111830.28466-1-anthony.perard@citrix.com>
	<20180914111830.28466-3-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH 2/2] xen: Replace few mentions of xend by
 libxl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org

On Fri, 14 Sep 2018, Anthony PERARD wrote:
> xend have been replaced by libxenlight (libxl) for many Xen releases
> now.
> 
> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>

Acked-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  hw/xenpv/xen_machine_pv.c | 2 +-
>  include/hw/xen/xen.h      | 2 +-
>  qemu-options.hx           | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/xenpv/xen_machine_pv.c b/hw/xenpv/xen_machine_pv.c
> index 4d03aa59cb..de89b0ee1d 100644
> --- a/hw/xenpv/xen_machine_pv.c
> +++ b/hw/xenpv/xen_machine_pv.c
> @@ -42,7 +42,7 @@ static void xen_init_pv(MachineState *machine)
>  
>      switch (xen_mode) {
>      case XEN_ATTACH:
> -        /* nothing to do, xend handles everything */
> +        /* nothing to do, libxl handles everything */
>          break;
>      case XEN_EMULATE:
>          error_report("xen emulation not implemented (yet)");
> diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
> index 978aaa31fb..ba039c146d 100644
> --- a/include/hw/xen/xen.h
> +++ b/include/hw/xen/xen.h
> @@ -15,7 +15,7 @@
>  /* xen-machine.c */
>  enum xen_mode {
>      XEN_EMULATE = 0,  // xen emulation, using xenner (default)
> -    XEN_ATTACH        // attach to xen domain created by xend
> +    XEN_ATTACH        // attach to xen domain created by libxl
>  };
>  
>  extern uint32_t xen_domid;
> diff --git a/qemu-options.hx b/qemu-options.hx
> index d14a50805a..327bc8c897 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3400,7 +3400,7 @@ DEF("xen-domid", HAS_ARG, QEMU_OPTION_xen_domid,
>      "-xen-domid id   specify xen guest domain id\n", QEMU_ARCH_ALL)
>  DEF("xen-attach", 0, QEMU_OPTION_xen_attach,
>      "-xen-attach     attach to existing xen domain\n"
> -    "                xend will use this when starting QEMU\n",
> +    "                libxl will use this when starting QEMU\n",
>      QEMU_ARCH_ALL)
>  DEF("xen-domid-restrict", 0, QEMU_OPTION_xen_domid_restrict,
>      "-xen-domid-restrict     restrict set of available xen operations\n"
> @@ -3414,7 +3414,7 @@ Specify xen guest domain @var{id} (XEN only).
>  @item -xen-attach
>  @findex -xen-attach
>  Attach to existing xen domain.
> -xend will use this when starting QEMU (XEN only).
> +libxl will use this when starting QEMU (XEN only).
>  @findex -xen-domid-restrict
>  Restrict set of available xen operations to specified domain id (XEN only).
>  ETEXI
> -- 
> Anthony PERARD
> 
