Received: from eggs.gnu.org ([2001:4830:134:3::10]:56807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drOcR-0005Vu-E8
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 09:19:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drOcQ-0001mF-Il
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 09:19:19 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <150496954641.9654.1998704077006846521.stgit@bahia>
	<150496956243.9654.5568893219758334324.stgit@bahia>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3a258229-e3a0-04cf-bdc0-da4d1083999e@amsat.org>
Date: Sun, 10 Sep 2017 13:56:59 -0300
MIME-Version: 1.0
In-Reply-To: <150496956243.9654.5568893219758334324.stgit@bahia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/5] spapr_pci: drop useless check in
 spapr_phb_vfio_get_loc_code()
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
> g_strdup_printf() either returns a non-null pointer, either aborts
> if it failed to allocate memory.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>

Acked-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   hw/ppc/spapr_pci.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index d7880f257aa1..ef982f2ef370 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -766,7 +766,7 @@ static char *spapr_phb_vfio_get_loc_code(sPAPRPHBState *sphb,  PCIDevice *pdev)
>       /* Construct the path of the file that will give us the DT location */
>       path = g_strdup_printf("/sys/bus/pci/devices/%s/devspec", host);
>       g_free(host);
> -    if (!path || !g_file_get_contents(path, &buf, NULL, NULL)) {
> +    if (!g_file_get_contents(path, &buf, NULL, NULL)) {
>           goto err_out;
>       }
>       g_free(path);
> @@ -774,7 +774,7 @@ static char *spapr_phb_vfio_get_loc_code(sPAPRPHBState *sphb,  PCIDevice *pdev)
>       /* Construct and read from host device tree the loc-code */
>       path = g_strdup_printf("/proc/device-tree%s/ibm,loc-code", buf);
>       g_free(buf);
> -    if (!path || !g_file_get_contents(path, &buf, NULL, NULL)) {
> +    if (!g_file_get_contents(path, &buf, NULL, NULL)) {
>           goto err_out;
>       }
>       return buf;
> 
> 
