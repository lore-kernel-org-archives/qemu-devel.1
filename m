Received: from eggs.gnu.org ([2001:4830:134:3::10]:53995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e9A1m-0006cm-HX
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 09:22:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e9A1g-0008MR-TC
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 09:22:54 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:45049)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e9A1g-0008Lq-Mu
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 09:22:48 -0400
Received: by mail-wr0-x244.google.com with SMTP id z55so12598094wrz.1
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 06:22:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a169c6f0-4a82-cd3c-7f83-0a6394c06e98@ilande.co.uk>
References: <1508947167-5304-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1508947167-5304-10-git-send-email-mark.cave-ayland@ilande.co.uk>
	<CAFEAcA8DGeoNWxr9Y-vRXmtR5=7+EMQqfpt5cs7x2qTcfRZR4Q@mail.gmail.com>
	<98d12504-4523-2a5c-aefa-4b01e1c6c7df@ilande.co.uk>
	<a169c6f0-4a82-cd3c-7f83-0a6394c06e98@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Oct 2017 13:22:27 +0000
Message-ID: <CAFEAcA9u3kw6LnwE3ZnExdcmMM42AuycnLOppiX7wXdeKk5hcw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCHv4 09/13] lance: move TYPE_LANCE and
 SysBusPCNetState from lance.c to lance.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Artyom Tarasenko <atar4qemu@gmail.com>

On 30 October 2017 at 13:10, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> On 26/10/17 11:12, Mark Cave-Ayland wrote:
>> On 25/10/17 18:47, Peter Maydell wrote:
>>> On 25 October 2017 at 16:59, Mark Cave-Ayland wrote:
>>>> --- /dev/null
>>>> +++ b/include/hw/net/lance.h
>>>> @@ -0,0 +1,41 @@
>>>> +/*
>>>> + * QEMU AMD PC-Net II (Am79C970A) emulation
>>>
>>> Filename says this is Lance ethernet, but the comment says it's PC-Net ?
>>
>> According to the datasheet for Am79C970A, the original Lance is an
>> Am7990 device and the Am79C970A aka PCNet-PCI II as emulated by QEMU is
>> register-compatible with it.
>>
>> I guess the comment above is more technically correct, but I'm happy to
>> adjust it in my local tree if you still feel it needs to change?

I think we should have a comment that says what the file is
for. Since this is a different file from pcnet.h, we should
have a comment that isn't the same as the pcnet.h one.
I don't particularly mind what it says, as long as it briefly
explains what's in the file (and by implication what distinguishes
things in this file from things in the other).

thanks
-- PMM
