Received: from eggs.gnu.org ([209.51.188.92]:35235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gucnf-0005Nx-87
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 07:41:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gucnd-00063t-54
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 07:41:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gucnb-0005k6-6p
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 07:40:59 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7B86CAB401
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 12:40:28 +0000 (UTC)
Date: Fri, 15 Feb 2019 12:40:02 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190215124002.GD15131@stefanha-x1.localdomain>
References: <1550227757-10869-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9dgjiU4MmWPVapMU"
Content-Disposition: inline
In-Reply-To: <1550227757-10869-1-git-send-email-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] build: get rid of target-obj-y
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com


--9dgjiU4MmWPVapMU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 11:49:15AM +0100, Paolo Bonzini wrote:
> It is possible to specify the trace/ directory already in objs-y;
> there is no need to have a separate unnest-vars invocation.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  Makefile.objs       | 1 -
>  Makefile.target     | 7 ++-----
>  trace/Makefile.objs | 4 ++--
>  3 files changed, 4 insertions(+), 8 deletions(-)

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

(Yep, I don't know the details of the build system well enough for a
Reviewed-by.)

--9dgjiU4MmWPVapMU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcZrMiAAoJEJykq7OBq3PIUh8H/A0Avq2SUJy+73v469cw/Z7+
50jixcLT2tdvilDq6fygZ1YWTCHn6/UXS+SRLiBaPzCv44xkjzOtYNGHOvMWaiMp
ZXSBvr+zxeDKZGY00gh0jMF86/tFNLdHmMQwTEcUpm6AGnMYIWIUdvKkF0QwEN9A
WyXCYWjC1Ehxfk03tvaSnM6yuS/97y+UNTgN6AKgBJ+/hOH6X4JIN8tG/kZdSuHR
Juh/amKKlPDOZhK7yB3WSXjN4tKc5DuP1PZPDTr0osnng86bJCT1BA7ugAD3XlXp
dZsmvmyAEndpeu/eaWXf2WblhD/9/Jb4lcBrwi9QwNp3ykaBQLlpgftm6USP3mQ=
=YGL5
-----END PGP SIGNATURE-----

--9dgjiU4MmWPVapMU--
