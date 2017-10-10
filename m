Received: from eggs.gnu.org ([2001:4830:134:3::10]:54684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1e1x0H-000892-UJ
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 12:03:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1e1x0B-0005UT-K9
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 12:03:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1e1x0B-0005Tn-7L
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 12:03:27 -0400
References: <20171005172013.3098-1-ehabkost@redhat.com>
	<20171005172013.3098-3-ehabkost@redhat.com>
	<7af19e5a-702e-fd41-951b-47a542269929@redhat.com>
	<20171010024907.GZ4015@localhost.localdomain>
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Message-ID: <b64d22d3-50be-3bf6-9f27-12931b811389@redhat.com>
Date: Tue, 10 Oct 2017 18:03:14 +0200
MIME-Version: 1.0
In-Reply-To: <20171010024907.GZ4015@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2XPuQc1wLCcXbJC1h9RjMFKjeosiMOuLT"
Subject: Re: [Qemu-devel] [PATCH v2 2/3] scripts: Remove debug parameter
 from QEMUMonitorProtocol
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2XPuQc1wLCcXbJC1h9RjMFKjeosiMOuLT
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b64d22d3-50be-3bf6-9f27-12931b811389@redhat.com>
Subject: Re: [PATCH v2 2/3] scripts: Remove debug parameter from
 QEMUMonitorProtocol
References: <20171005172013.3098-1-ehabkost@redhat.com>
 <20171005172013.3098-3-ehabkost@redhat.com>
 <7af19e5a-702e-fd41-951b-47a542269929@redhat.com>
 <20171010024907.GZ4015@localhost.localdomain>
In-Reply-To: <20171010024907.GZ4015@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dne 10.10.2017 v 04:49 Eduardo Habkost napsal(a):
> On Sat, Oct 07, 2017 at 10:26:14AM +0200, Luk=C3=A1=C5=A1 Doktor wrote:=

>> Dne 5.10.2017 v 19:20 Eduardo Habkost napsal(a):
>>> Use logging module for the QMP debug messages.  The only scripts
>>> that set debug=3DTrue are iotests.py and guestperf/engine.py, and
>>> they already call logging.basicConfig() to set up logging.
>>>
>>> Scripts that don't configure logging are safe as long as they
>>> don't need debugging output, because debug messages don't trigger
>>> the "No handlers could be found for logger" message from the
>>> Python logging module.
>>>
>>> Scripts that already configure logging but don't use debug=3DTrue
>>> (e.g. scripts/vm/basevm.py) will get QMP debugging enabled for
>>> free.
>>>
>>> Cc: "Alex Benn=C3=A9e" <alex.bennee@linaro.org>
>>> Cc: Fam Zheng <famz@redhat.com>
>>> Cc: "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org>
>>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>>> ---
>>> Changes v1 -> v2:
>>> * Actually remove debug parameter from method definition
>>>   (Fam Zheng)
>>> * Fix "<<<" vs ">>>" confusion
>>>   (Fam Zheng)
>>> * Remove "import sys" line
>>>   (Luk=C3=A1=C5=A1 Doktor)
>>> ---
>>>  scripts/qemu.py    |  3 +--
>>>  scripts/qmp/qmp.py | 16 +++++++---------
>>>  2 files changed, 8 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/scripts/qemu.py b/scripts/qemu.py
>>> index c9a106fbce..f6d2e68627 100644
>>> --- a/scripts/qemu.py
>>> +++ b/scripts/qemu.py
>>> @@ -177,8 +177,7 @@ class QEMUMachine(object):
>>> =20
>>>      def _pre_launch(self):
>>>          self._qmp =3D qmp.qmp.QEMUMonitorProtocol(self._monitor_addr=
ess,
>>> -                                                server=3DTrue,
>>> -                                                debug=3Dself._debug)=

>>> +                                                server=3DTrue)
>>> =20
>>>      def _post_launch(self):
>>>          self._qmp.accept()
>>> diff --git a/scripts/qmp/qmp.py b/scripts/qmp/qmp.py
>>> index ef12e8a1a0..07c9632e9e 100644
>>> --- a/scripts/qmp/qmp.py
>>> +++ b/scripts/qmp/qmp.py
>>> @@ -11,7 +11,7 @@
>>>  import json
>>>  import errno
>>>  import socket
>>> -import sys
>>> +import logging
>>> =20
>>> =20
>>>  class QMPError(Exception):
>>> @@ -32,12 +32,14 @@ class QMPTimeoutError(QMPError):
>>> =20
>>>  class QEMUMonitorProtocol(object):
>>> =20
>>> +    #: Logger object for debugging messages
>>> +    logger =3D logging.getLogger('QMP')
>>>      #: Socket's error class
>>>      error =3D socket.error
>>>      #: Socket's timeout
>>>      timeout =3D socket.timeout
>>> =20
>>> -    def __init__(self, address, server=3DFalse, debug=3DFalse):
>>> +    def __init__(self, address, server=3DFalse):
>>>          """
>>>          Create a QEMUMonitorProtocol class.
>>> =20
>>> @@ -51,7 +53,6 @@ class QEMUMonitorProtocol(object):
>>>          """
>>>          self.__events =3D []
>>>          self.__address =3D address
>>> -        self._debug =3D debug
>>>          self.__sock =3D self.__get_sock()
>>>          self.__sockfile =3D None
>>>          if server:
>>> @@ -83,8 +84,7 @@ class QEMUMonitorProtocol(object):
>>>                  return
>>>              resp =3D json.loads(data)
>>>              if 'event' in resp:
>>> -                if self._debug:
>>> -                    print >>sys.stderr, "QMP:<<< %s" % resp
>>> +                self.logger.debug("<<< %s", resp)
>>>                  self.__events.append(resp)
>>>                  if not only_event:
>>>                      continue
>>> @@ -164,8 +164,7 @@ class QEMUMonitorProtocol(object):
>>>          @return QMP response as a Python dict or None if the connect=
ion has
>>>                  been closed
>>>          """
>>> -        if self._debug:
>>> -            print >>sys.stderr, "QMP:>>> %s" % qmp_cmd
>>> +        self.logger.debug(">>> %s", qmp_cmd)
>>>          try:
>>>              self.__sock.sendall(json.dumps(qmp_cmd))
>>>          except socket.error as err:
>>> @@ -173,8 +172,7 @@ class QEMUMonitorProtocol(object):
>>>                  return
>>>              raise socket.error(err)
>>>          resp =3D self.__json_read()
>>> -        if self._debug:
>>> -            print >>sys.stderr, "QMP:<<< %s" % resp
>>> +        self.logger.debug("<<< %s", resp)
>>>          return resp
>>> =20
>>>      def cmd(self, name, args=3DNone, cmd_id=3DNone):
>>>
>>
>> This one looks good, but in order to no break qemu-iotests verbose mod=
e it requires fix to qtest/iotests:
>>
>> ```diff
>> diff --git a/scripts/qtest.py b/scripts/qtest.py
>> index df0daf2..0e955a8 100644
>> --- a/scripts/qtest.py
>> +++ b/scripts/qtest.py
>> @@ -77,12 +77,12 @@ class QEMUQtestMachine(qemu.QEMUMachine):
>>      '''A QEMU VM'''
>> =20
>>      def __init__(self, binary, args=3DNone, name=3DNone, test_dir=3D"=
/var/tmp",
>> -                 socket_scm_helper=3DNone):
>> +                 socket_scm_helper=3DNone, debug=3DFalse):
>>          if name is None:
>>              name =3D "qemu-%d" % os.getpid()
>>          super(QEMUQtestMachine,
>>                self).__init__(binary, args, name=3Dname, test_dir=3Dte=
st_dir,
>> -                             socket_scm_helper=3Dsocket_scm_helper)
>> +                             socket_scm_helper=3Dsocket_scm_helper, d=
ebug=3Ddebug)
>>          self._qtest =3D None
>>          self._qtest_path =3D os.path.join(test_dir, name + "-qtest.so=
ck")
>> =20
>> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotest=
s.py
>> index 1af117e..989ebd3 100644
>> --- a/tests/qemu-iotests/iotests.py
>> +++ b/tests/qemu-iotests/iotests.py
>> @@ -193,9 +193,8 @@ class VM(qtest.QEMUQtestMachine):
>>          name =3D "qemu%s-%d" % (path_suffix, os.getpid())
>>          super(VM, self).__init__(qemu_prog, qemu_opts, name=3Dname,
>>                                   test_dir=3Dtest_dir,
>> -                                 socket_scm_helper=3Dsocket_scm_helpe=
r)
>> -        if debug:
>> -            self._debug =3D True
>> +                                 socket_scm_helper=3Dsocket_scm_helpe=
r,
>> +                                 debug=3Ddebug)
>>          self._num_drives =3D 0
>> =20
>>      def add_device(self, opts):
>> ```
>=20
> I'm confused by why the above patch is necessary.  We are in the
> process of removing the 'debug' parameter from QEMUMachine and
> QEMUMonitorProtocol, why would we add a debug parameter to
> QEMUQtestMachine and iotests.py?
>=20
>>
>> (because the `debug` used to be set after `__init__`, but the logging =
is initialized during `__init__`.)
>>
>> Therefor conditional ACK when the qtest/iotest fix precedes this commi=
t.
>=20
> Do you mean the following?
>=20
>   Message-Id: <20170927130339.21444-3-ehabkost@redhat.com>
>   Subject: [Qemu-devel] [PATCH 2/5] iotests: Set up Python logging
>   https://www.mail-archive.com/qemu-devel@nongnu.org/msg485036.html
>   https://github.com/ehabkost/qemu/commit/afa79b55676dcd1859aa9d1f983c9=
dfbbcc13197
>=20

I'm sorry, my fault. With the afa79b55676dcd1859aa9d1f983c9dfbbcc13197 co=
mmit it works well and I haven't found any other issues.

Reviewed-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>=20

> It is already queued on python-next.
>=20



--2XPuQc1wLCcXbJC1h9RjMFKjeosiMOuLT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEwBAEBCAAaBQJZ3O9CExxsZG9rdG9yQHJlZGhhdC5jb20ACgkQJrNi5H/PIsEi
TQf+PMKzWLDwu2lOVkumEy/PEnkYe8nSZ7GUM1gadwjRZ1Vh1PsGBPrtVF8bPlS9
OFdcuTIEm3/HPahQHLSwn11xXzsLVYrhVMFWYuqpAXTUzQ5MvVOLyUwm36e4/hA9
Tr7FQ+vLzo/Qj2kaMosLs7khGlzmmLbjdJHi+pQXOMTXJq7AnOCIytLCR/Q/+Uru
+NRtWFyUtgRnimuSnm95dKtANxOgkVgDUbrSlQjL/wFoXW5BRrziu1g5XoJnFAK+
l4yqBmoGXyCTM27ZoTYRJ2JutsKAPg4znUeSOXQ1ZRL8Lo4S4ApTtgdBHEGIC1Vr
yJuLtBUxwLdZiV5OvFOHLLa7aA==
=JMWm
-----END PGP SIGNATURE-----

--2XPuQc1wLCcXbJC1h9RjMFKjeosiMOuLT--
