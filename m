Received: from eggs.gnu.org ([2001:4830:134:3::10]:58073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wlosh@bsdimp.com>) id 1gNf3q-0004P5-2h
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 09:25:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wlosh@bsdimp.com>) id 1gNf3o-0004X9-8k
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 09:25:30 -0500
Received: from mail-it1-x12e.google.com ([2607:f8b0:4864:20::12e]:50451)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wlosh@bsdimp.com>) id 1gNf3m-0004Vk-GD
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 09:25:27 -0500
Received: by mail-it1-x12e.google.com with SMTP id k206-v6so34897015ite.0
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 06:25:24 -0800 (PST)
MIME-Version: 1.0
References: <20181115085808.GH27915@xz-x1>
	<162b1a37-79d7-8133-22ee-688748fe62b1@redhat.com>
	<20181116025304.GC11565@xz-x1>
	<CANCZdfrozw4f+ntOyUuX+N1Ny1j+BBEqhuowPXk2sRTSBzCGEw@mail.gmail.com>
	<20181116050134.GA16550@xz-x1>
	<CAFEAcA_r6QmSHHpvRCAOic1EppZamfhwFVQ_R7dUvNzomfNsgg@mail.gmail.com>
	<20181116123026.bcjmirbs2sl2phm7@sirius.home.kraxel.org>
In-Reply-To: <20181116123026.bcjmirbs2sl2phm7@sirius.home.kraxel.org>
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 16 Nov 2018 07:25:11 -0700
Message-ID: <CANCZdfojn3U6NkQRyJWBBwsGNBu_XMDRpHH7JuOWEidaRjJkUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Are FreeBSD guest images working?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>, Ilya Maximets <i.maximets@samsung.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

On Fri, Nov 16, 2018, 5:30 AM Gerd Hoffmann <kraxel@redhat.com wrote:

> On Fri, Nov 16, 2018 at 09:47:48AM +0000, Peter Maydell wrote:
> > On 16 November 2018 at 05:01, Peter Xu <peterx@redhat.com> wrote:
> > > I would guess there aren't many people like me to prefer booting a VM
> > > using console, though I agree that it'll be nice if we put something
> > > into the prebuilt images like what's suggested by Ilya (and so far I
> > > don't see anything bad with that):
> >
> > As it happens I would have preferred the instructions on
> > the QEMU wiki to work with a pure serial console but was unable
> > to get that working so defaulted to graphics. (I didn't try very
> > hard: x86 in general is much worse for getting serial boot
> > working than other architectures, partly because of the BIOS.)
>
> qemu-system-x86_64 -machine graphics=off should work reasonable well
> these days.
>

That's what I use to test the boot blocks / boot loader :)

Warner

>
