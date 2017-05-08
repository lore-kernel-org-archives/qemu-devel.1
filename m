Received: from eggs.gnu.org ([2001:4830:134:3::10]:41606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d7loy-0005NJ-Vh
	for qemu-devel@nongnu.org; Mon, 08 May 2017 12:47:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d7lov-0006C4-TB
	for qemu-devel@nongnu.org; Mon, 08 May 2017 12:47:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46008)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1d7lov-0006AY-Jx
	for qemu-devel@nongnu.org; Mon, 08 May 2017 12:47:37 -0400
References: <CADmzSSiQYXzJf0vzhyaXdncZaq9gzPrN0BRm4_OOpPv+wJ9Bjw@mail.gmail.com>
	<87wp9r689l.fsf@dusky.pond.sub.org>
	<CADmzSShCnLNFzBAZDw8+ZG00L=Qgy7OOE7Q06-z1fHYuBJHpRQ@mail.gmail.com>
	<bdb8ffb7-b9f0-242c-2bf9-3eb94530180b@redhat.com>
	<CADmzSSizPt5JcWq8n-ZqnpYVB0q36x+JQYWXimyk1LciHsnkKQ@mail.gmail.com>
	<0456ed7c-c465-6e6b-77a2-8be37e0e6ae2@redhat.com>
	<CADmzSSgN6+gK2rhcpiYu7y_gG3UT7oL92Q4zG+GQVoqGbVGKXg@mail.gmail.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a535a8cf-6f04-206f-3f4e-3cf7539f16a5@redhat.com>
Date: Mon, 8 May 2017 18:47:31 +0200
MIME-Version: 1.0
In-Reply-To: <CADmzSSgN6+gK2rhcpiYu7y_gG3UT7oL92Q4zG+GQVoqGbVGKXg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uovawJS59Hib4eQDDdasAaHIDorCOvQia"
Subject: Re: [Qemu-devel] format=raw,readonly errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Carl Karsten <carl@personnelware.com>, Eric Blake <eblake@redhat.com>
Cc: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uovawJS59Hib4eQDDdasAaHIDorCOvQia
From: Max Reitz <mreitz@redhat.com>
To: Carl Karsten <carl@personnelware.com>, Eric Blake <eblake@redhat.com>
Cc: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <a535a8cf-6f04-206f-3f4e-3cf7539f16a5@redhat.com>
Subject: Re: [Qemu-devel] format=raw,readonly errors
References: <CADmzSSiQYXzJf0vzhyaXdncZaq9gzPrN0BRm4_OOpPv+wJ9Bjw@mail.gmail.com>
 <87wp9r689l.fsf@dusky.pond.sub.org>
 <CADmzSShCnLNFzBAZDw8+ZG00L=Qgy7OOE7Q06-z1fHYuBJHpRQ@mail.gmail.com>
 <bdb8ffb7-b9f0-242c-2bf9-3eb94530180b@redhat.com>
 <CADmzSSizPt5JcWq8n-ZqnpYVB0q36x+JQYWXimyk1LciHsnkKQ@mail.gmail.com>
 <0456ed7c-c465-6e6b-77a2-8be37e0e6ae2@redhat.com>
 <CADmzSSgN6+gK2rhcpiYu7y_gG3UT7oL92Q4zG+GQVoqGbVGKXg@mail.gmail.com>
In-Reply-To: <CADmzSSgN6+gK2rhcpiYu7y_gG3UT7oL92Q4zG+GQVoqGbVGKXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08.05.2017 18:33, Carl Karsten wrote:
> On Mon, May 8, 2017 at 11:29 AM, Eric Blake <eblake@redhat.com> wrote:
>=20
>> On 05/08/2017 10:56 AM, Carl Karsten wrote:
>>
>>>>>>> juser@gator:~/temp$ qemu-system-x86_64 -m 256 -display curses
>> -drive
>>>>>>> file=3Ddisk.cow -drive file=3Dboot.img
>>>>>>> WARNING: Image format was not specified for 'boot.img' and probin=
g
>>>>>> guessed
>>>>>>> raw.
>>>>>>>          Automatically detecting the format is dangerous for raw
>>>> images,
>>>>>>> write operations on block 0 will be restricted.
>>>>>>>          Specify the 'raw' format explicitly to remove the
>>>> restrictions.
>>
>>>  "write operations on block 0 will be restricted."
>>>
>>> Is there a way to explicitly enable that?
>>
>> Yes. Pass format=3Draw at the right place (in other words, instead of
>> getting the 'raw' format driver by default, explicitly mentioning that=

>> you KNOW you want the 'raw' format driver is enough to shut up the
>> warning).
>>
>=20
> according to the warning: "Specify the 'raw' format explicitly to remov=
e
> the restrictions."
>=20
> I want the restriction.
>=20
> format=3Draw, (write operations on block 0)=3Drestricted

Well, the restriction won't prevent all writes to the first sector,
though; it will only prevent writes which would make the image look like
it was in some non-raw format. So this is probably not what you want anyw=
ay.

Unfortunately, I don't know any current way to "soft" write-protect an
image. It sounds like an interesting idea, though, and should be simple
enough to implement e.g. in the raw driver.

Max


--uovawJS59Hib4eQDDdasAaHIDorCOvQia
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkQoSMSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A+LcH/1fn6XUjs7BZRD7OWE9DRJ32W/WI0oUd
40CTbUC8RAmdOU7RCDreD1KLQbrirydJmNZHsWFAqHWYZt7Fb580399AdtsLGskZ
wa9PzR/sF5GOZA6pMb8fVBYbLx2llNiD56OobVVYFS3afIHyaP2h4W5+cF9lT3Ei
AtBWOPKaxDC5tT5ZkCFmM2YSXHSdKh8rEoUG/uN1FLB7QFvNYyPoQzDHu7/0U7iE
35cTnE5i+LYeztl61KQtJBZ8JhV5sYjS0iK4OobBR8rJsHtDtERT9nxfZ1mNyWed
6SgYu4WJEL4g0ci6iFK3WRAT+rJal8sWiIFWCv47a7VXm/Yu8Nk2wCE=
=mWva
-----END PGP SIGNATURE-----

--uovawJS59Hib4eQDDdasAaHIDorCOvQia--
