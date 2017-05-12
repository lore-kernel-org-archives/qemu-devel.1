Received: from eggs.gnu.org ([2001:4830:134:3::10]:55982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d9Gsb-0005B3-Kf
	for qemu-devel@nongnu.org; Fri, 12 May 2017 16:09:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d9GsY-0006EZ-9u
	for qemu-devel@nongnu.org; Fri, 12 May 2017 16:09:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41131)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d9GsY-0006CN-0S
	for qemu-devel@nongnu.org; Fri, 12 May 2017 16:09:34 -0400
References: <CGME20170512133144eucas1p23502fd953ee73bda5b2afb25e65604f9@eucas1p2.samsung.com>
	<1494595886-30912-1-git-send-email-a.perevalov@samsung.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a0f35d74-611a-7ba4-8cab-30a94d4b1da6@redhat.com>
Date: Fri, 12 May 2017 15:09:29 -0500
MIME-Version: 1.0
In-Reply-To: <1494595886-30912-1-git-send-email-a.perevalov@samsung.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vdI3sDvTO8Is2rRtel4diIThH6limMOP3"
Subject: Re: [Qemu-devel] [PATCH V5 0/9] calculate blocktime for postcopy
 live migration
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
--vdI3sDvTO8Is2rRtel4diIThH6limMOP3
From: Eric Blake <eblake@redhat.com>
To: Alexey Perevalov <a.perevalov@samsung.com>, qemu-devel@nongnu.org
Cc: i.maximets@samsung.com, dgilbert@redhat.com, peterx@redhat.com
Message-ID: <a0f35d74-611a-7ba4-8cab-30a94d4b1da6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V5 0/9] calculate blocktime for postcopy live
 migration
References: <CGME20170512133144eucas1p23502fd953ee73bda5b2afb25e65604f9@eucas1p2.samsung.com>
 <1494595886-30912-1-git-send-email-a.perevalov@samsung.com>
In-Reply-To: <1494595886-30912-1-git-send-email-a.perevalov@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/12/2017 08:31 AM, Alexey Perevalov wrote:
> The rationale for that idea is following:
> vCPU could suspend during postcopy live migration until faulted
> page is not copied into kernel. Downtime on source side it's a value -
> time interval since source turn vCPU off, till destination start runnig=

> vCPU. But that value was proper value for precopy migration it really s=
hows
> amount of time when vCPU is down. But not for postcopy migration, becau=
se
> several vCPU threads could susppend after vCPU was started. That is imp=
ortant
> to estimate packet drop for SDN software.
>=20
> This is 5th version of patch set. In previous was build error in mingw.=

> First version was tagged as RFC, second was without version tag, third =
with V3.
>=20
> This patch set doesn't include improvements sugested by Peter Xu for
> get_mem_fault_cpu_index, but I would prefer to do it. I think to introd=
uce a
> tree for fast CPUState lookup by thread_id, or general code, due to the=
re are
> places like qemu_get_cpu (cpus.c) with the similar lookup.
>=20
> (V4 -> V5)
>     - fill_destination_postcopy_migration_info empty stub was missed fo=
r none linux
> build
>=20
> (V3 -> V4)

I reviewed a couple of spots related to QMP in v4 before seeing that you
had already posted v5; those comments still apply.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--vdI3sDvTO8Is2rRtel4diIThH6limMOP3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZFhZ5AAoJEKeha0olJ0NqmKwH/iM7deqOu9eLPkoc2HlrSJni
XD23o+kiXRY3vllUWrjsvhlgJRNgGj5TKewQTAySxABCRDVYWEsPv2BXgZ4pEhbz
ubiZf3BNyggCaw9BjvtHc5S2TGxz+nVestBLr8S104/4oXtV9yI8y1nUzQSdzypB
ckvDKk4qroqsLTPGIocYVc+bj0Xjs1Hpnos9d836bO8JaYORGlCR1GIQpUxRg5ba
/n2/xJmoGe/iPxH0OINcS6rdzhEO7goJLRRgOizKtI3dSLt70Nj3/s44sGP8WRti
cp7CbUQEc7iUXap525tIT1ZbgOp0r2WzCjOv2gNrc/e1HSG7YoZPKauej/zFkkU=
=BkAC
-----END PGP SIGNATURE-----

--vdI3sDvTO8Is2rRtel4diIThH6limMOP3--
