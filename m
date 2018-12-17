Received: from eggs.gnu.org ([2001:4830:134:3::10]:55931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gYyiJ-0005Ag-M4
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 14:38:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gYyiG-0005xq-By
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 14:38:03 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52313)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gYyiG-0005xU-4H
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 14:38:00 -0500
Received: by mail-wm1-f65.google.com with SMTP id m1so397683wml.2
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 11:38:00 -0800 (PST)
References: <1543467132-2873-1-git-send-email-liq3ea@gmail.com>
	<1543467132-2873-3-git-send-email-liq3ea@gmail.com>
	<644186db-32d3-7c83-8b37-02e8427ef217@redhat.com>
	<87o99kj7tm.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b3e3a763-7865-285b-4fa7-b3146f19d354@redhat.com>
Date: Mon, 17 Dec 2018 20:37:56 +0100
MIME-Version: 1.0
In-Reply-To: <87o99kj7tm.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 2/2] hw: vmmouse: Use link instead of
 pointer property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Li Qiang <liq3ea@gmail.com>, mst@redhat.com, pbonzini@redhat.com, ehabkost@redhat.com, Thomas Huth <thuth@redhat.com>, darren.kenny@oracle.com, qemu-devel@nongnu.org, rth@twiddle.net

On 12/17/18 8:01 PM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
> 
>> Hi Li,
>>
>> On 11/29/18 5:52 AM, Li Qiang wrote:
>>> According to qdev-properties.h, properties of pointer type should
>>> be avoided. Turn "ps2_mouse" into a link.
>>>
>>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>>> Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
>>> Signed-off-by: Li Qiang <liq3ea@gmail.com>
>>> ---
> [...]
>>> diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
>>> index 4412eaf604..f63aac6673 100644
>>> --- a/hw/i386/vmmouse.c
>>> +++ b/hw/i386/vmmouse.c
> [...]
>>> @@ -283,8 +289,6 @@ static void vmmouse_class_initfn(ObjectClass *klass, void *data)
>>>      dc->realize = vmmouse_realizefn;
>>>      dc->reset = vmmouse_reset;
>>>      dc->vmsd = &vmstate_vmmouse;
>>> -    dc->props = vmmouse_properties;
>>> -    /* Reason: pointer property "ps2_mouse" */
>>>      dc->user_creatable = false;
>>
>> "user_creatable = false" must have an justification comment.
> 
> Correct.
> 
>> Can you keep 'Reason: link property "ps2_mouse"'?
> 
> Is this a valid reason?
> 
> A pointer property is one, because it can only be set by code.

I prefer the original comment :)

/* Reason: pointer property "ps2_mouse" */

>> Eventually the maintainer taking this patch can fix this for you.
>>
>> With the comment:
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>
>>>  }
> [...]
> 
