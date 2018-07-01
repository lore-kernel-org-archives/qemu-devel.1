Received: from eggs.gnu.org ([2001:4830:134:3::10]:33775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <davidsondfgl@gmail.com>) id 1fZh6r-0002tx-R6
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 14:30:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <davidsondfgl@gmail.com>) id 1fZh6q-00074E-O8
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 14:30:05 -0400
Received: from mail-qt0-x235.google.com ([2607:f8b0:400d:c0d::235]:39179)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <davidsondfgl@gmail.com>)
	id 1fZh6q-00073R-J3
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 14:30:04 -0400
Received: by mail-qt0-x235.google.com with SMTP id q12-v6so8236127qtp.6
	for <qemu-devel@nongnu.org>; Sun, 01 Jul 2018 11:30:04 -0700 (PDT)
References: <CALAE4RoqNTXyGEUbV3LmonNcyA=o8toPhRrDS23w4W_Zg3z3qg@mail.gmail.com>
	<20180520025454.GH3652@lianli.shorne-pla.net>
	<CALAE4RpKFttWOBaw-15bTKsU4LG=h6K=K9=U08ThDsGieSJ1=g@mail.gmail.com>
	<CAAfxs74OhhCLYcXJ6xqEJWho_O244D6+qYMxMHfspjHG-G17Ug@mail.gmail.com>
From: Davidson Francis <davidsondfgl@gmail.com>
Message-ID: <e9864a71-f81d-7093-adfd-7bac2999afb5@gmail.com>
Date: Sun, 1 Jul 2018 15:30:00 -0300
MIME-Version: 1.0
In-Reply-To: <CAAfxs74OhhCLYcXJ6xqEJWho_O244D6+qYMxMHfspjHG-G17Ug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] OpenRISC - SPR_PICMR always 'OR-ing' the values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stafford Horne <shorne@gmail.com>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>, Openrisc <openrisc@lists.librecores.org>

Hello,

Thanks for working on this, your tree works fine here and the issue
seems to be fixed, I have nothing to complain about.

Regards,
Davidson Francis.

On 01-07-2018 05:18, Stafford Horne wrote:
> Hello,
> 
> We have been working on a few patches to fixed QEMU for OpenRISC and I
> included the change for picmr writes, richard added some changes to
> SPR writes which might help with the masking/umasking work more
> reliably.
> 
> If you want to try them out could you check:
>     https://github.com/stffrdhrn/qemu/tree/or1k-fixes-212-1
> 
> Thanks for your help.
> 
> -Stafford
> 
> On Sun, May 20, 2018 at 12:32 PM Davidson Francis
> <davidsondfgl@gmail.com> wrote:
>>
>> Thank you for quick reply,
>>
>> Yes, I've tried, after that, the register works as expected, but even so, if I
>> enable the interrupts right after, I still receive interrupts from the same IRQ,
>> but maybe there is something wrong with my code.
>>
>> Regards,
>> Davidson Francis.
>>
>> 2018-05-19 23:54 GMT-03:00 Stafford Horne <shorne@gmail.com>:
>>> On Sat, May 19, 2018 at 08:08:47PM -0300, Davidson Francis wrote:
>>>> Hello Stafford,
>>>>
>>>> I'm currently using or1k as a target CPU in an operating system that
>>>> I'm working.
>>>> It happens that I'm having some issues regarding the PICMR register: I realize
>>>> that in the latest Qemu version (2.12) when I write into PICMR, the Qemu is
>>>> actually 'OR-ing' the values (as I could note in target/openrisc/sys_helper.c
>>>> file), so I can't mask an already enabled interrupt.
>>>>
>>>> I don't know if this behaviour is expected and if so, I'm sorry, but this does
>>>> not occurs in the or1ksim, so I thought this could be might an issue.
>>>
>>> Hello, thanks for pointing this out.  It looks wrong to me too.  Have you tested
>>> changing it to just `env->picmr = rb;`?
>>>
>>> -Stafford
