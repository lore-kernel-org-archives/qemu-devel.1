Received: from eggs.gnu.org ([2001:4830:134:3::10]:47939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAZQE-0001G1-8e
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 06:41:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAZQD-0008Ol-G5
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 06:41:58 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:46853)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eAZQD-0008NS-92
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 06:41:57 -0400
Received: by mail-wr0-x233.google.com with SMTP id l1so2116507wrc.3
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 03:41:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1509705342.31823.16.camel@redhat.com>
References: <20171023210803.20998-1-makovick@gmail.com>
	<20171023210803.20998-5-makovick@gmail.com>
	<1509532830.3856.7.camel@redhat.com>
	<CAHmvugcYmaujAYGwpb+ObistFr522W1XsuV-6jUgi543VgfvTA@mail.gmail.com>
	<1509701213.31823.11.camel@redhat.com>
	<CAFEAcA8RbiuAwwW4oqD_i2NGMeAao8KU=pWP7faM0QbajHgMYw@mail.gmail.com>
	<1509705342.31823.16.camel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Nov 2017 10:41:35 +0000
Message-ID: <CAFEAcA_DbZ_1WxjtN5NiY3drFgqmJpZwxcrKSeYtqqkjkq0hUA@mail.gmail.com>
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

On 3 November 2017 at 10:35, Gerd Hoffmann <kraxel@redhat.com> wrote:
> On Fri, 2017-11-03 at 09:37 +0000, Peter Maydell wrote:
>> Also I think it would be nice to have written up what the
>> "expected" set of hotkeys for UI frontends are, so we can
>> be consistent. I think SDL and gtk are different about what
>> their ungrab keycombo is, for instance. (I've been assuming
>> gtk is the "this is the right behaviour" exemplar to follow.)
>
> That is another mess I'll plan to look at, because I want rework the
> display command line switches parsing.  So, the current state is:
>
> gtk ungrab is ctrl-alt-g.
> sdl ungrab is ctrl-alt (by default, but see below).
> cocoa ungrab is ctl-alt too.
> For reference: virt-viewer (vnc/spice client) likewise uses ctrl-alt.
>
> So it seems gtk is the odd one here.  Possibly due to how hotkeys are
> implemented in gtk, could be a GtkAccelGroup simply doesn't support
> modifier-only hotkeys.

There's a patch in-flight to switch cocoa to ctrl-alt-g.
(If you think that's a bad idea it would be useful to reply
to that patch.)

Using plain ctrl-alt for ungrab has the disadvantage that you
then can't send the guest any ctrl-alt-anything combos at all,
I think.

thanks
-- PMM
