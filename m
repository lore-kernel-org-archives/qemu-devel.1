Received: from eggs.gnu.org ([2001:4830:134:3::10]:38941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6kQk-0006QO-5u
	for qemu-devel@nongnu.org; Fri, 05 May 2017 17:06:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6kQh-00017p-2W
	for qemu-devel@nongnu.org; Fri, 05 May 2017 17:06:26 -0400
References: <20170504030755.1001-1-eblake@redhat.com>
	<20170504030755.1001-7-eblake@redhat.com>
	<f573947e-d97b-ff59-5881-15d1a1b3b8d4@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1b3c371b-abc7-d9b1-4fd5-dd1faffb42fe@redhat.com>
Date: Fri, 5 May 2017 16:06:14 -0500
MIME-Version: 1.0
In-Reply-To: <f573947e-d97b-ff59-5881-15d1a1b3b8d4@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kIXLgHC91fbuV0t18ccPMvMPw8TdmnDm4"
Subject: Re: [Qemu-devel] [PATCH v12 06/10] iotests: Improve
 _filter_qemu_img_map
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kIXLgHC91fbuV0t18ccPMvMPw8TdmnDm4
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com
Message-ID: <1b3c371b-abc7-d9b1-4fd5-dd1faffb42fe@redhat.com>
Subject: Re: [PATCH v12 06/10] iotests: Improve _filter_qemu_img_map
References: <20170504030755.1001-1-eblake@redhat.com>
 <20170504030755.1001-7-eblake@redhat.com>
 <f573947e-d97b-ff59-5881-15d1a1b3b8d4@redhat.com>
In-Reply-To: <f573947e-d97b-ff59-5881-15d1a1b3b8d4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/05/2017 03:58 PM, Max Reitz wrote:
> On 04.05.2017 05:07, Eric Blake wrote:
>> Although _filter_qemu_img_map documents that it scrubs offsets, it
>> was only doing so for human mode.  Of the existing tests using the
>> filter (97, 122, 150, 154, 176), two of them are affected, but it
>> does not hurt the validity of the tests to not require particular
>> mappings (another test, 66, uses offsets but intentionally does not
>> pass through _filter_qemu_img_map, because it checks that offsets
>> are unchanged before and after an operation).
>>

>>  _filter_qemu_img_map()
>>  {
>>      sed -e 's/\([0-9a-fx]* *[0-9a-fx]* *\)[0-9a-fx]* */\1/g' \
>> +	-e 's/"offset": [0-9]\+/"offset": OFFSET/g' \>          -e 's/Mapped=
 to *//' | _filter_testdir | _filter_imgfmt

Whoa - mail corruption.

>=20
> This makes my OCD very sad.

The real culprit? TAB damage.  I guess this is one of the files that
emacs thinks should be indented with TAB instead of space, because the
file itself looks aligned, only the patch is botched.

>=20
> With the alignment fixed:
>=20
> Reviewed-by: Max Reitz <mreitz@redhat.com>
>=20
> (Without this fixed: Will-change-when-applying-and-then-add-the-R-b)

Much appreciated, and I await the final verdict on whether I have to
respin (you've pointed out several cleanups I can make), or whether you
take the fixed version of these patches and let me write a few more
followups.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--kIXLgHC91fbuV0t18ccPMvMPw8TdmnDm4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZDOlGAAoJEKeha0olJ0NqpqkIAJP83nD4kQzmSRGCsUvRaejH
Cz8rxPW6KFvVED54CBUMl6iz++lCTSAPc9UBTG54Lswee7TqVSl2Xh87RpY8CFI7
C2Q9GOMsR9XEAkPYwadajgSM8FayI4Fu3GWWE9RRpIRuBD3U3ed3D9XvComtyD/K
UYjuil1V/rX6so8emL68mS0R8O+0GzJCZat5Kx/SbtXT802TUJ/zGP2kB+acoQam
c+vOspo+UxNFfPszXdWmhLhPzlVjxSTY2RfrRe/dcooQO448NuHGRwNbkmzolZf7
bSXRKtN1Vrg/pCFXsLwr6GOaaUzMomOlcAeWRhbgHnOEDVp9Xo0k1VB0LD4ByVI=
=0di6
-----END PGP SIGNATURE-----

--kIXLgHC91fbuV0t18ccPMvMPw8TdmnDm4--
