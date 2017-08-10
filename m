Received: from eggs.gnu.org ([2001:4830:134:3::10]:35198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dfeVA-0004rn-GC
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 23:51:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dfeV6-0003bS-Ja
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 23:51:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:22696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dfeV6-0003ax-Cj
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 23:51:12 -0400
References: <1C4DF81E-D39F-42E2-9D0C-5D76819662A4@gmail.com>
	<9a34ac74-d96f-bd9c-7666-b02e2f8accba@redhat.com>
	<613DA9EA-28E9-426C-8A9A-5D4805A46E2C@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b3f776c4-5ea9-5771-8863-6308d4b186bb@redhat.com>
Date: Thu, 10 Aug 2017 05:51:07 +0200
MIME-Version: 1.0
In-Reply-To: <613DA9EA-28E9-426C-8A9A-5D4805A46E2C@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] No video for Windows 2000 guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, ehabkost@redhat.com, Richard Henderson <rth@twiddle.net>

On 09.08.2017 20:12, Programmingkid wrote:
> 
>> On Aug 9, 2017, at 12:37 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 09/08/2017 16:56, Programmingkid wrote:
>>> The default vga card not longer works with a Windows 2000 guest. All I see is a black screen after a the Windows splash screen.
>>>
>>> This is the command-line I used: 
>>>
>>> qemu-system-i386 -hda Windows2000HD.qcow2 -boot c -m 512
>>>
>>> When using the -vga cirrus option video works. Testing was done with QEMU v2.10.0 rc2. 
>>
>> Did it work in 2.9?
>>
>> Paolo
> 
> I haven't test version QEMU 2.9.0 but I did test version 2.8.0 and it has the same problem. Starting up Windows 2000 in VGA mode allowed me to access the operating system. Found out QEMU's default video controller is not recognized. In the Device Manager I can see a yellow question mark for Video Controller (VGA Compatible). I remember Windows 2000 being able to use the default video card in QEMU in the past. I may be able to bisect this issue after all.

I guess you'll end up with QEMU 2.1 as good version and 2.2 as the first
"bad" version. According the qemu-doc:

-vga type

    Select type of VGA card to emulate. Valid values for type are

    cirrus

        Cirrus Logic GD5446 Video card. All Windows versions starting
        from Windows 95 should recognize and use this graphic card. For
        optimal performances, use 16 bit color depth in the guest and
        the host OS. (This card was the default before QEMU 2.2)

    std

        Standard VGA card with Bochs VBE extensions. If your guest OS
        supports the VESA 2.0 VBE extensions (e.g. Windows XP) and if
        you want to use high resolution modes (>= 1280x1024x16) then you
        should use this option. (This card is the default since QEMU
        2.2)

Everything is in the documentation ;-)

 Thomas
