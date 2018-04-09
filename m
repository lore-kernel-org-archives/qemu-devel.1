Received: from eggs.gnu.org ([2001:4830:134:3::10]:56606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5XNG-0006ki-MO
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 10:02:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5XN7-0008FI-Db
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 10:02:22 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:38626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f5XN7-0008Ey-8F
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 10:02:13 -0400
Received: by mail-oi0-x243.google.com with SMTP id c3-v6so7693340oib.5
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 07:02:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHP4M8X-Dus1Z8UegDTaab5LvaiDAgQa8upsx_KdnPO+A-XoTQ@mail.gmail.com>
References: <CAHP4M8VVWyNqi4yLS3S0GXaDz3j8QvUiC=aoJ_DfZLtZBaFwqg@mail.gmail.com>
	<CAFEAcA9stTjg3Wpq5x_vj63jm1DrxAQREk4XPeFWb5rff-Uofg@mail.gmail.com>
	<CAHP4M8X-Dus1Z8UegDTaab5LvaiDAgQa8upsx_KdnPO+A-XoTQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Apr 2018 15:01:51 +0100
Message-ID: <CAFEAcA_1X1AQ6j9pZQ8fEHmQCxRNK7EhGkohuLbTMpoPONe5PA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] Use of -machine when running via
 qemu-system-arm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ajay Garg <ajaygargnsit@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 9 April 2018 at 14:43, Ajay Garg <ajaygargnsit@gmail.com> wrote:
> On Mon, Apr 9, 2018 at 7:08 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 9 April 2018 at 14:35, Ajay Garg <ajaygargnsit@gmail.com> wrote:
>>> Hi All.
>>>
>>> Not sure if this is purely an ARM-related question, but I will be
>>> grateful if someone could point to some literature that explains what
>>> difference choosing a  machine makes (when we don't need to have any
>>> such flag for qemu-system-i386 or qemu-system-x86_64).
>>
>> Hi; this is a pretty common question, which we talk about on our
>> wiki page here:
>>  https://wiki.qemu.org/Documentation/Platforms/ARM
>
> Yep, had already been through it :)
>
>>
>> The underlying reason why you need this on Arm but not on x86
>> is that for x86 every single piece of x86 hardware is pretty
>> much identical. For Arm (as part of its history in the embedded
>> space) the general rule is that every board is different.
>
> Yep, perhaps I am needing a more layman-kinda example-cum-explanation
> for this, so would be grateful for some help in this regard.

Well, the wiki text is the best explanation I have; perhaps
you could suggest what part of it is confusing, and we could
improve it?

thanks
-- PMM
