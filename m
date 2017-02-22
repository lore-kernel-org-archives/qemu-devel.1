Received: from eggs.gnu.org ([2001:4830:134:3::10]:42997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cgSqw-0005YT-4P
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 04:04:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cgSqv-0000U1-4y
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 04:04:50 -0500
Received: from mail-lf0-x22c.google.com ([2a00:1450:4010:c07::22c]:36229)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cgSqu-0000T1-Pj
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 04:04:49 -0500
Received: by mail-lf0-x22c.google.com with SMTP id b80so2636968lfe.3
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 01:04:48 -0800 (PST)
MIME-Version: 1.0
References: <1487663858-11731-1-git-send-email-kraxel@redhat.com>
	<CAJ+F1CLK3aPi+aDgHGUjCCF2Xbi1V=g5UjM_BAko_PSfau33KA@mail.gmail.com>
	<1487668309.2694.37.camel@redhat.com>
	<CAJ+F1C+0jQ=e3dC--qWGDzhjAHtxDeYd_FRo3QGfWKO-thQ3yA@mail.gmail.com>
	<1487671486.2694.65.camel@redhat.com>
In-Reply-To: <1487671486.2694.65.camel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 22 Feb 2017 09:04:36 +0000
Message-ID: <CAJ+F1CLAsqBe7B81wOzVrLWJVsWpQQ4kfH1ZPgMxpwZmaE7qJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] spice: add display & head options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

Hi

On Tue, Feb 21, 2017 at 2:04 PM Gerd Hoffmann <kraxel@redhat.com> wrote:

>   Hi,
>
> > It's always 0, except with virtio.
> >
> > But I think virtio linux driver multi-monitor code would work with a
> > single qemu head (like qxl, fwiw last time I checked, multi-monitor
> > virtio+spice worked, with 3d too).
>
> > It seems to me the qemu "head" is quite different (lower-level) from
> > spice "head".
>
> Well.  spice/qxl supports two different ways to do multihead ...
>
> The first way is one display channel per head.  Which maps nicely to
> qemu heads.  With qxl you'll use one qxl-vga device for the primary
> display and one (or more) qxl devices for the secondary displays.  I
> think multihead with windows guests still works that way, but xorg
> support for that (xinerama mode) is pretty bad.  IIRC it needs manual
> configuration, could also be recent xorg versions don't support it any
> more.  Dunno where we stand with wayland.
>
> The second way is a single display channel with a single, big surface
> for all heads.  Then -- with spice-agent help -- guest and client
> negotiate which region of the big display gets scanned out to which
> head.
>
> Multihead spice with virtio-gpu fundamentally works like the first way,
> except that we have a single device with multiple heads (and display
> channels) instead of multiple devices which have a single head each.
>

ok


>
> The use case I see for this is not so much multihead configuration.
> With multiple display devices in your system, for example one intel-vgpu
> and one emulated display device one could export only one of the two via
> spice.
>

My understanding is that "head" will not work correctly with QXL (only head
0, but can be a multi-head QXL), but should do what you expect with virtio.

thanks
--=20
Marc-Andr=C3=A9 Lureau
