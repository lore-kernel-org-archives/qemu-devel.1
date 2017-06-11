Received: from eggs.gnu.org ([2001:4830:134:3::10]:55128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dJtF5-00009j-Kn
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 23:08:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dJtF4-0001Qv-MO
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 23:08:43 -0400
References: <1497078250-19505-1-git-send-email-lizhengui@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b69bd8b0-c892-6456-713b-333d0e173cb4@redhat.com>
Date: Sat, 10 Jun 2017 22:08:31 -0500
MIME-Version: 1.0
In-Reply-To: <1497078250-19505-1-git-send-email-lizhengui@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AdRom6xv2cG8WGJ8WfBWJeBb7GsNDfoFI"
Subject: Re: [Qemu-devel] [PATCH] bdrv_inc_in_flight and bdrv_dec_in_flight:
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhengui Li <lizhengui@huawei.com>, armbru@redhat.com, kwolf@redhat.com, mreitz@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AdRom6xv2cG8WGJ8WfBWJeBb7GsNDfoFI
From: Eric Blake <eblake@redhat.com>
To: Zhengui Li <lizhengui@huawei.com>, armbru@redhat.com, kwolf@redhat.com,
 mreitz@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Message-ID: <b69bd8b0-c892-6456-713b-333d0e173cb4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] bdrv_inc_in_flight and bdrv_dec_in_flight:
References: <1497078250-19505-1-git-send-email-lizhengui@huawei.com>
In-Reply-To: <1497078250-19505-1-git-send-email-lizhengui@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/10/2017 02:04 AM, Zhengui Li wrote:
> Avoid empty pointer access if the bs is NULL.
>=20
> Signed-off-by: Zhengui Li <lizhengui@huawei.com>
> ---
>  block/io.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

NACK; this is fixing a symptom, not the problem. If you have a coredump
due to a bad caller passing in NULL, then post the backtrace and let's
fix the broken caller instead.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--AdRom6xv2cG8WGJ8WfBWJeBb7GsNDfoFI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZPLQwAAoJEKeha0olJ0NqgY4H/0AmbnRdGCkEnzhY/LlSAI+X
wK2zqDaqmYytW5AruI7Rx3TRqDIP30XFEFrN+lzBh2TKKsnOs07XYarligw7CdTr
lt6gRdL5yNxNeyYnjRCttS8Hd3NFPwhRQ4RGQNDUNhGEzQX7oCK9JuX+p48zTpzp
nQbaJclyRDRpYd55wycjBpKIAkGbvBJoDvt7DUP2A5Bucdpl2w0TeQFnEl/BuTQJ
IzXZ2+Na8zEMhdcWAlsEmS3uEAmm4hPajSe3UBQ54+o7CpbNC+AhK629k3Ocd43q
M9rLv8hSiBrmZyvshNIl84WiP00Nw+it781NuBxZAlovRwOQN5mHGF6HXYrjLF0=
=f8LP
-----END PGP SIGNATURE-----

--AdRom6xv2cG8WGJ8WfBWJeBb7GsNDfoFI--
