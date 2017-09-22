Received: from eggs.gnu.org ([2001:4830:134:3::10]:42566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dvQzm-0002tl-Gm
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:40:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dvQzl-0003K9-3p
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:40:06 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:50574)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dvQzk-0003Jm-Ut
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:40:05 -0400
Received: by mail-wr0-x22c.google.com with SMTP id w12so1345164wrc.7
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 09:40:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170922154014.29350-7-f4bug@amsat.org>
References: <20170922154014.29350-1-f4bug@amsat.org>
	<20170922154014.29350-7-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Sep 2017 17:39:43 +0100
Message-ID: <CAFEAcA-FgAHEjMkS=kgYbwCW6A9qHBmfgYVLZm3DRQPWKSRPWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 06/34] ppc: remove duplicated includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>

On 22 September 2017 at 16:39, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
> applied using ./scripts/clean-includes
>
> not needed since 7ebaf795560
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/ppc/spapr_hcall.c | 1 -
>  target/ppc/kvm.c     | 3 ---
>  2 files changed, 4 deletions(-)
>
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 57bb411394..2aeee28fe6 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -13,7 +13,6 @@
>  #include "trace.h"
>  #include "kvm_ppc.h"
>  #include "hw/ppc/spapr_ovec.h"
> -#include "qemu/error-report.h"
>  #include "mmu-book3s-v3.h"
>
>  struct SPRSyncState {
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 1deaf106d2..c9105af393 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -47,9 +47,6 @@
>  #include "sysemu/hostmem.h"
>  #include "qemu/cutils.h"
>  #include "qemu/mmap-alloc.h"
> -#if defined(TARGET_PPC64)
> -#include "hw/ppc/spapr_cpu_core.h"
> -#endif
>  #include "elf.h"
>  #include "sysemu/kvm_int.h"
>
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
