Received: from eggs.gnu.org ([2001:4830:134:3::10]:57640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gM84t-0004Be-GI
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 04:00:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gM84p-0003zU-Uo
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 04:00:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gM84p-0003xM-I2
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 04:00:11 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1541751214-17515-1-git-send-email-liq3ea@gmail.com>
	<7d20734d-f43a-957c-9cb5-4644320037aa@redhat.com>
	<fc711588-581f-515a-dbf2-62faf6ff1d2f@redhat.com>
Date: Mon, 12 Nov 2018 09:59:54 +0100
In-Reply-To: <fc711588-581f-515a-dbf2-62faf6ff1d2f@redhat.com> (Thomas Huth's
	message of "Fri, 9 Nov 2018 09:26:40 +0100")
Message-ID: <87h8gmfz79.fsf_-_@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] qdev has no maintainer (was: [PATCH] hw: set_netdev:
 remove useless code)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Li Qiang <liq3ea@gmail.com>, stefanha@redhat.com, marcandre.lureau@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

Thomas Huth <thuth@redhat.com> writes:

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

We've never had a formal qdev maintainer.

"qdev is too important to continue much longer without a maintainer."
Message-ID: <m37h8v85r7.fsf@blackfin.pond.sub.org>
https://lists.gnu.org/archive/html/qemu-devel/2011-06/msg01053.html

The closest we got to appointing one was probably here:
Message-ID: <56B33C2A.8030405@redhat.com>
https://lists.gnu.org/archive/html/qemu-devel/2016-02/msg00949.html

In my opinion, not having a maintainer push or at least direct the cart
is one of the reasons of the relatively sad state of qdev.

Same for QOM, where we had an active maintainer for a while, but no
more.
