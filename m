Received: from eggs.gnu.org ([2001:4830:134:3::10]:56860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drOcX-0005Zs-EX
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 09:19:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drOcW-0001qO-J8
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 09:19:25 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <150496954641.9654.1998704077006846521.stgit@bahia>
	<150496957019.9654.12729412560336508445.stgit@bahia>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2482b70c-66a4-59a2-95ae-ea228ce23324@amsat.org>
Date: Sun, 10 Sep 2017 13:57:10 -0300
MIME-Version: 1.0
In-Reply-To: <150496957019.9654.12729412560336508445.stgit@bahia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/5] spapr_pci: drop useless check in
 spapr_populate_pci_child_dt()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 09/09/2017 12:06 PM, Greg Kurz wrote:
> spapr_phb_get_loc_code() either returns a non-null pointer, either
> aborts if g_strdup_printf() failed to allocate memory.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   hw/ppc/spapr_pci.c |    6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index ef982f2ef370..cd8efb181223 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1282,12 +1282,8 @@ static int spapr_populate_pci_child_dt(PCIDevice *dev, void *fdt, int offset,
>                               pci_find_device_name((ccode >> 16) & 0xff,
>                                                    (ccode >> 8) & 0xff,
>                                                    ccode & 0xff)));
> -    buf = spapr_phb_get_loc_code(sphb, dev);
> -    if (!buf) {
> -        error_report("Failed setting the ibm,loc-code");
> -        return -1;
> -    }
>   
> +    buf = spapr_phb_get_loc_code(sphb, dev);
>       err = fdt_setprop_string(fdt, offset, "ibm,loc-code", buf);
>       g_free(buf);
>       if (err < 0) {
> 
> 
