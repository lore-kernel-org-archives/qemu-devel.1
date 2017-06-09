Received: from eggs.gnu.org ([2001:4830:134:3::10]:55064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dJRVn-000742-IM
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 17:32:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dJRVk-0001DS-Cl
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 17:32:07 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:32817)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dJRVk-0001DO-8Y
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 17:32:04 -0400
Received: by mail-qt0-x244.google.com with SMTP id w1so17785587qtg.0
	for <qemu-devel@nongnu.org>; Fri, 09 Jun 2017 14:32:04 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170609150622.4720-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <26b0f6df-a52c-21f0-a22a-fc29d1b7249f@amsat.org>
Date: Fri, 9 Jun 2017 18:32:00 -0300
MIME-Version: 1.0
In-Reply-To: <20170609150622.4720-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] hw/misc: add missing includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

I intended to send those 3 patches as separate since unrelated, but 
failed again, sorry :S

On 06/09/2017 12:06 PM, Philippe Mathieu-Daudé wrote:
> inlined create_unimplemented_device() calls sysbus_mmio_map_overlap().
>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>
> v2: Addressed review feedback from Eric Blake
>
>  include/hw/misc/unimp.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/hw/misc/unimp.h b/include/hw/misc/unimp.h
> index 3462d85836..52e068ec3e 100644
> --- a/include/hw/misc/unimp.h
> +++ b/include/hw/misc/unimp.h
> @@ -8,6 +8,8 @@
>  #ifndef HW_MISC_UNIMP_H
>  #define HW_MISC_UNIMP_H
>
> +#include "hw/sysbus.h"
> +
>  #define TYPE_UNIMPLEMENTED_DEVICE "unimplemented-device"
>
>  /**
>
