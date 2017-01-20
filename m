Received: from eggs.gnu.org ([2001:4830:134:3::10]:34566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cUSDG-0000Qc-WF
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 00:58:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cUSDD-0005i7-UG
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 00:58:15 -0500
Received: from [59.151.112.132] (port=39013 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cUSDD-0005h4-HZ
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 00:58:11 -0500
References: <1483175588-17006-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<1483175588-17006-5-git-send-email-caoj.fnst@cn.fujitsu.com>
	<20170118153621.75d8b83d@t450s.home>
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <5881A858.2020203@cn.fujitsu.com>
Date: Fri, 20 Jan 2017 14:04:08 +0800
MIME-Version: 1.0
In-Reply-To: <20170118153621.75d8b83d@t450s.home>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v11 4/4] vfio: add 'aer' property to
 expose aercap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, izumi.taku@jp.fujitsu.com, Dou Liyang <douly.fnst@cn.fujitsu.com>



On 01/19/2017 06:36 AM, Alex Williamson wrote:
> On Sat, 31 Dec 2016 17:13:08 +0800
> Cao jin <caoj.fnst@cn.fujitsu.com> wrote:
> 
>> From: Chen Fan <chen.fan.fnst@cn.fujitsu.com>
>>
>> Add 'aer' property, let user choose whether expose the aer capability
>> or not.
> 
> But that's not what it does, it only controls the behavior in response
> to non-fatal errors, the capability is exposed regardless.
> 

This commit log is legacy, and defaults to off is a result of the
configuration restriction & your previous discussion, right?

In current version, if 'aer' property is off, we just allocate the
config space via pcie_add_capability(), we don't init the AER
capability, the value is all 0s there, so does that still mean
"capability is exposed regardless"?

>> Should disable aer feature by default, because only non-fatal
>> error is supported now. 
> 
> Why does that mean it should be disabled by default?  What bad thing
> happens if we enable this opportunistically?
> 
>> Signed-off-by: Chen Fan <chen.fan.fnst@cn.fujitsu.com>
>> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
>> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
>> ---
>>  hw/vfio/pci.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 9861f72..fc9db66 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -3057,6 +3057,8 @@ static Property vfio_pci_dev_properties[] = {
>>      DEFINE_PROP_UINT32("x-pci-sub-device-id", VFIOPCIDevice,
>>                         sub_device_id, PCI_ANY_ID),
>>      DEFINE_PROP_UINT32("x-igd-gms", VFIOPCIDevice, igd_gms, 0),
>> +    DEFINE_PROP_BIT("aer", VFIOPCIDevice, features,
>> +                    VFIO_FEATURE_ENABLE_AER_BIT, false),
>>      /*
>>       * TODO - support passed fds... is this necessary?
>>       * DEFINE_PROP_STRING("vfiofd", VFIOPCIDevice, vfiofd_name),
> 
> 
> 
> .
> 

-- 
Sincerely,
Cao jin
