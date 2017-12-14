Received: from eggs.gnu.org ([2001:4830:134:3::10]:43611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ePWgt-0007SR-Dw
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 11:49:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ePWgo-0005RF-SW
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 11:48:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ePWgo-0005Qi-Ie
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 11:48:54 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 662F180F79
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 16:48:53 +0000 (UTC)
References: <20171208115834.21577-1-berrange@redhat.com>
	<8e85e5e6-01f6-9c01-f7fa-e33ec4f9d6c7@redhat.com>
	<20171212141749.GC26971@redhat.com>
	<54f33ad4-4483-9f92-ff24-9e6d1f4daf2a@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <853f8f0b-453c-82c9-5e05-ccab21c41ad2@redhat.com>
Date: Thu, 14 Dec 2017 10:48:51 -0600
MIME-Version: 1.0
In-Reply-To: <54f33ad4-4483-9f92-ff24-9e6d1f4daf2a@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="abfkldxbXHG47Av81gBDOq9flWOhSI8lj"
Subject: Re: [Qemu-devel] [PATCH] docs: update information for TLS
 certificate management
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--abfkldxbXHG47Av81gBDOq9flWOhSI8lj
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <853f8f0b-453c-82c9-5e05-ccab21c41ad2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] docs: update information for TLS certificate
 management
References: <20171208115834.21577-1-berrange@redhat.com>
 <8e85e5e6-01f6-9c01-f7fa-e33ec4f9d6c7@redhat.com>
 <20171212141749.GC26971@redhat.com>
 <54f33ad4-4483-9f92-ff24-9e6d1f4daf2a@redhat.com>
In-Reply-To: <54f33ad4-4483-9f92-ff24-9e6d1f4daf2a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/14/2017 03:41 AM, Thomas Huth wrote:

>>> You can use '--object' with qemu as well (getopt_long_only() accepts
>>> double-dash form in addition to single dash).  If it makes it any eas=
ier
>>> to only document the double-dash form, then go for it.
>>
>> Since the QEMU -help text only mentions the single dash format, I'll
>> stick with that.
>>
>> Perhaps though, we should change the -help text (and all docs) to alwa=
ys
>> use double dash format so we're consistent across QEMU codebase, and m=
ore
>> normal CLI arg syntax for long options ?
>=20
> Good idea!
>=20

I've added it to
https://wiki.qemu.org/Contribute/BiteSizedTasks#Consistent_option_usage_i=
n_documentation
--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--abfkldxbXHG47Av81gBDOq9flWOhSI8lj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloyq3MACgkQp6FrSiUn
Q2qasggAmFSTrM5MBVgxPPpBazB/tM8AsJjvR3rNHoL6VCzrZir7lPoS9mk1E6Ky
bsXygidqH53N1KIbs6XYdjAwGkvfZGESsUCcQKrX9l0UQ38ukxMvtWViY1TvRIcF
5Dvsj7Abdfw5kIXrsZrTxn3oF+S9idZPndKEZC+vOJAuDvFzvtHHRwcIRdoqZgsS
k1pCgGs9Am43pjltc9jzQUxHArHj/sPoiY43JW8tp1CmbHrVGHRV/vuP+pWuxB7V
ebf3dnIqQJTvKyMoSG7Y/1v35+w5eWDn6wH67BEC+pQkeqUnmgq5WSr32U7lZ7eh
iTzkPk7MKZtyK1IyV8D9hKfTDkO5Xw==
=GjDl
-----END PGP SIGNATURE-----

--abfkldxbXHG47Av81gBDOq9flWOhSI8lj--
