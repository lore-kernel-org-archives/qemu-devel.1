Received: from eggs.gnu.org ([2001:4830:134:3::10]:46182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1fL1O1-00020V-Vj
	for qemu-devel@nongnu.org; Tue, 22 May 2018 03:07:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1fL1Ny-0002AU-QF
	for qemu-devel@nongnu.org; Tue, 22 May 2018 03:07:09 -0400
Received: from mout.web.de ([217.72.192.78]:43365)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.kiszka@web.de>) id 1fL1Ny-00029i-G8
	for qemu-devel@nongnu.org; Tue, 22 May 2018 03:07:06 -0400
From: Jan Kiszka <jan.kiszka@web.de>
References: <f6aa6ac8-3c3c-bf90-6273-3d584f4707c8@web.de>
Message-ID: <a2198ea1-e0f6-6b04-63a8-fd04b40c9ff2@web.de>
Date: Tue, 22 May 2018 09:06:56 +0200
MIME-Version: 1.0
In-Reply-To: <f6aa6ac8-3c3c-bf90-6273-3d584f4707c8@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/i386: Fix IVHD entry length for AMD
 IOMMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

On 2018-03-29 14:51, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Counting from the IVHD ID field to the all-devices entry, we have 28
> bytes, not 36.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  hw/i386/acpi-build.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index deb440f286..a0cda71411 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2561,7 +2561,7 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker)
>                               (1UL << 7),  /* PPRSup       */
>                               1);
>      /* IVHD length */
> -    build_append_int_noprefix(table_data, 0x24, 2);
> +    build_append_int_noprefix(table_data, 28, 2);
>      /* DeviceID */
>      build_append_int_noprefix(table_data, s->devid, 2);
>      /* Capability offset */
> 

Waiting to be merged.

Jan
