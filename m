Received: from eggs.gnu.org ([2001:4830:134:3::10]:36539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejWTA-0003wP-D9
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 15:37:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejWT9-00019U-AF
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 15:37:28 -0500
References: <20180206182507.21753-1-vsementsov@virtuozzo.com>
	<20180206182629.GQ20001@redhat.com>
	<55cf676e-eae0-e694-c89b-778b0225730b@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3c0e7de4-5f59-f905-840f-63f7261f5af7@redhat.com>
Date: Wed, 7 Feb 2018 14:37:03 -0600
MIME-Version: 1.0
In-Reply-To: <55cf676e-eae0-e694-c89b-778b0225730b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] iotests: 205: support luks format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

On 02/06/2018 12:57 PM, Eric Blake wrote:
> On 02/06/2018 12:26 PM, Daniel P. Berrang=C3=A9 wrote:
>> On Tue, Feb 06, 2018 at 09:25:07PM +0300, Vladimir Sementsov-Ogievskiy=
=20
>> wrote:
>>> Support default luks options in VM.add_drive and in new library
>>> function qemu_img_create. Use it in 205 iotests.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---
>>
>> Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
>=20
> Thanks. I'll take this through my NBD queue.
>=20
> git git://repo.or.cz/qemu/ericb.git nbd
>=20

I'm seeing this failure now :(

$ ./check -luks 205
QEMU          -- "/home/eblake/qemu/x86_64-softmmu/qemu-system-x86_64"=20
-nodefaults -machine accel=3Dqtest
QEMU_IMG      -- "/home/eblake/qemu/qemu-img"
QEMU_IO       -- "/home/eblake/qemu/qemu-io"  --cache writeback
QEMU_NBD      -- "/home/eblake/qemu/qemu-nbd"
IMGFMT        -- luks (iter-time=3D10)
IMGPROTO      -- file
PLATFORM      -- Linux/x86_64 red 4.14.16-300.fc27.x86_64
TEST_DIR      -- /home/eblake/qemu/tests/qemu-iotests/scratch
SOCKET_SCM_HELPER -- /home/eblake/qemu/tests/qemu-iotests/socket_scm_help=
er

205         [failed, exit status 1] - output mismatch (see 205.out.bad)
--- /home/eblake/qemu/tests/qemu-iotests/205.out	2018-02-07=20
09:48:13.346107367 -0600
+++ /home/eblake/qemu/tests/qemu-iotests/205.out.bad	2018-02-07=20
14:35:21.859890826 -0600
@@ -1,5 +1,159 @@
-.......
+qemu-img: /home/eblake/qemu/tests/qemu-iotests/scratch/disk: Failed to=20
get "write" lock
+Is another process using the image?
+qemu-img: /home/eblake/qemu/tests/qemu-iotests/scratch/disk: Failed to=20
get "write" lock
+Is another process using the image?
+qemu-img: /home/eblake/qemu/tests/qemu-iotests/scratch/disk: Failed to=20
get "write" lock
+Is another process using the image?
+qemu-img: /home/eblake/qemu/tests/qemu-iotests/scratch/disk: Failed to=20
get "write" lock
+Is another process using the image?
+qemu-img: /home/eblake/qemu/tests/qemu-iotests/scratch/disk: Failed to=20
get "write" lock
+Is another process using the image?
+qemu-img: /home/eblake/qemu/tests/qemu-iotests/scratch/disk: Failed to=20
get "write" lock
+Is another process using the image?
+qemu-img: /home/eblake/qemu/tests/qemu-iotests/scratch/disk: Failed to=20
get "write" lock
+Is another process using the image?
+EEEEEEE
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ERROR: test_connect_after_remove_default (__main__.TestNbdServerRemove)
+----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "205", line 37, in setUp
+    self.vm.launch()
+  File "/home/eblake/qemu/tests/qemu-iotests/../../scripts/qemu.py",=20
line 221, in launch
+    self._launch()
+  File "/home/eblake/qemu/tests/qemu-iotests/../../scripts/qemu.py",=20
line 244, in _launch
+    self._post_launch()
+  File "/home/eblake/qemu/tests/qemu-iotests/../../scripts/qtest.py",=20
line 100, in _post_launch
+    super(QEMUQtestMachine, self)._post_launch()
+  File "/home/eblake/qemu/tests/qemu-iotests/../../scripts/qemu.py",=20
line 196, in _post_launch
+    self._qmp.accept()
+  File "/home/eblake/qemu/tests/qemu-iotests/../../scripts/qmp/qmp.py",=20
line 157, in accept
+    return self.__negotiate_capabilities()
+  File "/home/eblake/qemu/tests/qemu-iotests/../../scripts/qmp/qmp.py",=20
line 73, in __negotiate_capabilities
+    raise QMPConnectError
+QMPConnectError
...

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
