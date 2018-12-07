Received: from eggs.gnu.org ([2001:4830:134:3::10]:42811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gVE6W-0007yE-Cw
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 06:15:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gVE6R-00087V-FW
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 06:15:32 -0500
References: <1543571638-2892-1-git-send-email-liq3ea@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <653dfb5d-f90a-12c2-44f0-2acd1858772f@vivier.eu>
Date: Fri, 7 Dec 2018 12:15:17 +0100
MIME-Version: 1.0
In-Reply-To: <1543571638-2892-1-git-send-email-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] util: vfio-helpers: use
 ARRAY_SIZE in qemu_vfio_init_pci()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, philmd@redhat.com
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

Le 30/11/2018 à 10:53, Li Qiang a écrit :
> Cc: qemu-trivial@nongnu.org
> 
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>  util/vfio-helpers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
> index cccc9cd42e..342d4a2285 100644
> --- a/util/vfio-helpers.c
> +++ b/util/vfio-helpers.c
> @@ -348,7 +348,7 @@ static int qemu_vfio_init_pci(QEMUVFIOState *s, const char *device,
>          goto fail;
>      }
>  
> -    for (i = 0; i < 6; i++) {
> +    for (i = 0; i < ARRAY_SIZE(s->bar_region_info); i++) {
>          ret = qemu_vfio_pci_init_bar(s, i, errp);
>          if (ret) {
>              goto fail;
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
