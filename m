Received: from eggs.gnu.org ([2001:4830:134:3::10]:34226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYdYm-0000r4-MN
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:53:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYdYi-0004Ti-N0
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:53:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cYdYi-0004Ta-Dn
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:53:40 -0500
References: <1485888144-16531-1-git-send-email-mst@redhat.com>
	<1485888144-16531-6-git-send-email-mst@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ca375be4-6694-2de2-dac2-38e0f587d576@redhat.com>
Date: Tue, 31 Jan 2017 12:53:34 -0600
MIME-Version: 1.0
In-Reply-To: <1485888144-16531-6-git-send-email-mst@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JS2mIScO2nhh4xrmwRDF5ABp66sFiK343"
Subject: Re: [Qemu-devel] [PULL v4 05/23] compiler: rework BUG_ON using a
 struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JS2mIScO2nhh4xrmwRDF5ABp66sFiK343
From: Eric Blake <eblake@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ca375be4-6694-2de2-dac2-38e0f587d576@redhat.com>
Subject: Re: [PULL v4 05/23] compiler: rework BUG_ON using a struct
References: <1485888144-16531-1-git-send-email-mst@redhat.com>
 <1485888144-16531-6-git-send-email-mst@redhat.com>
In-Reply-To: <1485888144-16531-6-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/31/2017 12:42 PM, Michael S. Tsirkin wrote:
> There are theoretical concerns that some compilers might not trigger
> build failures on attempts to define an array of size (x ? -1 : 1) wher=
e
> x is a variable and make it a variable sized array instead. Let rewrite=


s/Let/Let's/

> using a struct with a negative bit field size instead as there are no
> dynamic bit field sizes.  This is similar to what Linux does.

On one of the earlier review spins, I suggested making it explicit that
we are now requiring that the condition be a compile-time constant (you
got that wording in 2/23, but not here) - food for thought if you have
to respin this.

>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/qemu/compiler.h | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--JS2mIScO2nhh4xrmwRDF5ABp66sFiK343
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYkN0uAAoJEKeha0olJ0NqUzoH/0ClWSCKbow86sRZL2AxN9EH
LFDPSBSdlzsUR1P1skOWCy67BAgn4cAu0teub8X8vs8r560AcPMpmc1bpRjEDVhS
7w1zevkEFjz8BotzsRPNNNZx1T7TbXjVod631L0de0zvK9hfa+SfGZ+dF09fqRbU
ZF9FBsj4x6XJbNXLbPXc9cPe41kcH4AiwJFVTzK0mh0frJ+COesFOdraXAUw0PXW
2rZcjQ3RWcQl1d074Jx+0H+Wqp69O1MFVR7GISA8V3C/c3jS0Vz+NF9ZCyZx/yVE
zADKjgous1Eb7ogk6kO911b3rRSQreBZJl9Q7uLodXYXT4JPeNisYl8pRgPeHF8=
=317x
-----END PGP SIGNATURE-----

--JS2mIScO2nhh4xrmwRDF5ABp66sFiK343--
