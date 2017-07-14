Received: from eggs.gnu.org ([2001:4830:134:3::10]:53322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVsA3-0000WX-6T
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 00:25:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVsA2-0002qg-4g
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 00:25:03 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170713163219.9024-1-marcandre.lureau@redhat.com>
	<20170713163219.9024-22-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <913419f4-d2b9-be51-34ce-1644c48278fa@amsat.org>
Date: Fri, 14 Jul 2017 01:24:53 -0300
MIME-Version: 1.0
In-Reply-To: <20170713163219.9024-22-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH v2 21/29] msix: use
 DIV_ROUND_UP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

On 07/13/2017 01:32 PM, Marc-André Lureau wrote:
> I used the clang-tidy qemu-round check to generate the fix:
> https://github.com/elmarco/clang-tools-extra
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   hw/pci/msix.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/pci/msix.c b/hw/pci/msix.c
> index 5078d3dd19..c944c02135 100644
> --- a/hw/pci/msix.c
> +++ b/hw/pci/msix.c
> @@ -438,7 +438,7 @@ void msix_save(PCIDevice *dev, QEMUFile *f)
>       }
>   
>       qemu_put_buffer(f, dev->msix_table, n * PCI_MSIX_ENTRY_SIZE);
> -    qemu_put_buffer(f, dev->msix_pba, (n + 7) / 8);
> +    qemu_put_buffer(f, dev->msix_pba, DIV_ROUND_UP(n, 8));
>   }
>   
>   /* Should be called after restoring the config space. */
> @@ -453,7 +453,7 @@ void msix_load(PCIDevice *dev, QEMUFile *f)
>   
>       msix_clear_all_vectors(dev);
>       qemu_get_buffer(f, dev->msix_table, n * PCI_MSIX_ENTRY_SIZE);
> -    qemu_get_buffer(f, dev->msix_pba, (n + 7) / 8);
> +    qemu_get_buffer(f, dev->msix_pba, DIV_ROUND_UP(n, 8));
>       msix_update_function_masked(dev);
>   
>       for (vector = 0; vector < n; vector++) {
> 
