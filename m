Received: from eggs.gnu.org ([2001:4830:134:3::10]:42711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gTpny-00075Z-Ke
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:06:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gTpnw-0007Zu-Gn
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:06:37 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:39712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gTpnw-0007Z2-C7
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:06:36 -0500
Received: by mail-oi1-x243.google.com with SMTP id i6so11152805oia.6
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 07:06:36 -0800 (PST)
MIME-Version: 1.0
References: <20181129123502.30129-1-kraxel@redhat.com>
	<b647b71a-ac53-f256-3e16-efa4806b4f7d@redhat.com>
	<20181130112802.tbessg2nohhccgif@sirius.home.kraxel.org>
In-Reply-To: <20181130112802.tbessg2nohhccgif@sirius.home.kraxel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Dec 2018 15:06:24 +0000
Message-ID: <CAFEAcA8DZO-GJZLiG6qNXhWMD2zWWaO5_Tm-R7_nDw-625_PGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-devel for-3.1?] [PATCH] egl-headless: add
 egl_create_context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, 30 Nov 2018 at 11:29, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Thu, Nov 29, 2018 at 08:09:56AM -0600, Eric Blake wrote:
> > On 11/29/18 6:35 AM, Gerd Hoffmann wrote:
> > > We must set the correct context (via eglMakeCurrent) before
> > > calling qemu_egl_create_context, so we need a thin wrapper and can't
> > > hook qemu_egl_create_context directly as ->dpy_gl_ctx_create callback.
> > >
> > > Reported-by: Frederik Carlier <frederik.carlier@quamotion.mobi>
> > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > > ---
> > >   ui/egl-headless.c | 10 +++++++++-
> > >   1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > How severe is this? Is it something that would warrant 3.1-rc4, or are we
> > safe deferring it to 4.0?
>
> Fixes segfaults (should probably update the commit message to say so),
> therefore 3.1 material IMHO.

Original reporter seems to be saying in the bug report that this
doesn't actually fix his bug ?

Is this a regression from 3.0? It doesn't look like it from a
quick look at the git history, so given that plus the uncertainty
about whether it's actually fixing the bug I'm inclined to defer
this to 4.0.

thanks
-- PMM
