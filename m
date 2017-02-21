Received: from eggs.gnu.org ([2001:4830:134:3::10]:59011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cg6fT-0000tn-SY
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:23:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cg6fT-0001MM-46
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:23:31 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:34025)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cg6fS-0001Ls-TC
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:23:31 -0500
Received: by mail-lf0-x244.google.com with SMTP id h67so2795910lfg.1
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 01:23:30 -0800 (PST)
MIME-Version: 1.0
References: <1487663858-11731-1-git-send-email-kraxel@redhat.com>
	<CAJ+F1CLK3aPi+aDgHGUjCCF2Xbi1V=g5UjM_BAko_PSfau33KA@mail.gmail.com>
	<1487668309.2694.37.camel@redhat.com>
In-Reply-To: <1487668309.2694.37.camel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 21 Feb 2017 09:23:18 +0000
Message-ID: <CAJ+F1C+0jQ=e3dC--qWGDzhjAHtxDeYd_FRo3QGfWKO-thQ3yA@mail.gmail.com>
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

On Tue, Feb 21, 2017 at 1:11 PM Gerd Hoffmann <kraxel@redhat.com> wrote:

> On Di, 2017-02-21 at 08:52 +0000, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Tue, Feb 21, 2017 at 11:58 AM Gerd Hoffmann <kraxel@redhat.com>
> > wrote:
> >
> >         This allows to specify display and head to use, simliar to
> >         vnc.
> >
> >
> >
> > Does "head" in qemu always match the head for multi-monitor spice?
> > (with a single qxl/virtio).
>
> Yes, head as specified in graphic_console_init().
>

It's always 0, except with virtio.

But I think virtio linux driver multi-monitor code would work with a single
qemu head (like qxl, fwiw last time I checked, multi-monitor virtio+spice
worked, with 3d too). It seems to me the qemu "head" is quite different
(lower-level) from spice "head".

The relation would need to be clarified imho before we expose this option.
--=20
Marc-Andr=C3=A9 Lureau
