Received: from eggs.gnu.org ([2001:4830:134:3::10]:54374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f6CBl-0006bH-KG
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 05:37:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f6CBk-0002lI-76
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 05:37:13 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20180330161040.350271-1-vsementsov@virtuozzo.com>
	<b6a499bc-b5c6-7c35-e916-d63861f0c0c5@redhat.com>
	<3d0d9016-276f-c1c6-eb7e-ef78c0744f01@redhat.com>
	<47c416af-4b8e-db9a-4b4b-9b0eb060b4ff@virtuozzo.com>
Message-ID: <ec4ee8f5-7a47-2e18-1fe3-d4f3859bc8ce@virtuozzo.com>
Date: Wed, 11 Apr 2018 12:36:57 +0300
MIME-Version: 1.0
In-Reply-To: <47c416af-4b8e-db9a-4b4b-9b0eb060b4ff@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] iotests: fix 169
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org

11.04.2018 12:02, Vladimir Sementsov-Ogievskiy wrote:
> 03.04.2018 23:13, John Snow wrote:
>>
>> On 04/03/2018 12:23 PM, Max Reitz wrote:
>>> On 2018-03-30 18:10, Vladimir Sementsov-Ogievskiy wrote:
>>>> Use MIGRATION events instead of RESUME. Also, make a TODO: enable
>>>> dirty-bitmaps capability for offline case.
>>>>
>>>> This (likely) fixes racy faults at least of the following types:
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 - timeout on waiting for RESUME event
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 - sha256 mismatch on 136 (138 after this patc=
h)
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> ---
>>>>
>>>> This patch is a true change for the test anyway. But I don't=20
>>>> understand,
>>>> why (and do really) it fixes the things. And I'm not sure about do we
>>>> really have a bug in bitmap migration or persistence. So, it's up=20
>>>> to you,
>>>> take it into 2.12...
>>>>
>>>> It was already discussed, that "STOP" event is bad for tests. What=20
>>>> about
>>>> "RESUME"? How can we miss it? And sha256 mismatch is really something
>>>> strange.
>>>>
>>>> Max, please check, do it fix 169 for you.
>>>>
>>>> =C2=A0 tests/qemu-iotests/169 | 44=20
>>>> +++++++++++++++++++++++---------------------
>>>> =C2=A0 1 file changed, 23 insertions(+), 21 deletions(-)
>>> This makes the test pass (thanks!), but it still leaves behind five=20
>>> cats...
>>>
>>> Max
>>>
>>>
>> Hmm:
>>
>> jhuston=C2=A0 14772=C2=A0 0.0=C2=A0 0.0=C2=A0=C2=A0 4296=C2=A0=C2=A0 784=
 pts/3=C2=A0=C2=A0=C2=A0 S=C2=A0=C2=A0=C2=A0 16:12=C2=A0=C2=A0 0:00 cat
>> /home/bos/jhuston/src/qemu/bin/git/tests/qemu-iotests/scratch/mig_file
>> jhuston=C2=A0 14796=C2=A0 0.0=C2=A0 0.0=C2=A0=C2=A0 4296=C2=A0=C2=A0 764=
 pts/3=C2=A0=C2=A0=C2=A0 S=C2=A0=C2=A0=C2=A0 16:12=C2=A0=C2=A0 0:00 cat
>> /home/bos/jhuston/src/qemu/bin/git/tests/qemu-iotests/scratch/mig_file
>> jhuston=C2=A0 14940=C2=A0 0.0=C2=A0 0.0=C2=A0=C2=A0 4296=C2=A0=C2=A0 788=
 pts/3=C2=A0=C2=A0=C2=A0 S=C2=A0=C2=A0=C2=A0 16:12=C2=A0=C2=A0 0:00 cat
>> /home/bos/jhuston/src/qemu/bin/git/tests/qemu-iotests/scratch/mig_file
>> jhuston=C2=A0 14964=C2=A0 0.0=C2=A0 0.0=C2=A0=C2=A0 4296=C2=A0=C2=A0 720=
 pts/3=C2=A0=C2=A0=C2=A0 S=C2=A0=C2=A0=C2=A0 16:12=C2=A0=C2=A0 0:00 cat
>> /home/bos/jhuston/src/qemu/bin/git/tests/qemu-iotests/scratch/mig_file
>> jhuston=C2=A0 15052=C2=A0 0.0=C2=A0 0.0=C2=A0=C2=A0 4296=C2=A0=C2=A0 768=
 pts/3=C2=A0=C2=A0=C2=A0 S=C2=A0=C2=A0=C2=A0 16:12=C2=A0=C2=A0 0:00 cat
>> /home/bos/jhuston/src/qemu/bin/git/tests/qemu-iotests/scratch/mig_file
>>
>> Why do these get left behind? Nothing to consume the data...?
>
> aha, understand. it is due to last vm_b.shutdown() and vm_b.launch in=20
> case of should_migrate. So, at the end of the test I restart vm_b with=20
> -incoming parameter. But it looks like=C2=A0 a bug anyway, If we start qe=
mu=20
> with -incoming "exec", should not we kill cat process, if there were=20
> no migration?
>

third type of fail, without this patch:

+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ERROR: test__persistent__migbitmap__offline_shared=20
(__main__.TestDirtyBitmapMigration)
+methodcaller(name, ...) --> methodcaller object
+----------------------------------------------------------------------
+Traceback (most recent call last):
+=C2=A0 File "169", line 135, in do_test_migration
+=C2=A0=C2=A0=C2=A0 self.vm_b.launch()
+=C2=A0 File=20
"/work/src/qemu/up-169/tests/qemu-iotests/../../scripts/qemu.py", line=20
221, in launch
+=C2=A0=C2=A0=C2=A0 self._launch()
+=C2=A0 File=20
"/work/src/qemu/up-169/tests/qemu-iotests/../../scripts/qemu.py", line=20
244, in _launch
+=C2=A0=C2=A0=C2=A0 self._post_launch()
+=C2=A0 File=20
"/work/src/qemu/up-169/tests/qemu-iotests/../../scripts/qtest.py", line=20
100, in _post_launch
+=C2=A0=C2=A0=C2=A0 super(QEMUQtestMachine, self)._post_launch()
+=C2=A0 File=20
"/work/src/qemu/up-169/tests/qemu-iotests/../../scripts/qemu.py", line=20
196, in _post_launch
+=C2=A0=C2=A0=C2=A0 self._qmp.accept()
+=C2=A0 File=20
"/work/src/qemu/up-169/tests/qemu-iotests/../../scripts/qmp/qmp.py",=20
line 157, in accept
+=C2=A0=C2=A0=C2=A0 return self.__negotiate_capabilities()
+=C2=A0 File=20
"/work/src/qemu/up-169/tests/qemu-iotests/../../scripts/qmp/qmp.py",=20
line 75, in __negotiate_capabilities
+=C2=A0=C2=A0=C2=A0 resp =3D self.cmd('qmp_capabilities')
+=C2=A0 File=20
"/work/src/qemu/up-169/tests/qemu-iotests/../../scripts/qmp/qmp.py",=20
line 191, in cmd
+=C2=A0=C2=A0=C2=A0 return self.cmd_obj(qmp_cmd)
+=C2=A0 File=20
"/work/src/qemu/up-169/tests/qemu-iotests/../../scripts/qmp/qmp.py",=20
line 174, in cmd_obj
+=C2=A0=C2=A0=C2=A0 resp =3D self.__json_read()
+=C2=A0 File=20
"/work/src/qemu/up-169/tests/qemu-iotests/../../scripts/qmp/qmp.py",=20
line 82, in __json_read
+=C2=A0=C2=A0=C2=A0 data =3D self.__sockfile.readline()
+=C2=A0 File "/usr/lib64/python2.7/socket.py", line 447, in readline
+=C2=A0=C2=A0=C2=A0 data =3D self._sock.recv(self._rbufsize)
+error: [Errno 104] Connection reset by peer
+


--=20
Best regards,
Vladimir
