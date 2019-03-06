Received: from eggs.gnu.org ([209.51.188.92]:36421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1h1Z07-0001YP-Pt
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 11:02:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1h1Z07-0006Id-5S
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 11:02:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42214)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1h1Z06-0006HS-SF
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 11:02:35 -0500
Date: Wed, 6 Mar 2019 17:02:27 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190306170227.1268caa2@Igors-MacBook-Pro.local>
In-Reply-To: <20190227075101.6263-3-richardw.yang@linux.intel.com>
References: <20190227075101.6263-1-richardw.yang@linux.intel.com>
	<20190227075101.6263-3-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/4] nvdimm: use *function* directly
 instead of allocating it again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, xiaoguangrong.eric@gmail.com

On Wed, 27 Feb 2019 15:50:59 +0800
Wei Yang <richardw.yang@linux.intel.com> wrote:

> At the beginning or nvdimm_build_common_dsm(), variable *function* is
> already allocated for Arg2.
> 
> This patch reuse variable *function* instead of allocating it again.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  hw/acpi/nvdimm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
> index 39af8cdba8..e63a1ef15d 100644
> --- a/hw/acpi/nvdimm.c
> +++ b/hw/acpi/nvdimm.c
> @@ -1086,7 +1086,7 @@ static void nvdimm_build_common_dsm(Aml *dev)
>       */
>      aml_append(method, aml_store(handle, aml_name(NVDIMM_DSM_HANDLE)));
>      aml_append(method, aml_store(aml_arg(1), aml_name(NVDIMM_DSM_REVISION)));
> -    aml_append(method, aml_store(aml_arg(2), aml_name(NVDIMM_DSM_FUNCTION)));
> +    aml_append(method, aml_store(function, aml_name(NVDIMM_DSM_FUNCTION)));
>  
>      /*
>       * The fourth parameter (Arg3) of _DSM is a package which contains
