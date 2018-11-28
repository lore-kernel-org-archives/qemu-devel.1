Received: from eggs.gnu.org ([2001:4830:134:3::10]:39160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gRv4o-0007iE-Kn
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 03:20:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gRv4n-0000uQ-RE
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 03:20:06 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41565)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gRv4n-0000u1-Ke
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 03:20:05 -0500
Received: by mail-wr1-x444.google.com with SMTP id x10so25302037wrs.8
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 00:20:05 -0800 (PST)
MIME-Version: 1.0
References: <20181126153036.22414-1-fziglio@redhat.com>
	<20181127123502.GZ12172@natto.ory.fergeau.eu>
	<20181128054850.exrlih6zqskaw7a7@sirius.home.kraxel.org>
In-Reply-To: <20181128054850.exrlih6zqskaw7a7@sirius.home.kraxel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 28 Nov 2018 12:19:51 +0400
Message-ID: <CAJ+F1CKbLZuivyqcDCWxfBJY=VscGGeR7Cp5uFDvXduGxbocpA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Spice-devel] [PATCH] spice: Use new
 SpiceImageCompression definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Christophe Fergeau <cfergeau@redhat.com>, spice-devel <spice-devel@lists.freedesktop.org>, QEMU <qemu-devel@nongnu.org>

Hi
On Wed, Nov 28, 2018 at 9:48 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Tue, Nov 27, 2018 at 01:35:02PM +0100, Christophe Fergeau wrote:
> > hey,
> >
> > On Mon, Nov 26, 2018 at 03:30:36PM +0000, Frediano Ziglio wrote:
> > > Definitions were updated by spice-server in patch de66161 included
> > > in 0.12.6 released on 12th June 2015.
> >
> > QEMU's configure only checks for spice-server 0.12.0:
>
> > I don't know how far back QEMU wants to support spice-server.
> > Apart from this, the patch looks good to me.
>
> 0.12.6 is more than three years old, so this or something newer should
> be available in most distros meanwhile.  Raising the bar to that version
> looks ok to me (separate patch please, and please also drop #ifdefs we
> don't need any more then).

See https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg00486.html
"bump spice-server required version to 0.12.6"

> thanks,
>   Gerd
>
> _______________________________________________
> Spice-devel mailing list
> Spice-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/spice-devel



--=20
Marc-Andr=C3=A9 Lureau
