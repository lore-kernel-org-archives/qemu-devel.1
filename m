Received: from eggs.gnu.org ([2001:4830:134:3::10]:36142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fG3JK-0003u7-Uw
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:09:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fG3JI-0006Fn-85
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:09:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46944 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fG3JI-0006FS-3K
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:09:44 -0400
Date: Tue, 8 May 2018 15:09:31 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180508140931.GA30745@stefanha-x1.localdomain>
References: <20180502100422.8688-1-peterx@redhat.com>
	<20180502100422.8688-4-peterx@redhat.com>
	<20180508102338.GE19710@stefanha-x1.localdomain>
	<20180508103232.GA19024@xz-mi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <20180508103232.GA19024@xz-mi>
Subject: Re: [Qemu-devel] [PATCH v4 3/4] monitor: more comments on lock-free
 fleids/funcs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 08, 2018 at 06:32:32PM +0800, Peter Xu wrote:
> On Tue, May 08, 2018 at 11:23:38AM +0100, Stefan Hajnoczi wrote:
> > On Wed, May 02, 2018 at 06:04:21PM +0800, Peter Xu wrote:
> > > Add some explicit comment for both Readline and cpu_set/cpu_get helpe=
rs
> > > that they do not need the mon_lock protection.
> > >=20
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  monitor.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/monitor.c b/monitor.c
> > > index 9f361ec21e..6100ad44f8 100644
> > > --- a/monitor.c
> > > +++ b/monitor.c
> > > @@ -207,6 +207,7 @@ struct Monitor {
> > >      int suspend_cnt;            /* Needs to be accessed atomically */
> > >      bool skip_flush;
> > >      bool use_io_thr;
> > > +    /* Only used in parser, so no lock needed. */
> > >      ReadLineState *rs;
> > >      MonitorQMP qmp;
> > >      gchar *mon_cpu_path;
> >=20
> > Which fields does this comment cover?
>=20
> "rs" only.  Maybe I should move the comment to the end of line?
>=20
>     ReadLineState *rs;       /* Only used in parser, so no lock needed. */

Yes, please.

Stefan

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa8a+bAAoJEJykq7OBq3PIlmUH/0klIuoxUqQoTKZuHUm8Yn8e
yzDnqPxX8Taaw4WRx1Xiq8VKsKfBNYFWWo6jlNvISkRQtKozw7+NjTY2mlzl+OJp
auRnXnxls6AFRPMhJio0EU3DQBIX6PRtqbK//fuV6Ra1arlBM4a/RaOFoZict9vr
c29IZVl+iihI62/W07m+musnm+0CmuiWYKPTyZgE3BT0WSvh07cH8obmrEG9VpED
EjsJE6NnEj5X5KAB4HKDHd4NT3rDVK7hUoWW2+aOOywt/pdVYmKKkvOQ72omXRir
KtpLce5TWQlVxc2ARJOVsRf/n02zydBrfp1Ld6BVUp+ik/xvKDXWeFnxheqxmqc=
=WsvI
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
