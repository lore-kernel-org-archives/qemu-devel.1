Received: from eggs.gnu.org ([2001:4830:134:3::10]:35535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eAEUy-0004fH-Go
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 08:21:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eAEUt-00033h-J6
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 08:21:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eAEUt-00032c-CI
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 08:21:23 -0400
References: <20171031112457.10516.8971.stgit@pasha-VirtualBox>
	<20171031112542.10516.61105.stgit@pasha-VirtualBox>
	<7f87350f-2a29-ae49-c86a-63bc8c425937@redhat.com>
	<001601d353d1$b839eab0$28adc010$@ru>
	<2c37b9dc-3b17-8848-f9c1-cd6cf7b4c609@redhat.com>
	<001701d353d2$af3cc7b0$0db65710$@ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <918bb472-84fe-9061-0914-d3ee997488c9@redhat.com>
Date: Thu, 2 Nov 2017 13:21:09 +0100
MIME-Version: 1.0
In-Reply-To: <001701d353d2$af3cc7b0$0db65710$@ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 08/26] replay: make safe vmstop at
 record/replay
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, kraxel@redhat.com, alex.bennee@linaro.org

On 02/11/2017 13:04, Pavel Dovgalyuk wrote:
>> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
>>>>> diff --git a/migration/savevm.c b/migration/savevm.c
>>>>> index 20cebe1..41a13c0 100644
>>>>> --- a/migration/savevm.c
>>>>> +++ b/migration/savevm.c
>>>>> @@ -2143,8 +2143,8 @@ int save_snapshot(const char *name, Error **errp)
>>>>>      AioContext *aio_context;
>>>>>
>>>>>      if (!replay_can_snapshot()) {
>>>>> -        monitor_printf(mon, "Record/replay does not allow making snapshot "
>>>>> -                        "right now. Try once more later.\n");
>>>>> +        error_report("Record/replay does not allow making snapshot "
>>>>> +                     "right now. Try once more later.\n");
>>>>
>>>> Why this change?
>>>
>>> Kind of a mess in changes.
>>> It should be in patch 06 which introduce these lines.
>>> I'll fix it in the next version.
>>
>> No problem.  Remember to delete the \n too since otherwise patchew
>> complains.
> 
> Is this ok for the line over 80 symbols here?

Patchew (and checkpatch) are complaining about the \n in the string,
i.e. "later.\n" -> "later.".

Thanks,

Paolo
