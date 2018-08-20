Received: from eggs.gnu.org ([2001:4830:134:3::10]:34162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1frn01-0001qJ-50
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 12:25:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1frn00-0002Zd-Eo
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 12:25:49 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46754)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1frn00-0002ZN-8Z
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 12:25:48 -0400
Received: by mail-wr1-x441.google.com with SMTP id a108-v6so10816110wrc.13
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 09:25:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180720063109.4631-1-pbonzini@redhat.com>
	<f5d4ea7c-0799-a30d-9afe-e5b83448011d@redhat.com>
In-Reply-To: <f5d4ea7c-0799-a30d-9afe-e5b83448011d@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 20 Aug 2018 18:25:35 +0200
Message-ID: <CAJ+F1C+uSzcm6GBvaraMuxax=xUxwEU2Zbj4DnXYyRUb242n+Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC/RFT PATCH 0/2] spice-display locking fixes
 (cursors)?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On Mon, Aug 20, 2018 at 5:29 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 20/07/2018 08:31, Paolo Bonzini wrote:
> > The first issue was found by Coverity and should be trivial.  The secon=
d
> > however made me wonder how to test the code and whether it has ever
> > worked, because in theory it should be an instant deadlock whenever
> > qemu_spice_cursor_refresh_bh is called.
> >
> > So I'm looking for help.  In fact, the changes are not tested beyond
> > compilation.
> >
> > Paolo
> >
> > Paolo Bonzini (2):
> >   spice-display: access ptr_x/ptr_y under Mutex
> >   spice-display: fix qemu_spice_cursor_refresh_bh locking
> >
> >  ui/spice-display.c | 37 +++++++++++++++++++++++++------------
> >  1 file changed, 25 insertions(+), 12 deletions(-)
> >
>
> Ping?
>


tested &
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



--=20
Marc-Andr=C3=A9 Lureau
