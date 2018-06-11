Received: from eggs.gnu.org ([2001:4830:134:3::10]:44458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fSPx7-00053O-Ig
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 12:45:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fSPx2-0002fz-IQ
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 12:45:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58774 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fSPx2-0002fg-Cf
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 12:45:52 -0400
Date: Mon, 11 Jun 2018 17:45:49 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180611164549.GI17756@stefanha-x1.localdomain>
References: <20180604080630.10946-1-peterx@redhat.com>
	<87tvqeyfs2.fsf@dusky.pond.sub.org> <20180608044235.GA7736@xz-mi>
	<20180608080446.GH29183@stefanha-x1.localdomain>
	<87a7s5snce.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8/UBlNHSEJa6utmr"
Content-Disposition: inline
In-Reply-To: <87a7s5snce.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH] monitor: postpone
 monitor_qmp_cleanup_queues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Peter Xu <peterx@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--8/UBlNHSEJa6utmr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 08, 2018 at 10:18:25AM +0200, Markus Armbruster wrote:
> Stefan Hajnoczi <stefanha@gmail.com> writes:
> > On Fri, Jun 08, 2018 at 12:42:35PM +0800, Peter Xu wrote:
> >> On Thu, Jun 07, 2018 at 01:53:01PM +0200, Markus Armbruster wrote:
> >> > Peter Xu <peterx@redhat.com> writes:
> >> >=20
> >> > > Previously we cleanup the queues when we got CLOSED event.  It was=
 used
> >> >=20
> >> > we clean up
> >> >=20
> >> > > to make sure we won't leftover replies/events of a old client to a=
 new
> >> >=20
> >> > we won't send leftover replies/events of an old client
> >> >=20
> >> > > client.  Now this patch postpones that until OPENED.
> >> >=20
> >> > What if OPENED never comes?
> >>=20
> >> Then we clean that up until destruction of the monitor.  IMHO it's
> >> fine, but I'm not sure whether that's an overall acceptable approach.
> >
> > I think this patch fixes the problem at the wrong level.  Marc-Andr=E9's
> > fix seemed like a cleaner solution.
>=20
> Is it the right solution?
>=20
> I proposed another one:

Sorry, I won't be able to participate in this because I'm behind on
other patches and tasks.  Therefore, feel free to disregard but I'll
give my 2 cents:

This seems like a chardev bug.  The solution should probably be in the
chardev layer (Marc-Andr=E9's patch or something else), not in the monitor
(this patch).

Even if there is a monitor change, it's probably necessary to at least
clarify the meaning of the CLOSE event to reduce the chance of similar
bugs in future chardev users.

Stefan

--8/UBlNHSEJa6utmr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbHqc9AAoJEJykq7OBq3PItn4H/3O6esr9NPeoj5jYb/1FNhQg
TNIfRqNLXpo3OgOBjVWi8PV0xuFxRdw0GH7uqvZ25kKSgr549mzP1Nj5UM2XxmAv
2s1CzTag4ISi/lK4G6wiKik1hCb3nX6xp+4/m7Th2mXL+na4WGuji0vbaQu7H20Z
Hmax2DsuRa7uBKkAbk+ltSHvMHUTOmuaQhKcuG+Zu9pZqy5ZCRiSCg+AcgyKBtFQ
RQ4fqfyTncoGc01htJNa6b2UCU/oK15RbKEviqPz8N2kbnicyoRB4CxUSn+PgjZn
24LOPyU6TkihmQBP83kwNHc3u8UDpSyG5K90fkAyCUXQM/4zCqNVGHRAt8lAl7c=
=5Rn5
-----END PGP SIGNATURE-----

--8/UBlNHSEJa6utmr--
