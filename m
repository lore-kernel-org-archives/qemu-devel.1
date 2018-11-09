Received: from eggs.gnu.org ([2001:4830:134:3::10]:55115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gL2Ay-0005PS-2d
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 03:30:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gL2At-0007Ln-U9
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 03:29:59 -0500
References: <1541751214-17515-1-git-send-email-liq3ea@gmail.com>
	<7d20734d-f43a-957c-9cb5-4644320037aa@redhat.com>
	<fc711588-581f-515a-dbf2-62faf6ff1d2f@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <57a92d57-dd52-e347-b3be-e9fefb150672@redhat.com>
Date: Fri, 9 Nov 2018 09:29:37 +0100
MIME-Version: 1.0
In-Reply-To: <fc711588-581f-515a-dbf2-62faf6ff1d2f@redhat.com>
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
To: Thomas Huth <thuth@redhat.com>, Li Qiang <liq3ea@gmail.com>, stefanha@redhat.com, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, QEMU Trivial <qemu-trivial@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On 09/11/2018 09:26, Thomas Huth wrote:
> On 2018-11-09 09:21, Laurent Vivier wrote:
>> On 09/11/2018 09:13, Li Qiang wrote:
>>> In set_netdev(), the peers[i] is initialized
>>> qemu_find_net_clients_except() when i is in
>>> 0 between 'queues' it can't be NULL.
>>>
>>> Signed-off-by: Li Qiang <liq3ea@gmail.com>
>>> ---
>>>  hw/core/qdev-properties-system.c | 4 ----
>>>  1 file changed, 4 deletions(-)
>>>
>>> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
>>> index 8b22fb5..b45a7ef 100644
>>> --- a/hw/core/qdev-properties-system.c
>>> +++ b/hw/core/qdev-properties-system.c
>>> @@ -288,10 +288,6 @@ static void set_netdev(Object *obj, Visitor *v, const char *name,
>>>      }
>>>  
>>>      for (i = 0; i < queues; i++) {
>>> -        if (peers[i] == NULL) {
>>> -            err = -ENOENT;
>>> -            goto out;
>>> -        }
>>>  
>>>          if (peers[i]->peer) {
>>>              err = -EEXIST;
>>>
>>
>> Reviewed-by: Laurent Vivier <lvivier@redhat.com>
> 
> So who can pick up such patches? We don't have a maintainer for the QDEV
> subsystem anymore... should it go via qemu-trivial?

It seems trivial enough to go via qemu-trivial, but it would be good to
have a R-b from someone else than me to confirm.

Thanks,
Laurent
