Received: from eggs.gnu.org ([2001:4830:134:3::10]:45070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cvq0j-00014J-EA
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 14:50:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cvq0f-0003tn-Hw
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 14:50:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cvq0f-0003t3-9R
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 14:50:25 -0400
References: <4712D8F4B26E034E80552F30A67BE0B1A4F5DD@ORSMSX112.amr.corp.intel.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <119011da-a75c-3baf-f5c0-f59e0bbc1000@redhat.com>
Date: Wed, 5 Apr 2017 13:50:20 -0500
MIME-Version: 1.0
In-Reply-To: <4712D8F4B26E034E80552F30A67BE0B1A4F5DD@ORSMSX112.amr.corp.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TC30QQTng0VSTpweVtiBKsGWhx97llIxv"
Subject: Re: [Qemu-devel] [PATCH 1/3] move xen-common.c to hw/xen/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Xu, Anthony" <anthony.xu@intel.com>, "'qemu-devel@nongnu.org'" <qemu-devel@nongnu.org>
Cc: "anthony.perard@citrix.com" <anthony.perard@citrix.com>, 'Paolo Bonzini' <pbonzini@redhat.com>, "sstabellini@kernel.org" <sstabellini@kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TC30QQTng0VSTpweVtiBKsGWhx97llIxv
From: Eric Blake <eblake@redhat.com>
To: "Xu, Anthony" <anthony.xu@intel.com>,
 "'qemu-devel@nongnu.org'" <qemu-devel@nongnu.org>
Cc: "anthony.perard@citrix.com" <anthony.perard@citrix.com>,
 'Paolo Bonzini' <pbonzini@redhat.com>,
 "sstabellini@kernel.org" <sstabellini@kernel.org>
Message-ID: <119011da-a75c-3baf-f5c0-f59e0bbc1000@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] move xen-common.c to hw/xen/
References: <4712D8F4B26E034E80552F30A67BE0B1A4F5DD@ORSMSX112.amr.corp.intel.com>
In-Reply-To: <4712D8F4B26E034E80552F30A67BE0B1A4F5DD@ORSMSX112.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/05/2017 01:39 PM, Xu, Anthony wrote:
> move xen-common.c to hw/xen/
>=20

Your message failed to set the 'In-Reply-To:' header, and was therefore
not threaded to your 0/3 cover letter.  Please see if you can fix that
before posting your next series.

>=20
> Signed-off -by: Anthony Xu <anthony.xu@intel.com>
>=20
>=20
>=20
> ---
>  hw/xen/xen-common.c | 158 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  stubs/xen-common.c  |  14 +++++
>  xen-common-stub.c   |  14 -----
>  xen-common.c        | 158 --------------------------------------------=
--------
>  4 files changed, 172 insertions(+), 172 deletions(-)

Please run 'git config diff.renames true' so that patches like this will
be a LOT smaller on the mailing list, and will more easily focus on the
(few) things that have to change due to the new name rather than being a
bulk delete/insert operation that hides the changes.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--TC30QQTng0VSTpweVtiBKsGWhx97llIxv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY5TxsAAoJEKeha0olJ0Nqfc8H/jmeHnVeIMceTlQiw3Un5/h7
EAIAY2bxnj/Qg5FPIhuB4+YMzA8cHWjPhG10KMrUSKDfkOi0y5LgV3rHlq2mhGwj
J1/Prr4vqEWI3s/jo6UGNIMXEqrhwILP0hC6TOXGF7TQE96s4mgBpv5GISgUtEcy
RZKSMPdSldpJpMRw2dB1fe0XvoRctEr6SQXh6oqs6ZtJpAPMZphZ5ht6KsVDXav4
azwbTm5Aauy6l918L+n03WzoP6zIHkN2+gWRC7XIuKOJW25Hxr5p9spS4T5JnRQB
zDB+d4vXqeHie+eP90lFg0Sby12neZExvNxOiDg7O4Uy3NysALNAm1PH5tYdp94=
=aOl6
-----END PGP SIGNATURE-----

--TC30QQTng0VSTpweVtiBKsGWhx97llIxv--
