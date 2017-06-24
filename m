Received: from eggs.gnu.org ([2001:4830:134:3::10]:35131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dOkJl-0005HW-Rt
	for qemu-devel@nongnu.org; Sat, 24 Jun 2017 08:37:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dOkJh-0007AD-W4
	for qemu-devel@nongnu.org; Sat, 24 Jun 2017 08:37:37 -0400
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:34667)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dOkJh-0007A3-QO
	for qemu-devel@nongnu.org; Sat, 24 Jun 2017 08:37:33 -0400
Received: by mail-io0-x244.google.com with SMTP id m19so9351582ioe.1
	for <qemu-devel@nongnu.org>; Sat, 24 Jun 2017 05:37:33 -0700 (PDT)
In-Reply-To: <CAFEAcA8pJWX+3bE7AGT6FJCnCJGpnZ-_UeG2cC3CfrFMH+Taww@mail.gmail.com>
References: <04A047CA-48D8-4381-B08C-0A91B135D7D0@gmail.com>
	<CAFEAcA8pJWX+3bE7AGT6FJCnCJGpnZ-_UeG2cC3CfrFMH+Taww@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <08149D8B-670C-4258-95D2-11B777F6B6C6@gmail.com>
Content-Transfer-Encoding: 7bit
From: G 3 <programmingkidx@gmail.com>
Date: Sat, 24 Jun 2017 08:37:30 -0400
Subject: Re: [Qemu-devel] [PATCH] Improve Cocoa modifier key handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Ian McKellar <ianloic@google.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>


On Jun 24, 2017, at 8:14 AM, Peter Maydell wrote:

> On 23 June 2017 at 21:05, Programmingkid  
> <programmingkidx@gmail.com> wrote:
>> This patch is incompatible with anything below Mac OS 10.10.
>
> Oops. Thanks for the report.
>
>> We support Mac OS 10.5 and up. I was able to make this patch work
>> on Mac OS 10.6 by changing this line:
>>
>> NSEventModifierFlags modifiers = [event modifierFlags];
>>
>> to this:
>>
>> NSUInteger modifiers = [event modifierFlags];
>>
>> This wouldn't be enough. The [event modifierFlags] code would have to
>> be replaced because the modifierFlags function is not available on
>> Mac OS 10.5.

Please disregard what I said about the [event modifierFlags] code. It  
turns out it has been available since Mac OS 10.0. Sorry for the  
mistake.


> Do you still use 10.5? It's a decade old now, and I notice that
> in the QEMU 2.5 changelog we actually said we were going to
> remove 10.5 support. So one option would be to simply remove
> 10.5 support entirely, if nobody needs it any more.

I do have a computer with 10.5 on it. I will be happy to help support  
Mac OS 10.5.
