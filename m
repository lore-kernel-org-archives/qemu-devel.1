Received: from eggs.gnu.org ([2001:4830:134:3::10]:52644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f9Rik-0007Md-6a
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:48:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f9Rif-0002mt-Ap
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:48:42 -0400
Received: from mail-pg0-x22e.google.com ([2607:f8b0:400e:c05::22e]:36226)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1f9Rif-0002lW-4H
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:48:37 -0400
Received: by mail-pg0-x22e.google.com with SMTP id i6so3760529pgv.3
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 01:48:36 -0700 (PDT)
Date: Fri, 20 Apr 2018 16:48:32 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180420084832.GT15181@stefanha-x1.localdomain>
References: <20180406194205.9872-1-nikhilbalachandra.inbox@gmail.com>
	<20180416073100.GA28904@stefanha-x1.localdomain>
	<CAAGXMmLL2TBmNDqtVjp7y56WT6NadmX8X4HMBhXaWX6jJnirDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k8r0khnpBuGu0wUi"
Content-Disposition: inline
In-Reply-To: <CAAGXMmLL2TBmNDqtVjp7y56WT6NadmX8X4HMBhXaWX6jJnirDg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] Make qemu-bridge-helper work in macOS
 and FreeBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikhil Balachandra <nikhilbalachandra.inbox@gmail.com>
Cc: qemu-devel@nongnu.org


--k8r0khnpBuGu0wUi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 17, 2018 at 09:57:46AM +0530, Nikhil Balachandra wrote:
> Hi Stefan,
>=20
> Thanks for the review. I'll be sending v2 version of this patch in next 3=
-4
> days with the following changes.
>=20
> 1) New scripts/update-xnu-headers.sh script to import if_bridgevar.h[4]
> into include/standard-headers/xnu directory.
>     @qemu-devel - Please let me know if there is a better approach.
> 2) Fix broken vnet hdr in this patch.
> 3) Having minimal code in qemu-bridge-helper.c to open tap device instead
> of using tap_open().
>=20
> [4] - macOS if_bridgevar.h header file has APSL and BSD license.

Great, thank you!

Stefan

--k8r0khnpBuGu0wUi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa2algAAoJEJykq7OBq3PIOFUIAMXEnciJ9YDD4YPRqCxSxtDJ
di7zCvpe6SsM7oFT4CH5nLQzaMWJm91GqSmjP+oL6mwmKdzrgaomnGa/PWQgyMFJ
Mezdl7PgVwkRS49h7dT750v158LPcvMuSMUStXdb68L+cb8MQp0fhMZN8wsxAvwy
H27CG4vgH8Ca1qVY2H9EPLz6g1yu4rtpgHRZYm5H5T5YIOJTfvPSMUHlTfeTIVJ9
qNplEn57OyOEwgZvGxasdMwGNZqpXrjuZ0Wm004q8zSQfWB7bDubwEEv4uMjMJX8
Mix9QiH3d0kbLOtdg+/YR8DcqHPd9UbYUw3nsKf4PFEL4RgLHLg8SA57wjFFzuM=
=fGgx
-----END PGP SIGNATURE-----

--k8r0khnpBuGu0wUi--
