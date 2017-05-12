Received: from eggs.gnu.org ([2001:4830:134:3::10]:54847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d9GpZ-00032W-4F
	for qemu-devel@nongnu.org; Fri, 12 May 2017 16:06:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d9GpX-0003hs-NE
	for qemu-devel@nongnu.org; Fri, 12 May 2017 16:06:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43382)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d9GpX-0003hD-DU
	for qemu-devel@nongnu.org; Fri, 12 May 2017 16:06:27 -0400
References: <1494588703-9076-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170512113223eucas1p2c2a88ead00f3121fc1bfc8dab4f18c78@eucas1p2.samsung.com>
	<1494588703-9076-10-git-send-email-a.perevalov@samsung.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fdeddcc9-11a9-278a-0436-76d92052c2e5@redhat.com>
Date: Fri, 12 May 2017 15:06:18 -0500
MIME-Version: 1.0
In-Reply-To: <1494588703-9076-10-git-send-email-a.perevalov@samsung.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mmGm41BPCIeeWietVNtvgDKR1v0WGcEMW"
Subject: Re: [Qemu-devel] [PATCH V4 9/9] migration: postcopy_blocktime
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>, qemu-devel@nongnu.org
Cc: i.maximets@samsung.com, dgilbert@redhat.com, peterx@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mmGm41BPCIeeWietVNtvgDKR1v0WGcEMW
From: Eric Blake <eblake@redhat.com>
To: Alexey Perevalov <a.perevalov@samsung.com>, qemu-devel@nongnu.org
Cc: i.maximets@samsung.com, dgilbert@redhat.com, peterx@redhat.com
Message-ID: <fdeddcc9-11a9-278a-0436-76d92052c2e5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V4 9/9] migration: postcopy_blocktime
 documentation
References: <1494588703-9076-1-git-send-email-a.perevalov@samsung.com>
 <CGME20170512113223eucas1p2c2a88ead00f3121fc1bfc8dab4f18c78@eucas1p2.samsung.com>
 <1494588703-9076-10-git-send-email-a.perevalov@samsung.com>
In-Reply-To: <1494588703-9076-10-git-send-email-a.perevalov@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/12/2017 06:31 AM, Alexey Perevalov wrote:
> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> ---
>  docs/migration.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/docs/migration.txt b/docs/migration.txt
> index 1b940a8..d0f5a6d 100644
> --- a/docs/migration.txt
> +++ b/docs/migration.txt
> @@ -402,6 +402,16 @@ will now cause the transition from precopy to post=
copy.
>  It can be issued immediately after migration is started or any
>  time later on.  Issuing it after the end of a migration is harmless.
> =20
> +Blocktime it's a postcopy live migration metric, intend to show

s/it's/is/
s/intend/intended/

> +when source vCPU was in state interruptable sleep due to pagefault.

s/when/how long the/

> +This value is calculated on destination side.
> +To enable postcopy blocktime calculation, enter following command on d=
estination
> +monitor:
> +
> +migrate_set_capability postcopy-blocktime on
> +
> +Postcopy blocktime could be retrieved by query-migrate qmp command.

s/could/can/

> +
>  Note: During the postcopy phase, the bandwidth limits set using
>  migrate_set_speed is ignored (to avoid delaying requested pages that
>  the destination is waiting for).
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--mmGm41BPCIeeWietVNtvgDKR1v0WGcEMW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZFhW6AAoJEKeha0olJ0Nqa7MH/RIt9ntD+tDPwV9S/9uyD9Eb
jhOJ2WDlB4UjzoVm40F+w8FKVECPktwXkjJBz37ScdoRMeL3vkZyuDO2vlzL+qe2
fyFGoi3W0/oDedqbk/G8MX7tsTK3eRIRxZ67ZBuVbfi5XFfAPPO1GZAHmrcYT9+R
zgw8Xd2UVHlXg9LcXSszz4PE3eWlafxSKS1hbzLsnhhIFBL1zUDXFc7eKAv+YQr+
/EY81Wttr8lEstzN8KzH1gPGvCLSCI2jWHT+Wo+ta4FUWLImaOmd1yljlTshl0zH
rAQvNhiFS0Vm/4cylHwV0mx3tCO4iYL7CAX7qkMR2/hhAGYkeAE5EIy79zs+yJk=
=Cqo9
-----END PGP SIGNATURE-----

--mmGm41BPCIeeWietVNtvgDKR1v0WGcEMW--
