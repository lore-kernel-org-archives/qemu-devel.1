Received: from eggs.gnu.org ([209.51.188.92]:33082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gjkyw-00080q-DL
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:11:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gjkyv-0005Ne-0g
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:11:46 -0500
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
	<20181229122027.42245-6-vsementsov@virtuozzo.com>
	<a4565e50-b670-333e-a3db-72ff5a42b776@redhat.com>
	<084ff0b6-1de8-1c17-f085-97a8b1aeb8b5@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <fab4d292-ea59-5e1f-ec43-486abc455e7c@redhat.com>
Date: Wed, 16 Jan 2019 14:11:25 +0100
MIME-Version: 1.0
In-Reply-To: <084ff0b6-1de8-1c17-f085-97a8b1aeb8b5@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Aizie2YwaBPkEuYdbzhX65Ul6ZtiV67we"
Subject: Re: [Qemu-devel] [PATCH v5 05/11] iotests: allow resume_drive by
 node name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "fam@euphon.net" <fam@euphon.net>, "stefanha@redhat.com" <stefanha@redhat.com>, "jcody@redhat.com" <jcody@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>, "eblake@redhat.com" <eblake@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Aizie2YwaBPkEuYdbzhX65Ul6ZtiV67we
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "fam@euphon.net" <fam@euphon.net>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jcody@redhat.com" <jcody@redhat.com>, "kwolf@redhat.com"
 <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "eblake@redhat.com" <eblake@redhat.com>, "jsnow@redhat.com"
 <jsnow@redhat.com>
Message-ID: <fab4d292-ea59-5e1f-ec43-486abc455e7c@redhat.com>
Subject: Re: [PATCH v5 05/11] iotests: allow resume_drive by node name
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
 <20181229122027.42245-6-vsementsov@virtuozzo.com>
 <a4565e50-b670-333e-a3db-72ff5a42b776@redhat.com>
 <084ff0b6-1de8-1c17-f085-97a8b1aeb8b5@virtuozzo.com>
In-Reply-To: <084ff0b6-1de8-1c17-f085-97a8b1aeb8b5@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 14.01.19 17:06, Vladimir Sementsov-Ogievskiy wrote:
> 14.01.2019 17:46, Max Reitz wrote:
>> On 29.12.18 13:20, Vladimir Sementsov-Ogievskiy wrote:
>>> After node graph changes, we may not be able to resume_drive by devic=
e
>>> name (backing files are not recursively searched). So, lets allow to
>>> resume by node-name. Set constant name for breakpoints, to avoid
>>> introducing extra parameters.
>>
>> Hm, I don't quite understand this reason.  Is this so you can create
>> breakpoints on one node (which falls through to the first blkdebug nod=
e)
>> and then remove them from another (falling through to the same blkdebu=
g
>> node)?
>=20
> add/remove breakpoint goes through ->file children, but my filter links=

> active disk as ->backing. So, before block-job start we can insert brea=
kpoint
> by device name. But then, when filter inserted, we can't remove breakpo=
int,
> because my filter hides blkdebug with active disk under ->backing link.=

>=20
> Maybe, right solution would be support backing links in bdrv_debug_brea=
kpoint()
> and bdrv_debug_remove_breakpoint() for the case when there is no file c=
hild.
>=20
> But being unsure about right behavior, I've decided to adjust the test.=

>=20
> What about just do both  add/remove breakpoint through blkdebug node-na=
me, to
> make it less weird?

Yes, I was mostly wondering about the "set constant name for
breakpoints".  It doesn't seem necessary to me; if you use node names,
you could address the blkdebug node directly, I would think.

Max

>> Wouldn't it be better to let the user specify the breakpoint name?
>=20
> it's not needed now. with current naming we can have one break-point in=
 device,
> so we don't need different names.
>=20
>>
>> Max
>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---
>>>   tests/qemu-iotests/iotests.py | 9 +++++----
>>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotes=
ts.py
>>> index 76877ad584..c9779f432f 100644
>>> --- a/tests/qemu-iotests/iotests.py
>>> +++ b/tests/qemu-iotests/iotests.py
>>> @@ -415,11 +415,11 @@ class VM(qtest.QEMUQtestMachine):
>>>               self.pause_drive(drive, "write_aio")
>>>               return
>>>           self.qmp('human-monitor-command',
>>> -                    command_line=3D'qemu-io %s "break %s bp_%s"' % (=
drive, event, drive))
>>> +                    command_line=3D'qemu-io %s "break %s bp_0"' % (d=
rive, event))
>>>  =20
>>>       def resume_drive(self, drive):
>>>           self.qmp('human-monitor-command',
>>> -                    command_line=3D'qemu-io %s "remove_break bp_%s"'=
 % (drive, drive))
>>> +                    command_line=3D'qemu-io %s "remove_break bp_0"' =
% (drive))
>>>  =20
>>>       def hmp_qemu_io(self, drive, cmd):
>>>           '''Write to a given drive using an HMP command'''
>>> @@ -543,13 +543,14 @@ class QMPTestCase(unittest.TestCase):
>>>           self.assertEqual(self.vm.flatten_qmp_object(json.loads(json=
_filename[5:])),
>>>                            self.vm.flatten_qmp_object(reference))
>>>  =20
>>> -    def cancel_and_wait(self, drive=3D'drive0', force=3DFalse, resum=
e=3DFalse):
>>> +    def cancel_and_wait(self, drive=3D'drive0', force=3DFalse, resum=
e=3DFalse,
>>> +                        resume_node=3DNone):
>>>           '''Cancel a block job and wait for it to finish, returning =
the event'''
>>>           result =3D self.vm.qmp('block-job-cancel', device=3Ddrive, =
force=3Dforce)
>>>           self.assert_qmp(result, 'return', {})
>>>  =20
>>>           if resume:
>>> -            self.vm.resume_drive(drive)
>>> +            self.vm.resume_drive(resume_node or drive)
>>>  =20
>>>           cancelled =3D False
>>>           result =3D None
>>>
>>
>>
>=20
>=20



--Aizie2YwaBPkEuYdbzhX65Ul6ZtiV67we
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlw/LX0ACgkQ9AfbAGHV
z0AodAf/U3CVkw+3teRl0cQKEe/P9JRvTcGto97sMR5aVL2Ir5eprCmJA6HqKqQ1
/nO4obOtevH53M3pyViLPuWxITwktbTSszdkbirVz0EBs5yCCcY7JIuUjweMtnNH
7g5CyFbwaNXXdMsepmmUMIBRDncnR3dWtvxdkGx9JORNZzCzoakxVdDPTiJm5Wpu
LsmPwBBxnJi3rDSIpFcFK3NGQO8lNZnwyfHiDMmUfHzgIJwtNgn94Dr5uSON86iZ
67yIerF3qGwOygH5X3XBqQxxyaBaOmjEReCLtoVQRQ9/1AGdR1W32hb6LrbEYN/Z
UtfnUEFqJ/VS/REzVq7NfzI0qgp8WQ==
=dqQv
-----END PGP SIGNATURE-----

--Aizie2YwaBPkEuYdbzhX65Ul6ZtiV67we--
