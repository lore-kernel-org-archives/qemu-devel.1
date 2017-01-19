Received: from eggs.gnu.org ([2001:4830:134:3::10]:54029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cUDsD-0000OI-0c
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:39:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cUDs7-0003Xq-Og
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:39:33 -0500
References: <20170118161653.19296-1-eblake@redhat.com>
	<20170118161653.19296-5-eblake@redhat.com>
	<87h94vflc6.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8999bd18-6f17-c15f-65a4-221475088ec8@redhat.com>
Date: Thu, 19 Jan 2017 08:39:15 -0600
MIME-Version: 1.0
In-Reply-To: <87h94vflc6.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UBm5anLoJvXpp2sDjfPGIffx34bh2aajW"
Subject: Re: [Qemu-devel] [PATCH v2 4/6] fdc-test: Avoid deprecated 'change'
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, "open list:Floppy" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UBm5anLoJvXpp2sDjfPGIffx34bh2aajW
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 "open list:Floppy" <qemu-block@nongnu.org>
Message-ID: <8999bd18-6f17-c15f-65a4-221475088ec8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/6] fdc-test: Avoid deprecated 'change'
 command
References: <20170118161653.19296-1-eblake@redhat.com>
 <20170118161653.19296-5-eblake@redhat.com>
 <87h94vflc6.fsf@dusky.pond.sub.org>
In-Reply-To: <87h94vflc6.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/19/2017 03:30 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> Use the preferred blockdev-change-medium command instead.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> Reviewed-by: John Snow <jsnow@redhat.com>
>> ---
>>  tests/fdc-test.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/fdc-test.c b/tests/fdc-test.c
>> index 738c6b4..f5ff68d 100644
>> --- a/tests/fdc-test.c
>> +++ b/tests/fdc-test.c
>> @@ -298,8 +298,9 @@ static void test_media_insert(void)
>>
>>      /* Insert media in drive. DSKCHK should not be reset until a step=
 pulse
>>       * is sent. */
>> -    qmp_discard_response("{'execute':'change', 'arguments':{"
>> -                         " 'device':'floppy0', 'target': %s, 'arg': '=
raw' }}",
>> +    qmp_discard_response("{'execute':'blockdev-change-medium', 'argum=
ents':{"
>> +                         " 'device':'floppy0', 'filename': %s, "
>> +                         "'format': 'raw' }}",
>>                           test_image);
>>
>>      dir =3D inb(FLOPPY_BASE + reg_dir);
>=20
> 'device' is deprecated.  Can we use 'id' here?

I'll give it a shot.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--UBm5anLoJvXpp2sDjfPGIffx34bh2aajW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYgM+TAAoJEKeha0olJ0NqyYYH/2zNvUSbYfMj2uJRCye5U/Qb
Pov7gpevp2TsryBuKsdKCBJZ/k9KgoIG/qsnlolJDYKwfZUjILeVlrrBNtwTCruI
DFhI8GiBwnAId26PWJiw09C9gi3yWyS+Q3LUq9X8fFHi08IVostjNghoELRiQCGI
4zJza7FF+1OsEH63L7H9bHYOOcyPa+SqU4oLyrdvXD8k+eIJVkp7fQPctEI4mk/e
sV8K0w6ZejQnIDm742/A+oqWqjdfhyR5zlah6zbIZyD9SDnbiRPK6LZjEJdwn21U
MXLlVPMR+EygSpjGSw97ob3etIOrdK6N2CvGbmUN3MVm4pYHc9MXld3ww7MMnmg=
=lLTj
-----END PGP SIGNATURE-----

--UBm5anLoJvXpp2sDjfPGIffx34bh2aajW--
