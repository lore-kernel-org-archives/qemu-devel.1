Received: from eggs.gnu.org ([2001:4830:134:3::10]:52240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f9Rhs-0006lf-R9
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:47:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f9Rho-0000y4-0M
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:47:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44000 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f9Rhn-0000xH-QS
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:47:43 -0400
References: <20180417224054.26363-1-lersek@redhat.com>
	<20180418060243.iafg4wj5gwsruop5@sirius.home.kraxel.org>
	<b9c7d767-39c4-065f-f487-34c0c682bd85@redhat.com>
	<20180419100900.7b66fde0@umbus.fritz.box>
	<d032dfe2-bfab-5a12-c867-a5229f303f5f@redhat.com>
	<20180420110301.1734899d@umbus.fritz.box>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <57df20fb-4a5b-7219-b364-29444ae86461@redhat.com>
Date: Fri, 20 Apr 2018 10:47:23 +0200
MIME-Version: 1.0
In-Reply-To: <20180420110301.1734899d@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fCpRnHqQ2M5mfbDrLmPufXOXMzumTxNL5"
Subject: Re: [Qemu-devel] [qemu RFC v2] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <dgibson@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>, Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Eric Blake <eblake@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michal Privoznik <mprivozn@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fCpRnHqQ2M5mfbDrLmPufXOXMzumTxNL5
From: Paolo Bonzini <pbonzini@redhat.com>
To: David Gibson <dgibson@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 libvir-list@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>,
 Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Eric Blake <eblake@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Michal Privoznik <mprivozn@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Message-ID: <57df20fb-4a5b-7219-b364-29444ae86461@redhat.com>
Subject: Re: [qemu RFC v2] qapi: add "firmware.json"
References: <20180417224054.26363-1-lersek@redhat.com>
 <20180418060243.iafg4wj5gwsruop5@sirius.home.kraxel.org>
 <b9c7d767-39c4-065f-f487-34c0c682bd85@redhat.com>
 <20180419100900.7b66fde0@umbus.fritz.box>
 <d032dfe2-bfab-5a12-c867-a5229f303f5f@redhat.com>
 <20180420110301.1734899d@umbus.fritz.box>
In-Reply-To: <20180420110301.1734899d@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 20/04/2018 03:03, David Gibson wrote:
>> This also implies I shouldn't add "openbios" separately, which was
>> suggested earlier by Gerd -- according to
>> <https://en.wikipedia.org/wiki/OpenBIOS>, OpenBIOS is another
>> implementation of OFW.
>=20
> Right.  Although I think OpenBIOS and SLOF support a disjoint set of
> machines.  Openhackware which is (was?) used on some machines is yet
> another (very partial) openfirmware implementation.

We can:

1a) replace the architecture field with an ABI field (seems wrong to me)

1b) add an "ABI" field (containing e.g. prep, spapr, etc.) to complement
the architecture field

2) we include directly a glob pattern for the QEMU machine types (also
seems wrong).

3) just like we effectively moved the guest ABI to the features field,
we split the features into host-features and guest-features, and the
host ABI (prep, spapr, etc.; but also OVMF's SMM requirement fits here
for example) moves into host-features.  Again, just like 1a/1b, this can
be replace or complement the architecture field, and I think I'd prefer
the latter

Paolo


--fCpRnHqQ2M5mfbDrLmPufXOXMzumTxNL5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlrZqSAACgkQv/vSX3jH
roPvQgf/TFDQCPLbX4CQSE8Af5BnkmyASL9kyVIAP3a/KKskjTpa2fp9yZfj6eKR
reQU+WTBHz+r3m/qLlUmcKTbghMyLwTtmN3xUq5O/4/YlvhkK6GwWWAWRcuV+U13
gAMScQhEZUe5UnWbbYw6gqQ0X30oGH6nMAE8BCLteRbSg3IEllGF5oIsBAGiW2be
coIWrruW5qR9dwHTefGy2msGVPJ6kjtTOtpK7o15efjanIodt5iiX805yhVRfa3U
j6zqVNtSDhmtmPPmROb8J2dNSkwe7T9AwwQgeguycp4aqusX3wlFIjSxlvLZGjj5
pwYwSQY+gfUr0nDqqZUVvnBXQGTs9A==
=c8Mr
-----END PGP SIGNATURE-----

--fCpRnHqQ2M5mfbDrLmPufXOXMzumTxNL5--
