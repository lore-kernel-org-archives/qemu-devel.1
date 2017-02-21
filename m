Received: from eggs.gnu.org ([2001:4830:134:3::10]:42730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cgBuS-0008Ez-3B
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:59:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cgBuR-0007qv-8H
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:59:20 -0500
References: <1487683100-16013-1-git-send-email-eric.auger@redhat.com>
	<1487683100-16013-2-git-send-email-eric.auger@redhat.com>
	<98d4d9e8-761c-76f9-ecb0-c5a4a658dfab@codeaurora.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <2dcc9002-ec06-c55e-c0a2-75d05fe05762@redhat.com>
Date: Tue, 21 Feb 2017 15:59:08 +0100
MIME-Version: 1.0
In-Reply-To: <98d4d9e8-761c-76f9-ecb0-c5a4a658dfab@codeaurora.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] vfio/platform: make the vfio-platform
 device non abstract
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sinan Kaya <okaya@codeaurora.org>, eric.auger.pro@gmail.com, peter.maydell@linaro.org, alex.williamson@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: shankerd@codeaurora.org, vikrams@codeaurora.org, agraf@suse.de, pelcan@codeaurora.org

Hi Sinan,
On 21/02/2017 15:45, Sinan Kaya wrote:
> Hi Eric,
> Thanks for the long anticipated patch.
> 
> On 2/21/2017 8:18 AM, Eric Auger wrote:
>> +    DEFINE_PROP_STRING("manufacturer", VFIOPlatformDevice, manufacturer),
>> +    DEFINE_PROP_STRING("model", VFIOPlatformDevice, model),
> 
> The OF string is not always of the format "manufacturer, model".
> 
> HIDMA for instance uses a syntax of "qcom, hidma-1.0" and "qcom, hidma-2.0".
> This syntax is used for cases where an IP gets used in multiple SOCs. 
> 
> Maybe, we should call it just compatible-string and try not to make meaning
> out of it.
> 
> Sinan
> 

in  http://www.devicetree.org/specifications-pdf I found the description
at the bottom.

I your case what would prevent from creating 2 entries in the table and
then use either in qemu cmd line?

VFIO_PLATFORM_BINDING("qcom", "hidma-1.0", add_amd_hidma_fdt_node),
VFIO_PLATFORM_BINDING("qcom", "hidma-2.0", add_amd_hidma_fdt_node),

The issue is the comma in the property is interpreted as a separator for
options, hence that choice of having 2 separate options.

Besides I will fix the CONFIG_LINUX compilation issue asap.

Thanks

Eric

"
The recommended format is "manufacturer,model", where manufacturer is a
string describing the name of the manufacturer (such as a stock ticker
symbol), and model specifies the model number.

Example:
compatible = "fsl,mpc8641-uart", "ns16550";
In this example, an operating system would first try to locate a device
driver that supported
fsl,mpc8641-uart. If a driver was not found, it would then try to locate
a driver that supported the more general ns16550 device type.
"
