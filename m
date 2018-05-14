Received: from eggs.gnu.org ([2001:4830:134:3::10]:52584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIHv6-0002d4-EI
	for qemu-devel@nongnu.org; Mon, 14 May 2018 14:10:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIHv5-0004BX-Fp
	for qemu-devel@nongnu.org; Mon, 14 May 2018 14:10:00 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-25-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <001d4b36-5486-f4ae-50b2-5918921ec976@redhat.com>
Date: Mon, 14 May 2018 20:09:48 +0200
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-25-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="px1a7RXLopeKT3OrWXzWOI8P9TKb7qUkw"
Subject: Re: [Qemu-devel] [PATCH 24/42] job: Add job_event_*()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--px1a7RXLopeKT3OrWXzWOI8P9TKb7qUkw
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <001d4b36-5486-f4ae-50b2-5918921ec976@redhat.com>
Subject: Re: [PATCH 24/42] job: Add job_event_*()
References: <20180509162637.15575-1-kwolf@redhat.com>
 <20180509162637.15575-25-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-25-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 18:26, Kevin Wolf wrote:
> Go through the Job layer in order to send QMP events. For the moment,
> these functions only call a notifier in the BlockJob layer that sends
> the existing commands.
>=20
> This uses notifiers rather than JobDriver callbacks because internal
> users of jobs won't receive QMP events, but might still be interested
> in getting notified for the events.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/blockjob.h |  9 +++++++++
>  include/qemu/job.h       | 18 ++++++++++++++++++
>  blockjob.c               | 42 ++++++++++++++++++++++++++++------------=
--
>  job.c                    | 19 +++++++++++++++++++
>  4 files changed, 74 insertions(+), 14 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--px1a7RXLopeKT3OrWXzWOI8P9TKb7qUkw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr50OwACgkQ9AfbAGHV
z0DPqAgAplFknGAcj/GDL8CyOq0Lp1cm+kcP43qIljivsDLaTo43xpdgci68nvzS
+3/1hEgIkza0ACdT/2qhlQOJ8cK0loKP7bRn7nyVJt8zw0x3CBxDPCUOFM4or5NH
0nGk5NpsgusIoTBBXNtWeUQPaCWrBAiT0B0igBvhpzljKXsDm43SE8PS1AmuFZwc
59TKxVXVGgSyCMgHF1+mo1c6/cJVjjUZ6lxSzq5z3+FJArtBw/8RyVOAkXs0KTt4
Im3JtfLIctbr8nndWCDZmc3Lo/4MGnX4EW9z9Wr5X9Aeb9wzmkxlOswvB+78a89E
cwTu6Nh3r54Ww1eav6ucSNmfGC/2MQ==
=W3Sv
-----END PGP SIGNATURE-----

--px1a7RXLopeKT3OrWXzWOI8P9TKb7qUkw--
