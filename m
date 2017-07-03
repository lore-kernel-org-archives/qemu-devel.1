Received: from eggs.gnu.org ([2001:4830:134:3::10]:32808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS7pz-0005Vv-SU
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 16:20:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS7pw-00055z-LZ
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 16:20:51 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:36578)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dS7pw-00055K-HX
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 16:20:48 -0400
Received: by mail-qt0-x241.google.com with SMTP id v31so24804588qtb.3
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 13:20:48 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
	<1499099693-22903-22-git-send-email-pbonzini@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <53198724-711a-1a95-bb15-f5588ea424f1@twiddle.net>
Date: Mon, 3 Jul 2017 13:20:43 -0700
MIME-Version: 1.0
In-Reply-To: <1499099693-22903-22-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 21/22] target/i386: add the CONFIG_TCG into
 Makefiles
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, anthony.xu@intel.com, berrange@redhat.com, a.rigo@virtualopensystems.com, yang.zhong@intel.com

On 07/03/2017 09:34 AM, Paolo Bonzini wrote:
> From: Yang Zhong <yang.zhong@intel.com>
> 
> Add the CONFIG_TCG for frontend and backend's files in the related
> Makefiles.
> 
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/Makefile.objs | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/target/i386/Makefile.objs b/target/i386/Makefile.objs
> index 4fcb7f3..36949b1 100644
> --- a/target/i386/Makefile.objs
> +++ b/target/i386/Makefile.objs
> @@ -1,6 +1,7 @@
> -obj-y += translate.o helper.o cpu.o bpt_helper.o
> -obj-y += excp_helper.o fpu_helper.o cc_helper.o int_helper.o svm_helper.o
> -obj-y += smm_helper.o misc_helper.o mem_helper.o seg_helper.o mpx_helper.o
> +obj-y += helper.o cpu.o bpt_helper.o
> +obj-$(CONFIG_TCG) += translate.o
> +obj-$(CONFIG_TCG) += excp_helper.o fpu_helper.o int_helper.o svm_helper.o cc_helper.o
> +obj-$(CONFIG_TCG) += smm_helper.o misc_helper.o mem_helper.o seg_helper.o mpx_helper.o
>   obj-y += gdbstub.o
>   obj-$(CONFIG_SOFTMMU) += machine.o arch_memory_mapping.o arch_dump.o monitor.o
>   obj-$(CONFIG_KVM) += kvm.o hyperv.o
> 

Modulo my final question for patch 20,

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
