Received: from eggs.gnu.org ([2001:4830:134:3::10]:50185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dZsU3-0005R4-SO
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 01:34:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dZsU0-0001Uu-O6
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 01:34:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1dZsU0-0001Ub-Ej
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 01:34:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 300F883F3E
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 05:34:11 +0000 (UTC)
References: <20170720162815.19802-1-ldoktor@redhat.com>
	<20170720162815.19802-6-ldoktor@redhat.com>
	<20170720182753.GV2757@localhost.localdomain>
	<6701dad4-40a5-7287-a4b8-a22e19b90ce2@redhat.com>
	<20170721184227.GB2757@localhost.localdomain>
	<1ec2f684-ddbc-de62-e13b-58f54d92e27d@redhat.com>
	<20170724153242.GH2757@localhost.localdomain>
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Message-ID: <b704404a-2a0c-3cbd-18ef-861c987775dc@redhat.com>
Date: Tue, 25 Jul 2017 07:34:04 +0200
MIME-Version: 1.0
In-Reply-To: <20170724153242.GH2757@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HuQof5t9ALHnnfL58trxhhnXecjumUIRg"
Subject: Re: [Qemu-devel] [PATCH 05/11] qemu.py: Use custom exceptions
 rather than Exception
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
--HuQof5t9ALHnnfL58trxhhnXecjumUIRg
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: apahim@redhat.com, qemu-devel@nongnu.org, famz@redhat.com,
 armbru@redhat.com, mreitz@redhat.com
Message-ID: <b704404a-2a0c-3cbd-18ef-861c987775dc@redhat.com>
Subject: Re: [PATCH 05/11] qemu.py: Use custom exceptions rather than
 Exception
References: <20170720162815.19802-1-ldoktor@redhat.com>
 <20170720162815.19802-6-ldoktor@redhat.com>
 <20170720182753.GV2757@localhost.localdomain>
 <6701dad4-40a5-7287-a4b8-a22e19b90ce2@redhat.com>
 <20170721184227.GB2757@localhost.localdomain>
 <1ec2f684-ddbc-de62-e13b-58f54d92e27d@redhat.com>
 <20170724153242.GH2757@localhost.localdomain>
In-Reply-To: <20170724153242.GH2757@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dne 24.7.2017 v 17:32 Eduardo Habkost napsal(a):
> On Mon, Jul 24, 2017 at 02:13:09PM +0200, Luk=C3=A1=C5=A1 Doktor wrote:=

>> Dne 21.7.2017 v 20:42 Eduardo Habkost napsal(a):
>>> On Fri, Jul 21, 2017 at 08:37:34AM +0200, Luk=C3=A1=C5=A1 Doktor wrot=
e:
>>>> Dne 20.7.2017 v 20:27 Eduardo Habkost napsal(a):
>>>>> On Thu, Jul 20, 2017 at 06:28:09PM +0200, Luk=C3=A1=C5=A1 Doktor wr=
ote:
>>>>>> The naked Exception should not be widely used. It makes sense to b=
e a
>>>>>> bit more specific and use better-suited custom exceptions. As a be=
nefit
>>>>>> we can store the full reply in the exception in case someone needs=
 it
>>>>>> when catching the exception.
>>>>>>
>>>>>> Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
>>>>>> ---
>>>>>>  scripts/qemu.py | 17 +++++++++++++++--
>>>>>>  1 file changed, 15 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/scripts/qemu.py b/scripts/qemu.py
>>>>>> index 5948e19..2bd522f 100644
>>>>>> --- a/scripts/qemu.py
>>>>>> +++ b/scripts/qemu.py
>>>>>> @@ -19,6 +19,19 @@ import subprocess
>>>>>>  import qmp.qmp
>>>>>> =20
>>>>>> =20
>>>>>> +class MonitorResponseError(qmp.qmp.QMPError):
>>>>>> +    '''
>>>>>> +    Represents erroneous QMP monitor reply
>>>>>> +    '''
>>>>>> +    def __init__(self, reply):
>>>>>> +        try:
>>>>>> +            desc =3D reply["error"]["desc"]
>>>>>> +        except KeyError:
>>>>>> +            desc =3D reply
>>>>>> +        super(MonitorResponseError, self).__init__(desc)
>>>>>> +        self.reply =3D reply
>>>>>
>>>>> This would require every user of self.reply to first check if
>>>>> it's a string or dictionary.  All because of the "Monitor is
>>>>> closed" case below:
>>>>>
>>>> I haven't used it for the `Monitor is closed` exception, so
>>>> it's just to be able to store really broken reply safely.
>>>> Anyway people can check whether the reply is a dict, or I can
>>>> add `is_valid_reply` property which would check for
>>>> `[error][desc]` presence (which is a bit more precise than just
>>>> plain dict type checking).
>>>
>>>
>>> Oops, I wasn't paying enough attention, sorry.  self.reply is
>>> actually always set to the response from the monitor.
>>>
>>> If you are just trying a safe fallback for 'desc' if the response
>>> broken, what about using repr(reply) or json.dumps(reply) if
>>> reply['error']['desc'] isn't set?
>>>
>> I could use repr, but I'd prefer keeping it the way it is as
>> you could use `isinstance` to see whether it's dict and
>> interact with it (if needed, eg. on negative testing, which is
>> my motivation for storing the full response).
>=20
> This makes sense for self.reply, but I'm thinking about the
> argument to Exception.__init__().  I'm worried that things might
> break if the argument is not a string.
>=20

I see. It's python so it'll simply use `__str__` method, but you are righ=
t that for the exception description the use of `repr` is better. I'll ch=
ange it in v2 (keeping the `self.reply` as is).
Luk=C3=A1=C5=A1


--HuQof5t9ALHnnfL58trxhhnXecjumUIRg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEwBAEBCAAaBQJZdthMExxsZG9rdG9yQHJlZGhhdC5jb20ACgkQJrNi5H/PIsEj
aQgAxUUaeBFRNShRhFNGGKMAUDYusolJ+r2jqrrVuF1rmGse8iayRXi//IMRQwnq
+k+TRf5V7ibGZGAhxfrr/PSZZXJJfwuznC1IMIpcP4b/eQLcz+j8KJa7N0+Q6rLH
3DeH5VyYE1n2Kgr+zCe1QVEE7so9hXPbkbv07+9J6lZGD2H+7jcANJwBZqk0f9kp
m0z2vM++33BMdeSAi6zWMoQLtR7QmIiUJYBJDHz31XYN7w1pkZeCmeHxs4kDLtsd
MRJgMJvIJylVa59wIyYm+VtHQ9C9ayl5IhQUFdP36zGsm7Oh2wUi06ik/dPkHMXT
NwfTBDvMGwhP3Q/FABZXAq3O2Q==
=Orl9
-----END PGP SIGNATURE-----

--HuQof5t9ALHnnfL58trxhhnXecjumUIRg--
