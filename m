Received: from eggs.gnu.org ([2001:4830:134:3::10]:53163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dcagZ-0004Rd-GO
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 13:10:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dcagY-0004iZ-Kp
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 13:10:23 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:33804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dcagY-0004i6-CY
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 13:10:22 -0400
Received: by mail-wr0-x236.google.com with SMTP id 12so9434603wrb.1
	for <qemu-devel@nongnu.org>; Tue, 01 Aug 2017 10:10:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <09b423f3-c9fe-77de-c6df-4ed79f0fa9bf@redhat.com>
References: <150160611982.36.12492156362530631521@93e45bedd699>
	<09b423f3-c9fe-77de-c6df-4ed79f0fa9bf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Aug 2017 18:10:00 +0100
Message-ID: <CAFEAcA9Mea6ysDVm76rf20HKC+z1jcMfM88zmCdHod=jt1e62Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/17] Misc changes for QEMU 2.10-rc1 (?)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>

On 1 August 2017 at 17:50, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 01/08/2017 18:48, no-reply@patchew.org wrote:
>> ERROR: space prohibited before that '++' (ctx:WxB)
>> #78: FILE: hw/bt/sdp.c:741:
>> +        data[len ++] = attribute_id >> 8;
>>                   ^
>>
>> ERROR: space prohibited before that '++' (ctx:WxB)
>> #79: FILE: hw/bt/sdp.c:742:
>> +        data[len ++] = attribute_id & 0xff;
>
> This is the preexisting Bluetooth code... I didn't change the space,
> should I have done that?

Judgement call -- I usually fix up existing errors if I'm touching
a bit of code anyway, unless it's a whitespace-only change or a
pure code-motion patch.

>> ERROR: space required before the open parenthesis '('
>> #73: FILE: tests/rtc-test.c:344:
>> +    } while(0)
>
> This seems to be more common than "while (0)" inside macros, should we
> allow it in checkpatch.pl?

Overall the space is much more common: 551 examples with the
space vs 90 without; so I don't think a relaxation of checkpatch
is particularly justified. I don't think macros need to be any
different from the rest of our code on things like spacing.

thanks
-- PMM
