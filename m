Received: from eggs.gnu.org ([209.51.188.92]:37565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gxDDd-0002sS-3N
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:58:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gxDDc-0005ij-A5
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:58:33 -0500
References: <20190220224003.4420-1-eric.auger@redhat.com>
	<20190220224003.4420-18-eric.auger@redhat.com>
	<20190222164814.10411186@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <e188c7e9-633b-f80c-6ca3-45c5886a0134@redhat.com>
Date: Fri, 22 Feb 2019 16:57:40 +0100
MIME-Version: 1.0
In-Reply-To: <20190222164814.10411186@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: peter.maydell@linaro.org, drjones@redhat.com, Shivaprasad G Bhat <sbhat@linux.ibm.com>, david@redhat.com, qemu-devel@nongnu.org, shameerali.kolothum.thodi@huawei.com, dgilbert@redhat.com, qemu-arm@nongnu.org, david@gibson.dropbear.id.au, eric.auger.pro@gmail.com

Hi Igor,

On 2/22/19 4:48 PM, Igor Mammedov wrote:
> On Wed, 20 Feb 2019 23:40:03 +0100
> Eric Auger <eric.auger@redhat.com> wrote:
> 
>> Machine option nvdimm allows to turn NVDIMM support on.
> 
> With virt-arm and spapr[1] trying to add nvdimm, I think it's time
> to generalize and move acpi_nvdimm_state to generic Machine
> instead of duplicating the same code in several machines.

OK I will go this way

Thanks a lot for your time!

Best Regards

Eric
> 
> 1) [RFC PATCH 3/4] spapr: Add NVDIMM device support
> 
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
> [...]
> 
> 
