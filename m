Received: from eggs.gnu.org ([2001:4830:134:3::10]:48971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cvkdY-0008Q9-9k
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 09:06:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cvkdX-0000ei-4a
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 09:06:12 -0400
References: <20170118161653.19296-1-eblake@redhat.com>
	<20170118161653.19296-5-eblake@redhat.com>
	<87h94vflc6.fsf@dusky.pond.sub.org>
	<8999bd18-6f17-c15f-65a4-221475088ec8@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8ae60273-e215-7b08-c5b1-bb1132b86312@redhat.com>
Date: Tue, 4 Apr 2017 21:10:25 -0500
MIME-Version: 1.0
In-Reply-To: <8999bd18-6f17-c15f-65a4-221475088ec8@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0PDpSMLOtvEdVhikKlnib1bHATBlL4J8C"
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
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, "open list:Floppy" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0PDpSMLOtvEdVhikKlnib1bHATBlL4J8C
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 "open list:Floppy" <qemu-block@nongnu.org>
Message-ID: <8ae60273-e215-7b08-c5b1-bb1132b86312@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/6] fdc-test: Avoid deprecated 'change'
 command
References: <20170118161653.19296-1-eblake@redhat.com>
 <20170118161653.19296-5-eblake@redhat.com>
 <87h94vflc6.fsf@dusky.pond.sub.org>
 <8999bd18-6f17-c15f-65a4-221475088ec8@redhat.com>
In-Reply-To: <8999bd18-6f17-c15f-65a4-221475088ec8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/19/2017 08:39 AM, Eric Blake wrote:
> On 01/19/2017 03:30 AM, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>>
>>> Use the preferred blockdev-change-medium command instead.
>>>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>> Reviewed-by: John Snow <jsnow@redhat.com>
>>> ---
>>>  tests/fdc-test.c | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tests/fdc-test.c b/tests/fdc-test.c
>>> index 738c6b4..f5ff68d 100644
>>> --- a/tests/fdc-test.c
>>> +++ b/tests/fdc-test.c
>>> @@ -298,8 +298,9 @@ static void test_media_insert(void)
>>>
>>>      /* Insert media in drive. DSKCHK should not be reset until a ste=
p pulse
>>>       * is sent. */
>>> -    qmp_discard_response("{'execute':'change', 'arguments':{"
>>> -                         " 'device':'floppy0', 'target': %s, 'arg': =
'raw' }}",
>>> +    qmp_discard_response("{'execute':'blockdev-change-medium', 'argu=
ments':{"
>>> +                         " 'device':'floppy0', 'filename': %s, "
>>> +                         "'format': 'raw' }}",
>>>                           test_image);
>>>
>>>      dir =3D inb(FLOPPY_BASE + reg_dir);
>>
>> 'device' is deprecated.  Can we use 'id' here?
>=20
> I'll give it a shot.

Harder than I thought. Search for 'floppy0' in tests/ - you'll notice
that nothing explicitly sets that device name, which means I don't know
where to inject an explicit 'id' counterpart name to use instead (we are
inheriting the default device name that you get when starting an x86
board without -nodefaults).  Maybe someone else can supply an idea?

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--0PDpSMLOtvEdVhikKlnib1bHATBlL4J8C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY5FIRAAoJEKeha0olJ0NqaLAIAJAqfqCTXspu1I8gAFKcWPHC
60MP0KgoO/ggh9N55KO/WzmigpxKCuU+7PDYIAmND6k5gFzxfAnYCbAFla+BV0SX
02NrvErWKnbwuI7is9lFImr/yX9b26QMNu2w+k/KP5aBX4nbPb9Q5VGJv0Z9dwDB
U+7FbAcf/iQqCmFwmCiTc/jgwY/oAiAmholiqqjlfmycR3YY8Ow/NlBOjOsdGfV5
N66/Nu6gDqWs+45JjEnUMTV/u7HKiSOOTNpCAfZlh+r+39VlpQNg6rDuobFrRZF3
bc8izUuLu8oUaZam4u4l5bIncfsUMwuUY3n/5eQAhtJf6RfKDlJEOkyKScRaEUM=
=0t6e
-----END PGP SIGNATURE-----

--0PDpSMLOtvEdVhikKlnib1bHATBlL4J8C--
