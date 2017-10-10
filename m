Received: from eggs.gnu.org ([2001:4830:134:3::10]:53890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e21IS-00062w-Bv
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 16:38:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e21IP-0005o0-9K
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 16:38:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39856
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e21IP-0005nn-36
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 16:38:33 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9AKZLeC029310
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 16:38:30 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dh37df13w-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 16:38:29 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 10 Oct 2017 14:38:28 -0600
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
	<20171009225623.29232-36-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 10 Oct 2017 16:38:24 -0400
MIME-Version: 1.0
In-Reply-To: <20171009225623.29232-36-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <0d977b50-b7eb-caf3-0603-c55018ec0ab8@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 35/42] tpm-tis: simplify header inclusion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: amarnath.valluri@intel.com

On 10/09/2017 06:56 PM, Marc-Andr=C3=A9 Lureau wrote:
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>


> ---
>   hw/tpm/tpm_tis.c | 13 ++++---------
>   1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index 3c8d246ac8..e7e8b112e8 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -24,17 +24,12 @@
>
>   #include "qemu/osdep.h"
>   #include "hw/isa/isa.h"
> -#include "sysemu/tpm_backend.h"
> -#include "tpm_int.h"
> -#include "sysemu/block-backend.h"
> -#include "exec/address-spaces.h"
> -#include "hw/hw.h"
> -#include "hw/i386/pc.h"
> -#include "hw/pci/pci_ids.h"
>   #include "qapi/error.h"
> -#include "qemu-common.h"
> -#include "qemu/main-loop.h"
> +
>   #include "hw/acpi/tpm.h"
> +#include "hw/pci/pci_ids.h"
> +#include "sysemu/tpm_backend.h"
> +#include "tpm_int.h"
>
>   #define TPM_TIS_NUM_LOCALITIES      5     /* per spec */
>   #define TPM_TIS_LOCALITY_SHIFT      12
