Received: from eggs.gnu.org ([2001:4830:134:3::10]:54292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1dvQS6-0001JG-4H
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:05:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1dvQS2-0002Kx-3X
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:05:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34316
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1dvQS1-0002KU-Ta
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:05:14 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8MG4MGK009737
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 12:05:10 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2d53j0rk0x-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 12:05:10 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 22 Sep 2017 10:05:09 -0600
References: <20170922154014.29350-1-f4bug@amsat.org>
	<20170922154014.29350-17-f4bug@amsat.org>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 22 Sep 2017 12:05:04 -0400
MIME-Version: 1.0
In-Reply-To: <20170922154014.29350-17-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <c7f95a1e-3153-9ecb-b6a7-f88f391980e6@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 16/34] hw/tpm: remove old i386 dependency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Amarnath Valluri <amarnath.valluri@intel.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On 09/22/2017 11:39 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

> ---
>   hw/tpm/tpm_passthrough.c | 1 -
>   hw/tpm/tpm_tis.c         | 1 -
>   2 files changed, 2 deletions(-)
>
> diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
> index 9234eb3459..461f551a0c 100644
> --- a/hw/tpm/tpm_passthrough.c
> +++ b/hw/tpm/tpm_passthrough.c
> @@ -29,7 +29,6 @@
>   #include "sysemu/tpm_backend.h"
>   #include "tpm_int.h"
>   #include "hw/hw.h"
> -#include "hw/i386/pc.h"
>   #include "sysemu/tpm_backend_int.h"
>   #include "tpm_tis.h"
>   #include "tpm_util.h"
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index a6440fef91..a3a93f7229 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -28,7 +28,6 @@
>   #include "sysemu/block-backend.h"
>   #include "exec/address-spaces.h"
>   #include "hw/hw.h"
> -#include "hw/i386/pc.h"
>   #include "hw/pci/pci_ids.h"
>   #include "tpm_tis.h"
>   #include "qapi/error.h"
