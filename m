Received: from eggs.gnu.org ([2001:4830:134:3::10]:57769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cljND-0004ZK-U5
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:43:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cljNA-00035o-Pi
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:43:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cljN7-00035A-Km
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:43:52 -0500
References: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
	<148900636610.27090.7472863810631270644.stgit@brijesh-build-machine>
From: Eric Blake <eblake@redhat.com>
Message-ID: <48478982-b2da-cc70-f5f1-2f34ca60fc87@redhat.com>
Date: Wed, 8 Mar 2017 15:43:45 -0600
MIME-Version: 1.0
In-Reply-To: <148900636610.27090.7472863810631270644.stgit@brijesh-build-machine>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hdswsA9iTTfv3HwaIvtnOkJsru6bGBXJR"
Subject: Re: [Qemu-devel] [RFC PATCH v4 09/20] hmp: display memory
 encryption support in 'info kvm'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>, ehabkost@redhat.com, crosthwaite.peter@gmail.com, armbru@redhat.com, mst@redhat.com, p.fedin@samsung.com, qemu-devel@nongnu.org, lcapitulino@redhat.com, pbonzini@redhat.com, rth@twiddle.net
Cc: Thomas.Lendacky@amd.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hdswsA9iTTfv3HwaIvtnOkJsru6bGBXJR
From: Eric Blake <eblake@redhat.com>
To: Brijesh Singh <brijesh.singh@amd.com>, ehabkost@redhat.com,
 crosthwaite.peter@gmail.com, armbru@redhat.com, mst@redhat.com,
 p.fedin@samsung.com, qemu-devel@nongnu.org, lcapitulino@redhat.com,
 pbonzini@redhat.com, rth@twiddle.net
Cc: Thomas.Lendacky@amd.com
Message-ID: <48478982-b2da-cc70-f5f1-2f34ca60fc87@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH v4 09/20] hmp: display memory encryption
 support in 'info kvm'
References: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
 <148900636610.27090.7472863810631270644.stgit@brijesh-build-machine>
In-Reply-To: <148900636610.27090.7472863810631270644.stgit@brijesh-build-machine>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/08/2017 02:52 PM, Brijesh Singh wrote:
> update 'info kvm' to display the memory encryption support.
>=20
> (qemu) info kvm
> kvm support: enabled
> memory encryption: disabled
>=20
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---

> +++ b/qapi-schema.json
> @@ -185,9 +185,12 @@
>  #
>  # @present: true if KVM acceleration is built into this executable
>  #
> +# @mem-encryption: true if Memory Encryption is active (since 2.8)

You've missed 2.8, and probably even 2.9, unless you can argue that this
is a bug-fix appropriate during soft freeze.  So this should be since 2.1=
0.

> +#
>  # Since: 0.14.0
>  ##
> -{ 'struct': 'KvmInfo', 'data': {'enabled': 'bool', 'present': 'bool'} =
}
> +{ 'struct': 'KvmInfo', 'data': {'enabled': 'bool', 'present': 'bool',
> +            'mem-encryption' : 'bool'} }
> =20


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--hdswsA9iTTfv3HwaIvtnOkJsru6bGBXJR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYwHsRAAoJEKeha0olJ0NqsAIIAJvKdSafWavDbAnEFMJ+P+59
fpErr5V1HA3J+og6iyXJXtUqHQEr9nuNcONgj7hBmaWWwAuNbC3Y2SSXfCljZPBT
VTW0/GBNKkwbODV967Ju9a3RwJHR1kQXH2cUKcqNQ+pKIxbeTHNeyB20fI2PGbrf
FfegwLRqVnqwlLt+7fD9+SuM4h+0xj29esl4JqqRsEeUO3KSuuprAlFrE2hDsJMR
aIuSR66jU8wcJ2824CZHs7paMZck9iAfZdJDFh381Z8aBHQbBO8RDXO16GQP2jY5
gdEnP9Y/wm+NqnIWR7Ot9R5SFbbG3FftevFli+znU0Y66+0VwG9DzUrplBiFQBU=
=dVGy
-----END PGP SIGNATURE-----

--hdswsA9iTTfv3HwaIvtnOkJsru6bGBXJR--
