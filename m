Received: from eggs.gnu.org ([2001:4830:134:3::10]:44058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cIyPg-0003OD-6B
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 08:55:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cIyPd-0006Qs-4K
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 08:55:36 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33203)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cIyPc-0006QB-UD
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 08:55:33 -0500
Received: by mail-wm0-x242.google.com with SMTP id u144so18772191wmu.0
	for <qemu-devel@nongnu.org>; Mon, 19 Dec 2016 05:55:32 -0800 (PST)
Date: Mon, 19 Dec 2016 13:55:29 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161219135529.GE17374@stefanha-x1.localdomain>
References: <53e52412-cd32-cb9e-2261-882a7b5b84ea@imatronix.cl>
	<20161219010743.GA2719@lemon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ns7jmDPpOpCD+GE/"
Content-Disposition: inline
In-Reply-To: <20161219010743.GA2719@lemon>
Subject: Re: [Qemu-devel] Can qemu reopen image files?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Christopher Pereira <kripper@imatronix.cl>, qemu-devel@nongnu.org


--Ns7jmDPpOpCD+GE/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 19, 2016 at 09:07:43AM +0800, Fam Zheng wrote:
> On Sun, 12/18 20:52, Christopher Pereira wrote:
> > Hi,
> >=20
> > We are doing a "qemu-img convert" operation (qcow2, with compression) to
> > shorten the backing-chain (in the middle of the backing-chain).
> > In order to force qemu to reopen files, we do a save and restore operat=
ion.
> > Is there a faster way to reopen image files using virsh or qemu?
>=20
> No, don't use qemu-img when the image is in use by QEMU. You want to use
> "block-commit" command provided by QMP.

It's worth being more explicit here:

You will corrupt the image file if you access it with another program
while QEMU is using it!

Stefan

--Ns7jmDPpOpCD+GE/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYV+bRAAoJEJykq7OBq3PIIE0H/0mIDsFDieSvLj244Hdkxhpu
lpHoNfwAPt0TGI0ZhVna6rZMPisqf0tyCc6cJTIKQ7I5WfNcnS1y18EY0MbUoaj7
Iuig4HzdM+Ti7nouHt0nR48S4MswYUTNzzMkjpYN3/m+wMfEz/Ak5oiFFgXbePjf
YPG+anWTFnAEeenCTo6FGYufiYFtFJcVcsNJfimMhoxx/FeTW4PCweiLo3Ob4iRC
FwU/fglYjrPt9I7Uc5i9vVGfLb/8P7EJi6jxPCuRXEtEP4fySXtCTLfLY9pzjNUw
c7arMKeUIZp443QA4OTSlWdUB7DMYmt1dcRv7ePBbWCJVKs3/FfryfUo9AQHj1g=
=gp6d
-----END PGP SIGNATURE-----

--Ns7jmDPpOpCD+GE/--
