Received: from eggs.gnu.org ([209.51.188.92]:41486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gw4DR-0003AE-Cx
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:09:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gw4DQ-00034N-Fj
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:09:37 -0500
References: <1550058881-16351-1-git-send-email-thuth@redhat.com>
	<3374c532-c885-d26e-2d34-0454943c3905@redhat.com>
	<28c77705-33c2-f10b-9dae-331bc15c9596@redhat.com>
	<20190219075333.GA4727@localhost.localdomain>
	<d7a55ce9-a83c-12fe-fd16-d45dff67630a@redhat.com>
	<20190219093716.GF4727@localhost.localdomain>
	<6d9d1a3c-7310-3134-ea5c-a03d451b8982@redhat.com>
	<20190219113840.GK4727@localhost.localdomain>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4ea52831-3f8d-75aa-ea17-53614dc96594@redhat.com>
Date: Tue, 19 Feb 2019 13:09:13 +0100
MIME-Version: 1.0
In-Reply-To: <20190219113840.GK4727@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Failing iotests in CI (was: Add a gitlab-ci file
 for Continuous Integration testing on Gitlab)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Qemu-block <qemu-block@nongnu.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, berrange@redhat.com

On 19/02/2019 12.38, Kevin Wolf wrote:
> Am 19.02.2019 um 11:11 hat Thomas Huth geschrieben:
>> On 19/02/2019 10.37, Kevin Wolf wrote:
>>> Am 19.02.2019 um 10:04 hat Thomas Huth geschrieben:
>>>> On 19/02/2019 08.53, Kevin Wolf wrote:
[...]
>> 169 got killed via abort():
>>
>> 169                [08:34:39] [08:34:46] [failed, exit status 1] - out=
put mismatch (see 169.out.bad)
>> --- /builds/huth/qemu/tests/qemu-iotests/169.out	2019-02-19 08:23:54.0=
00000000 +0000
>> +++ /builds/huth/qemu/tests/qemu-iotests/169.out.bad	2019-02-19 08:34:=
46.000000000 +0000
>> @@ -1,5 +1,29 @@
>> -....................
>> +WARNING:qemu:qemu received signal 6: /builds/huth/qemu/tests/qemu-iot=
ests/../../x86_64-softmmu/qemu-system-x86_64 -chardev socket,id=3Dmon,pat=
h=3D/tmp/qemu-iotests-quick-25045/tmpGQOExQ/qemua-13044-monitor.sock -mon=
 chardev=3Dmon,mode=3Dcontrol -display none -vga none -qtest unix:path=3D=
/tmp/qemu-iotests-quick-25045/qemua-13044-qtest.sock -machine accel=3Dqte=
st -nodefaults -machine accel=3Dqtest -drive if=3Dvirtio,id=3Ddrive0,file=
=3D/tmp/qemu-iotests-quick-25045/disk_a,format=3Dqcow2,cache=3Dwriteback
>> [...]
>>
>> No clue why.
>=20
> In order to debug failures like this, I usually enable core dumps.

It's only failing for me on the gitlab-CI system. I don't think that
I've got the possibility to grab coredumps there...

>> 232 is also strange, no idea what is going on here:
>>
>> 232                [08:38:53] [08:38:56] - output mismatch (see 232.ou=
t.bad)
>> --- /builds/huth/qemu/tests/qemu-iotests/232.out	2019-02-19 08:23:54.0=
00000000 +0000
>> +++ /builds/huth/qemu/tests/qemu-iotests/232.out.bad	2019-02-19 08:38:=
56.000000000 +0000
>> @@ -21,13 +21,13 @@
>>  NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
>>  NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
>> =20
>> -QEMU_PROG: -drive driver=3Dfile,file=3DTEST_DIR/t.IMGFMT,if=3Dnone,re=
ad-only=3Doff,auto-read-only=3Doff: Could not open 'TEST_DIR/t.IMGFMT': P=
ermission denied
>> -NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
>> -NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
>> -
>> -QEMU_PROG: -drive driver=3Dfile,file=3DTEST_DIR/t.IMGFMT,if=3Dnone,au=
to-read-only=3Doff: Could not open 'TEST_DIR/t.IMGFMT': Permission denied
>> -NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
>> -NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
>> +NODE_NAME: TEST_DIR/t.IMGFMT (file)
>> +NODE_NAME: TEST_DIR/t.IMGFMT (file)
>> +NODE_NAME: TEST_DIR/t.IMGFMT (file)
>> +
>> +NODE_NAME: TEST_DIR/t.IMGFMT (file)
>> +NODE_NAME: TEST_DIR/t.IMGFMT (file)
>> +NODE_NAME: TEST_DIR/t.IMGFMT (file)
>=20
> Do you run the tests as root? This messes with any tests that try to
> test read-only cases because root can write to everything, no matter
> what the permissions say.

I don't know whether gitlab runs the CI pipelines as root, but I doubt
it. Looking at the shell "prompts" that they show inbetween ("$") it
looks like they are running the CI tests as a normal user, though.

>>>> By the way, 235 and 238 also fail on my normal laptop with RHEL7:
>>>> [...]
>>>> Any ideas what might be going on here?
>>>
>>> I think it's most likely that QEMU just prints an error message on
>>> startup and exits.
>> Right, I finally found the issue:
>>
>> qemu-system-x86_64: -machine accel=3Dkvm: No accelerator found
>>
>> I apparently compiled my QEMU with --disable-kvm at one point in time =
and
>> forgot to enable it later again. =3D=3D> These tests should really che=
ck whether
>> KVM is available in QEMU before they blindly use this feature.
>=20
> Ideally, they shouldn't use it at all.

235 seems to use KVM on purpose according to the commit description...?

But maybe we can change it to "-M accel=3Dkvm:qtest" somehow ... though
this currently seems to hang the test, as far as I can see... Maybe
"accel=3Dkvm:tcg", so that it works at least without kvm?

According to Stefan, 238 does not need KVM at all (see his patch that he
just sent).

 Thomas
