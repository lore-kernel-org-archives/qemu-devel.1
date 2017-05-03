Received: from eggs.gnu.org ([2001:4830:134:3::10]:58335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1d61DQ-0005lv-Ou
	for qemu-devel@nongnu.org; Wed, 03 May 2017 16:49:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1d61DP-0006oT-TI
	for qemu-devel@nongnu.org; Wed, 03 May 2017 16:49:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1d61DP-0006nb-Mp
	for qemu-devel@nongnu.org; Wed, 03 May 2017 16:49:39 -0400
Date: Wed, 3 May 2017 23:49:35 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170503234930-mutt-send-email-mst@kernel.org>
References: <20170503203604.31462-1-ehabkost@redhat.com>
	<20170503203604.31462-5-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170503203604.31462-5-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RESEND v2 04/21] iommu: Remove FIXME
 comment about user_creatable=true
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>, Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On Wed, May 03, 2017 at 05:35:47PM -0300, Eduardo Habkost wrote:
> amd-iommu and intel-iommu are really meant to be used with
> -device, so they need user_creatable=true. Remove the FIXME
> comment.
> 
> Cc: Marcel Apfelbaum <marcel@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
> Acked-by: Marcel Apfelbaum <marcel@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> Changes v1 -> v2:
> * (none)
> ---
>  hw/i386/amd_iommu.c   | 5 +----
>  hw/i386/intel_iommu.c | 5 +----
>  2 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 7b92c8c15a..efcc93cbfd 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -1186,10 +1186,7 @@ static void amdvi_class_init(ObjectClass *klass, void* data)
>      dc->vmsd = &vmstate_amdvi;
>      dc->hotpluggable = false;
>      dc_class->realize = amdvi_realize;
> -    /*
> -     * FIXME: Set only because we are not sure yet if this device
> -     * will be outside the q35 sysbus whitelist.
> -     */
> +    /* Supported by the pc-q35-* machine types */
>      dc->user_creatable = true;
>  }
>  
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 54187a04a4..327a46cd19 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3009,10 +3009,7 @@ static void vtd_class_init(ObjectClass *klass, void *data)
>      dc->hotpluggable = false;
>      x86_class->realize = vtd_realize;
>      x86_class->int_remap = vtd_int_remap;
> -    /*
> -     * FIXME: Set only because we are not sure yet if this device
> -     * will be outside the q35 sysbus whitelist.
> -     */
> +    /* Supported by the pc-q35-* machine types */
>      dc->user_creatable = true;
>  }
>  
> -- 
> 2.11.0.259.g40922b1
