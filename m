Received: from eggs.gnu.org ([209.51.188.92]:58172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gj1cN-0004iK-Qm
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:45:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gj1cK-0004cI-4L
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:45:27 -0500
Received: from m50-110.126.com ([123.125.50.110]:35718)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gj1cD-0004Uw-Io
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:45:19 -0500
References: <20190113143641.38936-1-lifei1214@126.com>
	<20190114033130.GE24343@xz-x1> <87va2rwwlc.fsf@dusky.pond.sub.org>
	<20190114071846.GF24343@xz-x1>
	<64212cc6-47aa-78ae-20cb-d75c5fade03a@redhat.com>
From: Fei Li <lifei1214@126.com>
Message-ID: <fa23eb07-96c1-ea0f-f1a8-63141c4879c8@126.com>
Date: Mon, 14 Jan 2019 20:45:02 +0800
MIME-Version: 1.0
In-Reply-To: <64212cc6-47aa-78ae-20cb-d75c5fade03a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/misc/edu: add msi_uninit() for
 pci_edu_uninit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: shirley17fei@gmail.com, qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>


在 2019/1/14 下午6:40, Philippe Mathieu-Daudé 写道:
> On 1/14/19 8:18 AM, Peter Xu wrote:
>> On Mon, Jan 14, 2019 at 08:02:23AM +0100, Markus Armbruster wrote:
>>> Peter Xu <peterx@redhat.com> writes:
>>>
>>>> On Sun, Jan 13, 2019 at 10:36:41PM +0800, Fei Li wrote:
>>>>> From: Fei Li <shirley17fei@gmail.com>
>>>>>
>>>>> Let's supplement the msi_uninit() when failing to realize
>>>>> the pci edu device.
>>>>>
>>>>> Cc: Markus Armbruster <armbru@redhat.com>
>>>>> Cc: Peter Xu <peterx@redhat.com>
>>>>> Cc: Michael S. Tsirkin <mst@redhat.com>
>>>>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>>>>> Signed-off-by: Fei Li <shirley17fei@gmail.com>
>>>>> ---
>>>>>   hw/misc/edu.c | 1 +
>>>>>   1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/hw/misc/edu.c b/hw/misc/edu.c
>>>>> index cdcf550dd7..4feb7503de 100644
>>>>> --- a/hw/misc/edu.c
>>>>> +++ b/hw/misc/edu.c
>>>>> @@ -367,6 +367,7 @@ static void pci_edu_uninit(PCIDevice *pdev)
>>>>>   {
>>>>>       EduState *edu = EDU(pdev);
>>>>>   
>>>>> +    msi_uninit(pdev);
>>>> It would be cleaner to me to call this after the join() since
>>>> edu_fact_thread() could potentially use msi_*() helpers then the
>>>> destructions follow the reverse order of init.
>>> Destruction in reverse creation order is good practice.
>>>
>>> This being the "QEMU educational PCI device", good practice is even more
>>> desirable.
>> Very persuasive.  With that, I'd like to withdraw my excuse of
>> "msi_uninit() is optional" too. :)
>>
>> Fei, please feel free to pick my r-b if you want to repost, and IMHO
>> you can also add:
>>
>> Reported-by: Markus Armbruster <armbru@redhat.com>
>>
>> Thanks,
>>
> Moving msi_uninit() after timer_del():
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Ok, thanks all!

Will do the update and send a new version soon.

Have a nice day
Fei
