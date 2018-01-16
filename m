Received: from eggs.gnu.org ([2001:4830:134:3::10]:48496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebJAg-0000Rc-6F
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:48:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebJAf-00056Q-7t
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:48:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ebJAf-000561-1l
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:48:25 -0500
Date: Tue, 16 Jan 2018 06:48:19 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180116064759-mutt-send-email-mst@kernel.org>
References: <20180114104751.21965-1-mark.cave-ayland@ilande.co.uk>
	<20180114104751.21965-10-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180114104751.21965-10-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 09/11] pci: add trace-events support for
 hw/pci-host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, atar4qemu@gmail.com, Marcel Apfelbaum <marcel@redhat.com>

On Sun, Jan 14, 2018 at 10:47:49AM +0000, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> CC: Michael S. Tsirkin <mst@redhat.com>
> CC: Marcel Apfelbaum <marcel@redhat.com>

Seems harmless so why not.

Acked-by: Michael S. Tsirkin <mst@redhat.com>



> ---
>  Makefile.objs            | 1 +
>  hw/pci-host/trace-events | 1 +
>  2 files changed, 2 insertions(+)
>  create mode 100644 hw/pci-host/trace-events
> 
> diff --git a/Makefile.objs b/Makefile.objs
> index c8b1bba593..6aa793ce4f 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -149,6 +149,7 @@ trace-events-subdirs += hw/i386/xen
>  trace-events-subdirs += hw/9pfs
>  trace-events-subdirs += hw/ppc
>  trace-events-subdirs += hw/pci
> +trace-events-subdirs += hw/pci-host
>  trace-events-subdirs += hw/s390x
>  trace-events-subdirs += hw/vfio
>  trace-events-subdirs += hw/acpi
> diff --git a/hw/pci-host/trace-events b/hw/pci-host/trace-events
> new file mode 100644
> index 0000000000..9284b1fbad
> --- /dev/null
> +++ b/hw/pci-host/trace-events
> @@ -0,0 +1 @@
> +# See docs/devel/tracing.txt for syntax documentation.
> -- 
> 2.11.0
