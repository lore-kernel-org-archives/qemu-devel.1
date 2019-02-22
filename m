Received: from eggs.gnu.org ([209.51.188.92]:33047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gxD46-0002Fa-36
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:48:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gxD44-0000Op-6O
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:48:41 -0500
Date: Fri, 22 Feb 2019 16:48:14 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190222164814.10411186@redhat.com>
In-Reply-To: <20190220224003.4420-18-eric.auger@redhat.com>
References: <20190220224003.4420-1-eric.auger@redhat.com>
	<20190220224003.4420-18-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 17/17] hw/arm/virt: Add nvdimm and
 nvdimm-persistence options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, david@redhat.com, dgilbert@redhat.com, david@gibson.dropbear.id.au, drjones@redhat.com, Shivaprasad G Bhat <sbhat@linux.ibm.com>

On Wed, 20 Feb 2019 23:40:03 +0100
Eric Auger <eric.auger@redhat.com> wrote:

> Machine option nvdimm allows to turn NVDIMM support on.

With virt-arm and spapr[1] trying to add nvdimm, I think it's time
to generalize and move acpi_nvdimm_state to generic Machine
instead of duplicating the same code in several machines.

1) [RFC PATCH 3/4] spapr: Add NVDIMM device support

> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
[...]
