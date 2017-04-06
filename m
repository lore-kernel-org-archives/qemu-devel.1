Received: from eggs.gnu.org ([2001:4830:134:3::10]:48998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cw3oL-0002CW-2L
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 05:34:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cw3oG-0003v6-6U
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 05:34:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60152)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1cw3oG-0003uk-0O
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 05:34:32 -0400
References: <20170404202429.14643-1-ehabkost@redhat.com>
	<20170404202429.14643-5-ehabkost@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <5b8d32db-4de2-f82e-fa2e-a5ed806428e4@redhat.com>
Date: Thu, 6 Apr 2017 12:34:25 +0300
MIME-Version: 1.0
In-Reply-To: <20170404202429.14643-5-ehabkost@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 04/21] iommu: Remove FIXME comment about
 user_creatable=true
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 04/04/2017 11:24 PM, Eduardo Habkost wrote:
> amd-iommu and intel-iommu are really meant to be used with
> -device, so they need user_creatable=true. Remove the FIXME
> comment.
>
> Cc: Marcel Apfelbaum <marcel@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
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
> index d71d52c328..b14db306ef 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -2601,10 +2601,7 @@ static void vtd_class_init(ObjectClass *klass, void *data)
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
>

Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

Thanks,
Marcel
