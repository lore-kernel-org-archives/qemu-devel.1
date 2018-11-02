Received: from eggs.gnu.org ([2001:4830:134:3::10]:45296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gIe0f-00011P-Fz
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 14:17:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gIe0e-0002eN-EZ
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 14:17:29 -0400
References: <ae2d0fbd-5198-47e8-9ad2-40a85f0b3576@default>
	<ad9227ab-bcce-1703-e6aa-a7b14907868b@redhat.com>
	<e9a68107-ccde-337d-25f2-5636c8a89f19@amazon.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <156d16ca-1e89-1b00-cba4-bfcfc100f9c4@redhat.com>
Date: Fri, 2 Nov 2018 14:17:10 -0400
MIME-Version: 1.0
In-Reply-To: <e9a68107-ccde-337d-25f2-5636c8a89f19@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] How to emulate block I/O timeout on qemu side?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marc Olson <marcolso@amazon.com>, Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org
Cc: Qemu-block <qemu-block@nongnu.org>



On 11/02/2018 01:55 PM, Marc Olson wrote:
> On 11/2/18 10:49 AM, John Snow wrote:
>> On 11/02/2018 04:11 AM, Dongli Zhang wrote:
>>> Hi,
>>>
>>> Is there any way to emulate I/O timeout on qemu side (not fault
>>> injection in VM
>>> kernel) without modifying qemu source code?
>>>
>>> For instance, I would like to observe/study/debug the I/O timeout
>>> handling of
>>> nvme, scsi, virtio-blk (not supported) of VM kernel.
>>>
>>> Is there a way to trigger this on purpose on qemu side?
>>>
>>> Thank you very much!
>>>
>>> Dongli Zhang
>>>
>> I don't think the blkdebug driver supports arbitrary delays right now.
>> Maybe we could augment it to do so?
>>
>> (I thought someone already had, but maybe it wasn't merged?)
>>
>> Aha, here:
>>
>> https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg05297.html
>> V2: https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg00394.html
>>
>> Let's work from there.
> 
> I've got updates to that patch series that fell on the floor due to
> other competing things. I'll get some screen time this weekend to work
> on them and submit v3.
> 
> /marc
> 

Great! Please CC the usual maintainers, but also include me.

In the meantime, Dongli Zhang, why don't you try the v2 patch and see if
that helps you out for your use case? Report back if it works for you or
not.

--js
