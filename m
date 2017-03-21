Received: from eggs.gnu.org ([2001:4830:134:3::10]:57949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1cq7tn-0005ZO-Ua
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 20:43:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1cq7tk-00065J-RE
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 20:43:43 -0400
Received: from mga02.intel.com ([134.134.136.20]:47672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tianyu.lan@intel.com>)
	id 1cq7tk-00063m-F8
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 20:43:40 -0400
References: <1489750157-17401-1-git-send-email-tianyu.lan@intel.com>
	<1489750157-17401-2-git-send-email-tianyu.lan@intel.com>
	<20170320194953.GF2811@thinpad.lan.raisama.net>
From: Lan Tianyu <tianyu.lan@intel.com>
Message-ID: <dc4f31ad-ab68-1576-5e75-f49447be8f6f@intel.com>
Date: Tue, 21 Mar 2017 08:36:04 +0800
MIME-Version: 1.0
In-Reply-To: <20170320194953.GF2811@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 1/4] I440: Allow adding sysbus devices
 with -device on I440
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, chao.gao@intel.com, kevin.tian@intel.com, pbonzini@redhat.com, rth@twiddle.net, mst@redhat.com

Hi Eduardo:
	Thanks for your review.
On 2017年03月21日 03:49, Eduardo Habkost wrote:
> On Fri, Mar 17, 2017 at 07:29:14PM +0800, Lan Tianyu wrote:
>> From: Chao Gao <chao.gao@intel.com>
>>
>> xen-viommu will be a sysbus device and the device model will
>> be enabled via "-device" parameter.
>>
>> Signed-off-by: Chao Gao <chao.gao@intel.com>
>> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> 
> I'm worried about the bugs we may expose by accepting all the
> other sysbus devices in the command-line in addition to
> xen-viommu.
> 
> I am working on a RFC to replace "has_dynamic_sysbus" with a
> whitelist of sysbus device classes. This way we could enable only
> xen-viommu on i440fx, instead of suddenly enabling all sysbus
> devices just because of xen-viommu.

That sounds reasonable. Thanks for the job and we rebase on your patches.



> 
>> ---
>>  hw/i386/pc_piix.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>> index a07dc81..3289593 100644
>> --- a/hw/i386/pc_piix.c
>> +++ b/hw/i386/pc_piix.c
>> @@ -436,6 +436,7 @@ static void pc_i440fx_machine_options(MachineClass *m)
>>      m->hot_add_cpu = pc_hot_add_cpu;
>>      m->default_machine_opts = "firmware=bios-256k.bin";
>>      m->default_display = "std";
>> +    m->has_dynamic_sysbus = true;
>>  }
>>  
>>  static void pc_i440fx_2_7_machine_options(MachineClass *m)
>> -- 
>> 1.8.3.1
>>
> 


-- 
Best regards
Tianyu Lan
