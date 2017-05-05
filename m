Received: from eggs.gnu.org ([2001:4830:134:3::10]:42595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d6c19-0002Ew-JM
	for qemu-devel@nongnu.org; Fri, 05 May 2017 08:07:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d6c16-0001CB-9A
	for qemu-devel@nongnu.org; Fri, 05 May 2017 08:07:27 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:33666)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d6c16-0001Bv-4m
	for qemu-devel@nongnu.org; Fri, 05 May 2017 08:07:24 -0400
Received: by mail-qk0-x243.google.com with SMTP id o85so519410qkh.0
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 05:07:24 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1493977730-20581-1-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4cb86019-8247-fa13-556c-d4f5f4302c96@amsat.org>
Date: Fri, 5 May 2017 09:07:19 -0300
MIME-Version: 1.0
In-Reply-To: <1493977730-20581-1-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] ppc: xics: fix compilation with CentOS 6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: dgibson@redhat.com, stefanha@redhat.com

On 05/05/2017 06:48 AM, Paolo Bonzini wrote:
> The PowerPCCPU typedef is included twice if a file includes
> both hw/ppc/xics.h and target/ppc/cpu-qom.h.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> 	There are other failures but I don't have time to debug them today:
>
> 	In file included from /tmp/qemu-test/src/include/hw/ppc/pnv.h:26,
> 	                 from /tmp/qemu-test/src/hw/ppc/pnv.c:31:
> 	/tmp/qemu-test/src/include/hw/ppc/pnv_psi.h:50: error: redefinition of typedef ‘PnvPsi’
> 	/tmp/qemu-test/src/include/hw/ppc/pnv_lpc.h:26: note: previous declaration of ‘PnvPsi’ was here
> 	In file included from /tmp/qemu-test/src/include/hw/ppc/pnv.h:27,
> 	                 from /tmp/qemu-test/src/hw/ppc/pnv.c:31:
> 	/tmp/qemu-test/src/include/hw/ppc/pnv_occ.h:25: error: redefinition of typedef ‘PnvPsi’
> 	/tmp/qemu-test/src/include/hw/ppc/pnv_psi.h:50: note: previous declaration of ‘PnvPsi’ was here
> 	In file included from /tmp/qemu-test/src/hw/ppc/pnv.c:39:
> 	/tmp/qemu-test/src/include/hw/ipmi/ipmi.h:188: error: redefinition of typedef ‘IPMIBmc’
> 	/tmp/qemu-test/src/include/hw/ppc/pnv.h:121: note: previous declaration of ‘IPMIBmc’ was here
> 	make[1]: *** [hw/ppc/pnv.o] Error 1
>
> 	Please start including Docker-based tests in your pre-pull-request tests.
>
>  include/hw/ppc/xics.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index c215dc7..ce1942b 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -29,6 +29,7 @@
>  #define XICS_H
>
>  #include "hw/qdev.h"
> +#include "target/ppc/cpu-qom.h"
>
>  #define XICS_IPI        0x2
>  #define XICS_BUID       0x1
> @@ -46,7 +47,6 @@ typedef struct ICSStateClass ICSStateClass;
>  typedef struct ICSState ICSState;
>  typedef struct ICSIRQState ICSIRQState;
>  typedef struct XICSFabric XICSFabric;
> -typedef struct PowerPCCPU PowerPCCPU;
>
>  #define TYPE_ICP "icp"
>  #define ICP(obj) OBJECT_CHECK(ICPState, (obj), TYPE_ICP)
>
