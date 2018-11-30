Received: from eggs.gnu.org ([2001:4830:134:3::10]:33009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSmP1-0005El-2S
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 12:16:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSm9i-00068g-GX
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 12:00:43 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:46044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gSm9i-00068N-AI
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 12:00:42 -0500
Received: by mail-oi1-x242.google.com with SMTP id b141so5268839oii.12
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 09:00:42 -0800 (PST)
MIME-Version: 1.0
References: <154356772378.66975.13711686652368325931.stgit@bahia.lan>
	<cf3f805a-4991-04d6-2cbb-6c1cca8bd238@redhat.com>
	<20181130174548.247d293c@bahia.lan>
In-Reply-To: <20181130174548.247d293c@bahia.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Nov 2018 17:00:29 +0000
Message-ID: <CAFEAcA_Z9WqjyikYO9CrvP_sM11NU6F7J0xgEimLzNTN7SKaSQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-3.1?] 9p: remove support for the
 "handle" backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Eric Blake <eblake@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>

On Fri, 30 Nov 2018 at 16:45, Greg Kurz <groug@kaod.org> wrote:
>
> On Fri, 30 Nov 2018 09:52:18 -0600
> Eric Blake <eblake@redhat.com> wrote:
>
> > On 11/30/18 2:49 AM, Greg Kurz wrote:
> > > The "handle" fsdev backend was deprecated in QEMU 2.12.0 with:
> > >
> > > commit db3b3c7281ca82e2647e072a1f97db111313dd73
> > > Author: Greg Kurz <groug@kaod.org>
> > > Date:   Mon Jan 8 11:18:23 2018 +0100
> > >
> > >      9pfs: deprecate handle backend
> >
> > > It has passed the two release cooling period without any complaint.
> > >
> > > Remove it now.
> > >
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > ---
> > >
> > > It could have been removed for 3.1.0, but I woke up too late, so moving
> > > this to 4.0.
> > >
> > > ---
> > >   fsdev/qemu-fsdev.c    |    3
> > >   hw/9pfs/9p-handle.c   |  710 -------------------------------------------------
> > >   hw/9pfs/Makefile.objs |    1
> > >   qemu-deprecated.texi  |    8 -
> > >   qemu-options.hx       |    8 -
> > >   5 files changed, 4 insertions(+), 726 deletions(-)
> > >   delete mode 100644 hw/9pfs/9p-handle.c
> >
> > Well, it certainly doesn't drive -rc4 on its own, but as we may have an
> > -rc4 for other reasons, maybe it could still be argued that this is 3.1
> > material on the grounds of removing questionable code for less attack
> > exposure?
> >
>
> Makes sense, as this is precisely the reason that led me to
> deprecate this in the first place.

I would prefer not to have a 700-line patch in rc4, even
a negative-diffstat one. If it's not a definite problem
then we shouldn't put the change in at this stage in the
release process.

thanks
-- PMM
