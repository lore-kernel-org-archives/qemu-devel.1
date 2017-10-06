Received: from eggs.gnu.org ([2001:4830:134:3::10]:47479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e0RnW-00023Z-Ml
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 08:32:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e0RnR-0000uz-Qg
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 08:32:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50016)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e0RnR-0000tB-Hv
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 08:32:05 -0400
References: <1501119055-4060-1-git-send-email-mdroth@linux.vnet.ibm.com>
	<150706931752.3830.12126799989731308076@sif>
	<20171006102329.GN10961@umbus.fritz.box>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9edef8ed-9231-32de-ace5-790ee9de960b@redhat.com>
Date: Fri, 6 Oct 2017 14:31:35 +0200
MIME-Version: 1.0
In-Reply-To: <20171006102329.GN10961@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Cc8sLupTVXIKhKXv8srUTi3DT6eKBpBCf"
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/3] qdev/vfio: defer DEVICE_DEL
 to avoid races with libvirt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, groug@kaod.org, armbru@redhat.com, alex.williamson@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Cc8sLupTVXIKhKXv8srUTi3DT6eKBpBCf
From: Paolo Bonzini <pbonzini@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, groug@kaod.org,
 armbru@redhat.com, alex.williamson@redhat.com
Message-ID: <9edef8ed-9231-32de-ace5-790ee9de960b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/3] qdev/vfio: defer DEVICE_DEL to
 avoid races with libvirt
References: <1501119055-4060-1-git-send-email-mdroth@linux.vnet.ibm.com>
 <150706931752.3830.12126799989731308076@sif>
 <20171006102329.GN10961@umbus.fritz.box>
In-Reply-To: <20171006102329.GN10961@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 06/10/2017 12:23, David Gibson wrote:
> On Tue, Oct 03, 2017 at 05:21:57PM -0500, Michael Roth wrote:
>> Patch 1/3 is also needed for another series that Greg is working on
>> and I don't want to hold that up for this series, so if it's
>> preferred that we just post that patch separately in the meantime
>> please let me know.
>=20
> Yeah, now that I've understood the issue properly, I also think this
> is a good idea.  I recommend reposting.

Yes, please do!

Thanks,

Paolo


--Cc8sLupTVXIKhKXv8srUTi3DT6eKBpBCf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlnXd6cACgkQv/vSX3jH
roNc9Af/cwz/UxUjJvpZUcOS4P7qKQt+thbbmio4TEpRyUCrYThM/FZQrCjUNOt/
p3HY1c28bJVbZztAWAXhlyrZ3sKVccjZY/skahBfbYqYDnwmdBoMixcIIS1mKiZr
EimCpGiqIbXla4kUYeqXFQErD992omeWgtDBKdxlOjniIrEOw8zeTHeHaLmCJ3Tm
1TJZBd8W/L1zjlAfdhofHxAoBduUb4T9YDmfuKo99YfsQ+2zBO2qPs5ctaHGdDr8
am3FMdLHN68IK3s6k+PwQJtsWNyP/QV+Q9joTGYZu5+XZPId2VJm4S8JwRO9GyqP
eZ0gxM9zv6du2KVh7EaMwu2mfG/pZA==
=ab85
-----END PGP SIGNATURE-----

--Cc8sLupTVXIKhKXv8srUTi3DT6eKBpBCf--
