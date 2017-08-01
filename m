Received: from eggs.gnu.org ([2001:4830:134:3::10]:54741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dcanW-0006FL-SO
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 13:17:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dcanU-0002Cd-7g
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 13:17:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dcanU-0002Ay-13
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 13:17:32 -0400
References: <150160611982.36.12492156362530631521@93e45bedd699>
	<09b423f3-c9fe-77de-c6df-4ed79f0fa9bf@redhat.com>
	<CAFEAcA9Mea6ysDVm76rf20HKC+z1jcMfM88zmCdHod=jt1e62Q@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1743b106-1217-92ee-589d-9ba99f76556d@redhat.com>
Date: Tue, 1 Aug 2017 19:17:24 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9Mea6ysDVm76rf20HKC+z1jcMfM88zmCdHod=jt1e62Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/17] Misc changes for QEMU 2.10-rc1 (?)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>

On 01/08/2017 19:10, Peter Maydell wrote:
> On 1 August 2017 at 17:50, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> On 01/08/2017 18:48, no-reply@patchew.org wrote:
>>> ERROR: space prohibited before that '++' (ctx:WxB)
>>> #78: FILE: hw/bt/sdp.c:741:
>>> +        data[len ++] = attribute_id >> 8;
>>>                   ^
>>>
>>> ERROR: space prohibited before that '++' (ctx:WxB)
>>> #79: FILE: hw/bt/sdp.c:742:
>>> +        data[len ++] = attribute_id & 0xff;
>>
>> This is the preexisting Bluetooth code... I didn't change the space,
>> should I have done that?
> 
> Judgement call -- I usually fix up existing errors if I'm touching
> a bit of code anyway, unless it's a whitespace-only change or a
> pure code-motion patch.

Me too.  In this case however the code is pretty much untouched so it's
unlikely that it would become consistent one day (and I suspect no one
wants to get on git blame for bluetooth emulation :)).

>>> ERROR: space required before the open parenthesis '('
>>> #73: FILE: tests/rtc-test.c:344:
>>> +    } while(0)
>>
>> This seems to be more common than "while (0)" inside macros, should we
>> allow it in checkpatch.pl?
> 
> Overall the space is much more common: 551 examples with the
> space vs 90 without; so I don't think a relaxation of checkpatch
> is particularly justified. I don't think macros need to be any
> different from the rest of our code on things like spacing.

Ok, for this patch I kept it consistent within the file, but for 2.11 we
can change everything to "while (0)".

Paolo
