Received: from eggs.gnu.org ([2001:4830:134:3::10]:55062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hsp.cat7@gmail.com>) id 1ennOZ-0000QT-D4
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 10:30:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hsp.cat7@gmail.com>) id 1ennOV-0006H3-AL
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 10:30:23 -0500
Received: from mail-ot0-x22f.google.com ([2607:f8b0:4003:c0f::22f]:45871)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hsp.cat7@gmail.com>) id 1ennOV-0006FS-3J
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 10:30:19 -0500
Received: by mail-ot0-x22f.google.com with SMTP id f11so3245883otj.12
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 07:30:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180219103034.zbqxtdises26loqb@sirius.home.kraxel.org>
References: <CABLmASGFPBQV8y1Omm+S53P92Dew_aWBBbDoap+c2b2PVxeLzg@mail.gmail.com>
	<ab4612a8-5c82-5abf-cbc3-d5ec47cd9498@tuxfamily.org>
	<CABLmASFG_cT768zVJwKwrOAB=xhbhvzLa_wvJ4qjRkE6GoZvrA@mail.gmail.com>
	<20180219085648.kgkeo36adbk2tp6g@sirius.home.kraxel.org>
	<CABLmASFgZaV3OgFMykpSi3Ok46+xQ+FW0GNTM+0-wgZyhh8qNw@mail.gmail.com>
	<20180219103034.zbqxtdises26loqb@sirius.home.kraxel.org>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Mon, 19 Feb 2018 16:30:17 +0100
Message-ID: <CABLmASFziChKARGJ-+R0ZJr-F4rbVFZFaixC-CZ8mPF2Sfr=9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Qemu SDL2 bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Thomas Huth <huth@tuxfamily.org>, qemu-devel qemu-devel <qemu-devel@nongnu.org>

On Mon, Feb 19, 2018 at 11:30 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>> >> Hi,
>> >>
>> >> With SDL, unlike GTK, the mouse does not move outside the window. So I
>> >> have to use Ctrl-Alt-G to release focus and then click in the other
>> >> window. After two switches the reported issue occurs. Indeed, the Alt
>> >> key seems to go into a state in which it is stuck. When trying to
>> >> exclude my own keyboard being at fault, I've also noticed the right
>> >> Alt key on my keyboard cannot be used for the release.
>> >
>> > Which qemu version?  There have been a bunch of SDL2 fixes in the 2.12
>> > devel cycle already, so if you are on 2.11 still please try git master
>> > and see whenever that improves things.
>> >
>> > cheers,
>> >   Gerd
>> >
>>
>> Hi.
>>
>> This was with my own qemu master builds as of yesterday.
>
> Including most recent ui pull request (commit 5e8d6a12d643a38b82a0a713a77d1192117dbdca) ?
>
> I'm wondering that you need Ctrl-Alt-G in the first place, sdl2 and gtk
> should have identical behavior here (i.e. no ctrl-alt-g needed in case a
> tablet or other absolute ptr device is present).
>
> cheers,
>   Gerd
>
Hi,

I went on to compile dgibson's rep which includes that commit. But the
issue remains.
I normally use -usb-mouse -usb-kbd in the command line, as these work
for Mac OS 9.x up to 10.5. Using -usb-tablet allows the mouse to
travel outside the GUI and seems to circumvent the issue in OSX
guests, but Mac OS 9.x  guests do not work with -usb-tablet.

Best,
Howard
