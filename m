Received: from eggs.gnu.org ([2001:4830:134:3::10]:38522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fAzSn-0005gs-EG
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:02:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fAzSm-0006dV-Cq
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:02:37 -0400
References: <20180215192829.9944-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9c4fcd99-8a8c-62d3-3c0d-d26601910835@redhat.com>
Date: Tue, 24 Apr 2018 10:02:10 -0500
MIME-Version: 1.0
In-Reply-To: <20180215192829.9944-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Zr3b1Ed3399tAKdyo1DrGeOXY57C0UFRs"
Subject: Re: [Qemu-devel] [PATCH 0/6] block: byte-based AIO read/write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Zr3b1Ed3399tAKdyo1DrGeOXY57C0UFRs
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <9c4fcd99-8a8c-62d3-3c0d-d26601910835@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/6] block: byte-based AIO read/write
References: <20180215192829.9944-1-eblake@redhat.com>
In-Reply-To: <20180215192829.9944-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/15/2018 01:28 PM, Eric Blake wrote:
> While we would prefer that block drivers use coroutines instead
> of aio callbacks, it is a fairly easy exercise to prove that
> all existing drivers with aio callbacks are merely scaling
> from bytes into sectors and back to bytes.  So, even though I
> am not set up to completely run (or even compile-test) this
> full series, it seems pretty straightforward to change the
> signature to quit playing games with pointless scaling.
>=20
> Note that except for the null-aio driver, I intentionally did
> NOT try and change the request_alignment from the block layer's
> default of 512 (it defaults to 1 only for drivers that use
> coroutines).
>=20
> (And along the way, I got my docker-test-mingw@fedora working;
> thanks to the help I got on IRC)

ping

>=20
> Eric Blake (6):
>   block: Support byte-based aio callbacks
>   file-win32: Switch to byte-based callbacks
>   null: Switch to byte-based read/write
>   rbd: Switch to byte-based callbacks
>   vxhs: Switch to byte-based callbacks
>   block: Drop last of the sector-based aio callbacks
>=20
>  include/block/block_int.h |  8 +++---
>  include/block/raw-aio.h   |  2 +-
>  block/io.c                | 26 ++++++++++++-------
>  block/file-win32.c        | 36 +++++++++++++-------------
>  block/null.c              | 66 ++++++++++++++++++++++++++-------------=
--------
>  block/rbd.c               | 36 ++++++++++++--------------
>  block/vxhs.c              | 36 +++++++++++---------------
>  block/win32-aio.c         |  5 ++--
>  8 files changed, 109 insertions(+), 106 deletions(-)
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Zr3b1Ed3399tAKdyo1DrGeOXY57C0UFRs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrfRvIACgkQp6FrSiUn
Q2oAAQf+PuAldKFHFqS0QMZIALnuemw4NGD83XKDZOcEPrPxq5Qrq/eGYdmmpTZy
JR21HJvzXKgCA+R/3yEK71F8+4oOGtDO7G6Q5fWuRA4hNMb2Yk6Md24VRQzO7xaC
AzIFOHcZVkhsBzChbfJFUAJWxMzD+FDrj8nmZKzjHJiF1fwct3//8YhXPdLrvWSF
AZRiRMuJPKaiPSp9YMi8hpS784G51itTLQWIe96vZeZcIPWZVUQY3UGVGGo8kgsE
a0Mi11bafkzYJGKxDVSbynkVK5rDEwJ+WpiXPkxg/QRos3yPOs9aMXqhY4bkD61L
9mxMG1oJ4AQfmKVSFpTIkavwx98r0g==
=IJVB
-----END PGP SIGNATURE-----

--Zr3b1Ed3399tAKdyo1DrGeOXY57C0UFRs--
