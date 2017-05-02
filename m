Received: from eggs.gnu.org ([2001:4830:134:3::10]:50254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d5YtU-0007WA-GQ
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:35:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d5YtP-0003J1-NY
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:35:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d5YtP-0003I8-Eu
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:35:07 -0400
References: <1493732857-10721-1-git-send-email-den@openvz.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <da1ab237-5dd0-cae9-7eb9-687203b37a64@redhat.com>
Date: Tue, 2 May 2017 09:34:55 -0500
MIME-Version: 1.0
In-Reply-To: <1493732857-10721-1-git-send-email-den@openvz.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lCPvrQuoL9DT9gBCU9fbDTRCrMAHRhbow"
Subject: Re: [Qemu-devel] [PATCH 1/1] monitor: increase amount of data for
 monitor to read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lCPvrQuoL9DT9gBCU9fbDTRCrMAHRhbow
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <da1ab237-5dd0-cae9-7eb9-687203b37a64@redhat.com>
Subject: Re: [PATCH 1/1] monitor: increase amount of data for monitor to read
References: <1493732857-10721-1-git-send-email-den@openvz.org>
In-Reply-To: <1493732857-10721-1-git-send-email-den@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/02/2017 08:47 AM, Denis V. Lunev wrote:
> Right now QMP and HMP monitors read 1 byte at a time from the socket, w=
hich
> is very inefficient. With 100+ VMs on the host this easily reasults in

s/reasults/results/

> a lot of unnecessary system calls and CPU usage in the system.
>=20
> This patch changes the amount of data to read to 4096 bytes, which matc=
hes
> buffer size on the channel level. Fortunately, monitor protocol is
> synchronous right now thus we should not face side effects in reality.

Do you have any easy benchmarks or measurements to prove what sort of
efficiencies we get?  (I believe they exist, but quantifying them never
hurts)

>=20
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Markus Armbruster <armbru@redhat.com>
> CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> CC: Eric Blake <eblake@redhat.com>
> ---
>  monitor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/monitor.c b/monitor.c
> index be282ec..00df5d0 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -3698,7 +3698,7 @@ static int monitor_can_read(void *opaque)
>  {
>      Monitor *mon =3D opaque;
> =20
> -    return (mon->suspend_cnt =3D=3D 0) ? 1 : 0;
> +    return (mon->suspend_cnt =3D=3D 0) ? 4096 : 0;

Is a hard-coded number correct, or should we be asking the channel for
an actual number?

>  }
> =20
>  static void handle_qmp_command(JSONMessageParser *parser, GQueue *toke=
ns)
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--lCPvrQuoL9DT9gBCU9fbDTRCrMAHRhbow
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZCJkQAAoJEKeha0olJ0Nqkr4IAJCBzaG349o5s/ZGP2dWeoRM
85QNjVt3QB87F08UWcksg5lZs/pdfRhLqPyUz2tzNFCYd0+TpxJQgpO/+b9tmGPt
+pyNznWu4wGHTEuHVMCdkTXDRv/rWE4q1939uzkywydSdie22mopzoViIQCxwatJ
E7MPMrr+ZjZ7I8+Zozf33zw503IoBaDRjBVaqqLcXNwRJnGAOYv5ufZC6Yur9Hcz
qe1dZEV/V9scuor9yeNm4VXJheFC+NQ2asJWtc+cWE7bdLMOwxHJzjbZiBkyWcQR
vKLqM1arwg9DJti7FZu+3va8GECzW30U0WC4anaZ9B1I5XPrmXFqXRE88E+r3zM=
=7bLd
-----END PGP SIGNATURE-----

--lCPvrQuoL9DT9gBCU9fbDTRCrMAHRhbow--
