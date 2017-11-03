Received: from eggs.gnu.org ([2001:4830:134:3::10]:54604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAZrv-0003NU-MG
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:10:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAZru-000487-RZ
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:10:35 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:48064)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eAZru-00047f-Ka
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:10:34 -0400
Received: by mail-wr0-x230.google.com with SMTP id y39so2185710wrd.4
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 04:10:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1509706872.31823.20.camel@redhat.com>
References: <20171023210803.20998-1-makovick@gmail.com>
	<20171023210803.20998-5-makovick@gmail.com>
	<1509532830.3856.7.camel@redhat.com>
	<CAHmvugcYmaujAYGwpb+ObistFr522W1XsuV-6jUgi543VgfvTA@mail.gmail.com>
	<1509701213.31823.11.camel@redhat.com>
	<CAFEAcA8RbiuAwwW4oqD_i2NGMeAao8KU=pWP7faM0QbajHgMYw@mail.gmail.com>
	<1509705342.31823.16.camel@redhat.com>
	<CAFEAcA_DbZ_1WxjtN5NiY3drFgqmJpZwxcrKSeYtqqkjkq0hUA@mail.gmail.com>
	<1509706872.31823.20.camel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Nov 2017 11:10:12 +0000
Message-ID: <CAFEAcA9kLX19tWACRLEGSd6iuRahTkBrORJqt1GSBSAA4bwr6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 4/7] sdl2: Only accept the hotkeys on the
 main window
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?B?SmluZMWZaWNoIE1ha292acSNa2E=?= <makovick@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

On 3 November 2017 at 11:01, Gerd Hoffmann <kraxel@redhat.com> wrote:
>   Hi,
>
>> There's a patch in-flight to switch cocoa to ctrl-alt-g.
>> (If you think that's a bad idea it would be useful to reply
>> to that patch.)
>
> I personally don't mind much.  I rarely use it.  With a tablet added to
> the guest (which I expect most people do these days) mouse grabs don't
> happen anyway.

I don't think we have the same grab semantics exactly on all
UI frontends either, so I dunno that that "doesn't grab on tablet"
is true either.

> But when switching cocoa it makes sense to switch sdl too for
> consistency.
>
>> Using plain ctrl-alt for ungrab has the disadvantage that you
>> then can't send the guest any ctrl-alt-anything combos at all,
>> I think.
>
> I think it works, because SDL does the ungrab on ctrl-alt key
> *release*.

This is exactly the kind of fine detail it would be helpful to
have written down so we can be consistent :-)

thanks
-- PMM
