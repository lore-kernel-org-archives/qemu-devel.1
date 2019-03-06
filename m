Received: from eggs.gnu.org ([209.51.188.92]:37910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1h1Z85-00057n-N0
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 11:10:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1h1Z84-0002Rd-Jb
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 11:10:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1h1Z84-0002R6-6m
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 11:10:48 -0500
Date: Wed, 6 Mar 2019 17:10:41 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190306171041.0bb86044@Igors-MacBook-Pro.local>
In-Reply-To: <20190227075101.6263-4-richardw.yang@linux.intel.com>
References: <20190227075101.6263-1-richardw.yang@linux.intel.com>
	<20190227075101.6263-4-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/4] nvdimm: use NVDIMM_ACPI_IO_LEN for the
 proper IO size
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

On Wed, 27 Feb 2019 15:51:00 +0800
Wei Yang <richardw.yang@linux.intel.com> wrote:

> The IO range is defined to 4 bytes with NVDIMM_ACPI_IO_LEN, so it is
> more proper to use this macro instead of calculating it by sizeof.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/nvdimm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
> index e63a1ef15d..2457c1aa44 100644
> --- a/hw/acpi/nvdimm.c
> +++ b/hw/acpi/nvdimm.c
> @@ -992,7 +992,7 @@ static void nvdimm_build_common_dsm(Aml *dev)
>      field = aml_field(NVDIMM_DSM_IOPORT, AML_DWORD_ACC, AML_NOLOCK,
>                        AML_PRESERVE);
>      aml_append(field, aml_named_field(NVDIMM_DSM_NOTIFY,
> -               sizeof(uint32_t) * BITS_PER_BYTE));
> +               NVDIMM_ACPI_IO_LEN * BITS_PER_BYTE));
>      aml_append(method, field);
>  
>      /*
