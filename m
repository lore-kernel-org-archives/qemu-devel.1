Received: from eggs.gnu.org ([2001:4830:134:3::10]:40987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fOIrq-00064P-HF
	for qemu-devel@nongnu.org; Thu, 31 May 2018 04:23:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fOIrn-0003A9-CP
	for qemu-devel@nongnu.org; Thu, 31 May 2018 04:23:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53834 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fOIrn-00039r-6g
	for qemu-devel@nongnu.org; Thu, 31 May 2018 04:23:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C930E76F91
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 08:23:26 +0000 (UTC)
Date: Thu, 31 May 2018 09:23:24 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180531082324.GB26429@stefanha-x1.localdomain>
References: <20180529055755.12404-1-peterx@redhat.com>
	<20180529055755.12404-6-peterx@redhat.com>
	<20180530163552.GG5973@stefanha-x1.localdomain>
	<20180531041147.GK27442@xz-mi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xXmbgvnjoT4axfJE"
Content-Disposition: inline
In-Reply-To: <20180531041147.GK27442@xz-mi>
Subject: Re: [Qemu-devel] [PATCH v9 5/7] monitor: remove event_clock_type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--xXmbgvnjoT4axfJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 31, 2018 at 12:11:47PM +0800, Peter Xu wrote:
> On Wed, May 30, 2018 at 05:35:52PM +0100, Stefan Hajnoczi wrote:
> > On Tue, May 29, 2018 at 01:57:53PM +0800, Peter Xu wrote:
> > > Instead, use a dynamic function to detect which clock we'll use.  The
> > > problem is that the old code will let monitor initialization depends =
on
> > > qtest_enabled().  After this change, we don't have such a dependency =
any
> > > more.
> >=20
> > There is a hidden dependency:
> >=20
> >   monitor_get_clock() returns the wrong value before main() has
> >   processed command-line arguments.
>=20
> To be more explicit:
>=20
>     monitor_get_clock() returns the wrong value before accelerator is
>     correctly setup (in configure_accelerator()).
>=20
> Since the only thing that matters here is whether we're using the
> qtest accelerator.
>=20
> >=20
> > Where is the guarantee that monitor_get_clock() is never called too
> > early?
>=20
> You are right, there is no guarantee except from programming POV.
> It's only used in:
>=20
>   monitor_qapi_event_queue
>   monitor_qapi_event_handler
>=20
> These two functions will never be called until accelerator is setup.
>=20
> >=20
> > At the least, monitor_get_clock() should call abort(3) if invoked too
> > early.  Even better would be an interface that cannot be used
> > incorrectly.
>=20
> Maybe then I should export the accel_initialised variable in
> configure_accelerator() and then I assert with that.  But that'll
> further expand the series a bit.
>=20
> Or, I can also mention above in the commit message to explain that a
> bit.

Documentation is okay, but please do it in the code, not the commit
message.  That way anyone looking at monitor_get_clock() will be aware
of the constraint.

Stefan

--xXmbgvnjoT4axfJE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbD7D8AAoJEJykq7OBq3PIZqMH/04f2iSw2+DGrjGUTMSlhoZb
rPXoXt6TmLlUJj5rkPQgbfyjbSJOrIeEErRPzaO9Xbb+zAzAgQtPNzOdmjPt5cZe
Bm2O/XkcaBZSqRZoKTu3tmn4EYr1PY44LraGx3bRjN1k5RzXmNK/oAkMUbJ+pJKO
2xdzypPNrnPSeGJ1BNJqd227vzFCH4DyKtgT0A/YfWltSi+5j47J4XN1+Yafr+ES
G6YTSKiNp+gMbCaAgkMabMn3ZWfdBnFOYJuZMPq+R4UAbAFfC8cspGOCpdyLIeuk
1LFc6igoHhTo1fbr3bZ05LJd8dvPd2X2I27ocwPwRE4Fvmw9f3uSN4ErP6/n1/Q=
=eqwa
-----END PGP SIGNATURE-----

--xXmbgvnjoT4axfJE--
