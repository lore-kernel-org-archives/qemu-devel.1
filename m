Received: from eggs.gnu.org ([2001:4830:134:3::10]:38758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1etDtB-00013N-CI
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 09:48:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1etDt7-00006L-Cy
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 09:48:25 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:35996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1etDt7-00005u-5Z
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 09:48:21 -0500
Received: by mail-wr0-x242.google.com with SMTP id v111so21202244wrb.3
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 06:48:20 -0800 (PST)
Date: Tue, 6 Mar 2018 14:48:18 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180306144818.GJ31045@stefanha-x1.localdomain>
References: <1520200587-14681-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6iqOn7HZPWKXx18"
Content-Disposition: inline
In-Reply-To: <1520200587-14681-1-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 0/5] Convert the TPM code to use tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, dgilbert@redhat.com


--d6iqOn7HZPWKXx18
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 04, 2018 at 04:56:22PM -0500, Stefan Berger wrote:
> This series of patches converts the TPM code to use tracing rather
> than the #define DEBUG_XYZ type of debugging.
>=20
> Regards,
>    Stefan
>=20
> Stefan Berger (5):
>   tpm: convert tpm_crb.c to use trace-events
>   tpm: convert tpm_passthrough.c to use trace-events
>   tpm: convert tpm_util.c to use trace-events
>   tpm: convert tpm_emulator.c to use trace-events
>   tpm: convert tpm_tis.c to use trace-events
>=20
>  Makefile.objs            |  1 +
>  hw/tpm/tpm_crb.c         | 17 +++------
>  hw/tpm/tpm_emulator.c    | 45 +++++++++++-----------
>  hw/tpm/tpm_passthrough.c | 13 ++-----
>  hw/tpm/tpm_tis.c         | 98 ++++++++++++++++++++++--------------------=
------
>  hw/tpm/tpm_util.c        | 29 ++++++--------
>  hw/tpm/trace-events      | 46 +++++++++++++++++++++++
>  7 files changed, 135 insertions(+), 114 deletions(-)
>  create mode 100644 hw/tpm/trace-events
>=20
> --=20
> 2.5.5
>=20
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--d6iqOn7HZPWKXx18
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJanqoyAAoJEJykq7OBq3PIxWoH/2054ziPAzjl3LhZr+G8TCjr
jgMGQYUpE6DE8eWUVjP47ZkEloiByumehevbdq8Pbr4VifmIy9lO7GHMElUNrrlY
toWcjQtVPRGc+J7NbVA68UFbGMfotIuIL4TgaMJKE68VX1dQ28alnk0dF5vO/N4h
p5YslpxohngI7ZZ3oP8/oyWK3Av7wBWgLA3FPte2EFDhSOaUEDNAsA0lKn2yLlOx
AaRVUM75NZlX4CoII72OWuQjCJnuEEaqrF2OdWA3EolwRM51QgEfsKag769FrG29
67/LV1hl72tJBLXfzn4ns5meiNWxoYNoN0JyAcHIK6grqtsHx1J8FVIS2YsRyW8=
=GfXo
-----END PGP SIGNATURE-----

--d6iqOn7HZPWKXx18--
