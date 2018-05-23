Received: from eggs.gnu.org ([2001:4830:134:3::10]:55506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fLLTm-0005uL-4v
	for qemu-devel@nongnu.org; Wed, 23 May 2018 00:34:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fLLTh-0008QL-3w
	for qemu-devel@nongnu.org; Wed, 23 May 2018 00:34:26 -0400
References: <20180522192034.13318-1-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3a90789d-ca98-9305-a2d4-2b6d166a6d2d@redhat.com>
Date: Wed, 23 May 2018 06:34:16 +0200
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
Cc: david@redhat.com, qemu-trivial@nongnu.org

On 22.05.2018 21:20, Paolo Bonzini wrote:
> Even though the presence of softfloat does not cause --disable-tcg builds to fail,
> it is the single largest .o file in them.  Remove it, since TCG is the only client.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  Makefile.target          |   2 +-
>  hw/i386/x86-iommu-stub.c | 132 +++++++++++++++++++++++++++++++++++++++
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
>  obj-y += target/$(TARGET_BASE_ARCH)/
>  obj-y += disas.o
>  obj-$(call notempty,$(TARGET_XML_FILES)) += gdbstub-xml.o

Without that x86-iommu-stub.c file:

Reviewed-by: Thomas Huth <thuth@redhat.com>
