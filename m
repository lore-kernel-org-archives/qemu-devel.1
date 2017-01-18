Received: from eggs.gnu.org ([2001:4830:134:3::10]:47600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cTus5-0007IZ-MU
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 13:22:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cTus1-0001Gj-NQ
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 13:22:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cTus1-0001GK-Ey
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 13:22:05 -0500
References: <1484759609-264075-1-git-send-email-imammedo@redhat.com>
	<1484759609-264075-10-git-send-email-imammedo@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7fc85b46-880d-04f1-1410-3131f55c596e@redhat.com>
Date: Wed, 18 Jan 2017 12:22:01 -0600
MIME-Version: 1.0
In-Reply-To: <1484759609-264075-10-git-send-email-imammedo@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4CvwdEdNlsJwKcGXRLUEPjLBfjdxhecGU"
Subject: Re: [Qemu-devel] [RFC 09/13] numa: introduce '-numa cpu' cpu option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>, Andrew Jones <drjones@redhat.com>, ehabkost@redhat.com, peter.maydell@linaro.org, fanc.fnst@cn.fujitsu.com, Thomas Huth <thuth@redhat.com>, caoj.fnst@cn.fujitsu.com, stefanha@redhat.com, izumi.taku@jp.fujitsu.com, vilanova@ac.upc.edu, David Gibson <david@gibson.dropbear.id.au>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4CvwdEdNlsJwKcGXRLUEPjLBfjdxhecGU
From: Eric Blake <eblake@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>, Andrew Jones
 <drjones@redhat.com>, ehabkost@redhat.com, peter.maydell@linaro.org,
 fanc.fnst@cn.fujitsu.com, Thomas Huth <thuth@redhat.com>,
 caoj.fnst@cn.fujitsu.com, stefanha@redhat.com, izumi.taku@jp.fujitsu.com,
 vilanova@ac.upc.edu, David Gibson <david@gibson.dropbear.id.au>
Message-ID: <7fc85b46-880d-04f1-1410-3131f55c596e@redhat.com>
Subject: Re: [Qemu-devel] [RFC 09/13] numa: introduce '-numa cpu' cpu option
References: <1484759609-264075-1-git-send-email-imammedo@redhat.com>
 <1484759609-264075-10-git-send-email-imammedo@redhat.com>
In-Reply-To: <1484759609-264075-10-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/18/2017 11:13 AM, Igor Mammedov wrote:
> It allows to specify mapping of a CPU to NUMA node on CLI.
> Option should be repeated for each present/possible CPU.
> Example for PC machine:
>   -numa node,nodeid=3D0 -numa node,nodeid=3D1 \
>   -numa cpu,socket-id=3D0,core-id=3D0,thread-id=3D0,node-id=3D0 \
>   -numa cpu,socket-id=3D1,core-id=3D0,thread-id=3D0,node-id=3D1
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---

> +++ b/qapi-schema.json
> @@ -5543,7 +5543,8 @@
>  ##
>  { 'union': 'NumaOptions',
>    'data': {
> -    'node': 'NumaNodeOptions' }}
> +    'node': 'NumaNodeOptions',
> +    'cpu': 'CpuInstanceProperties' }}

Missing a documentation blurb that includes a '(since 2.9)' tag.


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--4CvwdEdNlsJwKcGXRLUEPjLBfjdxhecGU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYf7JJAAoJEKeha0olJ0NqirUIAI8wmEHIBqZBJEy9ICdcrVHx
K7GTWjRwDe/+LpHjoHYHRfNoFxiSzsoC1o+y1wl4u8NPm9bBls001k9tjX96zXMM
0B9gNpqgiQ032pdqR2j44k6AcxwuWrLn8BeZTKRYqwu6ui8ASM8rgPq5GPedlltN
QAbqGCXvSWm+2ZRZkFUs/7ci5ol7jQTSiiU5s/+AtBj1CaZsM0q/iqw3XFeUtCu0
KqVj96xaMEHVrnHkD47GwPz7WWVaadwF25Kd9fMjmu9D/wr1CZLuEGbPgUHdGTgZ
G2vkTgpFm6w+fHXbY9Q3sehNXk6sw01VqePFmgDmE2dmhSHPMj2XIl8Ujsipea4=
=/6Ay
-----END PGP SIGNATURE-----

--4CvwdEdNlsJwKcGXRLUEPjLBfjdxhecGU--
