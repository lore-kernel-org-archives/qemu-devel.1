Received: from eggs.gnu.org ([2001:4830:134:3::10]:43785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1df44K-0007Yk-0B
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 08:57:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1df44E-0001g5-Nu
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 08:57:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1df44E-0001e4-E6
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 08:57:02 -0400
References: <20170726144226.6913-1-ldoktor@redhat.com>
	<20170726144226.6913-2-ldoktor@redhat.com>
	<20170808123829.GM16801@stefanha-x1.localdomain>
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Message-ID: <110c04e3-e676-c705-a6f9-de040208538e@redhat.com>
Date: Tue, 8 Aug 2017 14:56:47 +0200
MIME-Version: 1.0
In-Reply-To: <20170808123829.GM16801@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ieNPHlOtce2nPp0ngeXBjbpCXfAqBjIXq"
Subject: Re: [Qemu-devel] [PATCH v4 01/10] qemu.py: Pylint/style fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, ehabkost@redhat.com, apahim@redhat.com, armbru@redhat.com, mreitz@redhat.com, jsnow@redhat.com, f4bug@amsat.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ieNPHlOtce2nPp0ngeXBjbpCXfAqBjIXq
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, ehabkost@redhat.com,
 apahim@redhat.com, armbru@redhat.com, mreitz@redhat.com, jsnow@redhat.com,
 f4bug@amsat.org
Message-ID: <110c04e3-e676-c705-a6f9-de040208538e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 01/10] qemu.py: Pylint/style fixes
References: <20170726144226.6913-1-ldoktor@redhat.com>
 <20170726144226.6913-2-ldoktor@redhat.com>
 <20170808123829.GM16801@stefanha-x1.localdomain>
In-Reply-To: <20170808123829.GM16801@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dne 8.8.2017 v 14:38 Stefan Hajnoczi napsal(a):
> On Wed, Jul 26, 2017 at 04:42:17PM +0200, Luk=C3=A1=C5=A1 Doktor wrote:=

>> No actual code changes, just several pylint/style fixes and docstring
>> clarifications.
>>
>> Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
>> ---
>>  scripts/qemu.py | 76 ++++++++++++++++++++++++++++++++++++++++--------=
---------
>>  1 file changed, 53 insertions(+), 23 deletions(-)
>>
>> diff --git a/scripts/qemu.py b/scripts/qemu.py
>> index 880e3e8..191c916 100644
>> --- a/scripts/qemu.py
>> +++ b/scripts/qemu.py
>> @@ -23,8 +23,22 @@ import qmp.qmp
>>  class QEMUMachine(object):
>>      '''A QEMU VM'''
>> =20
>> -    def __init__(self, binary, args=3D[], wrapper=3D[], name=3DNone, =
test_dir=3D"/var/tmp",
>> -                 monitor_address=3DNone, socket_scm_helper=3DNone, de=
bug=3DFalse):
>> +    def __init__(self, binary, args=3D[], wrapper=3D[], name=3DNone,
>> +                 test_dir=3D"/var/tmp", monitor_address=3DNone,
>> +                 socket_scm_helper=3DNone, debug=3DFalse):
>> +        '''
>> +        Create a QEMUMachine object
>> +
>> +        @param binary: path to the qemu binary (str)
>> +        @param args: initial list of extra arguments
>> +        @param wrapper: list of arguments used as prefix to qemu bina=
ry
>> +        @param name: name of this object (used for log/monitor/... fi=
le names)
>> +        @param test_dir: base location to put log/monitor/... files i=
n
>> +        @param monitor_address: custom address for QMP monitor
>> +        @param socket_scm_helper: path to scm_helper binary (to forwa=
rd fds)
>> +        @param debug: enable debug mode (forwarded to QMP helper and =
such)
>> +        @note: Qemu process is not started until launch() is used.
>> +        '''
>>          if name is None:
>>              name =3D "qemu-%d" % os.getpid()
>>          if monitor_address is None:
>> @@ -33,12 +47,13 @@ class QEMUMachine(object):
>>          self._qemu_log_path =3D os.path.join(test_dir, name + ".log")=

>>          self._popen =3D None
>>          self._binary =3D binary
>> -        self._args =3D list(args) # Force copy args in case we modify=
 them
>> +        self._args =3D list(args)     # Force copy args in case we mo=
dify them
>>          self._wrapper =3D wrapper
>>          self._events =3D []
>>          self._iolog =3D None
>>          self._socket_scm_helper =3D socket_scm_helper
>>          self._debug =3D debug
>> +        self._qmp =3D None
>> =20
>>      # This can be used to add an unused monitor instance.
>>      def add_monitor_telnet(self, ip, port):
>> @@ -64,16 +79,16 @@ class QEMUMachine(object):
>>          if self._socket_scm_helper is None:
>>              print >>sys.stderr, "No path to socket_scm_helper set"
>>              return -1
>> -        if os.path.exists(self._socket_scm_helper) =3D=3D False:
>> +        if os.path.exists(self._socket_scm_helper) is False:
>=20
> PEP8 says:
>=20
>   Don't compare boolean values to True or False using =3D=3D.
>=20
> https://www.python.org/dev/peps/pep-0008/#id51
>=20
> This should be:
>=20
>   if not os.path.exists(self._socket_scm_helper):
>=20
Hello Stefan,

yep, you are right. I'll fix it in v5

>>      def command(self, cmd, conv_keys=3DTrue, **args):
>> +        '''
>> +        Invoke a QMP command and on success report result dict or on =
failure
>=20
> s/report/return/ ?
>=20
Don't see much difference, but I'll use the "return" in the next version.=


>> +        raise exception with details.
>> +        '''
>>          reply =3D self.qmp(cmd, conv_keys, **args)
>>          if reply is None:
>>              raise Exception("Monitor is closed")
>> @@ -193,15 +216,18 @@ class QEMUMachine(object):
>>          return events
>> =20
>>      def event_wait(self, name, timeout=3D60.0, match=3DNone):
>> -        # Test if 'match' is a recursive subset of 'event'
>> -        def event_match(event, match=3DNone):
>> +        ''' Wait for event in QMP, optionally filter results by match=
=2E '''
>=20
> Why are spaces around this docstring?
>=20

Sorry, this is a custom from other project's guidelines. I'll fix it.

Luk=C3=A1=C5=A1


--ieNPHlOtce2nPp0ngeXBjbpCXfAqBjIXq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEwBAEBCAAaBQJZibUPExxsZG9rdG9yQHJlZGhhdC5jb20ACgkQJrNi5H/PIsEr
cAf+NYsFAVDYUwrI3P/kGdaJVEDN7rRdeU1t+/a1DZ5n6req3QRteLeI4TkJ1c1F
V2GxpY0eGvx1P5tqiUFsDwiGSZsVyUiqouzHqWX7b3mzPihtgJPfrkD/GloL0LPA
3sKCwDvBNqBo7ad6BYz1BQ5vjoROsj4ehI9TiXUB0HFMUlj9nOerBiUjob6mIVy7
TxhlykDScYxwxB4iluAYGKo1X3spOkDOtJ335KbvXbStTsJdNrrzKQDmVBntzs18
O/csLuCQy5UNoJzumHZ6GxZciThhPxs6vIXjydBb+ks+E2UFj9oQmT5egnKk0FEj
Bo+4hgaBMwYIu2sikHqNQEqIbQ==
=CUiw
-----END PGP SIGNATURE-----

--ieNPHlOtce2nPp0ngeXBjbpCXfAqBjIXq--
