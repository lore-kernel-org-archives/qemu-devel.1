Received: from eggs.gnu.org ([2001:4830:134:3::10]:39041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaiOT-0002Cw-1k
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 08:32:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaiOP-0006v1-RW
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 08:32:13 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:36925)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaiOP-0006uh-N1
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 08:32:09 -0500
Received: by mail-qk0-x241.google.com with SMTP id y80so7409807qkb.4
	for <qemu-devel@nongnu.org>; Sun, 14 Jan 2018 05:32:09 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180114104751.21965-1-mark.cave-ayland@ilande.co.uk>
	<20180114104751.21965-10-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e4cb0bba-c6e0-0a38-7224-71738c3a7d5a@amsat.org>
Date: Sun, 14 Jan 2018 10:32:05 -0300
MIME-Version: 1.0
In-Reply-To: <20180114104751.21965-10-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, atar4qemu@gmail.com
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On 01/14/2018 07:47 AM, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Not sure this is worth a separate commit (I'd squash it in the next
patch), still:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> CC: Michael S. Tsirkin <mst@redhat.com>
> CC: Marcel Apfelbaum <marcel@redhat.com>
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
> 
