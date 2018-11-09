Received: from eggs.gnu.org ([2001:4830:134:3::10]:60819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gL4W0-0002JE-FJ
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 05:59:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gL4Vu-0001Ib-DJ
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 05:59:50 -0500
References: <1541751214-17515-1-git-send-email-liq3ea@gmail.com>
	<7d20734d-f43a-957c-9cb5-4644320037aa@redhat.com>
	<fc711588-581f-515a-dbf2-62faf6ff1d2f@redhat.com>
	<57a92d57-dd52-e347-b3be-e9fefb150672@redhat.com>
	<87933d44-2ae8-f5c6-cc60-04456fb2bcff@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <1cb384f4-fc97-af81-0308-2d07ee5f3745@vivier.eu>
Date: Fri, 9 Nov 2018 11:59:23 +0100
MIME-Version: 1.0
In-Reply-To: <87933d44-2ae8-f5c6-cc60-04456fb2bcff@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw: set_netdev: remove useless code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Li Qiang <liq3ea@gmail.com>, stefanha@redhat.com, marcandre.lureau@redhat.com
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On 09/11/2018 11:00, Paolo Bonzini wrote:
> On 09/11/2018 09:29, Laurent Vivier wrote:
>> On 09/11/2018 09:26, Thomas Huth wrote:
>>> On 2018-11-09 09:21, Laurent Vivier wrote:
>>>> On 09/11/2018 09:13, Li Qiang wrote:
>>>>> In set_netdev(), the peers[i] is initialized
>>>>> qemu_find_net_clients_except() when i is in
>>>>> 0 between 'queues' it can't be NULL.
>>>>>
>>>>> Signed-off-by: Li Qiang <liq3ea@gmail.com>
>>>>> ---
>>>>>  hw/core/qdev-properties-system.c | 4 ----
>>>>>  1 file changed, 4 deletions(-)
>>>>>
>>>>> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
>>>>> index 8b22fb5..b45a7ef 100644
>>>>> --- a/hw/core/qdev-properties-system.c
>>>>> +++ b/hw/core/qdev-properties-system.c
>>>>> @@ -288,10 +288,6 @@ static void set_netdev(Object *obj, Visitor *v, const char *name,
>>>>>      }
>>>>>  
>>>>>      for (i = 0; i < queues; i++) {
>>>>> -        if (peers[i] == NULL) {
>>>>> -            err = -ENOENT;
>>>>> -            goto out;
>>>>> -        }
>>>>>  
>>>>>          if (peers[i]->peer) {
>>>>>              err = -EEXIST;
>>>>>
>>>>
>>>> Reviewed-by: Laurent Vivier <lvivier@redhat.com>
>>>
>>> So who can pick up such patches? We don't have a maintainer for the QDEV
>>> subsystem anymore... should it go via qemu-trivial?
>>
>> It seems trivial enough to go via qemu-trivial, but it would be good to
>> have a R-b from someone else than me to confirm.
> 
> I would have expected Jason to pick it up, after all it's networking,
> but it's okay if you want to take it too.

If Jason pushes it before I do, I will remove it from my queue.
[I have the bad habit to rebase by branch before a pull request]

Thanks,
Laurent
