Received: from eggs.gnu.org ([209.51.188.92]:48684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ggRTz-0002zR-0C
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 04:46:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ggRTx-0002zK-An
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 04:46:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ggRTx-0002z3-46
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 04:46:05 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3AFFE8762D
	for <qemu-devel@nongnu.org>; Mon,  7 Jan 2019 09:46:04 +0000 (UTC)
Date: Mon, 7 Jan 2019 10:45:55 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190107094555.es7xunsor2aud3k7@sirius.home.kraxel.org>
References: <20181220141553.24098-1-marcandre.lureau@redhat.com>
	<20181220141553.24098-11-marcandre.lureau@redhat.com>
	<461252a9-b095-9441-054c-bb9dd00f8cf5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <461252a9-b095-9441-054c-bb9dd00f8cf5@redhat.com>
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
To: Eric Blake <eblake@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

On Thu, Dec 20, 2018 at 08:46:13AM -0600, Eric Blake wrote:
> On 12/20/18 8:15 AM, Marc-Andr=E9 Lureau wrote:
> > Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   qapi/ui.json | 24 ++++++++++++++++++++++++
> >   1 file changed, 24 insertions(+)
> >=20
> > diff --git a/qapi/ui.json b/qapi/ui.json
> > index 5ad13248d5..3f2f662dca 100644
> > --- a/qapi/ui.json
> > +++ b/qapi/ui.json
> > @@ -1075,6 +1075,30 @@
> >   #
> >   # Display (user interface) type.
> >   #
> > +# @default: The default user interface.
>=20
> Any more hints on how this default is determined?  Is it a compile-time
> decision, based on what libraries were linked in?

Basically yes.  A bit more complicated due to modules.  gtk, sdl and
cocoa are checked, in that order.  And if none of them is available the
vnc server is enabled.

> Does the work on adding
> #if support to qapi make it introspectible what the default is?

Due to modules it isn't a compile time constant.  With a modular build
and gtk being packaged as separate sub-rpm the default depends on
whenever the sub-rpm is installed or not.

So I guess the answer is "no".

cheers,
  Gerd
