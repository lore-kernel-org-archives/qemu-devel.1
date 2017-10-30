Received: from eggs.gnu.org ([2001:4830:134:3::10]:34490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e9GGe-0001RS-P2
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 16:02:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e9GGb-00018t-Lq
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 16:02:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38882)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e9GGb-00017t-D1
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 16:02:37 -0400
References: <7CA6B03C-DFAA-4A15-9E33-E3FAD6647140@gmail.com>
	<38c3125f-b050-c0ba-282f-bc1e9e11d297@redhat.com>
	<20171029102106.GA2841@work-vm>
	<847196B3-8C4D-4B8E-A6A4-5ADAEC73FF62@gmail.com>
	<20171030143220.GA5438@work-vm>
From: Eric Blake <eblake@redhat.com>
Message-ID: <40acf44f-a8d2-890e-556b-02f551b05f2d@redhat.com>
Date: Mon, 30 Oct 2017 21:02:33 +0100
MIME-Version: 1.0
In-Reply-To: <20171030143220.GA5438@work-vm>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="47s4d3phTAGj4tIuFbxtviwei4I0wUsLd"
Subject: Re: [Qemu-devel] drive_add: file names with spaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Programmingkid <programmingkidx@gmail.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--47s4d3phTAGj4tIuFbxtviwei4I0wUsLd
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Programmingkid <programmingkidx@gmail.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>
Message-ID: <40acf44f-a8d2-890e-556b-02f551b05f2d@redhat.com>
Subject: Re: [Qemu-devel] drive_add: file names with spaces
References: <7CA6B03C-DFAA-4A15-9E33-E3FAD6647140@gmail.com>
 <38c3125f-b050-c0ba-282f-bc1e9e11d297@redhat.com>
 <20171029102106.GA2841@work-vm>
 <847196B3-8C4D-4B8E-A6A4-5ADAEC73FF62@gmail.com>
 <20171030143220.GA5438@work-vm>
In-Reply-To: <20171030143220.GA5438@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/30/2017 03:32 PM, Dr. David Alan Gilbert wrote:

> Now, the real challenge is how to deal with a filename with a comma in;=

>    drive_add 1 "file=3Dfoo,bar"
>    Could not open 'foo': No such file or directory
>=20

Does HMP use the QemuOpts parser?  If so, try:

drive_add 1 "file=3Dfoo,,bar"

(that is, reproduce the double-comma escaping mechanism that we use on
the command line).

But I haven't personally tried this, so I have no idea if it will help.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--47s4d3phTAGj4tIuFbxtviwei4I0wUsLd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAln3hVkACgkQp6FrSiUn
Q2q9gwf+OL+9mvEXgC2zeR08+E1OmzoUM3SyTC7rC6KbKN5SNBG715O/raUYNsDk
pVXZalpKJ/kdyywkZmiII8ti0HmEfzdBy1qDeCoGw5Ds+xxDFzumo9x7J6Gpr3gb
LmdA5C0cDjNfgKtYgjtUppbZNkf5ZrwoviW4UorSBYVW10/eKKKYVXeUAcJYK66p
pM5ignzww76Ql74tLTSqGmurhCLTWs1nMMBPVfcqbgvdkLPlMSiFPvKtL0zxeOQe
SDARFD4WXgF16nQgxcEMFAFD83mmoPXUTnz5nkrdWy7CQvlkHpwbEomA/tB5i2HU
QH1TqV3q+oDZE7MPR/Wy9swRBVAcXw==
=yacY
-----END PGP SIGNATURE-----

--47s4d3phTAGj4tIuFbxtviwei4I0wUsLd--
