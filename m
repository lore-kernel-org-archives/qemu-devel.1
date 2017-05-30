Received: from eggs.gnu.org ([2001:4830:134:3::10]:34696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFk2U-0002wt-5p
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:30:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFk2T-0007Tm-AZ
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:30:34 -0400
References: <1496161442-96665-1-git-send-email-imammedo@redhat.com>
	<1496161442-96665-6-git-send-email-imammedo@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <554eca2d-3c94-c341-299f-d71bcb020edd@redhat.com>
Date: Tue, 30 May 2017 11:30:27 -0500
MIME-Version: 1.0
In-Reply-To: <1496161442-96665-6-git-send-email-imammedo@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5XKsjjJH2eTvB5AmFE9sCb9a0qj2cIPiH"
Subject: Re: [Qemu-devel] [PATCH v3 5/7] numa: move numa_node from CPUState
 into target specific classes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Andrew Jones <drjones@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5XKsjjJH2eTvB5AmFE9sCb9a0qj2cIPiH
From: Eric Blake <eblake@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Andrew Jones <drjones@redhat.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Message-ID: <554eca2d-3c94-c341-299f-d71bcb020edd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 5/7] numa: move numa_node from CPUState
 into target specific classes
References: <1496161442-96665-1-git-send-email-imammedo@redhat.com>
 <1496161442-96665-6-git-send-email-imammedo@redhat.com>
In-Reply-To: <1496161442-96665-6-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/30/2017 11:24 AM, Igor Mammedov wrote:
> Move vcpu's assocciated numa_node field out of generic CPUState

s/assocciated/associated/

> into inherited classes that actually care about cpu<->numa mapping,
> i.e: ARMCPU, PowerPCCPU, X86CPU.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---

> +++ b/target/arm/cpu.h
> @@ -703,6 +703,8 @@ struct ARMCPU {
> =20
>      ARMELChangeHook *el_change_hook;
>      void *el_change_hook_opaque;
> +
> +    int32_t node_id; /* NUMA node this CPU is belonging to */

s/is belonging/belongs/  (multiple places in the patch)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--5XKsjjJH2eTvB5AmFE9sCb9a0qj2cIPiH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZLZ4kAAoJEKeha0olJ0NquP4IAJCIOJFqVyzigiV02y9vDoOv
aYjA73MiGNJBIvZfHclFtT0qIiwiYJM/CWvpIg25oZbzGbHpwp3rj+dY/cxIecjP
D3aQUj6zO1aUPE3ErX1v9got3LtywFb6wu9tJPEtT/1yx+BcawCwNhAOrciA/C2K
5E3F6wAhd2EEiHe1KBg7SyFaxipvuO4qBR6v0/3g3ttO+QeFZhwLU43WSyf3FmBv
5AP8E5fj7jJuUn86DRlpbpBbDYDWlZ6mzuFgGoJdEPnFtJGO6Yzuqe/c0K6qAit7
zRYqyb+W8QvNVym+yt9QPWlCjkPIdDLWasojYph6wrsTsUJCmA3FEmJo5flsx3M=
=AKeT
-----END PGP SIGNATURE-----

--5XKsjjJH2eTvB5AmFE9sCb9a0qj2cIPiH--
