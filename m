Received: from eggs.gnu.org ([209.51.188.92]:40776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gn3Pt-00085T-Oc
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:29:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gn3Pt-00087F-4B
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:29:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gn3Ps-00086I-Rl
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:29:13 -0500
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
	<1548410831-19553-21-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c9e58ecf-98b4-a079-2e5d-939bdc40182a@redhat.com>
Date: Fri, 25 Jan 2019 16:29:08 +0100
MIME-Version: 1.0
In-Reply-To: <1548410831-19553-21-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 20/52] hw/alpha/Makefile.objs: Create
 CONFIG_* for alpha
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: yang.zhong@intel.com, Richard Henderson <rth@twiddle.net>

On 2019-01-25 11:06, Paolo Bonzini wrote:
> From: Yang Zhong <yang.zhong@intel.com>
> 
> Add the new configs to default-configs/alpha-sofmmu.mak.
> 
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> Message-Id: <20190123065618.3520-17-yang.zhong@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  default-configs/alpha-softmmu.mak | 1 +
>  hw/alpha/Makefile.objs            | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/default-configs/alpha-softmmu.mak b/default-configs/alpha-softmmu.mak
> index 4d654ea..49cb7ce 100644
> --- a/default-configs/alpha-softmmu.mak
> +++ b/default-configs/alpha-softmmu.mak
> @@ -19,3 +19,4 @@ CONFIG_I8259=y
>  CONFIG_MC146818RTC=y
>  CONFIG_ISA_TESTDEV=y
>  CONFIG_SMC37C669=y
> +CONFIG_DP264=y
> diff --git a/hw/alpha/Makefile.objs b/hw/alpha/Makefile.objs
> index 5c74275..62fdf3e 100644
> --- a/hw/alpha/Makefile.objs
> +++ b/hw/alpha/Makefile.objs
> @@ -1 +1 @@
> -obj-y += dp264.o pci.o typhoon.o
> +obj-$(CONFIG_DP264) += dp264.o pci.o typhoon.o

Reviewed-by: Thomas Huth <thuth@redhat.com>
