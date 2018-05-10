Received: from eggs.gnu.org ([2001:4830:134:3::10]:42607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fGlHd-000188-Pz
	for qemu-devel@nongnu.org; Thu, 10 May 2018 09:06:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fGlHZ-0006uK-Qn
	for qemu-devel@nongnu.org; Thu, 10 May 2018 09:06:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58668 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fGlHZ-0006tQ-Ly
	for qemu-devel@nongnu.org; Thu, 10 May 2018 09:06:53 -0400
Date: Thu, 10 May 2018 15:06:51 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180510150651.2abd4a50@redhat.com>
In-Reply-To: <20180427215314.23168-1-ross.zwisler@linux.intel.com>
References: <20180427215314.23168-1-ross.zwisler@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] nvdimm: fix typo in label-size
 definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Haozhong Zhang <haozhong.zhang@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, linux-nvdimm <linux-nvdimm@lists.01.org>

On Fri, 27 Apr 2018 15:53:12 -0600
Ross Zwisler <ross.zwisler@linux.intel.com> wrote:

> Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> Fixes: commit da6789c27c2e ("nvdimm: add a macro for property "label-size"")
> Cc: Haozhong Zhang <haozhong.zhang@intel.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/mem/nvdimm.c         | 2 +-
>  include/hw/mem/nvdimm.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
> index acb656b672..4087aca25e 100644
> --- a/hw/mem/nvdimm.c
> +++ b/hw/mem/nvdimm.c
> @@ -89,7 +89,7 @@ static void nvdimm_set_unarmed(Object *obj, bool value, Error **errp)
>  
>  static void nvdimm_init(Object *obj)
>  {
> -    object_property_add(obj, NVDIMM_LABLE_SIZE_PROP, "int",
> +    object_property_add(obj, NVDIMM_LABEL_SIZE_PROP, "int",
>                          nvdimm_get_label_size, nvdimm_set_label_size, NULL,
>                          NULL, NULL);
>      object_property_add_bool(obj, NVDIMM_UNARMED_PROP,
> diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
> index 7fd87c4e1c..74c60332e1 100644
> --- a/include/hw/mem/nvdimm.h
> +++ b/include/hw/mem/nvdimm.h
> @@ -48,7 +48,7 @@
>  #define NVDIMM_GET_CLASS(obj) OBJECT_GET_CLASS(NVDIMMClass, (obj), \
>                                                 TYPE_NVDIMM)
>  
> -#define NVDIMM_LABLE_SIZE_PROP "label-size"
> +#define NVDIMM_LABEL_SIZE_PROP "label-size"
>  #define NVDIMM_UNARMED_PROP    "unarmed"
>  
>  struct NVDIMMDevice {
