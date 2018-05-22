Received: from eggs.gnu.org ([2001:4830:134:3::10]:55493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fLEIB-0001io-VL
	for qemu-devel@nongnu.org; Tue, 22 May 2018 16:54:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fLEI8-0001e8-T4
	for qemu-devel@nongnu.org; Tue, 22 May 2018 16:54:00 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:33051)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fLEI8-0001dT-M7
	for qemu-devel@nongnu.org; Tue, 22 May 2018 16:53:56 -0400
Received: by mail-pg0-x244.google.com with SMTP id e21-v6so3481513pgv.0
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 13:53:56 -0700 (PDT)
References: <20180522192034.13318-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <724510e7-e739-5f88-b20b-9e27376a3438@linaro.org>
Date: Tue, 22 May 2018 13:53:45 -0700
MIME-Version: 1.0
In-Reply-To: <20180522192034.13318-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tcg: remove softfloat from --disable-tcg
 builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, thuth@redhat.com, david@redhat.com

On 05/22/2018 12:20 PM, Paolo Bonzini wrote:
> Even though the presence of softfloat does not cause --disable-tcg builds to fail,
> it is the single largest .o file in them.  Remove it, since TCG is the only client.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  Makefile.target          |   2 +-
>  hw/i386/x86-iommu-stub.c | 132 +++++++++++++++++++++++++++++++++++++++

Assuming this wasn't supposed to be here.

>  2 files changed, 133 insertions(+), 1 deletion(-)
>  create mode 100644 hw/i386/x86-iommu-stub.c
> 
> diff --git a/Makefile.target b/Makefile.target
> index d0ec77a307..dad2cf8778 100644
> --- a/Makefile.target
> +++ b/Makefile.target
> @@ -97,7 +97,7 @@ obj-$(CONFIG_TCG) += tcg/tcg.o tcg/tcg-op.o tcg/tcg-op-vec.o tcg/tcg-op-gvec.o
>  obj-$(CONFIG_TCG) += tcg/tcg-common.o tcg/optimize.o
>  obj-$(CONFIG_TCG_INTERPRETER) += tcg/tci.o
>  obj-$(CONFIG_TCG_INTERPRETER) += disas/tci.o
> -obj-y += fpu/softfloat.o
> +obj-$(CONFIG_TCG) += fpu/softfloat.o

But for this change alone,
Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~
