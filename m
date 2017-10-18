Received: from eggs.gnu.org ([2001:4830:134:3::10]:56904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e4jns-0000ki-UG
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 04:34:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e4jnp-0003r5-Nf
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 04:34:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e4jnp-0003qS-FN
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 04:34:13 -0400
References: <20171016222315.407-1-mdroth@linux.vnet.ibm.com>
	<20171016222315.407-2-mdroth@linux.vnet.ibm.com>
	<20171017054527.GJ2776@umbus.fritz.box>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <096a5344-1b12-ddab-408a-8b5cffdc53aa@redhat.com>
Date: Wed, 18 Oct 2017 10:34:01 +0200
MIME-Version: 1.0
In-Reply-To: <20171017054527.GJ2776@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OAUSP1nONAoPqQD3XQ8UXiIT3XsKe9gWd"
Subject: Re: [Qemu-devel] [PATCH v3 1/3] qdev: store DeviceState's canonical
 path to use when unparenting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, ehabkost@redhat.com, groug@kaod.org, armbru@redhat.com, alex.williamson@redhat.com, imammedo@redhat.com, "Michael S . Tsirkin" <mst@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OAUSP1nONAoPqQD3XQ8UXiIT3XsKe9gWd
From: Paolo Bonzini <pbonzini@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, ehabkost@redhat.com,
 groug@kaod.org, armbru@redhat.com, alex.williamson@redhat.com,
 imammedo@redhat.com, "Michael S . Tsirkin" <mst@redhat.com>
Message-ID: <096a5344-1b12-ddab-408a-8b5cffdc53aa@redhat.com>
Subject: Re: [PATCH v3 1/3] qdev: store DeviceState's canonical path to use
 when unparenting
References: <20171016222315.407-1-mdroth@linux.vnet.ibm.com>
 <20171016222315.407-2-mdroth@linux.vnet.ibm.com>
 <20171017054527.GJ2776@umbus.fritz.box>
In-Reply-To: <20171017054527.GJ2776@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 17/10/2017 07:45, David Gibson wrote:
>> =20
>>  post_realize_fail:
>> +    g_free(dev->canonical_path);
> Should dev->canonical_path be set to NULL on this failure path?
>=20

It should be fine because dev->pending_deleted_event can only become
true if dev->realized has ever been set to true.  But it's certainly
cleaner to clear it, so I'll do the change.

Queued the series, thanks.

Paolo


--OAUSP1nONAoPqQD3XQ8UXiIT3XsKe9gWd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlnnEfkACgkQv/vSX3jH
roNkvwgAll7CK/BmyCHDZ6q7iD8Tp/HJM4zgycZWqrX+XPKFLek9z2WkSinfvXBQ
Mljgf++NI9uqdszf0Z2S0x8A2AaktTjaiEac/ykkmW8EQ8glfrGkWYdgw2t7hioI
tYAlIb1PIvzaZ+Fx15IivZMt7mUO2IFmPQELDF3yaPvZazMFTBsxZ+TExyI4XaY/
frOuY6AX+NXDyOaWiwk+KrOaF2z6xk2JNwM5XRX2iR9Rt4qMEfXtolFA5DYCgK25
kQbAcsdtzl0SQ2hZLyHUNZNDrwC9gSe+NIO125ZBaqMhR4Dv4E8Rms+75QEn6QlJ
ARI2cM477O9a7eoKO+5gm/5+grKpvw==
=JXZw
-----END PGP SIGNATURE-----

--OAUSP1nONAoPqQD3XQ8UXiIT3XsKe9gWd--
