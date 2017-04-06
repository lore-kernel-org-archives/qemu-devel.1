Received: from eggs.gnu.org ([2001:4830:134:3::10]:38745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cw9Dq-00087O-AJ
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 11:21:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cw9Dn-0001pA-6c
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 11:21:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cw9Dm-0001nO-Td
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 11:21:15 -0400
References: <1491434491-1765-1-git-send-email-anthony.xu@intel.com>
	<1491434491-1765-2-git-send-email-anthony.xu@intel.com>
	<20170406151004.GA1618@redhat>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6ab9930b-1e83-c2c7-0915-78574394063f@redhat.com>
Date: Thu, 6 Apr 2017 10:21:03 -0500
MIME-Version: 1.0
In-Reply-To: <20170406151004.GA1618@redhat>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RRDDWrnVtVkNUjAR3GNcUpLw4iuf2s330"
Subject: Re: [Qemu-devel] [PATCH 1/3] move xen-common.c to hw/xen/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sahid Orentino Ferdjaoui <sferdjao@redhat.com>, Anthony Xu <anthony.xu@intel.com>
Cc: anthony.perard@citrix.com, pbonzini@redhat.com, sstabellini@kernel.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RRDDWrnVtVkNUjAR3GNcUpLw4iuf2s330
From: Eric Blake <eblake@redhat.com>
To: Sahid Orentino Ferdjaoui <sferdjao@redhat.com>,
 Anthony Xu <anthony.xu@intel.com>
Cc: anthony.perard@citrix.com, pbonzini@redhat.com, sstabellini@kernel.org,
 qemu-devel@nongnu.org
Message-ID: <6ab9930b-1e83-c2c7-0915-78574394063f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] move xen-common.c to hw/xen/
References: <1491434491-1765-1-git-send-email-anthony.xu@intel.com>
 <1491434491-1765-2-git-send-email-anthony.xu@intel.com>
 <20170406151004.GA1618@redhat>
In-Reply-To: <20170406151004.GA1618@redhat>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/06/2017 10:10 AM, Sahid Orentino Ferdjaoui wrote:
> On Wed, Apr 05, 2017 at 04:21:29PM -0700, Anthony Xu wrote:
>> move xen-common.c to hw/xen/
>>
>> Signed-off -by: Anthony Xu <anthony.xu@intel.com>
>=20
> nit: s/Signed-off -by/Signed-off-by, not sure if it's really important
> or not.

Some of the automated tooling may choke on the misspelled variant, and
S-o-b is legally important, so it is worth fixing.

By the way, you can use 'git commit -s' or 'git send-email -s' to add
S-o-b in the proper format at a given stage in your workflow, rather
than having to type it by hand; it becomes obvious that you didn't use
git's automation for adding it when you have a typo or when you have
more than one blank line between your S-o-b and the --- separator.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--RRDDWrnVtVkNUjAR3GNcUpLw4iuf2s330
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY5lzfAAoJEKeha0olJ0Nq8iUH/3FFnioRh5IANaOpZE5VyhQg
Q1lPQrmFQddrfSMlAFTM602B7tL1CGQpW7Y0S2PliPeBml2FVkgexhjwJW9qvm29
Nq87q5WaVG+EzIJGY6UGBWRZqrpLzZX7mauNhS9H0CfNSa1QnfohxD1q+EW2V9cr
g9p37EPFHGbg/QRpvivlJ8piYiI2xeRD7r14pnBm1noeuBLkQg9A81PMQXremk/Q
O6+pDeQLuusU3Zqc3j35yC+q9cTIXcCIvqodUazB6SUHpcL6Ff3yt1Mfg4YVVQv0
bHIVXe//RjuP6NpkaWwQjYAtzbt+YhrmP5JWbjmgxvsGH2xb7pYy79dpxceRovU=
=DXn4
-----END PGP SIGNATURE-----

--RRDDWrnVtVkNUjAR3GNcUpLw4iuf2s330--
