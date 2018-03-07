Received: from eggs.gnu.org ([2001:4830:134:3::10]:46367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etZtj-0000b2-RZ
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 09:18:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etZtg-0001S2-2L
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 09:18:27 -0500
Received: from mail-oi0-x22e.google.com ([2607:f8b0:4003:c06::22e]:40054)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1etZtf-0001Ro-SO
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 09:18:23 -0500
Received: by mail-oi0-x22e.google.com with SMTP id c12so1747305oic.7
	for <qemu-devel@nongnu.org>; Wed, 07 Mar 2018 06:18:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180307141118.cbgvj55p4wcrphyw@sirius.home.kraxel.org>
References: <CAFEAcA8Wz4q=+HDpSG_pFHB7xKMez6hCPFodoOxoTgr1FOy5nA@mail.gmail.com>
	<20180305103307.GL17368@redhat.com>
	<20180307141118.cbgvj55p4wcrphyw@sirius.home.kraxel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Mar 2018 14:18:02 +0000
Message-ID: <CAFEAcA-j_tZVKwnKzQP6bHahxHUge53vibgkVyVQFmDzS4F7Zg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] QEMU fails to configure on non-x86 hosts with
 recent SDL2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 7 March 2018 at 14:11, Gerd Hoffmann <kraxel@redhat.com> wrote:
>   Hi,
>
>> > Any suggestions for how to do a workaround?
>>
>> Drop -Wundef when running the configiure test, or override it with -Wno-undef
>>
>> If the actual ui/sdl* files fail for same reason, we could use a gcc
>> pragma top disable -Wundef in just those files, or set -Wno-undef in
>> CFLAGS on a per-.o file basis in Makefile.objs
>
> What is the status here?  Could you try this peter?  Don't have a test
> box with SDL 2.0.8 at hand ...

Haven't tried it, but I'm pretty sure it would work. For the
moment I just passed --disable-sdl to configure...

> Any reaction from debian/upstream?  Given that this probably affects
> pretty much any SDL user and 2.0.8 is a few days old only a quick 2.0.9
> bugfix release would be the best solution I guess.

Nothing from Debian yet; haven't tried to contact upstream
(feel free to do that yourself).

thanks
-- PMM
