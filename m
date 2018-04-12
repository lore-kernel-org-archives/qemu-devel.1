Received: from eggs.gnu.org ([2001:4830:134:3::10]:50812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f6SAc-0004hC-QS
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 22:41:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f6SAb-00041e-67
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 22:41:06 -0400
Date: Thu, 12 Apr 2018 12:21:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180412022154.GD9425@umbus.fritz.box>
References: <1523472120-56496-1-git-send-email-spopovyc@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="d01dLTUuW90fS44H"
Content-Disposition: inline
In-Reply-To: <1523472120-56496-1-git-send-email-spopovyc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for 2.13 v3 0/2] target/ppc: Support adding
 memory to initially memory-less NUMA nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Serhii Popovych <spopovyc@redhat.com>
Cc: qemu-ppc@nongnu.org, bharata@linux.vnet.ibm.com, qemu-devel@nongnu.org


--d01dLTUuW90fS44H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 11, 2018 at 02:41:58PM -0400, Serhii Popovych wrote:
> Now PowerPC Linux kernel supports hot-add to NUMA nodes not populated
> initially with memory we can enable such support in qemu. This requires
> two changes:
>=20
>   o Add device tree property "ibm,max-associativity-domains" to let
>     guest kernel chance to find max possible NUMA node
>=20
>   o Revert  commit b556854bd852 ("spapr: Don't allow memory hotplug to
>     memory less nodes") to remove check for hot-add to memory-less node.
>=20
> See description messges for individual changes for more details.
>=20
> v3:
>   - Make layer for max_cpus unspecified instead of setting it to zero.
>     Not adding cpu_to_be32(spapr_vcpu_id(spapr, max_cpus - 1)) because
>     at the moment we only want max number for numa nodes to enable feat.
>   - Rebase to current state of master branch.
>=20
> v2:
>   - Reorder patches in series according to description above.
>   - Add extra coment to revert noticing return to previous behaviour for
>     guests without support for hot-add to empty node.
>   - Drop max_cpus from topology in property due to vcpu id discontiguous
>     allocations. Thanks to David Gibson for extra explanation.
>   - Rebase to current state of master branch.
>=20
> Serhii Popovych (2):
>   spapr: Add ibm,max-associativity-domains property
>   Revert "spapr: Don't allow memory hotplug to memory less nodes"

Applied to ppc-for-2.13, thanks.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--d01dLTUuW90fS44H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrOwsEACgkQbDjKyiDZ
s5Jx9w//cpyKu+K3r6Dwkfd3H9eiY5PWkKbgEp7tqROu0fJYNhXRvdLfsYL/3Y1m
OERlz3iINVoS5M4kVAEmqlq6/91gJ+JzyAyuaMRI5YHluAFseWLG7RGi8GrM0TKs
/vLJTUKMC8HThVnuouY+QEJw+G9g0keaJYCf23uOcUzD2uB7zfHvBU7j9BuuepUL
42j/9vE64URw/i6oJ4emxGpapwzPDR6Pc2jNYxUmnEIQRHXe8QXcWLUoX/Dh9JBK
fUxfE+hGmoxGgOgfdowCofzvbLFWSCPOL5/SKHEw/byTHc5DYTHHAjyiHkeyQE67
wfFf44NgH6sg/OBLaYl3lFCHksV5pFwwR4n3WQeeV6HaPDg537w+HD+UsikuknnB
D1w5NyTT9Tp3cb79YxoJQVZ/CnA1jqCue/0nXbiTrjoWMbfFfnHxOnVppkf6f6Pp
tOBrUogwedSgJjymgEtpbwo98At0jCMAXE+Ws1PSyNSC105BKZjpRJh+3M0wQ1Sq
D1bSNKeBlVaxu2agEbcmB0qELpWybtox8CZBJ8rDEslsMoWY0bT830oPlDBRge/E
hE3BcSzkG4KNdVy+oj5VNfdj5WXjwKt/ePD3T2UOi7SxWQX03O5Iy1xds0E5Xikr
NTF9OKmYFckxNYTXAlGUwoY3gAJbvVy9+W1H6Cabgn2BCi/Fzfo=
=umer
-----END PGP SIGNATURE-----

--d01dLTUuW90fS44H--
