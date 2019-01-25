Received: from eggs.gnu.org ([209.51.188.92]:42163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gn3WM-0001vX-QP
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:35:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gn3WM-0003Pf-3r
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:35:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gn3WL-0003P6-Ry
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:35:54 -0500
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
	<1548410831-19553-25-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d9bb4dd8-e256-25cd-af38-92d70f71d237@redhat.com>
Date: Fri, 25 Jan 2019 16:35:50 +0100
MIME-Version: 1.0
In-Reply-To: <1548410831-19553-25-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 24/52] hw/openrisc/Makefile.objs: Create
 CONFIG_* for openrisc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: yang.zhong@intel.com, Jia Liu <proljc@gmail.com>

On 2019-01-25 11:06, Paolo Bonzini wrote:
> From: Yang Zhong <yang.zhong@intel.com>
> 
> Add the new configs to default-configs/or1k-sofmmu.mak.
> 
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> Message-Id: <20190123065618.3520-21-yang.zhong@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  default-configs/or1k-softmmu.mak | 1 +
>  hw/openrisc/Makefile.objs        | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/default-configs/or1k-softmmu.mak b/default-configs/or1k-softmmu.mak
> index 6f5824f..85a7e69 100644
> --- a/default-configs/or1k-softmmu.mak
> +++ b/default-configs/or1k-softmmu.mak
> @@ -3,3 +3,4 @@
>  CONFIG_SERIAL=y
>  CONFIG_OPENCORES_ETH=y
>  CONFIG_OMPIC=y
> +CONFIG_OPENRISC=y
> diff --git a/hw/openrisc/Makefile.objs b/hw/openrisc/Makefile.objs
> index 61246b1..8dc413c 100644
> --- a/hw/openrisc/Makefile.objs
> +++ b/hw/openrisc/Makefile.objs
> @@ -1,2 +1,2 @@
>  obj-y = pic_cpu.o cputimer.o
> -obj-y += openrisc_sim.o 
> +obj-$(CONFIG_OPENRISC) += openrisc_sim.o
> 

<bikeshedding>
CONFIG_OR1K_SIM instead of CONFIG_OPENRISC ?
</bikeshedding>

Anyway:
Reviewed-by: Thomas Huth <thuth@redhat.com>
