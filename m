Received: from eggs.gnu.org ([209.51.188.92]:43353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gpDjk-0003IX-6s
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 09:54:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gpDji-0006gO-9w
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 09:54:40 -0500
References: <1548942810-22942-1-git-send-email-thuth@redhat.com>
	<1548942810-22942-2-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4f2aa5e2-8aef-49d2-8497-74fb29082b51@redhat.com>
Date: Thu, 31 Jan 2019 15:54:30 +0100
MIME-Version: 1.0
In-Reply-To: <1548942810-22942-2-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/5] ppc64: Express dependencies of
 'pseries' and 'powernv' machines with kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, yang.zhong@intel.com

On 31/01/19 14:53, Thomas Huth wrote:

>  config PSERIES
>      bool
> +    select DIMM
> +    select PCI
> +    select VFIO
> +    select XICS_SPAPR
> +    select XIVE_SPAPR

Missing "select SPAPR_VSCSI", added it locally.

> 
>  config POWERNV
>      bool
> +    select ISA_IPMI_BT
> +    select ISA_BUS
> +    select MC146818RTC
> +    select XICS
> +    select XIVE
>  

Missing "select IPMI_LOCAL" for

/home/pbonzini/work/upstream/qemu/hw/ppc/pnv_bmc.c:67: undefined
reference to `ipmi_bmc_gen_event'
hw/ppc/pnv_bmc.o: In function `pnv_dt_bmc_sensors':
/home/pbonzini/work/upstream/qemu/hw/ppc/pnv_bmc.c:95: undefined
reference to `ipmi_bmc_sdr_find'

added it locally too.

Paolo
