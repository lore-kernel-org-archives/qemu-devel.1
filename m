Received: from eggs.gnu.org ([2001:4830:134:3::10]:35149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqLvL-0005bn-Ev
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 11:42:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqLvH-0005lb-C7
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 11:42:15 -0400
References: <148968198512.5555.1880820193606077571.stgit@bahia>
	<2deb61ba-f800-8774-6dfa-aa4e7c605e55@redhat.com>
	<20170321154229.1084c0e7@bahia.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <380e9907-d887-a392-dbd8-41228f313a31@redhat.com>
Date: Tue, 21 Mar 2017 10:42:08 -0500
MIME-Version: 1.0
In-Reply-To: <20170321154229.1084c0e7@bahia.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TfVR5AhBKCV7mwDQDoA3LEpxHkkNOgEsG"
Subject: Re: [Qemu-devel] [PATCH] 9pfs: don't try to flush self and avoid
 QEMU hang on reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TfVR5AhBKCV7mwDQDoA3LEpxHkkNOgEsG
From: Eric Blake <eblake@redhat.com>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Message-ID: <380e9907-d887-a392-dbd8-41228f313a31@redhat.com>
Subject: Re: [PATCH] 9pfs: don't try to flush self and avoid QEMU hang on
 reset
References: <148968198512.5555.1880820193606077571.stgit@bahia>
 <2deb61ba-f800-8774-6dfa-aa4e7c605e55@redhat.com>
 <20170321154229.1084c0e7@bahia.lan>
In-Reply-To: <20170321154229.1084c0e7@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/21/2017 09:42 AM, Greg Kurz wrote:

>>> This insane behavior is likely to denote a bug in the client, and it =
would
>>> deserve an Rerror message to be sent back. Unfortunately, the protoco=
l
>>> allows it and requires all flush requests to suceed (only a Tflush re=
sponse =20
>>
>> s/suceed/succeed/

The pull request still has the typo,


>>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>
>=20
> Oh, I've sent a v2 for this patch (error_report() a warning) and it is
> actually part of the pull request I've sent earlier today... dunno how
> to have your Reviewed-by: added there.

If you really want it, send a v2 pull request before Peter merges v1
(and an explicit NACK on the v1 cover letter will make your intentions
clear).  But at this point, I'm fine if the v1 pull request goes in
untouched.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--TfVR5AhBKCV7mwDQDoA3LEpxHkkNOgEsG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY0UnQAAoJEKeha0olJ0NqJQ4H/j22mbFclf+n+T4XoasKzxjm
K7bXAvh/m+RaTSFsG+HDy2kYdEP7CnqJJ3zLDrsxKUcy0Zd9rn0M6HAePEnd4O0/
b0r7ZsJ+u3tGUzoDQ6wml7rMImVE53z5jyonFquHfE6njTDIUhyl1+yym+fPfgMs
tm6d7mLzCCL26ND+9WXNycdPBNSqjv5njFQMmw4L8zyF08dwD3M21z2xP7+34Yga
EsANnwouepeKdFlXAPxTxIH18f01CYw82SqH5Ln+wxfgarJLo9bItOCRUt5bFqF9
cLfBRsdu2Tk9qrOvrBvMPg5MMkXI85vvPc6T8CHPNG6nPxot169tBKinXcHwdJ4=
=M634
-----END PGP SIGNATURE-----

--TfVR5AhBKCV7mwDQDoA3LEpxHkkNOgEsG--
