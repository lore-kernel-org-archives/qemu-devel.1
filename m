Received: from eggs.gnu.org ([2001:4830:134:3::10]:34242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cw31q-0007b4-OT
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 04:44:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cw31m-00052t-Rq
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 04:44:30 -0400
Received: from [59.151.112.132] (port=61590 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cw31m-00050Q-Ep
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 04:44:26 -0400
References: <58DA6954.2000601@cn.fujitsu.com>
	<20170328101233.74f50a92@t450s.home>
	<20170329000148.GA18849@redhat.com>
	<20170328205513.21b97381@t450s.home>
	<20170330205823-mutt-send-email-mst@kernel.org>
	<20170330121652.2ac8fa62@t450s.home> <58E4B0C9.50109@cn.fujitsu.com>
	<20170405133822.76cda620@t450s.home>
	<20170406004845-mutt-send-email-mst@kernel.org>
	<20170405161910.26fee7d1@t450s.home>
	<20170406013534-mutt-send-email-mst@kernel.org>
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <58E60218.4040500@cn.fujitsu.com>
Date: Thu, 6 Apr 2017 16:53:44 +0800
MIME-Version: 1.0
In-Reply-To: <20170406013534-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6] vfio error recovery: kernel support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, izumi.taku@jp.fujitsu.com



On 04/06/2017 06:36 AM, Michael S. Tsirkin wrote:
> On Wed, Apr 05, 2017 at 04:19:10PM -0600, Alex Williamson wrote:
>> On Thu, 6 Apr 2017 00:50:22 +0300
>> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>>
>>> On Wed, Apr 05, 2017 at 01:38:22PM -0600, Alex Williamson wrote:
>>>> The previous intention of trying to handle all sorts of AER faults
>>>> clearly had more value, though even there the implementation and
>>>> configuration requirements restricted the practicality.  For instance
>>>> is AER support actually useful to a customer if it requires all ports
>>>> of a multifunction device assigned to the VM?  This seems more like a
>>>> feature targeting whole system partitioning rather than general VM
>>>> device assignment use cases.  Maybe that's ok, but it should be a clear
>>>> design decision.  
>>>
>>> Alex, what kind of testing do you expect to be necessary?
>>> Would you say testing on real hardware and making it trigger
>>> AER errors is a requirement?
>>
>> Testing various fatal, non-fatal, and corrected errors with aer-inject,
>> especially in multfunction configurations (where more than one port
>> is actually usable) would certainly be required.  If we have cases where
>> the driver for a companion function can escalate a non-fatal error to a
>> bus reset, that should be tested, even if it requires temporary hacks to
>> the host driver for the companion function to trigger that case.  AER
>> handling is not something that the typical user is going to experience,
>> so it should to be thoroughly tested to make sure it works when needed
>> or there's little point to doing it at all.  Thanks,
>>
>> Alex
> 
> Some things can be tested within a VM. What would you
> say would be sufficient on a VM and what has to be
> tested on bare metal?
> 

Does the "bare metal" here mean something like XenServer?
-- 
Sincerely,
Cao jin
