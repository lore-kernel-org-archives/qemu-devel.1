Received: from eggs.gnu.org ([2001:4830:134:3::10]:43880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dfsJ8-0000c2-Kj
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 14:35:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dfsJ5-0002Vi-D0
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 14:35:46 -0400
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:33602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dfsJ5-0002Tg-7t
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 14:35:43 -0400
Received: by mail-io0-x243.google.com with SMTP id q64so2110475ioi.0
	for <qemu-devel@nongnu.org>; Thu, 10 Aug 2017 11:35:41 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <1a3c3e6d-bc75-5635-da19-db990e28351b@msgid.tls.msk.ru>
Date: Thu, 10 Aug 2017 14:35:39 -0400
Content-Transfer-Encoding: 7bit
Message-Id: <012D4B91-CB4D-439B-BBA4-BBD1A2DE119F@gmail.com>
References: <1C4DF81E-D39F-42E2-9D0C-5D76819662A4@gmail.com>
	<9a34ac74-d96f-bd9c-7666-b02e2f8accba@redhat.com>
	<613DA9EA-28E9-426C-8A9A-5D4805A46E2C@gmail.com>
	<b3f776c4-5ea9-5771-8863-6308d4b186bb@redhat.com>
	<1a3c3e6d-bc75-5635-da19-db990e28351b@msgid.tls.msk.ru>
Subject: Re: [Qemu-devel] No video for Windows 2000 guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, ehabkost@redhat.com


> On Aug 10, 2017, at 3:37 AM, Michael Tokarev <mjt@tls.msk.ru> wrote:
> 
> 10.08.2017 06:51, Thomas Huth wrote:
> []
> 
>> I guess you'll end up with QEMU 2.1 as good version and 2.2 as the first
>> "bad" version. According the qemu-doc:
>> 
>> -vga type
>> 
>>    Select type of VGA card to emulate. Valid values for type are
>> 
>>    cirrus
>> 
>>        Cirrus Logic GD5446 Video card. All Windows versions starting
>>        from Windows 95 should recognize and use this graphic card. For
>>        optimal performances, use 16 bit color depth in the guest and
>>        the host OS. (This card was the default before QEMU 2.2)
>> 
>>    std
>> 
>>        Standard VGA card with Bochs VBE extensions. If your guest OS
>>        supports the VESA 2.0 VBE extensions (e.g. Windows XP) and if
>>        you want to use high resolution modes (>= 1280x1024x16) then you
>>        should use this option. (This card is the default since QEMU
>>        2.2)
> 
> Both cirrus and stdvga worked in Win2k not-so-recently. Cirrus, IIRC,
> required a driver install, stdvga used "standard vga controller" which,
> in win2k, was always marked with yellow exclamation mark, just because
> the driver itself always sets that mark, "thinking" it is always wrong
> driver.
> 
> So no, it's not the switch from cirrus to std, it's something else.
> 
> /mjt

Here is the commit that causes Windows 2000 video problems: 

commit 94ef4f337fb614f18b765a8e0e878a4c23cdedcd
Author: Gerd Hoffmann <kraxel@redhat.com>
Date:   Tue May 17 10:54:54 2016 +0200

    vga: add sr_vbe register set
    
    Commit "fd3c136 vga: make sure vga register setup for vbe stays intact
    (CVE-2016-3712)." causes a regression.  The win7 installer is unhappy
    because it can't freely modify vga registers any more while in vbe mode.
