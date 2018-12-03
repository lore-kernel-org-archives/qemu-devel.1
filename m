Received: from eggs.gnu.org ([2001:4830:134:3::10]:48403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTrLB-00053n-1J
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:45:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTrL6-0004ts-Vf
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:45:00 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:40191)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gTrL6-0004tK-QZ
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:44:56 -0500
Received: by mail-oi1-x244.google.com with SMTP id t204so11484286oie.7
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 08:44:56 -0800 (PST)
References: <1543848532-12604-1-git-send-email-lizhijian@cn.fujitsu.com>
	<1543848532-12604-4-git-send-email-lizhijian@cn.fujitsu.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <39f2fb36-417f-a9fa-d462-39ce2c3af319@linaro.org>
Date: Mon, 3 Dec 2018 10:44:52 -0600
MIME-Version: 1.0
In-Reply-To: <1543848532-12604-4-git-send-email-lizhijian@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 v3 3/4] i386: import bootparam.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Zhijian <lizhijian@cn.fujitsu.com>, qemu-devel@nongnu.org, mst@redhat.com, peter.maydell@linaro.org
Cc: philip.li@intel.com, zhijianx.li@intel.com

On 12/3/18 8:48 AM, Li Zhijian wrote:
>  #include "hw/net/ne2000-isa.h"
> +#include <asm/bootparam.h>
>  
>  /* debug PC/ISA interrupts */
>  //#define DEBUG_IRQ
> @@ -820,20 +821,6 @@ static long get_file_size(FILE *f)
>      return size;
>  }
>  
> -/* setup_data types */
> -#define SETUP_NONE     0
> -#define SETUP_E820_EXT 1
> -#define SETUP_DTB      2
> -#define SETUP_PCI      3
> -#define SETUP_EFI      4
> -
> -struct setup_data {
> -    uint64_t next;
> -    uint32_t type;
> -    uint32_t len;
> -    uint8_t data[0];
> -} __attribute__((packed));
> -

No, this will fail to build for a non-x86 host, which will not have
<asm/bootparam.h>.  Or, perhaps, have a *different* asm/bootparam.h that will
be specific to a different host cpu.


r~
