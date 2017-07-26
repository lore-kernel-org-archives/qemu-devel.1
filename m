Received: from eggs.gnu.org ([2001:4830:134:3::10]:42140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1daM16-0000qO-4h
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 09:06:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1daM15-0003Tv-4C
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 09:06:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:24261)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1daM14-0003S4-RJ
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 09:06:19 -0400
References: <150107094952.114.932926322923994155@5d477a5b5989>
	<e982b2c6-dab4-24a0-7db4-2e76c370d227@redhat.com>
	<1501073395.29903.11.camel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6aca4a2d-4615-c4f5-46d6-df88448e733a@redhat.com>
Date: Wed, 26 Jul 2017 08:06:15 -0500
MIME-Version: 1.0
In-Reply-To: <1501073395.29903.11.camel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6OTVMt2wTnd76xaNc83sBnnIaJxWjV4oD"
Subject: Re: [Qemu-devel] [PATCH 0/5] ui: keymap fixes for 2.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, no-reply@patchew.org
Cc: famz@redhat.com, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6OTVMt2wTnd76xaNc83sBnnIaJxWjV4oD
From: Eric Blake <eblake@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 no-reply@patchew.org
Cc: famz@redhat.com, Markus Armbruster <armbru@redhat.com>
Message-ID: <6aca4a2d-4615-c4f5-46d6-df88448e733a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/5] ui: keymap fixes for 2.10
References: <150107094952.114.932926322923994155@5d477a5b5989>
 <e982b2c6-dab4-24a0-7db4-2e76c370d227@redhat.com>
 <1501073395.29903.11.camel@redhat.com>
In-Reply-To: <1501073395.29903.11.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/26/2017 07:49 AM, Gerd Hoffmann wrote:
>   Hi,
>=20
>> error message).  I suspect this is caused by your use of '@ac_*'
>> instead
>> of spelling out all the ac_ members added in qapi-schema.json in 4/5
>> -
>=20
> Hmm, adding them all will be a pretty long list, and it will probably
> become alot longer when we add more missing keys in 2.11 ...
>=20
> Should this maybe summarized along the lines of "# multimedia keys
> added in 2.10"?

I'm not sure what the doc-generator will insist on, but avoiding the
@name form may be sufficient.  I agree that for this particular enum,
the lists get quite long, so abbreviating may make sense, but at the
same time, being precise may be more useful for someone trying to grep
documentation.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--6OTVMt2wTnd76xaNc83sBnnIaJxWjV4oD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll4k8cACgkQp6FrSiUn
Q2ovNAf+P7z/NTzjJrnBjAJcULgqIEVxecdQPUBKQuNE74RCgRoBHPLU4K0oMYMu
a3ZyfTojwS63szrrr2kGTwcsuqB/JxU2Uu9alrYKDsMnTKsp6HPdOohUfUf75WEE
XesdlT+WkVyz7/VykdiedN4S/WZjP5Kabchi78wrCa7KJ6tmrGzAayv4aWXNcZSs
awaxYWPnBzDeYsFMHUcmpW+LEXCpPsFSK9261WaJYNKowMO6rP2phtYWSF7+aPtt
2/G5SpuMLHq74gkj3Gi5jMdJgbQuUKgTZ3pJiT3EKSEWpClzMHBG29nLPqVQP8DW
ICJg5+HeWeFqPYMJnKa+ek/XbsBe1A==
=+KeZ
-----END PGP SIGNATURE-----

--6OTVMt2wTnd76xaNc83sBnnIaJxWjV4oD--
