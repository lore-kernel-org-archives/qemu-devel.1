Received: from eggs.gnu.org ([2001:4830:134:3::10]:46471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1e7tbj-0000mh-Af
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 21:38:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1e7tbf-0005ee-E8
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 21:38:47 -0400
Received: from mga07.intel.com ([134.134.136.100]:38285)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tianyu.lan@intel.com>)
	id 1e7tbf-0005cp-3Q
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 21:38:43 -0400
References: <1502842933-8323-1-git-send-email-tianyu.lan@intel.com>
	<34042934-782b-6bcc-b9b2-de7a1816cfb7@redhat.com>
	<3ababa62-f055-5bbb-b9b9-c55ada8368dd@intel.com>
	<20170818163854.GY3108@localhost.localdomain>
	<471a4bdc-d381-4a70-0107-3150df6f5cf6@intel.com>
	<20171026121943.GB26955@localhost.localdomain>
	<20171026172631-mutt-send-email-mst@kernel.org>
From: Lan Tianyu <tianyu.lan@intel.com>
Message-ID: <a30bfc99-5bc4-0cdc-5eba-e1df1b2667f8@intel.com>
Date: Fri, 27 Oct 2017 09:30:59 +0800
MIME-Version: 1.0
In-Reply-To: <20171026172631-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] x86: Skip check apic_id_limit for Xen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, anthony.perard@citrix.com, Paolo Bonzini <pbonzini@redhat.com>, rth@twiddle.net

On 2017年10月26日 22:27, Michael S. Tsirkin wrote:
> On Thu, Oct 26, 2017 at 02:19:43PM +0200, Eduardo Habkost wrote:
>> On Mon, Aug 21, 2017 at 10:22:15AM +0800, Lan Tianyu wrote:
>>> On 2017年08月19日 00:38, Eduardo Habkost wrote:
>>>> On Thu, Aug 17, 2017 at 09:37:10AM +0800, Lan Tianyu wrote:
>>>>> On 2017年08月16日 19:21, Paolo Bonzini wrote:
>>>>>> On 16/08/2017 02:22, Lan Tianyu wrote:
>>>>>>> Xen vIOMMU device model will be in Xen hypervisor. Skip vIOMMU
>>>>>>> check for Xen here when vcpu number is more than 255.
>>>>>>
>>>>>> I think you still need to do a check for vIOMMU being enabled.
>>>>>
>>>>> Yes, this will be done in the Xen tool stack and Qemu doesn't have such
>>>>> knowledge. Operations of create, destroy Xen vIOMMU will be done in the
>>>>> Xen tool stack.
>>>>
>>>> Shouldn't we make QEMU have knowledge of the vIOMMU device, then?
>>>> Won't QEMU need to know about it eventually?
>>>>
>>>
>>> Hi Eduardo:
>>>      Thanks for your review.
>>>      Xen has some guest modes which doesn't use Qemu and we tried to
>>> make Xen vIOMMU framework compatible with all guest modes. So far, we
>>> are adding interrupt remapping function for Xen vIOMMU and find qemu
>>> doesn't need to know Xen vIOMMU. The check of vcpu number > 255 here
>>> will be done in Xen side and so skip the check in Qemu to avoid blocking
>>> Xen creating >255 vcpus.
>>>      We may make Qemu have knowledge of the vIOMMU device if it's
>>> necessary when adding new function.
>>
>> I was expecting it to go through the PC tree, but I will queue it
>> on x86-next instead.
> 
> I was waiting for an ack from you or Paolo as you participated in the
> discussion. But sure, go ahead
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 

Great. Thanks.
-- 
Best regards
Tianyu Lan
