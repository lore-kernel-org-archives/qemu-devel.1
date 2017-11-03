Received: from eggs.gnu.org ([2001:4830:134:3::10]:39319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAaoU-00062v-Q8
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 08:11:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAaoU-00074m-1w
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 08:11:06 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:47581)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eAaoT-00073K-R5
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 08:11:05 -0400
Received: by mail-wm0-x231.google.com with SMTP id r196so1078555wmf.2
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 05:11:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1509710857.31823.22.camel@redhat.com>
References: <20171023210803.20998-1-makovick@gmail.com>
	<20171023210803.20998-5-makovick@gmail.com>
	<1509532830.3856.7.camel@redhat.com>
	<CAHmvugcYmaujAYGwpb+ObistFr522W1XsuV-6jUgi543VgfvTA@mail.gmail.com>
	<1509701213.31823.11.camel@redhat.com>
	<CAFEAcA8RbiuAwwW4oqD_i2NGMeAao8KU=pWP7faM0QbajHgMYw@mail.gmail.com>
	<1509705342.31823.16.camel@redhat.com>
	<CAFEAcA_DbZ_1WxjtN5NiY3drFgqmJpZwxcrKSeYtqqkjkq0hUA@mail.gmail.com>
	<1509706872.31823.20.camel@redhat.com>
	<CAFEAcA9kLX19tWACRLEGSd6iuRahTkBrORJqt1GSBSAA4bwr6g@mail.gmail.com>
	<1509710857.31823.22.camel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Nov 2017 12:10:43 +0000
Message-ID: <CAFEAcA9J+uQ4xRSddJJPFC_Dk_j9+ESG1NY4B7qxkzasN86qFw@mail.gmail.com>
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

On 3 November 2017 at 12:07, Gerd Hoffmann <kraxel@redhat.com> wrote:
>   Hi,
>
>> I don't think we have the same grab semantics exactly on all
>> UI frontends either, so I dunno that that "doesn't grab on tablet"
>> is true either.
>
> Well, there are pointer grabs and keyboard grabs.
>
> Pointer grabs happen in relative mouse mode only, and I'm pretty sure
> we are consistent here.

Looking at the cocoa code, we grab the mouse even for absolute.
Commit f61c387ea627079b3 says we did that to align with SDL.

There's also the question of how grabs interact with fullscreen.

thanks
-- PMM
