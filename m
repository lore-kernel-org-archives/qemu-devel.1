Received: from eggs.gnu.org ([2001:4830:134:3::10]:38482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1etDsC-0000PP-3L
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 09:47:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1etDs8-00080I-9J
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 09:47:24 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41022 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1etDs7-0007yk-WA
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 09:47:20 -0500
References: <1519987399-19160-1-git-send-email-jusual@mail.ru>
	<20180306143104.GI31045@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <21566db2-d512-65f5-6b7a-6fd43db53927@redhat.com>
Date: Tue, 6 Mar 2018 15:47:08 +0100
MIME-Version: 1.0
In-Reply-To: <20180306143104.GI31045@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7GW1T4a0Px84vQvd4CH3PcDEt17kaRYg6"
Subject: Re: [Qemu-devel] [PATCH v2] checkpatch: add a warning for
 basename/dirname
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Julia Suvorova <jusual@mail.ru>
Cc: qemu-devel@nongnu.org, Jim Mussared <jim@groklearning.com>, Joel Stanley <joel@jms.id.au>, Cornelia Huck <cohuck@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7GW1T4a0Px84vQvd4CH3PcDEt17kaRYg6
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>, Julia Suvorova <jusual@mail.ru>
Cc: qemu-devel@nongnu.org, Jim Mussared <jim@groklearning.com>,
 Joel Stanley <joel@jms.id.au>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Message-ID: <21566db2-d512-65f5-6b7a-6fd43db53927@redhat.com>
Subject: Re: [PATCH v2] checkpatch: add a warning for basename/dirname
References: <1519987399-19160-1-git-send-email-jusual@mail.ru>
 <20180306143104.GI31045@stefanha-x1.localdomain>
In-Reply-To: <20180306143104.GI31045@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 06/03/2018 15:31, Stefan Hajnoczi wrote:
> On Fri, Mar 02, 2018 at 01:43:19PM +0300, Julia Suvorova wrote:
>> g_path_get_* do the same as g_strdup(basename/dirname(...)) but
>> without modifying the argument.
>>
>> Signed-off-by: Julia Suvorova <jusual@mail.ru>
>> ---
>>  scripts/checkpatch.pl | 5 +++++
>>  1 file changed, 5 insertions(+)
>=20
> Thanks, applied to my block-next tree:
> https://github.com/stefanha/qemu/commits/block-next

It's already in qemu.git :) (commit fb8446d94e).

Paolo


--7GW1T4a0Px84vQvd4CH3PcDEt17kaRYg6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlqeqewACgkQv/vSX3jH
roMDRgf8DTjJs1RlajjhhIwZGAlbl7cF7xbSYj2+QjLY63gC65DZV/Gl9Xnpj5Lp
TC7zmszU9HOUh+DKSHdBB/7We92g5SYft4z6EHFGZODrmZxlvanB64aVMYJ43thv
K0rRIfDYYwvecIPP5aKkQG47TrVpg1ibJVERzfN0ebl8UvESY2QhtgEafbBJe3j+
QdmyJdPAdvdndshNW3S9IN7Tf7RhK/n0Vv6LzYKIqOH7R15yRe5QGu+Pz5/+jA8H
/qrV3lyf0rOGFRoiwKUsjNnntAhWPGXSA5fMb80cbtTOAwK/rHA8nfcpUMuggP/Q
kcmcD9bPWUfK4Y+kTX0ZqZv1x8EuRg==
=GzrI
-----END PGP SIGNATURE-----

--7GW1T4a0Px84vQvd4CH3PcDEt17kaRYg6--
