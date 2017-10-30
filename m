Received: from eggs.gnu.org ([2001:4830:134:3::10]:48571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e9F3i-0001ZU-0H
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 14:45:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e9F3e-0002jV-JE
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 14:45:13 -0400
Received: from mail-qt0-x22f.google.com ([2607:f8b0:400d:c0d::22f]:54151)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e9F3e-0002jB-Fe
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 14:45:10 -0400
Received: by mail-qt0-x22f.google.com with SMTP id n61so17691745qte.10
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 11:45:10 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1508947167-5304-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1508947167-5304-10-git-send-email-mark.cave-ayland@ilande.co.uk>
	<CAFEAcA8DGeoNWxr9Y-vRXmtR5=7+EMQqfpt5cs7x2qTcfRZR4Q@mail.gmail.com>
	<98d12504-4523-2a5c-aefa-4b01e1c6c7df@ilande.co.uk>
	<a169c6f0-4a82-cd3c-7f83-0a6394c06e98@ilande.co.uk>
	<CAFEAcA9u3kw6LnwE3ZnExdcmMM42AuycnLOppiX7wXdeKk5hcw@mail.gmail.com>
	<ef818927-9c2e-37cd-91a1-8b5bf40ad8e1@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <74c257be-f3dc-ebf9-7a55-0eefe46ce93e@amsat.org>
Date: Mon, 30 Oct 2017 15:45:01 -0300
MIME-Version: 1.0
In-Reply-To: <ef818927-9c2e-37cd-91a1-8b5bf40ad8e1@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Artyom Tarasenko <atar4qemu@gmail.com>

Hi Mark,

>>>>>> +/*
>>>>>> + * QEMU AMD PC-Net II (Am79C970A) emulation
>>>>>
>>>>> Filename says this is Lance ethernet, but the comment says it's PC-Net ?
>>>>
>>>> According to the datasheet for Am79C970A, the original Lance is an
>>>> Am7990 device and the Am79C970A aka PCNet-PCI II as emulated by QEMU is
>>>> register-compatible with it.
>>>>
>>>> I guess the comment above is more technically correct, but I'm happy to
>>>> adjust it in my local tree if you still feel it needs to change?
>>
>> I think we should have a comment that says what the file is
>> for. Since this is a different file from pcnet.h, we should
>> have a comment that isn't the same as the pcnet.h one.
>> I don't particularly mind what it says, as long as it briefly
>> explains what's in the file (and by implication what distinguishes
>> things in this file from things in the other).
> 
> Okay then how about something along the lines of:
> 
>  * QEMU Lance (Am7990) device emulation
>  *
>  * Copyright (c) 2004 Antony T Curtis
>  * Copyright (c) 2017 Mark Cave-Ayland
>  *
>  * This represents the Sparc32 lance (Am7990) ethernet device which is
>  * an earlier register-compatible member of the AMD PC-Net II
>  * (Am79C970A) family.
> 
> In reality pcnet.c/pcnet.h are just the inner workings of the pcnet-pci
> and lance devices. The comments in pcnet-pci.c and lance.c are identical
> except for the Sparc32 reference and it was the same header from
> pcnet-pci.c that I used as the basis for my last patch.

You are right the PCnet family is based on the Lance one, but it seems
nobody remembers the Lance origin, the "PC-Net" took over.

Maybe we can agree with the different families having an unique
"hw/net/pcnet_lance.h" header with all Lance/PC-Net related XXX_TYPEs,
what do you think?

Regards,

Phil.
