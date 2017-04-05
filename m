Received: from eggs.gnu.org ([2001:4830:134:3::10]:35603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cvr3f-0002X8-Cz
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 15:57:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cvr3c-00052E-8j
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 15:57:35 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:33307)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cvr3c-00050s-3Z
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 15:57:32 -0400
Received: by mail-qt0-x244.google.com with SMTP id r45so3062407qte.0
	for <qemu-devel@nongnu.org>; Wed, 05 Apr 2017 12:57:31 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170405194741.18956-1-eblake@redhat.com>
	<20170405194741.18956-3-eblake@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5628e25b-1257-df1f-9575-28a260eb85e3@amsat.org>
Date: Wed, 5 Apr 2017 16:57:27 -0300
MIME-Version: 1.0
In-Reply-To: <20170405194741.18956-3-eblake@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 02/13] pci: Reduce scope of error
 injection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, armbru@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>

On 04/05/2017 04:47 PM, Eric Blake wrote:
> No one outside of pcie_aer.h was using error injection; mark them
> static for internal use.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>
> ---
> v3: new patch, suggested by Markus
> ---
>  include/hw/pci/pcie_aer.h | 4 ----
>  hw/pci/pcie_aer.c         | 4 ++--
>  2 files changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/include/hw/pci/pcie_aer.h b/include/hw/pci/pcie_aer.h
> index 526802b..729a943 100644
> --- a/include/hw/pci/pcie_aer.h
> +++ b/include/hw/pci/pcie_aer.h
> @@ -100,8 +100,4 @@ void pcie_aer_root_write_config(PCIDevice *dev,
>                                  uint32_t addr, uint32_t val, int len,
>                                  uint32_t root_cmd_prev);
>
> -/* error injection */
> -int pcie_aer_inject_error(PCIDevice *dev, const PCIEAERErr *err);
> -void pcie_aer_msg(PCIDevice *dev, const PCIEAERMsg *msg);
> -
>  #endif /* QEMU_PCIE_AER_H */
> diff --git a/hw/pci/pcie_aer.c b/hw/pci/pcie_aer.c
> index 653af86..828052b 100644
> --- a/hw/pci/pcie_aer.c
> +++ b/hw/pci/pcie_aer.c
> @@ -376,7 +376,7 @@ static void pcie_aer_msg_root_port(PCIDevice *dev, const PCIEAERMsg *msg)
>   *
>   * Walk up the bus tree from the device, propagate the error message.
>   */
> -void pcie_aer_msg(PCIDevice *dev, const PCIEAERMsg *msg)
> +static void pcie_aer_msg(PCIDevice *dev, const PCIEAERMsg *msg)
>  {
>      uint8_t type;
>
> @@ -631,7 +631,7 @@ static bool pcie_aer_inject_uncor_error(PCIEAERInject *inj, bool is_fatal)
>   * Figure 6-2: Flowchart Showing Sequence of Device Error Signaling and Logging
>   *             Operations
>   */
> -int pcie_aer_inject_error(PCIDevice *dev, const PCIEAERErr *err)
> +static int pcie_aer_inject_error(PCIDevice *dev, const PCIEAERErr *err)
>  {
>      uint8_t *aer_cap = NULL;
>      uint16_t devctl = 0;
>
