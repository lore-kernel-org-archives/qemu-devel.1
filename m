Received: from eggs.gnu.org ([2001:4830:134:3::10]:34075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marex@denx.de>) id 1dVnTT-0007OH-Mz
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 19:24:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marex@denx.de>) id 1dVnTQ-0000Ct-Ig
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 19:24:47 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:41077)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marex@denx.de>) id 1dVnTQ-0000CE-BH
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 19:24:44 -0400
References: <4EE89732-1A49-4D45-B94A-F8A57873E6EB@gmail.com>
	<1a59d15c-9bba-fa7b-198b-bf4bbdc11488@denx.de>
	<C130A840-281E-4A82-A4E1-4142261AB2FC@gmail.com>
	<c9179f0b-d978-31ad-19d5-2f4070a1b1b1@denx.de>
	<C1AED432-9B05-4B84-AB8D-6BC1AEDEE4F8@gmail.com>
From: Marek Vasut <marex@denx.de>
Message-ID: <6c72a5fe-0900-213a-8052-a2a3cef37edb@denx.de>
Date: Fri, 14 Jul 2017 01:06:37 +0200
MIME-Version: 1.0
In-Reply-To: <C1AED432-9B05-4B84-AB8D-6BC1AEDEE4F8@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Nios2 documentation page now up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: crwulff@gmail.com, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

On 07/13/2017 09:59 PM, Programmingkid wrote:
> 
> On Jul 13, 2017, at 3:01 PM, Marek Vasut wrote:
> 
>> On 07/13/2017 08:23 PM, Programmingkid wrote:
>>>
>>> On Jul 13, 2017, at 10:48 AM, Marek Vasut wrote:
>>>
>>>> On 07/13/2017 04:28 PM, Programmingkid wrote:
>>>>> Hi I have recently created a new documentation page for the Nios2 target. I would greatly appreciate any feedback you might have on it. Thank you.
>>>>
>>>> Great, thanks !
>>>>
>>>> A few nits, we also support nios2 userspace binary emulation. And Nios2
>>>> is I believe Altera specific. And we only support Nios2 R1 EL thus far.
>>>>
>>>>> Page: http://wiki.qemu.org/Documentation/Platforms/Nios2
>>>>>
>>>
>>> Thank you for the info. Did the suggested command line look good to you?
>>
>> I mean, ./configure --target-list=nios2-softmmu,nios2-linux-user when I
>> say that userspace linux binary emulation is supported.
> 
> I just did a git pull and tried your configure command. This is the error I saw:
> 
> ERROR: Unknown target name 'nios2-linux-user'

qemu$ ./configure --target-list=nios2-softmmu,nios2-linux-user
[...]
target list       nios2-softmmu nios2-linux-user
[...]

That's on commit 49bcce4b9c11759678fd223aefb48691c4959d4f

>>> Also would you know of any pre-made images the user could download to test the emulator? 
>>
>> I build them using OE with meta-altera myself.
> 
> Actually I was talking about a HD image file the user could try to boot from. A simple test image file would be good enough. 

You cannot attach a harddisk to the system. You can only boot a kernel
with initramfs (or use nfsboot with external work-in-progress patch).

>>> I will add your note about how only Nios2 R1 EL is currently supported.
>>>
>>> If you have any pictures of this emulator running I would be glad to add them to the wiki page. 
>>
>> Not at the moment, just a random post on my G+ (which I'd prefer to NOT
>> have linked in the wiki) ; although feel free to copy-paste the console
>> output:
>>
>> https://plus.google.com/+MarekVa%C5%A1ut/posts/BEvfXANeCs7
> 
> I will be glad to post any pictures whenever you decide to add pictures to the wiki page.

There is no graphical output on 10m50 GHRD ; the system only has serial
console.

-- 
Best regards,
Marek Vasut
