Received: from eggs.gnu.org ([2001:4830:134:3::10]:42561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dcDdo-0005ox-2m
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 12:34:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dcDdl-0005wU-DQ
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 12:34:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dcDdl-0005w4-7Z
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 12:33:57 -0400
Date: Mon, 31 Jul 2017 17:33:53 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170731163353.GA24783@stefanha-x1.localdomain>
References: <20170731140718.22010-1-stefanha@redhat.com>
	<20170731140718.22010-3-stefanha@redhat.com>
	<87d18g3anv.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <87d18g3anv.fsf@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] trace: add
 trace_event_get_state_backends()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Denis V. Lunev" <den@openvz.org>, "Daniel P. Berrange" <berrange@redhat.com>


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 31, 2017 at 06:09:56PM +0300, Llu=EDs Vilanova wrote:
> Stefan Hajnoczi writes:
>=20
> > Code that checks dstate is unaware of SystemTap and LTTng UST dstate, so
> > the following trace event will not fire when solely enabled by SystemTap
> > or LTTng UST:
>=20
> >   if (trace_event_get_state(TRACE_MY_EVENT)) {
> >       str =3D g_strdup_printf("Expensive string to generate ...",
> >                             ...);
> >       trace_my_event(str);
> >       g_free(str);
> >   }
>=20
> I believe this should be trace_event_get_state_backends(). Same applies t=
o the
> cover letter.

This instance and the cover letter are both showing the pattern in
existing code.

The description "event will not fire" is correct with
trace_event_get_state().  If I change it to
trace_event_get_state_backends() then the description is no longer
correct :).

Stefan

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZf1vxAAoJEJykq7OBq3PI7YcIAJP2Xxj8IxTgYD1VRtN/oDrT
1h70D4RNgf30aNoImYowxLnv00XwXBW/F6Gt8aZEX7YIQZOeuSz5KXfRdRPOgQUm
OlI8hvA9DZ5J5J4/BisFrVfu1vGW0XsiQIdqTLFiBBHade7vqNqoHAtU40L91ctI
3R9M3DtkPWHVXhAldIfu900YAXWhnh9cZ+uS/AWy6Q6q54gf+ZtyV2JTCmnvY5ux
LMup3rqPEbT6MW+YOaxtNbnXN10v8hFGFbz5PjPOVx7wBXkETXG79nefQm0K4KwD
GHVzrmRhW3rw0lEpnJ5OuC974q+UtrqN9ifEs3DCIOBWGP9p84VRSPecuo28oNQ=
=u6+g
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
