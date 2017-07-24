Received: from eggs.gnu.org ([2001:4830:134:3::10]:46818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dZcbg-0006P3-Hz
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:37:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dZcbc-000594-J2
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:37:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44885)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1dZcbc-00058k-9X
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:37:00 -0400
References: <20170720162815.19802-1-ldoktor@redhat.com>
	<20170720162815.19802-7-ldoktor@redhat.com>
	<989e2216-499c-3c22-3958-0c51ac342dd1@amsat.org>
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Message-ID: <b772f95e-9a3a-0a72-e6c6-7390902f62d1@redhat.com>
Date: Mon, 24 Jul 2017 14:36:52 +0200
MIME-Version: 1.0
In-Reply-To: <989e2216-499c-3c22-3958-0c51ac342dd1@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Tljh1clmOHrfECrOsGhvG3MBFVH8gqxXf"
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
--Tljh1clmOHrfECrOsGhvG3MBFVH8gqxXf
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 apahim@redhat.com, qemu-devel@nongnu.org, famz@redhat.com,
 armbru@redhat.com, mreitz@redhat.com, ehabkost@redhat.com
Message-ID: <b772f95e-9a3a-0a72-e6c6-7390902f62d1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 06/11] qmp.py: Couple of pylint/style fixes
References: <20170720162815.19802-1-ldoktor@redhat.com>
 <20170720162815.19802-7-ldoktor@redhat.com>
 <989e2216-499c-3c22-3958-0c51ac342dd1@amsat.org>
In-Reply-To: <989e2216-499c-3c22-3958-0c51ac342dd1@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dne 22.7.2017 v 03:30 Philippe Mathieu-Daud=C3=A9 napsal(a):
> Hi Luk=C3=A1=C5=A1,
>=20
> Since comment/indent fixes and code changes are not related I'd rather =
see this split in at least 2 patches.
>=20
Hello Philippe, thank you for the review, I'm wondering what code changes=
 you have in mind? This is commit should not bring any code changes, just=
 code reorganization (like including the self.* attributes on top of the =
file)

> On 07/20/2017 01:28 PM, Luk=C3=A1=C5=A1 Doktor wrote:
>> No actual code changes, just a few pylint/style fixes and docstring
>> clarifications.
>>
>> Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
>> ---
>>   scripts/qmp/qmp.py | 37 ++++++++++++++++++++++++-------------
>>   1 file changed, 24 insertions(+), 13 deletions(-)
>>
>> diff --git a/scripts/qmp/qmp.py b/scripts/qmp/qmp.py
>> index 62d3651..bb4d614 100644
>> --- a/scripts/qmp/qmp.py
>> +++ b/scripts/qmp/qmp.py
>> @@ -13,19 +13,30 @@ import errno
>>   import socket
>>   import sys
>>   +
>>   class QMPError(Exception):
>>       pass
>>   +
>>   class QMPConnectError(QMPError):
>>       pass
>>   +
>>   class QMPCapabilitiesError(QMPError):
>>       pass
>>   +
>>   class QMPTimeoutError(QMPError):
>>       pass
>>   +
>>   class QEMUMonitorProtocol:
>> +
>> +    #: Socket's error class
>> +    error =3D socket.error
>> +    #: Socket's timeout
>> +    timeout =3D socket.timeout
>> +
>=20
> ok
>=20
>>       def __init__(self, address, server=3DFalse, debug=3DFalse):
>>           """
>>           Create a QEMUMonitorProtocol class.
>> @@ -42,6 +53,7 @@ class QEMUMonitorProtocol:
>>           self.__address =3D address
>>           self._debug =3D debug
>>           self.__sock =3D self.__get_sock()
>> +        self.__sockfile =3D None
>>           if server:
>>               self.__sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUS=
EADDR, 1)
>>               self.__sock.bind(self.__address)
>> @@ -56,7 +68,7 @@ class QEMUMonitorProtocol:
>>         def __negotiate_capabilities(self):
>>           greeting =3D self.__json_read()
>> -        if greeting is None or not greeting.has_key('QMP'):
>> +        if greeting is None or "QMP" not in greeting:
>=20
> ok
>=20
>>               raise QMPConnectError
>>           # Greeting seems ok, negotiate capabilities
>>           resp =3D self.cmd('qmp_capabilities')
>> @@ -78,8 +90,6 @@ class QEMUMonitorProtocol:
>>                       continue
>>               return resp
>>   -    error =3D socket.error
>> -
>>       def __get_events(self, wait=3DFalse):
>>           """
>>           Check for new events in the stream and cache them in __event=
s.
>> @@ -89,8 +99,8 @@ class QEMUMonitorProtocol:
>>             @raise QMPTimeoutError: If a timeout float is provided and=
 the timeout
>>                                   period elapses.
>> -        @raise QMPConnectError: If wait is True but no events could b=
e retrieved
>> -                                or if some other error occurred.
>> +        @raise QMPConnectError: If wait is True but no events could b=
e
>> +                                retrieved or if some other error occu=
rred.
>>           """
>>             # Check for new events regardless and pull them into the c=
ache:
>> @@ -175,7 +185,7 @@ class QEMUMonitorProtocol:
>>           @param args: command arguments (dict)
>>           @param id: command id (dict, list, string or int)
>>           """
>> -        qmp_cmd =3D { 'execute': name }
>> +        qmp_cmd =3D {'execute': name}
>>           if args:
>>               qmp_cmd['arguments'] =3D args
>>           if id:
>> @@ -183,6 +193,9 @@ class QEMUMonitorProtocol:
>>           return self.cmd_obj(qmp_cmd)
>>         def command(self, cmd, **kwds):
>> +        """
>> +        Build and send a QMP command to the monitor, report errors wh=
en any
>=20
> I'm not native english speaker but I think "if any" sounds better.
>=20
Yep, you are right.

>> +        """
>>           ret =3D self.cmd(cmd, kwds)
>>           if ret.has_key('error'):
>>               raise Exception(ret['error']['desc'])
>> @@ -190,15 +203,15 @@ class QEMUMonitorProtocol:
>>         def pull_event(self, wait=3DFalse):
>>           """
>> -        Get and delete the first available QMP event.
>> +        Get and pop the first available QMP event.
>=20
> Both sentences seems unclear to me, regarding the function name... I wo=
nder if removing this comment makes this function clearer.
>=20
I was trying to avoid confusion with the delete. How about `Pulls/waits f=
or a single event`? I'd like to keep the rest of the docstring as the det=
ails might be useful.

Luk=C3=A1=C5=A1

>>             @param wait (bool): block until an event is available.
>>           @param wait (float): If wait is a float, treat it as a timeo=
ut value.
>>             @raise QMPTimeoutError: If a timeout float is provided and=
 the timeout
>>                                   period elapses.
>> -        @raise QMPConnectError: If wait is True but no events could b=
e retrieved
>> -                                or if some other error occurred.
>> +        @raise QMPConnectError: If wait is True but no events could b=
e
>> +                                retrieved or if some other error occu=
rred.
>>             @return The first available QMP event, or None.
>>           """
>> @@ -217,8 +230,8 @@ class QEMUMonitorProtocol:
>>             @raise QMPTimeoutError: If a timeout float is provided and=
 the timeout
>>                                   period elapses.
>> -        @raise QMPConnectError: If wait is True but no events could b=
e retrieved
>> -                                or if some other error occurred.
>> +        @raise QMPConnectError: If wait is True but no events could b=
e
>> +                                retrieved or if some other error occu=
rred.
>>             @return The list of available QMP events.
>>           """
>> @@ -235,8 +248,6 @@ class QEMUMonitorProtocol:
>>           self.__sock.close()
>>           self.__sockfile.close()
>>   -    timeout =3D socket.timeout
>> -
>>       def settimeout(self, timeout):
>>           self.__sock.settimeout(timeout)
>> =20
>=20
> Regards,
>=20
> Phil.



--Tljh1clmOHrfECrOsGhvG3MBFVH8gqxXf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEwBAEBCAAaBQJZdenkExxsZG9rdG9yQHJlZGhhdC5jb20ACgkQJrNi5H/PIsHk
DAf/aqChBxloi+QfiCM4R6mDyubWwPRyyqAcKsJ/CrbV3auBBdpRret7vJxiwTYe
aJor41pr2MxBnmHtYaN8hNgzTlxDAsPiMO7elvYhscAT10+jz6B8v1okra37zUoX
puWKEuvMnx3q9wPNxKxhb0x+rZbZbfNigMBUAnm3zWlEbX8uj6flK0g+Eo95grPa
695ub5mJbLGflWGmU27Rv3AKgSnnj/rFKjiVj3NXKTq5Ycng8TpeVhvHkErVL0LO
V1pyJEW/cMpKREOLED/gvf5aHIrd4ZrWbkCaqCOPN86pnDE+FbOmOFi/wTzl9NHP
WDOYNFGXYy8jKdbwXkSzOqAvjw==
=PCoK
-----END PGP SIGNATURE-----

--Tljh1clmOHrfECrOsGhvG3MBFVH8gqxXf--
