Received: from eggs.gnu.org ([2001:4830:134:3::10]:56800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dofMY-0001As-Ct
	for qemu-devel@nongnu.org; Sun, 03 Sep 2017 20:35:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dofMT-0000fO-Pe
	for qemu-devel@nongnu.org; Sun, 03 Sep 2017 20:35:38 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:37242)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dofMT-0000f9-Kr
	for qemu-devel@nongnu.org; Sun, 03 Sep 2017 20:35:33 -0400
Received: by mail-qt0-x241.google.com with SMTP id x29so3525614qtc.4
	for <qemu-devel@nongnu.org>; Sun, 03 Sep 2017 17:35:33 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170903163455.15132-1-n54@gmx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <115f628e-13f7-3696-82ec-1de354076c83@amsat.org>
Date: Sun, 3 Sep 2017 21:35:29 -0300
MIME-Version: 1.0
In-Reply-To: <20170903163455.15132-1-n54@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] usb-mtp: Add fallback definition of
 NAME_MAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>, kraxel@redhat.com
Cc: qemu-devel@nongnu.org

Hi Kamil,

On 09/03/2017 01:34 PM, Kamil Rytarowski wrote:
> This fixes build on SmartOS (Joyent).
> 
> Patch cherry-picked from pkgsrc by jperkin (Joyent).
> 
> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
> ---
>   hw/usb/dev-mtp.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
> index 94c2e94f10..6e8d7b21b5 100644
> --- a/hw/usb/dev-mtp.c
> +++ b/hw/usb/dev-mtp.c
> @@ -26,6 +26,10 @@
>   #include "hw/usb.h"
>   #include "hw/usb/desc.h"
>   
> +#ifndef NAME_MAX
> +#define NAME_MAX 255
> +#endif

this belongs to include/qemu/osdep.h

once moved there:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +
>   /* ----------------------------------------------------------------------- */
>   
>   enum mtp_container_type {
> 

Regards,

Phil.
