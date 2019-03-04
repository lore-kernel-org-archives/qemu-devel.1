Received: from eggs.gnu.org ([209.51.188.92]:43534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1h0hig-0004cy-II
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 02:09:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1h0hif-0000hq-OQ
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 02:09:02 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:32994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1h0hif-0000h4-Gp
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 02:09:01 -0500
Date: Mon, 4 Mar 2019 08:08:57 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20190304070857.zxgn6qt3wzjxjca4@function>
References: <20190303104430.7692-1-samuel.thibault@ens-lyon.org>
	<20190303104430.7692-3-samuel.thibault@ens-lyon.org>
	<87h8cjdtpp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h8cjdtpp.fsf@dusky.pond.sub.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] curses: add option to specify VGA font
 encoding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Eddie Kohler <ekohler@gmail.com>, kraxel@redhat.com, pbonzini@redhat.com

Markus Armbruster, le lun. 04 mars 2019 07:44:34 +0100, a ecrit:
> Samuel Thibault <samuel.thibault@ens-lyon.org> writes:
> > --- a/qapi/ui.json
> > +++ b/qapi/ui.json
> > @@ -1131,6 +1131,7 @@
> >  # @full-screen:   Start user interface in fullscreen mode (default: =
off).
> >  # @window-close:  Allow to quit qemu with window close button (defau=
lt: on).
> >  # @gl:            Enable OpenGL support (default: off).
> > +# @charset:       Font charset used by guest (default: CP437).
>=20
> Can you give brief rationale for defaulting to CP437?

I have added to the commit message:

=E2=80=9C
The default charset is made CP437 since that is the charset of the
hardware default VGA font.
=E2=80=9D

> > @@ -492,6 +709,10 @@ static void curses_display_init(DisplayState *ds=
, DisplayOptions *opts)
> >      }
> >  #endif
> > =20
> > +    setlocale(LC_CTYPE, "");
>=20
> General principles: any change to locale deserves prominent mention in
> the commit message.

I have added to the commit message:

=E2=80=9C
This also makes the curses backend set the LC_CTYPE locale to "" to
allow curses to emit wide characters.
=E2=80=9D

Samuel
