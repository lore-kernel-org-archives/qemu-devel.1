Received: from eggs.gnu.org ([209.51.188.92]:59463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hLm6R-0000lU-SG
	for qemu-devel@nongnu.org; Wed, 01 May 2019 06:04:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hLm6N-0002tf-Pn
	for qemu-devel@nongnu.org; Wed, 01 May 2019 06:04:39 -0400
References: <155650963851.10667.10736189532511840020@c2072b67cc0c>
	<ec0fad50-140c-0bf4-3421-d4e3d2d12dea@redhat.com>
	<87a7g67f0q.fsf@zen.linaroharston>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ef32496a-c449-bf2a-0ccf-3eef9e875f07@redhat.com>
Date: Wed, 1 May 2019 12:04:18 +0200
MIME-Version: 1.0
In-Reply-To: <87a7g67f0q.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/8] tests/qemu-iotests: Run basic
 iotests during "make check"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, fam@euphon.net, kwolf@redhat.com, emaste@freebsd.org, qemu-block@nongnu.org, philmd@redhat.com, armbru@redhat.com, cfergeau@redhat.com, mreitz@redhat.com, wainersm@redhat.com, lwhsu@freebsd.org

On 01/05/2019 10.30, Alex Benn=C3=A9e wrote:
>=20
> Thomas Huth <thuth@redhat.com> writes:
>=20
>> On 29/04/2019 05.47, no-reply@patchew.org wrote:
>>> Patchew URL: https://patchew.org/QEMU/20190428155451.15653-1-thuth@re=
dhat.com/
>>>
>>> This series failed the asan build test. Please find the testing comma=
nds and
>>> their output below. If you have Docker installed, you can probably re=
produce it
>>> locally.
>>>
>>> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
>>> #!/bin/bash
>>> time make docker-test-debug@fedora TARGET_LIST=3Dx86_64-softmmu J=3D1=
4 NETWORK=3D1
>>> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>>>
>>> The full log is available at
>>> http://patchew.org/logs/20190428155451.15653-1-thuth@redhat.com/testi=
ng.asan/?type=3Dmessage.
>>
>> The asan test failed since it could not check out the repository ...
>> a networking problem?
>>
>> Anyway, looks like there was a real bug here:
>>
>>  https://patchew.org/logs/20190428155451.15653-1-thuth@redhat.com/test=
ing.docker-clang@ubuntu/?type=3Dmessage
>>
>> Test 162 failed with:
>>
>> 162         - output mismatch (see 162.out.bad)
>> --- /tmp/qemu-test/src/tests/qemu-iotests/162.out	2019-04-28 16:09:31.=
000000000 +0000
>> +++ /tmp/qemu-test/build/tests/qemu-iotests/162.out.bad	2019-04-28 16:=
24:21.669646149 +0000
>> @@ -6,7 +6,9 @@
>>  image: nbd+unix://?socket=3D42
>>
>>  =3D=3D=3D SSH =3D=3D=3D
>> +qemu-img: warning: GLib: getpwuid_r(): failed due to unknown user id =
(1003)
>>  qemu-img: Could not open 'json:{"driver": "ssh", "host": "localhost",=
 "port": "0", "path": "/foo"}': Failed to connect socket: Connection refu=
sed
>> +qemu-img: warning: GLib: getpwuid_r(): failed due to unknown user id =
(1003)
>>  qemu-img: Could not open 'driver=3Dssh,host=3Dlocalhost,port=3D0,path=
=3D/foo': Failed to connect socket: Connection refused
>>  qemu-img: Could not open 'json:{"driver": "ssh", "host": "localhost",=
 "port": 0.42, "path": "/foo"}': Parameter 'port' expects a number
>>  qemu-img: Could not open 'driver=3Dssh,host=3Dlocalhost,port=3D0.42,p=
ath=3D/foo': Parameter 'port' expects a number
>>
>> ... I think I'll remove 162 from the "auto" group to avoid this.
>=20
> Should I wait for a v3 then?

Yes, I've got to respin anyway since there is a conflict with the new
iotest 249.

 Thomas
