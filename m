Received: from eggs.gnu.org ([2001:4830:134:3::10]:47526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fM8bu-0002df-4t
	for qemu-devel@nongnu.org; Fri, 25 May 2018 05:02:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fM8bp-00066M-67
	for qemu-devel@nongnu.org; Fri, 25 May 2018 05:02:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33630 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fM8bp-00066A-1Y
	for qemu-devel@nongnu.org; Fri, 25 May 2018 05:02:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 949C540122A1
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 09:01:59 +0000 (UTC)
Date: Fri, 25 May 2018 10:01:57 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180525090157.GB14757@stefanha-x1.localdomain>
References: <20180524043952.11245-1-peterx@redhat.com>
	<20180524043952.11245-5-peterx@redhat.com>
	<20180524092837.GD20733@stefanha-x1.localdomain>
	<20180525033022.GK12122@xz-mi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Content-Disposition: inline
In-Reply-To: <20180525033022.GK12122@xz-mi>
Subject: Re: [Qemu-devel] [PATCH v7 4/4] monitor: add lock to protect
 mon_fdsets
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


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 25, 2018 at 11:30:22AM +0800, Peter Xu wrote:
> On Thu, May 24, 2018 at 10:28:37AM +0100, Stefan Hajnoczi wrote:
> > On Thu, May 24, 2018 at 12:39:52PM +0800, Peter Xu wrote:
> > >  int monitor_fdset_get_fd(int64_t fdset_id, int flags)
> > >  {
> > > -#ifndef _WIN32
> > > +#ifdef _WIN32
> > > +    return -ENOENT;
> >=20
> > stubs/fdset.c:monitor_fdset_get_fd() should return -ENOENT instead of -1
> > now.
>=20
> Yes that's intended.  That's actually a suggestion from Markus since
> changing the return code will simplify the code.

No, I understand that part.  I'm pointing out that
stubs/fdset.c:monitor_fdset_get_fd() still returns -1 because it was not
updated by this patch.

Since this patch changes the return value to -errno, the stub function
should be updated to return a sensible -errno value too.

Stefan

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbB9EFAAoJEJykq7OBq3PISycIAIxAg8qkbTma+OSDZ3M4GPRH
OBKE228AUQ+zYzhN5qereHUG3xo0yW0PsV3TtWnKdWGHB9BV1BdMMCIpA1fekx/S
NuiH6Qg1On47rSSjAvGTZp9QyZww6aL5dhEfHJScR71JVr0/+SvMBS4sLBKhGW9O
pjFiDEWygRAWO+LhJnueQ/JX7JcWdywIX28q1m8W7uQ6zHWWCbTPR8g2bMDlqzkZ
i26Yt64otk6oT7Cj6MW9uDBEl/k4FCOw8PZJC3+FWnXvkZqLnFmLTlWYi5yYQVI9
Tuw5p300Airhl746dGGIeeTCMrkSCM3UkwvPG6hgl0/A2NB6PeSO93qX2qvRk48=
=x3Id
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
