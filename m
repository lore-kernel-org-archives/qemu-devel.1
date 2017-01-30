Received: from eggs.gnu.org ([2001:4830:134:3::10]:47190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1cY6yR-0004NX-F2
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 03:06:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1cY6yM-0008Bc-8z
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 03:06:03 -0500
Received: from mout.web.de ([217.72.192.78]:56655)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jan.kiszka@web.de>) id 1cY6yL-0008A9-Up
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 03:05:58 -0500
References: <8a51513f-59d7-a361-a4ef-99679aa460fb@siemens.com>
	<874m0peu50.fsf@dusky.pond.sub.org>
	<533e0b17-4d60-a584-5680-559834013c68@web.de>
	<87inp05m8m.fsf@dusky.pond.sub.org>
	<4504afce-c62e-c54f-33a3-483f16dc4530@web.de>
	<CAJ+F1C+UmEz_On1cGSrYDL0FZXqqeURV93nAvbnLA71WpNoL4w@mail.gmail.com>
	<bf19ec6d-7382-5563-2871-65a1111df691@web.de>
	<87efzlvuup.fsf@dusky.pond.sub.org>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <fb9b35ff-0676-6f79-697d-2c5b54aa9bd9@web.de>
Date: Mon, 30 Jan 2017 09:05:40 +0100
MIME-Version: 1.0
In-Reply-To: <87efzlvuup.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Towards an ivshmem 2.0?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Jailhouse <jailhouse-dev@googlegroups.com>, Wei Wang <wei.w.wang@intel.com>, qemu-devel <qemu-devel@nongnu.org>

On 2017-01-30 09:02, Markus Armbruster wrote:
> Jan Kiszka <jan.kiszka@web.de> writes:
> 
>> On 2017-01-29 15:00, Marc-André Lureau wrote:
>>> Hi
>>>
>>> On Sun, Jan 29, 2017 at 12:44 PM Jan Kiszka <jan.kiszka@web.de
>>> <mailto:jan.kiszka@web.de>> wrote:
>>>
>>>     >> Of course, I'm careful with investing much time into expanding the
>>>     >> existing, for Jailhouse possibly sufficient design if there no real
>>>     >> interest in continuing the ivshmem support in QEMU - because of
>>>     >> vhost-pci or other reasons. But if that interest exists, it would be
>>>     >> beneficial for us to have QEMU supporting a compatible version
>>>     and using
>>>     >> the same guest drivers. Then I would start looking into concrete
>>>     patches
>>>     >> for it as well.
>>>     >
>>>     > Interest is difficult for me to gauge, not least because alternatives
>>>     > are still being worked on.
>>>
>>>     I'm considering to suggest this as GSoC project now.
>>>
>>>
>>> It's better for a student and for the community if the work get accepted
>>> in the end.
> 
> Yes.
> 
>>> So, I think that could be an intersting GSoC (implementing your ivshmem
>>> 2 proposal). However, if the qemu community isn't ready to accept a new
>>> ivshmem, and would rather have vhost-pci based solution, I would suggest
>>> a different project (hopefully Wei Wang can help define it and mentor):
>>> work on a vhost-pci using dedicated shared PCI BARs (and kernel support
>>> to avoid extra copy - if I understand the extra copy situation correctly).
>>
>> It's still open if vhost-pci can replace ivshmem (not to speak of being
>> desirable for Jailhouse - I'm still studying). In that light, having
>> both implementations available to do real comparisons is valuable IMHO.
> 
> Yes, but is it appropriate for GSoC?
> 
>> That said, we will play with open cards, explain the student the
>> situation and let her/him decide knowingly.
> 
> Both the student and the QEMU project need to consider the situation
> carefully.
> 
>> Jan
>>
>> PS: We have a mixed history /wrt actually merging student projects.
> 
> Yes, but having screwed up is no license to screw up some more :)
> 

After having received multiple feedbacks in this direction, I will drop
that proposal from our list. So, don't worry. ;)

Jan
