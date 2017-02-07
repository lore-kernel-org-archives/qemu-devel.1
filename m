Received: from eggs.gnu.org ([2001:4830:134:3::10]:60351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cb7Tx-0000E2-39
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:15:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cb7Tu-0006Mb-0V
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:15:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cb7Tt-0006Li-RI
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:14:57 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1184FC04B95A
	for <qemu-devel@nongnu.org>; Tue,  7 Feb 2017 15:14:58 +0000 (UTC)
Date: Tue, 7 Feb 2017 15:14:55 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170207151455.GH8583@stefanha-x1.localdomain>
References: <20170204143245.15974-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aF3LVLvitz/VQU3c"
Content-Disposition: inline
In-Reply-To: <20170204143245.15974-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Makefile: Make "install" depend on
 "trace-events-all"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com


--aF3LVLvitz/VQU3c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 04, 2017 at 10:32:45PM +0800, Fam Zheng wrote:
> We install this file to data dir but since 0ab8ed18 it's no longer
> required by any objects during "make". List it explicitly as a depended
> target of install and fix the broken "make install" command.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--aF3LVLvitz/VQU3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYmeRvAAoJEJykq7OBq3PIcAgH/3Ox15bd6z54v1Jw8ZdZdNly
R6/RkzgygIxuq3f7PfD9k0ONd8AYYer/tjNAn7q2ZzGawQ7mSaadjygcIyOurJ/s
F/A4Zwri1oVfa27dQunZEXCCG/hsvzpDYOQvjQkyq32BZnm4Sf7OB9JojOSGn7b2
1AlJZ1jg28zhyKYMgnpDQdscZWoi4knPUREwxIQL6mpk/UP6OFMqoo/jyU/6+wW3
K/URtbgSksRpnjdfRmOCzLdRxST2rTElB2rArrDH+gJgt5KTwEDiRlpoqRmxYcSC
f54mlfU14qaCDpBpDQqyBq3utHzHffnhBVczRF/6yUcdlZd3YWTdeP4IqOw5PUw=
=9gSy
-----END PGP SIGNATURE-----

--aF3LVLvitz/VQU3c--
