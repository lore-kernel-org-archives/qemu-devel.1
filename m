Received: from eggs.gnu.org ([2001:4830:134:3::10]:48292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dcU2T-0005EU-MC
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 06:04:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dcU2P-0007DQ-Lo
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 06:04:33 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33465)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dcU2P-0007Cs-FE
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 06:04:29 -0400
Received: by mail-wm0-x242.google.com with SMTP id q189so2263985wmd.0
	for <qemu-devel@nongnu.org>; Tue, 01 Aug 2017 03:04:29 -0700 (PDT)
Date: Tue, 1 Aug 2017 11:04:25 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170801100425.GE13521@stefanha-x1.localdomain>
References: <20170725143923.11241-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LSp5EJdfMPwZcMS1"
Content-Disposition: inline
In-Reply-To: <20170725143923.11241-1-den@openvz.org>
Subject: Re: [Qemu-devel] [PATCH v2 1/1] monitor: improve tracing in
 handle_qmp_command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--LSp5EJdfMPwZcMS1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2017 at 05:39:23PM +0300, Denis V. Lunev wrote:
> Calculate req_json only if trace_handle_qmp_command enabled.
>=20
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: Llu=EDs Vilanova <vilanova@ac.upc.edu>
> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
> CC: Markus Armbruster <armbru@redhat.com>
> ---
> Changes from v1:
> - written in the explicit for, as discussed in the mailing list
>=20
>  monitor.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Replaced commit message & description with the one Markus suggested to
include more details on why this patch is necessary.

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--LSp5EJdfMPwZcMS1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZgFIpAAoJEJykq7OBq3PIankIAIsXRGKkCDuPrmyjFdVQF0O0
V1wW3Jj8brmGL6RdsoovcP747q4m1dZ/Lk7YU2SPL+mk3cRFCiXM2UE7DgpNETyN
s94trJ2b/WVdFeF3m9eT9b4LX9m2rt9PXgH90ceSd6g4h82+Nikmg58NjVx6UibH
oqIQkz8PtLeIaH1pMS0PON96p6XdMX0EnZaMbe7IZxtG5dhSZApe4ciJbDhMj4FM
0Hx5UIhFAtRwub76WddvVKh13moaIlmsQ60McnslNAV71nvOi6BJnAmpE72pRn72
jpr2YvdUqZeg0ScGFEU6qPG7pV5sCGIl5hDxyMNczAMRhm+tDnqyagKl8lLrmzs=
=die5
-----END PGP SIGNATURE-----

--LSp5EJdfMPwZcMS1--
