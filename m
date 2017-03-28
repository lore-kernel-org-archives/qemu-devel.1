Received: from eggs.gnu.org ([2001:4830:134:3::10]:33298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1csw0U-0004vt-RW
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 14:38:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1csw0R-0003tv-Pe
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 14:38:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41204)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1csw0R-0003tY-GG
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 14:38:11 -0400
References: <CAFEAcA_Dwky8Jr+y3JACdK5MVM82syrvzuVktnJF0cyZ-FjY0A@mail.gmail.com>
	<DM2PR21MB006077BF2F5F3DDA94E83ABD9E320@DM2PR21MB0060.namprd21.prod.outlook.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c538920e-f270-4ba1-df38-2b0b43fafb8b@redhat.com>
Date: Tue, 28 Mar 2017 13:38:04 -0500
MIME-Version: 1.0
In-Reply-To: <DM2PR21MB006077BF2F5F3DDA94E83ABD9E320@DM2PR21MB0060.namprd21.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nV1jXetfVwhbbeJMSkkrmNn5hQ43tl45P"
Subject: Re: [Qemu-devel] qemu-devel mailing list vs DMARC and
 microsoft.com's p=reject policy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Baumann <Andrew.Baumann@microsoft.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nV1jXetfVwhbbeJMSkkrmNn5hQ43tl45P
From: Eric Blake <eblake@redhat.com>
To: Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>
Message-ID: <c538920e-f270-4ba1-df38-2b0b43fafb8b@redhat.com>
Subject: Re: [Qemu-devel] qemu-devel mailing list vs DMARC and microsoft.com's
 p=reject policy
References: <CAFEAcA_Dwky8Jr+y3JACdK5MVM82syrvzuVktnJF0cyZ-FjY0A@mail.gmail.com>
 <DM2PR21MB006077BF2F5F3DDA94E83ABD9E320@DM2PR21MB0060.namprd21.prod.outlook.com>
In-Reply-To: <DM2PR21MB006077BF2F5F3DDA94E83ABD9E320@DM2PR21MB0060.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/28/2017 12:53 PM, Andrew Baumann via Qemu-devel wrote:

>>  (3) I could set dmarc_moderation_action to Munge From, which means th=
at
>>      those senders who have a p=3Dreject policy will get their mails
>>      rewritten to have a From=3D"Whoever (via the list) <qemu-devel@..=
=2E>"
>>      and their actual email in the Reply-to:
>>    * if anybody's mail client doesn't honour Reply-to: then what they
>>      think is a personal reply will go to the list by accident

That's my favorite of the options (and these days, reply-to works a lot
better than it used to even 10 year ago)...

>>
>> For the moment I have picked option (3), but I'm open to argument
>> that we should pick something else.
>=20
> Option 3 is a fine one from my perspective (I could also live with 2). =
This email will hopefully help you test whether it's effective.

and it appears to have worked; Andrew's mail purported to be from the
list, but had a correct 'Reply-to', and my mailer (thunderbird) appears
to do the right thing for reply-to-all.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--nV1jXetfVwhbbeJMSkkrmNn5hQ43tl45P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY2q2NAAoJEKeha0olJ0NqmRwIAIuCFetNjwlD9dzQHYZ4eMHs
6XbEHQWlNlEqtqQuvG5F+Vg3hNRd7jp3S4BQzLSU+nc8EUON1yXHcbeljElvptAT
iSWmKPVzBNPvwySlhTxfVPGSz7eglLTJSKm2RZ8fryS1j8bCUaahhYg5bp2Uug8k
fAaqmTLjuNAhGwIqIFBHEB9GQxQz87lrMhT7skI+HWvfoVEt8vUM+dYhCld3vJp+
LcP9g9VhrIjjbDAfCLkHT2WlSKY0nOnJFi0Vkxs3XX+aS8qPbcQ7CGTWSgwRbJou
mEF3bb+RTJyMUeEXokSaqqnDcEouOX1e1P9xERnN0cigcKNYDWA4sCXTAFomY5A=
=ePak
-----END PGP SIGNATURE-----

--nV1jXetfVwhbbeJMSkkrmNn5hQ43tl45P--
