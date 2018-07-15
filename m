Received: from eggs.gnu.org ([2001:4830:134:3::10]:53013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fepMw-00081j-3Z
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 18:19:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fepMv-0005fj-5q
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 18:19:54 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180715211731.2EBA27456B1@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <bcd20703-400a-6af8-6e4f-9345f78eaca3@amsat.org>
Date: Sun, 15 Jul 2018 19:19:44 -0300
MIME-Version: 1.0
In-Reply-To: <20180715211731.2EBA27456B1@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 3.0] sam460ex: Correct use after free
 error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 07/15/2018 05:47 PM, BALATON Zoltan wrote:
> Commit 51b0d834c changed error handling to report file name in error
> message but forgot to move freeing it after usage. Noticed by Coverity.
> 
> Fixes: CID 1394217
> Reported-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/ppc/sam460ex.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index e2b7028..0999efc 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -269,11 +269,12 @@ static int sam460ex_load_device_tree(hwaddr addr,
>          exit(1);
>      }
>      fdt = load_device_tree(filename, &fdt_size);
> -    g_free(filename);
>      if (!fdt) {
>          error_report("Couldn't load dtb file `%s'", filename);
> +        g_free(filename);
>          exit(1);
>      }
> +    g_free(filename);
>  
>      /* Manipulate device tree in memory. */
>  
> 
