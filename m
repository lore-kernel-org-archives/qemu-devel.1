Received: from eggs.gnu.org ([2001:4830:134:3::10]:48749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gRKK0-000719-2N
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 12:05:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gRKJu-0002Gi-EF
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 12:05:20 -0500
References: <20181125205000.10324-1-philmd@redhat.com>
	<20181125205000.10324-11-philmd@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <40c0e94b-687c-aaba-9d29-9ecdcbad937d@ilande.co.uk>
Date: Mon, 26 Nov 2018 17:05:05 +0000
MIME-Version: 1.0
In-Reply-To: <20181125205000.10324-11-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-3.1 10/25] MAINTAINERS: Add missing
 entries for the sun4u machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 25/11/2018 20:49, Philippe Mathieu-Daudé wrote:

> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  MAINTAINERS | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ba9cd9ac2b..d9cddb0cc8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1019,6 +1019,10 @@ Sun4u
>  M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>  S: Maintained
>  F: hw/sparc64/sun4u.c
> +F: hw/sparc64/sun4u_iommu.c
> +F: include/hw/sparc/sun4u_iommu.h
> +F: hw/pci-host/sabre.c
> +F: include/hw/pci-host/sabre.h
>  F: pc-bios/openbios-sparc64

These are correct, however you also want to add the simba PCI bridges i.e.

F: hw/pci-bridge/simba.c
F: include/hw/pci-bridge/simba.h

So with that:

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.
