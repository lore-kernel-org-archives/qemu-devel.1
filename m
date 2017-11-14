Received: from eggs.gnu.org ([2001:4830:134:3::10]:57815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1eEaJK-00066D-RY
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 07:27:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1eEaJG-0004ID-TN
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 07:27:26 -0500
Received: from 19pmail.ess.barracuda.com ([64.235.150.244]:45326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Yongbok.Kim@mips.com>)
	id 1eEaJG-0004EB-NG
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 07:27:22 -0500
References: <20171109154645.70920-1-marcel@redhat.com>
	<c86aa3a9-6992-0f4b-1fcf-14992798a6a1@amsat.org>
From: Yongbok Kim <yongbok.kim@mips.com>
Message-ID: <187b3018-6d55-fc61-8f65-621f8494ee67@mips.com>
Date: Tue, 14 Nov 2017 12:26:49 +0000
MIME-Version: 1.0
In-Reply-To: <c86aa3a9-6992-0f4b-1fcf-14992798a6a1@amsat.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
Subject: Re: [Qemu-devel] [PATCH V5] hw/pcie-pci-bridge: restrict to X86 and
 ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Marcel
	Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org, Paul Burton <paul.burton@mips.com>
Cc: thuth@redhat.com, cohuck@redhat.com, zuban32s@gmail.com, mst@redhat.com, Paul Burton <paul.burton@imgtec.com>, Yongbok Kim <yongbok.kim@imgtec.com>

On 09/11/2017 16:43, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Marcel,
>
> Cc'ing Paul and Yongbok Since I'm not sure their Boston board could also
> use it.
>
> On 11/09/2017 12:46 PM, Marcel Apfelbaum wrote:
>> The PCIE-PCI bridge is specific to "pure" PCIe systems
>> (on QEMU we have X86 and ARM), it does not make sense to
>> have it in other archs.
>>
>> Reported-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
>> ---
>>
>> V4 -> V5
>>    - Since all other tries failed, conditioned the
>>      device on the PCIe Root Port.
>>
>> V3 -> V4:
>>   - Move the config line to pci.mak  (Thomas)
>>
>> V2 -> V3:
>>   - Another tweak in subject s/if/it (Cornelia)
>>
>> V1 -> V2:
>>   Addressed Thomas and Cornelia comments:
>>   - Conditioned the pcie-pci-bridge compilation on
>>     the PCIe Root CONFIG_PCIE_PORT
>>   - Tweaked subject PCI -> PCIe
>>
>>   Thanks,
>>   Marcel
>>
>>
>>   hw/pci-bridge/Makefile.objs | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/pci-bridge/Makefile.objs b/hw/pci-bridge/Makefile.objs
>> index 666db37da2..1b05023662 100644
>> --- a/hw/pci-bridge/Makefile.objs
>> +++ b/hw/pci-bridge/Makefile.objs
>> @@ -1,5 +1,5 @@
>> -common-obj-y +=3D pci_bridge_dev.o pcie_pci_bridge.o
>> -common-obj-$(CONFIG_PCIE_PORT) +=3D pcie_root_port.o gen_pcie_root_port=
.o
>> +common-obj-y +=3D pci_bridge_dev.o
>> +common-obj-$(CONFIG_PCIE_PORT) +=3D pcie_root_port.o gen_pcie_root_port=
.o pcie_pci_bridge.o
> KISS :)
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
>>   common-obj-$(CONFIG_PXB) +=3D pci_expander_bridge.o
>>   common-obj-$(CONFIG_XIO3130) +=3D xio3130_upstream.o xio3130_downstrea=
m.o
>>   common-obj-$(CONFIG_IOH3420) +=3D ioh3420.o
>>

Hi Marcel, Philippe.

It looks ok for MIPS Boston.

[Yongbok Kim:
 =C2=A0 tested for MIPS boston]
Tested-by: Yongbok Kim <yongbok.kim@mips.com>

Regards,
Yongbok
