Received: from eggs.gnu.org ([2001:4830:134:3::10]:54188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1e1wyc-0006qy-5e
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 12:01:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1e1wyU-0004mm-Bq
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 12:01:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1e1wyU-0004li-2o
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 12:01:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7FDB95F2965
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 16:01:39 +0000 (UTC)
References: <20171005172013.3098-1-ehabkost@redhat.com>
	<20171005172013.3098-4-ehabkost@redhat.com>
	<cf1d369d-6c59-8513-2662-ca10c58c517c@redhat.com>
	<20171010025049.GA4015@localhost.localdomain>
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Message-ID: <a96271ee-63a7-8cb9-d097-d5f117ebd01a@redhat.com>
Date: Tue, 10 Oct 2017 18:01:36 +0200
MIME-Version: 1.0
In-Reply-To: <20171010025049.GA4015@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8r9ax7FBTg5cGLposGCmjfmstKqPniihI"
Subject: Re: [Qemu-devel] [PATCH v2 3/3] scripts: Remove debug parameter
 from QEMUMachine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>, Cleber Rosa <crosa@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8r9ax7FBTg5cGLposGCmjfmstKqPniihI
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Message-ID: <a96271ee-63a7-8cb9-d097-d5f117ebd01a@redhat.com>
Subject: Re: [PATCH v2 3/3] scripts: Remove debug parameter from QEMUMachine
References: <20171005172013.3098-1-ehabkost@redhat.com>
 <20171005172013.3098-4-ehabkost@redhat.com>
 <cf1d369d-6c59-8513-2662-ca10c58c517c@redhat.com>
 <20171010025049.GA4015@localhost.localdomain>
In-Reply-To: <20171010025049.GA4015@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dne 10.10.2017 v 04:50 Eduardo Habkost napsal(a):
> On Sat, Oct 07, 2017 at 10:34:57AM +0200, Luk=C3=A1=C5=A1 Doktor wrote:=

>> Dne 5.10.2017 v 19:20 Eduardo Habkost napsal(a):
>>> All scripts that use the QEMUMachine and QEMUQtestMachine classes
>>> (device-crash-test, tests/migration/*, iotests.py, basevm.py)
>>> already configure logging.
>>>
>>> The basicConfig() call inside QEMUMachine.__init__() is being
>>> kept just to make sure a script would still work if it didn't
>>> configure logging.
>>>
>>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>>> ---
>>>  scripts/qemu.py                     | 6 ++----
>>>  tests/migration/guestperf/engine.py | 6 ++----
>>>  tests/qemu-iotests/iotests.py       | 2 --
>>>  3 files changed, 4 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/scripts/qemu.py b/scripts/qemu.py
>>> index f6d2e68627..9bfdf6d37d 100644
>>> --- a/scripts/qemu.py
>>> +++ b/scripts/qemu.py
>>> @@ -54,7 +54,7 @@ class QEMUMachine(object):
>>> =20
>>>      def __init__(self, binary, args=3DNone, wrapper=3DNone, name=3DN=
one,
>>>                   test_dir=3D"/var/tmp", monitor_address=3DNone,
>>> -                 socket_scm_helper=3DNone, debug=3DFalse):
>>> +                 socket_scm_helper=3DNone):
>>>          '''
>>>          Initialize a QEMUMachine
>>> =20
>>> @@ -65,7 +65,6 @@ class QEMUMachine(object):
>>>          @param test_dir: where to create socket and log file
>>>          @param monitor_address: address for QMP monitor
>>>          @param socket_scm_helper: helper program, required for send_=
fd_scm()"
>>> -        @param debug: enable debug mode
>>>          @note: Qemu process is not started until launch() is used.
>>>          '''
>>>          if args is None:
>>> @@ -85,12 +84,11 @@ class QEMUMachine(object):
>>>          self._events =3D []
>>>          self._iolog =3D None
>>>          self._socket_scm_helper =3D socket_scm_helper
>>> -        self._debug =3D debug
>>>          self._qmp =3D None
>>>          self._qemu_full_args =3D None
>>> =20
>>>          # just in case logging wasn't configured by the main script:=

>>> -        logging.basicConfig(level=3D(logging.DEBUG if debug else log=
ging.WARN))
>>> +        logging.basicConfig()
>> Yes, this behaves the same as `debug=3DFalse`
>>
>>> =20
>>>      def __enter__(self):
>>>          return self
>>> diff --git a/tests/migration/guestperf/engine.py b/tests/migration/gu=
estperf/engine.py
>>> index 0a13050bc6..e14d4320b2 100644
>>> --- a/tests/migration/guestperf/engine.py
>>> +++ b/tests/migration/guestperf/engine.py
>>> @@ -388,15 +388,13 @@ class Engine(object):
>>>                                 args=3Dself._get_src_args(hardware),
>>>                                 wrapper=3Dself._get_src_wrapper(hardw=
are),
>>>                                 name=3D"qemu-src-%d" % os.getpid(),
>>> -                               monitor_address=3Dsrcmonaddr,
>>> -                               debug=3Dself._debug)
>>> +                               monitor_address=3Dsrcmonaddr)
>>> =20
>>>          dst =3D qemu.QEMUMachine(self._binary,
>>>                                 args=3Dself._get_dst_args(hardware, u=
ri),
>>>                                 wrapper=3Dself._get_dst_wrapper(hardw=
are),
>>>                                 name=3D"qemu-dst-%d" % os.getpid(),
>>> -                               monitor_address=3Ddstmonaddr,
>>> -                               debug=3Dself._debug)
>>> +                               monitor_address=3Ddstmonaddr)
>>> =20
>>>          try:
>>>              src.launch()
>>> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotes=
ts.py
>>> index 36a7757aaf..6f057904a9 100644
>>> --- a/tests/qemu-iotests/iotests.py
>>> +++ b/tests/qemu-iotests/iotests.py
>>> @@ -195,8 +195,6 @@ class VM(qtest.QEMUQtestMachine):
>>>          super(VM, self).__init__(qemu_prog, qemu_opts, name=3Dname,
>>>                                   test_dir=3Dtest_dir,
>>>                                   socket_scm_helper=3Dsocket_scm_help=
er)
>>> -        if debug:
>>> -            self._debug =3D True
>>
>> And this is the main issue. So instead of the fix I proposed in
>> previous commit major changes to
>> "tests/qemu-iotests/iotests.py" are necessary.
>=20
> Could you clarify what those major changes are?
>=20
> iotests.py was already changed to call basicConfig() according to
> args.debug in main().
>=20

Hello Eduardo,

I'm sorry, I was not aware of that patch. I think I used git://github.com=
/ehabkost/qemu.git branch python-next as HEAD, but either I forgot to upd=
ate it, or that patch was not yet pushed, or was I suppose to use differe=
nt HEAD? I'm sorry, I'm not used to this kind of workflow.

Btw the afa79b55676dcd1859aa9d1f983c9dfbbcc13197 is exactly what I had in=
 mind. The major changes I mentioned were related to `TestRunner` stream =
and it's verbosity, which was not part of that commit and is not really n=
ecessary.

Anyway with that commit this works well.

Reviewed-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>=20

>=20
>>
>>>          self._num_drives =3D 0
>>> =20
>>>      def add_device(self, opts):
>>>
>>
>=20
>=20
>=20
>=20



--8r9ax7FBTg5cGLposGCmjfmstKqPniihI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEwBAEBCAAaBQJZ3O7gExxsZG9rdG9yQHJlZGhhdC5jb20ACgkQJrNi5H/PIsG8
Ogf+JbJARd+QrDcaFkQknFfLoYD04zCLjmVMDdasn67XMdY2daWIYRhpPuvf4PZ1
tFRUXpxEP4tcMSp9cSxlxvdZdSeZAYH3rrlUyhpfd/qAFUikj4ra1vZiYGIf5tFV
ZajJizJbg4AFMuLjLRqV02BebBUuHN+G81Ssf7CcAJ2GNKRZR4JdD217yRF2HuuU
gzDagjjLCC91BaoVxMnjG7FkVamDGw3yy+eFVQF9XD+FAF/FuO6Nmxs0ZfzAOGnK
oQe4XjA8SP7zcbVLpwuLeUcu1avmHWWqgmSO29Ex1OPPrSZ7moFXYxiIHvToCEfL
QdbtxM+22al4BZ0kO7IhviS7dQ==
=hHCp
-----END PGP SIGNATURE-----

--8r9ax7FBTg5cGLposGCmjfmstKqPniihI--
