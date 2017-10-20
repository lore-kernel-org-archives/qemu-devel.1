Received: from eggs.gnu.org ([2001:4830:134:3::10]:49418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e5V8i-0003gq-Eh
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:06:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e5V8f-00010D-Aq
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:06:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1e5V8f-0000zj-44
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:06:53 -0400
References: <d34ce785-80bb-c4f5-4e35-2ec71b00344d@msgid.tls.msk.ru>
	<1508495342.18146.8.camel@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9e4910ab-c841-a814-8cc1-879ddb924b7c@redhat.com>
Date: Fri, 20 Oct 2017 13:06:47 +0200
MIME-Version: 1.0
In-Reply-To: <1508495342.18146.8.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Gerd Hoffmann <kraxel@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, qemu-devel qemu-devel <qemu-devel@nongnu.org>

On 20.10.2017 12:29, Gerd Hoffmann wrote:
> On Fri, 2017-10-20 at 13:05 +0300, Michael Tokarev wrote:
>> Hello
>>
>> After we tried to switch from SDL1 to SDL2 in Debian qemu,
>> we receives quite some reports about various issues.
>>
>> We use 2.10.1 version of qemu.
>>
>> Example of the issues: http://bugs.debian.org/879193
> 
> Doesn't reproduce.
> 
>> http://bugs.debian.org/870025 - a few patches at the bottom
> 
> Those patches should go to the mailing list.
> 
>> http://bugs.debian.org/878087
> 
> Yes, -k is simply not supported with sdl2.
> Those remappings should be done in the guest instead.
> 
>> What's the status of SDL2 support in qemu? I've seen it is
>> the default now if SDL2 is present on the system (it was
>> SDL1 before).
> 
> Yep.  Long term I want drop SDL1, this is the first step.
> 
>> Also, what's the status of SDL _audio_ support, is it needed
>> at all once we have alsa, pa and oss?
> 
> Dunno how well mixing sdl display with non-sdl audio works.  Feel free
> to send a patch dropping sdl audio to the list to check what people
> think about that ;)

I think we've had that topic before: SDL audio is still required for
some non-Linux systems like Haiku, so please don't remove it, even if
SDL audio still needs some love with SDL2 to get really usable there again.

 Thomas
