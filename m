Received: from eggs.gnu.org ([2001:4830:134:3::10]:58386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d7mpd-0001PE-Nc
	for qemu-devel@nongnu.org; Mon, 08 May 2017 13:52:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d7mpZ-0000Np-0W
	for qemu-devel@nongnu.org; Mon, 08 May 2017 13:52:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1d7mpY-0000Nj-RJ
	for qemu-devel@nongnu.org; Mon, 08 May 2017 13:52:20 -0400
Date: Mon, 8 May 2017 13:52:17 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170508175217.GO22428@stefanha-x1.localdomain>
References: <20170505103822.20641-1-alex.bennee@linaro.org>
	<20170505103822.20641-9-alex.bennee@linaro.org>
	<9d3cca3f-3a95-0beb-9342-428b96816173@redhat.com>
	<87pofnmgzl.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vNrHrykRFvLVX6W3"
Content-Disposition: inline
In-Reply-To: <87pofnmgzl.fsf@linaro.org>
Subject: Re: [Qemu-devel] [RFC PATCH v1 8/9] util/qemu-thread-*: add
 qemu_lock, locked and unlock trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, boost.lists@gmail.com, pavel.dovgaluk@ispras.ru, cota@braap.org, qemu-devel@nongnu.org


--vNrHrykRFvLVX6W3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 05, 2017 at 04:59:58PM +0100, Alex Benn=E9e wrote:
>=20
> Paolo Bonzini <pbonzini@redhat.com> writes:
>=20
> > On 05/05/2017 12:38, Alex Benn=E9e wrote:
> >> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> >
> > Can you look at the patch I just sent a pull request for?  It only has
> > locked and unlocked trace events, you can add lock on top.
>=20
> Cool - great minds think alike ;-)
>=20
> I'll re-spin my trace analysis script and the lock trace point once that
> pull request is merged. I would be nice if we could associate locks with
> names though as the QemuMutex * is basically just an anonymous handle.
> Would it be overly extravagant to add a const char * to QemuMutex to can
> be init'ed with a human readable name?
>=20
> Stefan,
>=20
> Does the trace sub-system have any way to register a human readable
> string to a given pointer value? I guess this is something that could be
> added to the trace pre-amble?

No, it doesn't.  I would make the trace event take const char * and pass
in the string.

Stefan

--vNrHrykRFvLVX6W3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZELBRAAoJEJykq7OBq3PIoKQIAIeRQB7LD1V9EqaLo+glg2pj
lGqhWLGJHuXRBQXxV0SLhxKE+9pN0J9aD9758JrHH/tl+5gCW/KiE4a19c7k+03N
3lPKyyOIrTulC04n+h8k9fcOX2FKLHkfBiUIZapsRFq4hE0a5s3Zpo6IAtEhYF5r
Y97Fn8UXIH8z57AvecFjOc0ryYPYiqjHTXZ/gUpevtMI+sS2+7SFZyUnuKp2c5V9
dbGK9kzzRfqdZLb+VNlsudFnG4R0lrcuFzU8RSMk90AzdIXeKPRIt6ANeZhytupy
BJfr0GGtvPk8O2/XeP7EgO3OcPEejTTuAOLNuH8SnrkOANiTSYGzZoDC5NCHkEg=
=HSiN
-----END PGP SIGNATURE-----

--vNrHrykRFvLVX6W3--
