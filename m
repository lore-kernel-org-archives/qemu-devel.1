Received: from eggs.gnu.org ([2001:4830:134:3::10]:57540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dqHd3-0006kb-1V
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 07:39:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dqHcz-0002mM-Qv
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 07:39:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dqHcz-0002l3-L1
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 07:39:17 -0400
References: <20170906142658.58298-1-marcel@redhat.com>
	<20170906142658.58298-3-marcel@redhat.com>
	<20170906144958.GA7570@localhost.localdomain>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <0c764f20-16ed-5bbc-f792-e410f56f1c93@redhat.com>
Date: Fri, 8 Sep 2017 14:39:04 +0300
MIME-Version: 1.0
In-Reply-To: <20170906144958.GA7570@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/pcie: disable IO port fwd by
 default for pcie-root-port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net, Laine Stump <laine@redhat.com>, Alexander Bezzubikov <zuban32s@gmail.com>

On 06/09/2017 17:49, Eduardo Habkost wrote:
> On Wed, Sep 06, 2017 at 05:26:58PM +0300, Marcel Apfelbaum wrote:
>> For most cases the devices attached to PCIe Root Ports
>> do not need IO ports range, add an 'enable-io-fwd' property
>> making it false by default, but keeping it true for older machines.
>>
>> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
> [...]
>> @@ -78,6 +111,7 @@ static const VMStateDescription vmstate_rp_dev = {
>>   
>>   static Property gen_rp_props[] = {
>>       DEFINE_PROP_BOOL("x-migrate-msix", GenPCIERootPort, migrate_msix, true),
>> +    DEFINE_PROP_BOOL("enable-io-fwd", GenPCIERootPort, enable_io_fwd, false),
> 

Hi Eduardo,

> There's no "x-" prefix, so I guess we really need to let the user
> or management software to set enable-io-fwd=on explicitly on some
> cases?
> 

Definitely. Specifically 2 cases:
  - attach PCIe-PCI bridge to start a legacy PCI hierarchy.
  - assign a device requiring IO ports range.

Thanks,
Marcel
