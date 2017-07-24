Received: from eggs.gnu.org ([2001:4830:134:3::10]:47471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dZcgA-0008KY-Mc
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:41:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dZcg6-0006xi-Qd
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:41:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1dZcg6-0006x4-G2
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:41:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 68ADEFBBB
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 12:41:37 +0000 (UTC)
References: <20170720162815.19802-1-ldoktor@redhat.com>
	<20170720162815.19802-10-ldoktor@redhat.com>
	<20170720183832.GY2757@localhost.localdomain>
	<c964cd15-16f6-e330-ebac-f7e71918471d@redhat.com>
	<20170721184657.GD2757@localhost.localdomain>
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Message-ID: <c12adc5d-afd5-9f22-d251-1106b2b7bfcd@redhat.com>
Date: Mon, 24 Jul 2017 14:41:29 +0200
MIME-Version: 1.0
In-Reply-To: <20170721184657.GD2757@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="klqbqhahTjA4NT15mGlGh9w4eBqCGm7Mi"
Subject: Re: [Qemu-devel] [PATCH 09/11] qmp.py: Avoid overriding a builtin
 object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: apahim@redhat.com, qemu-devel@nongnu.org, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--klqbqhahTjA4NT15mGlGh9w4eBqCGm7Mi
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: apahim@redhat.com, qemu-devel@nongnu.org, famz@redhat.com,
 armbru@redhat.com, mreitz@redhat.com
Message-ID: <c12adc5d-afd5-9f22-d251-1106b2b7bfcd@redhat.com>
Subject: Re: [PATCH 09/11] qmp.py: Avoid overriding a builtin object
References: <20170720162815.19802-1-ldoktor@redhat.com>
 <20170720162815.19802-10-ldoktor@redhat.com>
 <20170720183832.GY2757@localhost.localdomain>
 <c964cd15-16f6-e330-ebac-f7e71918471d@redhat.com>
 <20170721184657.GD2757@localhost.localdomain>
In-Reply-To: <20170721184657.GD2757@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dne 21.7.2017 v 20:46 Eduardo Habkost napsal(a):
> On Fri, Jul 21, 2017 at 08:53:49AM +0200, Luk=C3=A1=C5=A1 Doktor wrote:=

>> Dne 20.7.2017 v 20:38 Eduardo Habkost napsal(a):
>>> On Thu, Jul 20, 2017 at 06:28:13PM +0200, Luk=C3=A1=C5=A1 Doktor wrot=
e:
>>>> The "id" is a builtin method to get object's identity and should not=
 be
>>>> overridden. This might bring some issues in case someone was directl=
y
>>>> calling "cmd(..., id=3Did)" but I haven't found such usage on brief =
search
>>>> for "cmd\(.*id=3D".
>>>>
>>>> Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
>>>> ---
>>>>  scripts/qmp/qmp.py | 8 ++++----
>>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/scripts/qmp/qmp.py b/scripts/qmp/qmp.py
>>>> index a14b001..c3e0206 100644
>>>> --- a/scripts/qmp/qmp.py
>>>> +++ b/scripts/qmp/qmp.py
>>>> @@ -177,19 +177,19 @@ class QEMUMonitorProtocol(object):
>>>>              print >>sys.stderr, "QMP:<<< %s" % resp
>>>>          return resp
>>>> =20
>>>> -    def cmd(self, name, args=3DNone, id=3DNone):
>>>> +    def cmd(self, name, args=3DNone, cmd_id=3DNone):
>>>>          """
>>>>          Build a QMP command and send it to the QMP Monitor.
>>>> =20
>>>>          @param name: command name (string)
>>>>          @param args: command arguments (dict)
>>>> -        @param id: command id (dict, list, string or int)
>>>> +        @param cmd_id: command id (dict, list, string or int)
>>>>          """
>>>>          qmp_cmd =3D {'execute': name}
>>>>          if args:
>>>>              qmp_cmd['arguments'] =3D args
>>>> -        if id:
>>>> -            qmp_cmd['id'] =3D id
>>>> +        if cmd_id:
>>>> +            qmp_cmd['cmd_id'] =3D cmd_id
>>>
>>> The member sent through the monitor should still be called "id".
>>> i.e.:
>>>
>>>     qmp_cmd['id'] =3D cmd_id
>>>
>> Oups, sorry, automatic rename changed it and I forgot to fix
>> this one back. I'll address this in v2. The main problem with
>> this patch is it could break named arguments (`cmd(..., id=3Did)`
>> calls) so I'm not sure it's worth including. But as mentioned
>> in commit message I grepped full sources so we better fix this
>> before someone starts using it.
>=20
> I'm not convinced we need this patch, either.  What exactly
> breaks if we don't apply this patch and somebody tries to use
> cmd(..., id=3Did)?
>=20

It'll work properly. The only issue is the `id` method will be unavailabl=
e inside that function. So let's say you want to add `print` method to de=
bug issue with duplicate arguments, you'd be unable to use `id` to distin=
guish between them. The other issue is that people will see it and copy&p=
aste this ugliness to other projects poisoning the world :-)

Therefor I'd like to include it, but I'm prepared to yield.

Luk=C3=A1=C5=A1


--klqbqhahTjA4NT15mGlGh9w4eBqCGm7Mi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEwBAEBCAAaBQJZder5ExxsZG9rdG9yQHJlZGhhdC5jb20ACgkQJrNi5H/PIsEe
UQgAy7yBUACVE3M2GSbP2dwp1NS+yG36+NpIOa0JubdNCMOs0gbDMzYc2eiyLe3B
Mojgett4yI0kQRgvOBseS5jJit9qpZiaOpCOkgnXLnksBNfx2jHuo9vMKM71HIwh
A7L9zJb99v2UKw7OvDwo2wE+e7infO1jozuFha6XOQp7THIJvREPwiMAUU1vfqTS
HFRVwZDs9x8MzPVZvtC776auQZ1EtWn8R2DcS5Xppdpopi8t6zlr5rFvGodn9WOq
TWhUo1GAHRfYywGxPy4oLnPslpmQeHmrWc1F9Ihe/JBMAzp+bWweYEDfb9QrGyRS
F2CBixtKVTfFZlfgns98ZOWNQw==
=/8G0
-----END PGP SIGNATURE-----

--klqbqhahTjA4NT15mGlGh9w4eBqCGm7Mi--
