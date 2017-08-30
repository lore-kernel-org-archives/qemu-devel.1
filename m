Received: from eggs.gnu.org ([2001:4830:134:3::10]:34403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dn3UW-0001fe-6w
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:57:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dn3UT-0005zj-KU
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:57:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37098)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dn3UT-0005zW-Dx
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:57:09 -0400
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
From: Thomas Huth <thuth@redhat.com>
Message-ID: <529cf0d6-8949-18b5-115a-4419626878e5@redhat.com>
Date: Wed, 30 Aug 2017 15:56:58 +0200
MIME-Version: 1.0
In-Reply-To: <87ziahgtn5.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] make check speed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Cam Macdonell <cam@cs.ualberta.ca>, Fam Zheng <famz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <mlureau@redhat.com>, Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

On 30.08.2017 13:52, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
[...]
>> This also fails on a big endian ppc64 host machine:
>>
>> $ uname -m
>> ppc64
>> $ V=1 QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64 tests/ivshmem-test -m slow
>> /x86_64/ivshmem/single: OK
>> /x86_64/ivshmem/hotplug: OK
>> /x86_64/ivshmem/memdev: OK
>> /x86_64/ivshmem/pair: OK
>> /x86_64/ivshmem/server-msi: qemu-system-x86_64: -device ivshmem-doorbell,chardev=chr0,vectors=2: server sent invalid ID message
>> Broken pipe
> 
> Botched endian conversion?

Yes, it's an endianess problem. I just sent a patch, title
"hw/misc/ivshmem: Fix ivshmem_recv_msg() to also work on big endian
systems" (forgot to put you on CC:, sorry!).

 Thomas
