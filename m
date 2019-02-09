Received: from eggs.gnu.org ([209.51.188.92]:40311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gsSTY-0006dx-Kz
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 08:15:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gsSTY-0004Mu-0h
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 08:15:20 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51347)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gsSTX-0004Ln-NF
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 08:15:19 -0500
Received: by mail-wm1-x344.google.com with SMTP id b11so8388878wmj.1
	for <qemu-devel@nongnu.org>; Sat, 09 Feb 2019 05:15:19 -0800 (PST)
MIME-Version: 1.0
References: <20181220141553.24098-1-marcandre.lureau@redhat.com>
	<20181220141553.24098-11-marcandre.lureau@redhat.com>
	<461252a9-b095-9441-054c-bb9dd00f8cf5@redhat.com>
	<20190107094555.es7xunsor2aud3k7@sirius.home.kraxel.org>
In-Reply-To: <20190107094555.es7xunsor2aud3k7@sirius.home.kraxel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 9 Feb 2019 14:15:06 +0100
Message-ID: <CAJ+F1CKxmZdycF8q83ziSUB5Bnwk=NFASgfjJkEDsjuQ7vcSww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 10/12] qapi: document DisplayType enum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, QEMU <qemu-devel@nongnu.org>

Hi

On Mon, Jan 7, 2019 at 10:46 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Thu, Dec 20, 2018 at 08:46:13AM -0600, Eric Blake wrote:
> > On 12/20/18 8:15 AM, Marc-Andr=C3=A9 Lureau wrote:
> > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > ---
> > >   qapi/ui.json | 24 ++++++++++++++++++++++++
> > >   1 file changed, 24 insertions(+)
> > >
> > > diff --git a/qapi/ui.json b/qapi/ui.json
> > > index 5ad13248d5..3f2f662dca 100644
> > > --- a/qapi/ui.json
> > > +++ b/qapi/ui.json
> > > @@ -1075,6 +1075,30 @@
> > >   #
> > >   # Display (user interface) type.
> > >   #
> > > +# @default: The default user interface.
> >
> > Any more hints on how this default is determined?  Is it a compile-time
> > decision, based on what libraries were linked in?
>
> Basically yes.  A bit more complicated due to modules.  gtk, sdl and
> cocoa are checked, in that order.  And if none of them is available the
> vnc server is enabled.


Eric, should I cram this comment there?: "(gtk, sdl and
cocoa are checked, in that order.  And if none of them is available the
vnc server is enabled)"

thanks

>
> > Does the work on adding
> > #if support to qapi make it introspectible what the default is?
>
> Due to modules it isn't a compile time constant.  With a modular build
> and gtk being packaged as separate sub-rpm the default depends on
> whenever the sub-rpm is installed or not.
>
> So I guess the answer is "no".
>
> cheers,
>   Gerd
>



--=20
Marc-Andr=C3=A9 Lureau
