Received: from eggs.gnu.org ([2001:4830:134:3::10]:53507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dfi2S-0001WN-FD
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 03:37:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dfi2N-0000I1-JU
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 03:37:52 -0400
Received: from isrv.corpit.ru ([86.62.121.231]:36899)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dfi2N-0000H8-C4
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 03:37:47 -0400
References: <1C4DF81E-D39F-42E2-9D0C-5D76819662A4@gmail.com>
	<9a34ac74-d96f-bd9c-7666-b02e2f8accba@redhat.com>
	<613DA9EA-28E9-426C-8A9A-5D4805A46E2C@gmail.com>
	<b3f776c4-5ea9-5771-8863-6308d4b186bb@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <1a3c3e6d-bc75-5635-da19-db990e28351b@msgid.tls.msk.ru>
Date: Thu, 10 Aug 2017 10:37:43 +0300
MIME-Version: 1.0
In-Reply-To: <b3f776c4-5ea9-5771-8863-6308d4b186bb@redhat.com>
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
To: Thomas Huth <thuth@redhat.com>, Programmingkid <programmingkidx@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, ehabkost@redhat.com

10.08.2017 06:51, Thomas Huth wrote:
[]

> I guess you'll end up with QEMU 2.1 as good version and 2.2 as the first
> "bad" version. According the qemu-doc:
> 
> -vga type
> 
>     Select type of VGA card to emulate. Valid values for type are
> 
>     cirrus
> 
>         Cirrus Logic GD5446 Video card. All Windows versions starting
>         from Windows 95 should recognize and use this graphic card. For
>         optimal performances, use 16 bit color depth in the guest and
>         the host OS. (This card was the default before QEMU 2.2)
> 
>     std
> 
>         Standard VGA card with Bochs VBE extensions. If your guest OS
>         supports the VESA 2.0 VBE extensions (e.g. Windows XP) and if
>         you want to use high resolution modes (>= 1280x1024x16) then you
>         should use this option. (This card is the default since QEMU
>         2.2)

Both cirrus and stdvga worked in Win2k not-so-recently. Cirrus, IIRC,
required a driver install, stdvga used "standard vga controller" which,
in win2k, was always marked with yellow exclamation mark, just because
the driver itself always sets that mark, "thinking" it is always wrong
driver.

So no, it's not the switch from cirrus to std, it's something else.

/mjt
