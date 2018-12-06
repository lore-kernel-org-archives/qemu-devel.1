Received: from eggs.gnu.org ([2001:4830:134:3::10]:57567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gUrjl-0004QN-6V
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:22:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gUrjh-0002cu-6K
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:22:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1gUrjc-0002XC-2U
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:22:25 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D5EF6C025D28
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 11:22:19 +0000 (UTC)
References: <154393964026.28192.13536237934563059985.stgit@gimli.home>
	<154394084810.28192.18333845343054369357.stgit@gimli.home>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <e19cb3fa-4ec3-0751-f3a9-49740242b93b@redhat.com>
Date: Thu, 6 Dec 2018 12:22:12 +0100
MIME-Version: 1.0
In-Reply-To: <154394084810.28192.18333845343054369357.stgit@gimli.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [for-4.0 PATCH v3 9/9] pcie: Fast PCIe root ports
 for new machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>

Hi

On 12/4/18 5:27 PM, Alex Williamson wrote:
> Change the default speed and width for new machine types to the
> fastest and widest currently supported.  This should be compatible to
> the PCIe 4.0 spec.  Pre-QEMU-4.0 machine types remain at 2.5GT/s, x1
> width.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  hw/pci-bridge/gen_pcie_root_port.c |    4 ++--
>  include/hw/compat.h                |   10 +++++++++-
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
> index ca5418a89dd2..9766edb44596 100644
> --- a/hw/pci-bridge/gen_pcie_root_port.c
> +++ b/hw/pci-bridge/gen_pcie_root_port.c
> @@ -125,9 +125,9 @@ static Property gen_rp_props[] = {
>      DEFINE_PROP_SIZE("pref64-reserve", GenPCIERootPort,
>                       res_reserve.mem_pref_64, -1),
>      DEFINE_PROP_PCIE_LINK_SPEED("x-speed", PCIESlot,
> -                                speed, PCIE_LINK_SPEED_2_5),
> +                                speed, PCIE_LINK_SPEED_16),
>      DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
> -                                width, PCIE_LINK_WIDTH_1),
> +                                width, PCIE_LINK_WIDTH_32),
>      DEFINE_PROP_END_OF_LIST()
>  };
>  
> diff --git a/include/hw/compat.h b/include/hw/compat.h
> index 70958328fe7a..702cc62277db 100644
> --- a/include/hw/compat.h
> +++ b/include/hw/compat.h
> @@ -2,7 +2,15 @@
>  #define HW_COMPAT_H
>  
>  #define HW_COMPAT_3_1 \
> -    /* empty */
> +    {\
> +        .driver   = "pcie-root-port",\
> +        .property = "speed",\
> +        .value    = "2_5",\
> +    },{\
> +        .driver   = "pcie-root-port",\
> +        .property = "width",\
> +        .value    = "1",\
> +    },
>  
>  #define HW_COMPAT_3_0 \
>      /* empty */
> 
> 
