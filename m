Received: from eggs.gnu.org ([2001:4830:134:3::10]:52940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hsp.cat7@gmail.com>) id 1engLd-0008Qv-LN
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 02:58:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hsp.cat7@gmail.com>) id 1engLc-0003yR-R7
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 02:58:53 -0500
Received: from mail-ot0-x229.google.com ([2607:f8b0:4003:c0f::229]:36346)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hsp.cat7@gmail.com>) id 1engLc-0003y7-M9
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 02:58:52 -0500
Received: by mail-ot0-x229.google.com with SMTP id b15so1803787otf.3
	for <qemu-devel@nongnu.org>; Sun, 18 Feb 2018 23:58:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <ab4612a8-5c82-5abf-cbc3-d5ec47cd9498@tuxfamily.org>
References: <CABLmASGFPBQV8y1Omm+S53P92Dew_aWBBbDoap+c2b2PVxeLzg@mail.gmail.com>
	<ab4612a8-5c82-5abf-cbc3-d5ec47cd9498@tuxfamily.org>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Mon, 19 Feb 2018 08:58:51 +0100
Message-ID: <CABLmASFG_cT768zVJwKwrOAB=xhbhvzLa_wvJ4qjRkE6GoZvrA@mail.gmail.com>
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
To: Thomas Huth <huth@tuxfamily.org>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On Mon, Feb 19, 2018 at 8:09 AM, Thomas Huth <huth@tuxfamily.org> wrote:
> On 18.02.2018 11:11, Howard Spoelstra wrote:
>> Hi,
>>
>> I'd like to report a bug when using the SDL2 GUI in both Linux and
>> Windows, which can be observed with in my case latest qemu-system-ppc
>> running parallel instances of OSX 10.4 and 10.3.
>>
>> After switching back and forth between GUIs, dragging becomes copying,
>> keyboard starts using a strange character set.
>> An additional "Alt" key press is needed to restore normal behaviour.
>
>  Hi,
>
> how do you switch back and forth between GUIs? Using the mouse or a
> keystroke? I guess the latter ... sounds like the Alt key could be
> "stuck" in the guest?
>
>  Thomas

Hi,

With SDL, unlike GTK, the mouse does not move outside the window. So I
have to use Ctrl-Alt-G to release focus and then click in the other
window. After two switches the reported issue occurs. Indeed, the Alt
key seems to go into a state in which it is stuck. When trying to
exclude my own keyboard being at fault, I've also noticed the right
Alt key on my keyboard cannot be used for the release.

Best,
Howard
