Received: from eggs.gnu.org ([2001:4830:134:3::10]:52678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fBENa-0003yD-Tk
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 02:58:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fBENX-0007ur-15
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 02:58:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48556 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fBENW-0007ua-Sa
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 02:58:10 -0400
Date: Wed, 25 Apr 2018 14:57:59 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180425065759.GL9036@xz-mi>
References: <20180425054046.21519-1-peterx@redhat.com>
	<87wowvakcy.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wowvakcy.fsf@dusky.pond.sub.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] checkpatch.pl: add common glib defines to
 typelist
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, Apr 25, 2018 at 08:08:45AM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
>=20
> > Otherwise it can warn this:
> >
> >   ERROR: space prohibited between function name and open parenthesis =
'('
> >
> > When with things like this:
> >
> >   typedef gboolean (*it_tree_iterator)(ITValue start, ITValue end);
> >
> > CC: Paolo Bonzini <pbonzini@redhat.com>
> > CC: Stefan Hajnoczi <stefanha@redhat.com>
> > CC: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> > CC: Markus Armbruster <armbru@redhat.com>
> > CC: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > CC: Fam Zheng <famz@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  scripts/checkpatch.pl | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index d52207a3cc..6c25449cd3 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -266,6 +266,20 @@ our @typeList =3D (
> >  	qr{target_(?:u)?long},
> >  	qr{hwaddr},
> >  	qr{xml${Ident}},
> > +	# Glib definitions
> > +	qr{gchar},
> > +	qr{gshort},
> > +	qr{glong},
> > +	qr{gint},
> > +	qr{gboolean},
> > +	qr{guchar},
> > +	qr{gushort},
> > +	qr{gulong},
> > +	qr{guint},
> > +	qr{gfloat},
> > +	qr{gdouble},
> > +	qr{gpointer},
> > +	qr{gconstpointer},
> >  );
> > =20
> >  # This can be modified by sub possible.  Since it can be empty, be c=
areful
>=20
> Personally, I'd kill these with fire, then salt the fields that bore
> them.
>=20
> But as long as we have them in our code, checkpatch needs to cope.
> Let's list all types documented in
> <https://developer.gnome.org/glib/stable/glib-Basic-Types.html>.
> Missing:
>=20
>     gint8
>     guint8
>     gint16
>     guint16
>     gint32
>     guint32
>     gint64
>     guint64
>     gsize
>     gssize
>     goffset
>     gintptr
>     guintptr

I got the old list from the header file (glib/gtypes.h) directly, so I
should go for the document next time!  It's strange that I can hardly
find where is, e.g. gint8, defined.  Anyway, I'm posting a new one.

Thanks!

--=20
Peter Xu
