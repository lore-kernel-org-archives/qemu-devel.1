Received: from eggs.gnu.org ([2001:4830:134:3::10]:56115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f6FzK-0002ku-K5
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 09:40:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f6FzG-00078V-5J
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 09:40:38 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20180330161040.350271-1-vsementsov@virtuozzo.com>
	<b6a499bc-b5c6-7c35-e916-d63861f0c0c5@redhat.com>
	<3d0d9016-276f-c1c6-eb7e-ef78c0744f01@redhat.com>
	<47c416af-4b8e-db9a-4b4b-9b0eb060b4ff@virtuozzo.com>
	<ec4ee8f5-7a47-2e18-1fe3-d4f3859bc8ce@virtuozzo.com>
	<90b289f4-d976-1fb7-57e2-aa02d00947d1@virtuozzo.com>
Message-ID: <ed0b3e2a-ec0d-81db-afc2-b636bb19b184@virtuozzo.com>
Date: Wed, 11 Apr 2018 16:40:17 +0300
MIME-Version: 1.0
In-Reply-To: <90b289f4-d976-1fb7-57e2-aa02d00947d1@virtuozzo.com>
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

11.04.2018 16:05, Vladimir Sementsov-Ogievskiy wrote:
> 11.04.2018 12:36, Vladimir Sementsov-Ogievskiy wrote:
>> 11.04.2018 12:02, Vladimir Sementsov-Ogievskiy wrote:
>>> 03.04.2018 23:13, John Snow wrote:
>>>>
>>>> On 04/03/2018 12:23 PM, Max Reitz wrote:
>>>>> On 2018-03-30 18:10, Vladimir Sementsov-Ogievskiy wrote:
>>>>>> Use MIGRATION events instead of RESUME. Also, make a TODO: enable
>>>>>> dirty-bitmaps capability for offline case.
>>>>>>
>>>>>> This (likely) fixes racy faults at least of the following types:
>>>>>>
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 - timeout on waiting for RESUME event
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 - sha256 mismatch on 136 (138 after this pa=
tch)
>>>>>>
>>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy=20
>>>>>> <vsementsov@virtuozzo.com>
>>>>>> ---
>>>>>>
>>>>>> This patch is a true change for the test anyway. But I don't=20
>>>>>> understand,
>>>>>> why (and do really) it fixes the things. And I'm not sure about=20
>>>>>> do we
>>>>>> really have a bug in bitmap migration or persistence. So, it's up=20
>>>>>> to you,
>>>>>> take it into 2.12...
>>>>>>
>>>>>> It was already discussed, that "STOP" event is bad for tests.=20
>>>>>> What about
>>>>>> "RESUME"? How can we miss it? And sha256 mismatch is really=20
>>>>>> something
>>>>>> strange.
>>>>>>
>>>>>> Max, please check, do it fix 169 for you.
>>>>>>
>>>>>> =C2=A0 tests/qemu-iotests/169 | 44=20
>>>>>> +++++++++++++++++++++++---------------------
>>>>>> =C2=A0 1 file changed, 23 insertions(+), 21 deletions(-)
>>>>> This makes the test pass (thanks!), but it still leaves behind=20
>>>>> five cats...
>>>>>
>>>>> Max
>>>>>
>>>>>
>>>> Hmm:
>>>>
>>>> jhuston=C2=A0 14772=C2=A0 0.0=C2=A0 0.0=C2=A0=C2=A0 4296=C2=A0=C2=A0 7=
84 pts/3=C2=A0=C2=A0=C2=A0 S=C2=A0=C2=A0=C2=A0 16:12 0:00 cat
>>>> /home/bos/jhuston/src/qemu/bin/git/tests/qemu-iotests/scratch/mig_file
>>>> jhuston=C2=A0 14796=C2=A0 0.0=C2=A0 0.0=C2=A0=C2=A0 4296=C2=A0=C2=A0 7=
64 pts/3=C2=A0=C2=A0=C2=A0 S=C2=A0=C2=A0=C2=A0 16:12 0:00 cat
>>>> /home/bos/jhuston/src/qemu/bin/git/tests/qemu-iotests/scratch/mig_file
>>>> jhuston=C2=A0 14940=C2=A0 0.0=C2=A0 0.0=C2=A0=C2=A0 4296=C2=A0=C2=A0 7=
88 pts/3=C2=A0=C2=A0=C2=A0 S=C2=A0=C2=A0=C2=A0 16:12 0:00 cat
>>>> /home/bos/jhuston/src/qemu/bin/git/tests/qemu-iotests/scratch/mig_file
>>>> jhuston=C2=A0 14964=C2=A0 0.0=C2=A0 0.0=C2=A0=C2=A0 4296=C2=A0=C2=A0 7=
20 pts/3=C2=A0=C2=A0=C2=A0 S=C2=A0=C2=A0=C2=A0 16:12 0:00 cat
>>>> /home/bos/jhuston/src/qemu/bin/git/tests/qemu-iotests/scratch/mig_file
>>>> jhuston=C2=A0 15052=C2=A0 0.0=C2=A0 0.0=C2=A0=C2=A0 4296=C2=A0=C2=A0 7=
68 pts/3=C2=A0=C2=A0=C2=A0 S=C2=A0=C2=A0=C2=A0 16:12 0:00 cat
>>>> /home/bos/jhuston/src/qemu/bin/git/tests/qemu-iotests/scratch/mig_file
>>>>
>>>> Why do these get left behind? Nothing to consume the data...?
>>>
>>> aha, understand. it is due to last vm_b.shutdown() and vm_b.launch=20
>>> in case of should_migrate. So, at the end of the test I restart vm_b=20
>>> with -incoming parameter. But it looks like a bug anyway, If we=20
>>> start qemu with -incoming "exec", should not we kill cat process, if=20
>>> there were no migration?
>>>
>>
>> third type of fail, without this patch:
>>
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +ERROR: test__persistent__migbitmap__offline_shared=20
>> (__main__.TestDirtyBitmapMigration)
>> +methodcaller(name, ...) --> methodcaller object
>> +----------------------------------------------------------------------
>> +Traceback (most recent call last):
>> +=C2=A0 File "169", line 135, in do_test_migration
>> +=C2=A0=C2=A0=C2=A0 self.vm_b.launch()
>> +=C2=A0 File=20
>> "/work/src/qemu/up-169/tests/qemu-iotests/../../scripts/qemu.py",=20
>> line 221, in launch
>> +=C2=A0=C2=A0=C2=A0 self._launch()
>> +=C2=A0 File=20
>> "/work/src/qemu/up-169/tests/qemu-iotests/../../scripts/qemu.py",=20
>> line 244, in _launch
>> +=C2=A0=C2=A0=C2=A0 self._post_launch()
>> +=C2=A0 File=20
>> "/work/src/qemu/up-169/tests/qemu-iotests/../../scripts/qtest.py",=20
>> line 100, in _post_launch
>> +=C2=A0=C2=A0=C2=A0 super(QEMUQtestMachine, self)._post_launch()
>> +=C2=A0 File=20
>> "/work/src/qemu/up-169/tests/qemu-iotests/../../scripts/qemu.py",=20
>> line 196, in _post_launch
>> +=C2=A0=C2=A0=C2=A0 self._qmp.accept()
>> +=C2=A0 File=20
>> "/work/src/qemu/up-169/tests/qemu-iotests/../../scripts/qmp/qmp.py",=20
>> line 157, in accept
>> +=C2=A0=C2=A0=C2=A0 return self.__negotiate_capabilities()
>> +=C2=A0 File=20
>> "/work/src/qemu/up-169/tests/qemu-iotests/../../scripts/qmp/qmp.py",=20
>> line 75, in __negotiate_capabilities
>> +=C2=A0=C2=A0=C2=A0 resp =3D self.cmd('qmp_capabilities')
>> +=C2=A0 File=20
>> "/work/src/qemu/up-169/tests/qemu-iotests/../../scripts/qmp/qmp.py",=20
>> line 191, in cmd
>> +=C2=A0=C2=A0=C2=A0 return self.cmd_obj(qmp_cmd)
>> +=C2=A0 File=20
>> "/work/src/qemu/up-169/tests/qemu-iotests/../../scripts/qmp/qmp.py",=20
>> line 174, in cmd_obj
>> +=C2=A0=C2=A0=C2=A0 resp =3D self.__json_read()
>> +=C2=A0 File=20
>> "/work/src/qemu/up-169/tests/qemu-iotests/../../scripts/qmp/qmp.py",=20
>> line 82, in __json_read
>> +=C2=A0=C2=A0=C2=A0 data =3D self.__sockfile.readline()
>> +=C2=A0 File "/usr/lib64/python2.7/socket.py", line 447, in readline
>> +=C2=A0=C2=A0=C2=A0 data =3D self._sock.recv(self._rbufsize)
>> +error: [Errno 104] Connection reset by peer
>> +
>>
>>
>
> Hmm, first type? I'm now not sure about, did I really see sha256=20
> mismatch, or something like this (should be error, but found bitmap):
>
> --- /work/src/qemu/up-169/tests/qemu-iotests/169.out=C2=A0=C2=A0=C2=A0 20=
18-04-11=20
> 15:35:10.055027392 +0300
> +++ /work/src/qemu/up-169/tests/qemu-iotests/169.out.bad 2018-04-11=20
> 15:58:09.300450045 +0300
> @@ -1,5 +1,20 @@
> -........
> +F.......
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +FAIL: test__not_persistent__migbitmap__offline=20
> (__main__.TestDirtyBitmapMigration)
> +methodcaller(name, ...) --> methodcaller object
> +----------------------------------------------------------------------
> +Traceback (most recent call last):
> +=C2=A0 File "169", line 136, in do_test_migration
> +=C2=A0=C2=A0=C2=A0 self.check_bitmap(self.vm_b, sha256 if persistent els=
e False)
> +=C2=A0 File "169", line 77, in check_bitmap
> +=C2=A0=C2=A0=C2=A0 "Dirty bitmap 'bitmap0' not found");
> +=C2=A0 File "/work/src/qemu/up-169/tests/qemu-iotests/iotests.py", line=
=20
> 389, in assert_qmp
> +=C2=A0=C2=A0=C2=A0 result =3D self.dictpath(d, path)
> +=C2=A0 File "/work/src/qemu/up-169/tests/qemu-iotests/iotests.py", line=
=20
> 348, in dictpath
> +=C2=A0=C2=A0=C2=A0 self.fail('failed path traversal for "%s" in "%s"' % =
(path, str(d)))
> +AssertionError: failed path traversal for "error/desc" in=20
> "{u'return': {u'sha256':=20
> u'01d2ebedcb8f549a2547dbf8e231c410e3e747a9479e98909fc936e0035cf8b1'}}"

this looks absolutely impossible. not-persistent case. Where from we get=20
the bitmap after vm stop/start?? Ohh I can imagine. It's offline case,=20
and we remember that I forget to drop -incoming for vm b, so it loads=20
same incoming migration file.. then, the question is why it don't fail=20
always.. Aha! it may be because I don't wait for RESUME.

>
>
> Max, did you really seed sha256 mismatch or only something like this?
>


--=20
Best regards,
Vladimir
