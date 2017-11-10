Received: from eggs.gnu.org ([2001:4830:134:3::10]:48839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDD7c-0001eh-OH
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 12:29:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDD7b-0007O1-RM
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 12:29:40 -0500
References: <20171109203025.27493-1-mreitz@redhat.com>
	<20171109203025.27493-5-mreitz@redhat.com>
	<w51375mv4by.fsf@maestria.local.igalia.com>
	<d44fc75f-829c-65cd-fc19-04f32d897f8a@redhat.com>
	<w51tvy2t9m1.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <45294d61-b108-3e96-2bdc-59b3d471fefa@redhat.com>
Date: Fri, 10 Nov 2017 18:29:28 +0100
MIME-Version: 1.0
In-Reply-To: <w51tvy2t9m1.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2d5ejIxxFbEIINJFuDXS39eBpGjWkfCkQ"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 4/5] iotests: Make 083 less
 flaky
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2d5ejIxxFbEIINJFuDXS39eBpGjWkfCkQ
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <45294d61-b108-3e96-2bdc-59b3d471fefa@redhat.com>
Subject: Re: [Qemu-block] [PATCH v2 4/5] iotests: Make 083 less flaky
References: <20171109203025.27493-1-mreitz@redhat.com>
 <20171109203025.27493-5-mreitz@redhat.com>
 <w51375mv4by.fsf@maestria.local.igalia.com>
 <d44fc75f-829c-65cd-fc19-04f32d897f8a@redhat.com>
 <w51tvy2t9m1.fsf@maestria.local.igalia.com>
In-Reply-To: <w51tvy2t9m1.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-10 16:51, Alberto Garcia wrote:
> On Fri 10 Nov 2017 04:18:15 PM CET, Max Reitz wrote:
>> On 2017-11-10 11:02, Alberto Garcia wrote:
>>> On Thu 09 Nov 2017 09:30:24 PM CET, Max Reitz wrote:
>>>> +        echo > "$TEST_DIR/nbd-fault-injector.out"
>>>>  	$PYTHON nbd-fault-injector.py $extra_args "$nbd_addr" "$TEST_DIR/n=
bd-fault-injector.conf" >"$TEST_DIR/nbd-fault-injector.out" 2>&1 &
>>>
>>> It seems that in this patch you're indenting with spaces but this fil=
e
>>> uses tabs.
>>
>> Yes, but tabs are wrong. :-)
>=20
> I actually agree with you, but don't mix them in the file :-)

I can whistle and say here, too, that Eric liked it. O:-)

And I really don't want to use tabs in the second hunk of this patch, as
it's broken over two lines.

Max


--2d5ejIxxFbEIINJFuDXS39eBpGjWkfCkQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloF4fgSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AIVIH/1dpErPj+5+bKd+KpABLzuD7LgOx72s+
gblDIa1XdximWVl3t6Ph/QWQZk5SWdE0qvfpgscu1ukTBC1KE6WyFoiaGCXjuNkh
rIi0k+0MHRJEpGKtwQYp4T+/lBAvbBE0urJgdFvQXjbjqp4Y/1plEAtYAcPpM/MO
ZWqIWC5HmwPMrlMR+NPNXnSf8rAXyztzZ7pBkmK79mVxuV6mdgECzv+Pk50ckDJz
7JHp5Iv+l9u1A3BvF6rvXxrrwdoVcEACFgjeWt1502hsyZ8oXkIv/kYz5vvfIDtW
ZnSo3Swnxbh2N/VKfim9Osn0/HR0H8eJ4ovTbXyXjf99NIu+KKW/+94=
=GhFL
-----END PGP SIGNATURE-----

--2d5ejIxxFbEIINJFuDXS39eBpGjWkfCkQ--
