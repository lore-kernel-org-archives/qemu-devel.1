Received: from eggs.gnu.org ([2001:4830:134:3::10]:33664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dkkg1-0001eR-DN
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 01:27:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dkkfy-0006Yr-7q
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 01:27:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dkkfx-0006YY-V2
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 01:27:30 -0400
References: <20170816082650.21880-1-cohuck@redhat.com>
	<223c4e3c-097f-5a91-37fa-df4bfb427d60@redhat.com>
	<CAFEAcA_UfM_XNKdc5zfHsehoRE6Q+EszRZX3FByskir7c+0Lww@mail.gmail.com>
	<20170822010917.GO12356@umbus.fritz.box>
	<CAFEAcA8wbRjjJYtk-65NJEsu-ELVdKgtwreipabSaMtLTfS--Q@mail.gmail.com>
	<3f0dc918-0f55-e2f4-bf47-fe4abf5453bb@redhat.com>
	<CAFEAcA_ezKWweEuUB-cXTer0LLaeuiGDkSdfhApedhw4ykDT0Q@mail.gmail.com>
	<20170822112046.GC12356@umbus.fritz.box>
	<20170822134815.77020eb8.cohuck@redhat.com>
	<20170823002907.GC5379@umbus.fritz.box>
	<20170823091650.48e7c44e.cohuck@redhat.com>
	<54526d47-b436-79d5-7a38-9516eaa727a6@redhat.com>
	<5b0ff74a-08d6-558d-4c79-a93758e6302a@redhat.com>
	<0bb344a3-f8f8-3365-cef1-1c68cf7d160d@redhat.com>
	<20170823142047.366068f7.cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <897a578e-2375-b892-10af-879b8cc6136b@redhat.com>
Date: Thu, 24 Aug 2017 07:27:18 +0200
MIME-Version: 1.0
In-Reply-To: <20170823142047.366068f7.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] make check speed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <mlureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Cam Macdonell <cam@cs.ualberta.ca>

On 23.08.2017 14:20, Cornelia Huck wrote:
> On Wed, 23 Aug 2017 10:35:43 +0200
> Thomas Huth <thuth@redhat.com> wrote:
>=20
>> True. And I just learned that you can also already set the SPEED
>> variable to either "quick" or "slow" and that we're already using
>> g_test_quick() and g_test_slow() in a couple of places to check this. =
So
>> the framework for running quick vs. thorough tests is already there ..=
.
>> we just might want to add this to some more tests, I guess...
>>
>> Question for the maintainers and the test automation folks: Is anybody
>> already running "make check SPEED=3Dslow" or is this just rather an
>> unheard-of way of running the tests?
>=20
> So I tried this on master just for fun, and 'make V=3D1 SPEED=3Dslow
> check-qtest-x86_64' promptly failed for some ivshmem test.
>=20
> On x86_86:
> TEST: tests/ivshmem-test... (pid=3D3672)
>   /x86_64/ivshmem/single:                                              =
OK
>   /x86_64/ivshmem/hotplug:                                             =
OK
>   /x86_64/ivshmem/memdev:                                              =
OK
>   /x86_64/ivshmem/pair:                                                =
OK
>   /x86_64/ivshmem/server-msi:                                          =
**
> ERROR:/home/cohuck/git/qemu/tests/ivshmem-test.c:367:test_ivshmem_serve=
r: assertion failed (ret =3D=3D 0): (1 =3D=3D 0)
> FAIL
> GTester: last random seed: R02Scde8fd6835fdf17450c73e2f74f25007
> (pid=3D3697)
>  /x86_64/ivshmem/server-irq:                                          O=
K
> FAIL: tests/ivshmem-test
>=20
> On s390x:
> TEST: tests/ivshmem-test... (pid=3D63617)
>   /x86_64/ivshmem/single:                                              =
OK
>   /x86_64/ivshmem/hotplug:                                             =
OK
>   /x86_64/ivshmem/memdev:                                              =
OK
>   /x86_64/ivshmem/pair:                                                =
OK
>   /x86_64/ivshmem/server-msi:                                          =
qemu-system-x86_64: -device ivshmem-doorbell,chardev=3Dchr0,vectors=3D2: =
server sent invalid ID message
> Broken pipe
> FAIL
> GTester: last random seed: R02Sda000f7be5ce27b3dfbb03d12f297b69
> (pid=3D63640)
>   /x86_64/ivshmem/server-irq:                                          =
qemu-system-x86_64: -device ivshmem,size=3D1M,msi=3Doff,chardev=3Dchr0,ve=
ctors=3D2: server sent invalid ID message
> Broken pipe
> FAIL
> GTester: last random seed: R02S5a236dbcac35545cc34c0131fbc06162
> (pid=3D63648)
> FAIL: tests/ivshmem-test
>=20
> Both machines are on Fedora 26.

The ivshmem test fails for me with SPEED=3Dslow, too (on a x86 RHEL7
machine). Looks like it is definitely broken. Could anybody with some
ivshmem knowledge please have a look at this?

 Thanks,
  Thomas
