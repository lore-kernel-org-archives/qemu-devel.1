Received: from eggs.gnu.org ([209.51.188.92]:42830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1glXCf-0006cj-LN
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 05:53:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1glXCe-0001U6-Tg
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 05:53:17 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39351)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1glXCe-0001Th-N3
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 05:53:16 -0500
Received: by mail-wr1-x443.google.com with SMTP id t27so22752043wra.6
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 02:53:16 -0800 (PST)
Date: Mon, 21 Jan 2019 10:53:14 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190121105314.GG30536@stefanha-x1.localdomain>
References: <20190118173103.4903-1-berrange@redhat.com>
	<20190118173103.4903-5-berrange@redhat.com>
	<64c2ec84-8950-3c58-0ca7-d54c1a9438d2@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jt0yj30bxbg11sci"
Content-Disposition: inline
In-Reply-To: <64c2ec84-8950-3c58-0ca7-d54c1a9438d2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/4] trace: add ability to do simple
 printf logging via systemtap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>


--jt0yj30bxbg11sci
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 18, 2019 at 12:14:14PM -0600, Eric Blake wrote:
> On 1/18/19 11:31 AM, Daniel P. Berrang=E9 wrote:
> > +def c_macro_to_format(macro):
> > +    if macro.startswith("PRI"):
> > +        return macro[3]
> > +
> > +    if macro =3D=3D "TARGET_FMT_plx":
> > +        return "%016x"
>=20
> Do we really want to permit TARGET_FMT in our trace-events files, or
> should that be fixed in hw/tpm/trace-events?  See commit 73ff0610.

TARGET_FMT_plx is constant across all QEMU targets.  I think supporting
it is nice since it makes writing trace events more natural/convenient.

Stefan

--jt0yj30bxbg11sci
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcRaSaAAoJEJykq7OBq3PIXEsIAJpaa7rkYz5h0BTGXXxBj6aP
XqHPcB7Zxt2twF3DNkMAmw91V5mJC52vFo8hNpGuUTYyYCYWCMNDfjTzgHAZ58bb
taA3SY31UJKdXG8x4VdvnNjdOJ/LxBbe1brgGJO3XoMDchBlDX7xZayQsxZfRzy6
iDY15FX3QSB85CY/m/7dwOM3gwIhlk9fb3IVANuTq1a5c52xhVpjTeMoy8nXz0fc
nf/AxUmMny7jdvPtQqxIlJ00IS4VCiMZom+JKJSUPkofLvVCE0SQliWy+zMPcmiU
O/WCU8lANIWvgVIOESRdg0oGbXCiK8DvsNXmc8x3SYB39yPpVU2UkMzc+sJnrsk=
=lsWq
-----END PGP SIGNATURE-----

--jt0yj30bxbg11sci--
