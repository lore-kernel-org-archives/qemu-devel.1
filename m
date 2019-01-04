Received: from eggs.gnu.org ([208.118.235.92]:57030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gfVbl-0002H8-Ln
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 14:58:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gfVbh-0001Lv-N4
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 14:58:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gfVbh-0001Ld-Fe
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 14:58:13 -0500
References: <20181227063419.12981-1-yang.zhong@intel.com>
	<20181227063419.12981-24-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d3192ec2-bb58-0fdf-a100-7e885f8d8916@redhat.com>
Date: Fri, 4 Jan 2019 20:58:09 +0100
MIME-Version: 1.0
In-Reply-To: <20181227063419.12981-24-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 23/25] x86_64-softmmu.mak: remove
 i386-softmmu.mak include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, sameo@linux.intel.com, ehabkost@redhat.com, peter.maydell@linaro.org

On 2018-12-27 07:34, Yang Zhong wrote:
> Only keep same boards definitions as i386-softmmu.mak in
> x86_64-softmmu.mak.
> 
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  default-configs/x86_64-softmmu.mak | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/default-configs/x86_64-softmmu.mak b/default-configs/x86_64-softmmu.mak
> index 64b2ee2960..0c69c2930c 100644
> --- a/default-configs/x86_64-softmmu.mak
> +++ b/default-configs/x86_64-softmmu.mak
> @@ -1,3 +1,7 @@
>  # Default configuration for x86_64-softmmu
>  
> -include i386-softmmu.mak
> +# Boards:
> +#
> +CONFIG_ISAPC=y
> +CONFIG_I440FX=y
> +CONFIG_Q35=y

Not sure whether this patch is really necessary since the two configs
are currently really the same. Anyway, in case you want to keep the patch:

Reviewed-by: Thomas Huth <thuth@redhat.com>
