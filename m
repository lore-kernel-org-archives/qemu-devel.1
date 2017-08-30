Received: from eggs.gnu.org ([2001:4830:134:3::10]:42859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dn3q7-0003ZM-9k
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 10:19:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dn3q3-0005bY-5H
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 10:19:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dn3q2-0005bK-SN
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 10:19:27 -0400
From: Markus Armbruster <armbru@redhat.com>
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
	<897a578e-2375-b892-10af-879b8cc6136b@redhat.com>
	<20170830105901.6c1632ef.cohuck@redhat.com>
	<1020ea13-1f4d-4679-61d4-98c21dca0bb5@redhat.com>
	<87ziahgtn5.fsf@dusky.pond.sub.org>
	<529cf0d6-8949-18b5-115a-4419626878e5@redhat.com>
Date: Wed, 30 Aug 2017 16:19:07 +0200
In-Reply-To: <529cf0d6-8949-18b5-115a-4419626878e5@redhat.com> (Thomas Huth's
	message of "Wed, 30 Aug 2017 15:56:58 +0200")
Message-ID: <87k21lkujo.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] make check speed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, "Michael S.
	Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>, Cleber Rosa <crosa@redhat.com>, =?utf-8?B?THVr?= =?utf-8?B?w6HFoQ==?= Doktor <ldoktor@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Cam Macdonell <cam@cs.ualberta.ca>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

Thomas Huth <thuth@redhat.com> writes:

> On 30.08.2017 13:52, Markus Armbruster wrote:
>> Thomas Huth <thuth@redhat.com> writes:
> [...]
>>> This also fails on a big endian ppc64 host machine:
>>>
>>> $ uname -m
>>> ppc64
>>> $ V=1 QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64 tests/ivshmem-test -m slow
>>> /x86_64/ivshmem/single: OK
>>> /x86_64/ivshmem/hotplug: OK
>>> /x86_64/ivshmem/memdev: OK
>>> /x86_64/ivshmem/pair: OK
>>> /x86_64/ivshmem/server-msi: qemu-system-x86_64: -device ivshmem-doorbell,chardev=chr0,vectors=2: server sent invalid ID message
>>> Broken pipe
>> 
>> Botched endian conversion?
>
> Yes, it's an endianess problem. I just sent a patch, title
> "hw/misc/ivshmem: Fix ivshmem_recv_msg() to also work on big endian
> systems" (forgot to put you on CC:, sorry!).

No need to be sorry!  Because I always feel sorry when I have to review
another ivshmem patch ;-}
