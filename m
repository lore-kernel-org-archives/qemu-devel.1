Received: from eggs.gnu.org ([2001:4830:134:3::10]:39380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dUTL7-0003Zs-EL
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:42:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dUTL2-0001pb-Gm
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:42:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dUTL2-0001pS-6t
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:42:36 -0400
References: <1499237876.3041.4.camel@linux.intel.com>
	<6ad73f55-c48a-c083-e0ef-b8ac162ec989@redhat.com>
	<5233eee1-a017-ccae-3458-762c9e86902c@redhat.com>
	<20170707133949.GH10776@localhost.localdomain>
	<20170707181642-mutt-send-email-mst@kernel.org>
	<20170707180358.GA12152@localhost.localdomain>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <626ce419-8418-a4a2-88d3-b61bf20bbb32@redhat.com>
Date: Mon, 10 Jul 2017 10:42:26 +0300
MIME-Version: 1.0
In-Reply-To: <20170707180358.GA12152@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] change x86 default machine type to Q35?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>, Laszlo Ersek <lersek@redhat.com>

On 07/07/2017 21:03, Eduardo Habkost wrote:
> On Fri, Jul 07, 2017 at 06:17:57PM +0300, Michael S. Tsirkin wrote:
>> On Fri, Jul 07, 2017 at 10:39:49AM -0300, Eduardo Habkost wrote:
>>> On Wed, Jul 05, 2017 at 12:32:10PM +0300, Marcel Apfelbaum wrote:
>>>> On 05/07/2017 11:14, Thomas Huth wrote:
>>>>>    Hi,
>>>>>
>>>>
>>>> Hi,
>>>>
>>>>> On 05.07.2017 08:57, Chao Peng wrote:
>>>>>>
>>>>>> Q35 has been in QEMU for quite a while. Compared to the current default
>>>>>> i440FX, Q35 is probably not that mature and not widely used, however in
>>>>>> some case, Q35 has advantages, for example, in supporting new features.
>>>>>> For instance, we have some features require PCI-e support which is only
>>>>>> available on Q35 and some others need it for EFI support. It is of
>>>>>> course not necessary to change it as the default but if more and more
>>>>>> features have dependencies on Q35 because of requiring much more modern
>>>>>> features then I think it may be worth to do so. In such case we can have
>>>>>> more people to use it and find problems we may know or not know.
>>>>>
>>>>
>>>> Agreed
>>>>
>>>>> Yes, IMHO at one point in time, we should switch the default machine
>>>>> type to q35.
>>>>
>>>> +1
>>>>
>>>>> The i440FX is really quite old...
>>>>>
>>>>>> There are certainly some drawbacks:
>>>>>> -        Compatibility: current code or script may need adjustment
>>>>>
>>>>> That might be a real concern ...
>>>>
>>>> I am not so sure about that. Developers working on upstream projects
>>>> should expect such changes and, for our case,
>>>> modifying the command line by adding "-M pc" should not be a big deal.
>>>
>>> We could print a warning for 1 or 2 releases when users don't add
>>> a explicit "-M pc" or "-M q35" argument to qemu-system-x86_64,
>>> but:
>>>

Hi Eduardo,

>>>>
>>>> The upper layers should manage the defaults by themselves so
>>>> are not supposed to be affected.
>>>
>>> But they would be.  libvirt uses the default machine-type from
>>> QEMU.
>>
>> How about extending the command for supported machines with a
>> recommended machine type, and teaching libvirt to use that?
> 
> I don't think QEMU has enough information to decide if it should
> recommend "q35" or "pc".

We don't really need a complicated rule set, we would just recommend q35
by default. Libvirt will try to create the default machine and if fails
for some reason (what would it be?) it can switch to PC.

The advanced logic would be "old systems should use PC", where old
means Windows XP and before and so on. But this logic should appear
in management layers above.

Thanks,
Marcel




> 
