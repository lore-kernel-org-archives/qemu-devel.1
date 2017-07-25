Received: from eggs.gnu.org ([2001:4830:134:3::10]:55839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dZt5k-0007Cm-DK
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 02:13:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dZt5h-00015w-7o
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 02:13:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1dZt5g-00015S-U5
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 02:13:09 -0400
References: <20170720162815.19802-1-ldoktor@redhat.com>
	<20170720162815.19802-7-ldoktor@redhat.com>
	<989e2216-499c-3c22-3958-0c51ac342dd1@amsat.org>
	<b772f95e-9a3a-0a72-e6c6-7390902f62d1@redhat.com>
	<2cb14375-2300-83d5-a689-db5aadf2cf20@amsat.org>
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Message-ID: <32f17245-d2ec-6fb2-10b3-3f97e05a66b5@redhat.com>
Date: Tue, 25 Jul 2017 08:13:00 +0200
MIME-Version: 1.0
In-Reply-To: <2cb14375-2300-83d5-a689-db5aadf2cf20@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="h7DmDQ54rFCGs7MP7N1ipFsIjhMOpI7TD"
Subject: Re: [Qemu-devel] [PATCH 06/11] qmp.py: Couple of pylint/style fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, apahim@redhat.com, qemu-devel@nongnu.org, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com, ehabkost@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--h7DmDQ54rFCGs7MP7N1ipFsIjhMOpI7TD
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 apahim@redhat.com, qemu-devel@nongnu.org, famz@redhat.com,
 armbru@redhat.com, mreitz@redhat.com, ehabkost@redhat.com
Message-ID: <32f17245-d2ec-6fb2-10b3-3f97e05a66b5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 06/11] qmp.py: Couple of pylint/style fixes
References: <20170720162815.19802-1-ldoktor@redhat.com>
 <20170720162815.19802-7-ldoktor@redhat.com>
 <989e2216-499c-3c22-3958-0c51ac342dd1@amsat.org>
 <b772f95e-9a3a-0a72-e6c6-7390902f62d1@redhat.com>
 <2cb14375-2300-83d5-a689-db5aadf2cf20@amsat.org>
In-Reply-To: <2cb14375-2300-83d5-a689-db5aadf2cf20@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dne 25.7.2017 v 08:04 Philippe Mathieu-Daud=C3=A9 napsal(a):
> Hi Luk=C3=A1=C5=A1,
>=20
> On 07/24/2017 09:36 AM, Luk=C3=A1=C5=A1 Doktor wrote:
>> Dne 22.7.2017 v 03:30 Philippe Mathieu-Daud=C3=A9 napsal(a):
>>> Hi Luk=C3=A1=C5=A1,
>>>
>>> Since comment/indent fixes and code changes are not related I'd rathe=
r see this split in at least 2 patches.
>>>
>> Hello Philippe, thank you for the review, I'm wondering what code chan=
ges you have in mind? This is commit should not bring any code changes, j=
ust code reorganization (like including the self.* attributes on top of t=
he file)
>>
>>> On 07/20/2017 01:28 PM, Luk=C3=A1=C5=A1 Doktor wrote:
>>>> No actual code changes, just a few pylint/style fixes and docstring
>>>> clarifications.
>>>>
>>>> Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
>>>> ---
>>>>    scripts/qmp/qmp.py | 37 ++++++++++++++++++++++++-------------
>>>>    1 file changed, 24 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/scripts/qmp/qmp.py b/scripts/qmp/qmp.py
> [...]
>>>>        def __init__(self, address, server=3DFalse, debug=3DFalse):
>>>>            """
>>>>            Create a QEMUMonitorProtocol class.
>>>> @@ -42,6 +53,7 @@ class QEMUMonitorProtocol:
>>>>            self.__address =3D address
>>>>            self._debug =3D debug
>>>>            self.__sock =3D self.__get_sock()
>>>> +        self.__sockfile =3D None
>=20
> I was thinking about this line which is new. Now the declaration and in=
itialization are done in __init__() while before it was only declared/ini=
tialized in connect() or accept().
>=20
> I'm not expert of python interpreter/jit internals but expect the gener=
ated code to be slightly different, even if achieving the same.
>=20
> not a bit deal, just about wording ;)
>=20
Well the difference is that before `connect` you get `AttributeError` whe=
n looking for `self.__sockfile` while with this patch you'll get `None`. =
In this code nobody queries for `self.__sockfile` before the `connect` so=
 it should not change the behavior of this code so I consider that as a `=
style` fix as it's ugly to extend attributes later in code (with some exc=
eptions like Namespace-objects..). Anyway if you insist I can split those=
 patches.

Luk=C3=A1=C5=A1

>>>>            if server:
>>>>                self.__sock.setsockopt(socket.SOL_SOCKET, socket.SO_R=
EUSEADDR, 1)
>>>>                self.__sock.bind(self.__address)



--h7DmDQ54rFCGs7MP7N1ipFsIjhMOpI7TD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEwBAEBCAAaBQJZduFsExxsZG9rdG9yQHJlZGhhdC5jb20ACgkQJrNi5H/PIsFe
uwgAskEIkiIfibnOQVmS8lnAjqhOW1DIBX5NLUT3xRqVc+iWZFEGXqJsbQ1Ns88F
LiNePJbOsKn1qLQoemGlY65SqbdnNKFGa3WgndCd2gq/2QaQcxL9+otsEFQ4Bsh0
6y1s6R7kc/6uJhydh/Xn7K7CPBvglwfAEwQK6j3XFNV/6bNjUBNaEzqTL4wQTowh
EEc+kHoDAuB5PA5LOhydbQ52/XnymDW2hlI9E1qfVrggbgUxwyDHsLMxhO/Sp4oY
vDvsWsD5IPlv0cSBonF7vQgIKRCLlGX97oy2h3EtX8gX7kos8ie3cnl9D9JlfzNW
st4lGhvLY1wU09IxN2t2Zj8R9A==
=1/YA
-----END PGP SIGNATURE-----

--h7DmDQ54rFCGs7MP7N1ipFsIjhMOpI7TD--
