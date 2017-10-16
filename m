Received: from eggs.gnu.org ([2001:4830:134:3::10]:45808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e48mq-0008Dt-LM
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:02:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e48ml-0001Jb-QA
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:02:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1e48ml-0001If-KT
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:02:39 -0400
Date: Mon, 16 Oct 2017 20:02:32 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171016200124-mutt-send-email-mst@kernel.org>
References: <1508169816-5993-1-git-send-email-lukas.humbel@inf.ethz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1508169816-5993-1-git-send-email-lukas.humbel@inf.ethz.ch>
Subject: Re: [Qemu-devel] [PATCH] hw/pci: Add e1000e NIC as command line
 argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: lukas.humbel@inf.ethz.ch
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>

On Mon, Oct 16, 2017 at 06:03:36PM +0200, lukas.humbel@inf.ethz.ch wrote:
> From: Lukas Humbel <lukas.humbel@inf.ethz.ch>
> 
> Signed-off-by: Lukas Humbel <lukas.humbel@inf.ethz.ch>

We keep these around for legacy reasons but I'm not sure we need to add
to the list.  What's wrong with just creating them with -device e1000e?

> ---
>  hw/pci/pci.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 1e6fb88..9d6cd04 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1819,6 +1819,7 @@ static const char * const pci_nic_models[] = {
>      "i82559er",
>      "rtl8139",
>      "e1000",
> +    "e1000e",
>      "pcnet",
>      "virtio",
>      "sungem",
> @@ -1832,6 +1833,7 @@ static const char * const pci_nic_names[] = {
>      "i82559er",
>      "rtl8139",
>      "e1000",
> +    "e1000e",
>      "pcnet",
>      "virtio-net-pci",
>      "sungem",
> -- 
> 2.7.4
