Received: from eggs.gnu.org ([2001:4830:134:3::10]:40646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e7prC-00034h-0T
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 17:38:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e7pr6-0003ck-Vm
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 17:38:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:47658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1e7pr6-0003bb-PQ
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 17:38:24 -0400
Date: Thu, 26 Oct 2017 14:38:23 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <1508506702-17704-4-git-send-email-ian.jackson@eu.citrix.com>
Message-ID: <alpine.DEB.2.10.1710261438040.3086@sstabellini-ThinkPad-X260>
References: <23017.64539.31230.43449@mariner.uk.xensource.com>
	<1508506702-17704-1-git-send-email-ian.jackson@eu.citrix.com>
	<1508506702-17704-4-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v5.1 4/8] xen: destroy_hvm_domain: Move
 reason into a variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Jackson <ian.jackson@eu.citrix.com>
Cc: qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org

On Fri, 20 Oct 2017, Ian Jackson wrote:
> We are going to want to reuse this.
> 
> No functional change.
> 
> Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
> Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

Acked-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  hw/i386/xen/xen-hvm.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
> index 7b60ec6..83420cd 100644
> --- a/hw/i386/xen/xen-hvm.c
> +++ b/hw/i386/xen/xen-hvm.c
> @@ -1387,12 +1387,13 @@ void destroy_hvm_domain(bool reboot)
>      xc_interface *xc_handle;
>      int sts;
>  
> +    unsigned int reason = reboot ? SHUTDOWN_reboot : SHUTDOWN_poweroff;
> +
>      xc_handle = xc_interface_open(0, 0, 0);
>      if (xc_handle == NULL) {
>          fprintf(stderr, "Cannot acquire xenctrl handle\n");
>      } else {
> -        sts = xc_domain_shutdown(xc_handle, xen_domid,
> -                                 reboot ? SHUTDOWN_reboot : SHUTDOWN_poweroff);
> +        sts = xc_domain_shutdown(xc_handle, xen_domid, reason);
>          if (sts != 0) {
>              fprintf(stderr, "xc_domain_shutdown failed to issue %s, "
>                      "sts %d, %s\n", reboot ? "reboot" : "poweroff",
> -- 
> 2.1.4
> 
