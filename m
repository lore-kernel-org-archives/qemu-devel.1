Received: from eggs.gnu.org ([2001:4830:134:3::10]:41016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e5UY9-0006pU-FM
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 06:29:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e5UY4-0000eb-En
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 06:29:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e5UY4-0000eQ-97
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 06:29:04 -0400
Message-ID: <1508495342.18146.8.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 20 Oct 2017 12:29:02 +0200
In-Reply-To: <d34ce785-80bb-c4f5-4e35-2ec71b00344d@msgid.tls.msk.ru>
References: <d34ce785-80bb-c4f5-4e35-2ec71b00344d@msgid.tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] SDL2 issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel qemu-devel <qemu-devel@nongnu.org>

On Fri, 2017-10-20 at 13:05 +0300, Michael Tokarev wrote:
> Hello
> 
> After we tried to switch from SDL1 to SDL2 in Debian qemu,
> we receives quite some reports about various issues.
> 
> We use 2.10.1 version of qemu.
> 
> Example of the issues: http://bugs.debian.org/879193

Doesn't reproduce.

> http://bugs.debian.org/870025 - a few patches at the bottom

Those patches should go to the mailing list.

> http://bugs.debian.org/878087

Yes, -k is simply not supported with sdl2.
Those remappings should be done in the guest instead.

> What's the status of SDL2 support in qemu? I've seen it is
> the default now if SDL2 is present on the system (it was
> SDL1 before).

Yep.  Long term I want drop SDL1, this is the first step.

> Also, what's the status of SDL _audio_ support, is it needed
> at all once we have alsa, pa and oss?

Dunno how well mixing sdl display with non-sdl audio works.  Feel free
to send a patch dropping sdl audio to the list to check what people
think about that ;)

cheers,
  Gerd
