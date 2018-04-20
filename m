Received: from eggs.gnu.org ([2001:4830:134:3::10]:46058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9SMG-0002RO-OV
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 05:29:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9SMC-0007QZ-NC
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 05:29:32 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:39110)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f9SMC-0007PT-Fg
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 05:29:28 -0400
Received: by mail-wr0-x241.google.com with SMTP id q3-v6so11133108wrj.6
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 02:29:28 -0700 (PDT)
References: <20180419135901.30035-1-alex.bennee@linaro.org>
	<20180419135901.30035-32-alex.bennee@linaro.org>
	<8ccf1143-5895-ca8b-eea5-c7d96c992455@amsat.org>
	<87vacn9jd5.fsf@linaro.org>
	<CAFEAcA8u5sfzcoqGhAagoUj6cE014hdyRgdm6=LBDfE9rV+cjw@mail.gmail.com>
	<60b519a7-f49b-95e7-b9db-3e74133cf8c0@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <60b519a7-f49b-95e7-b9db-3e74133cf8c0@amsat.org>
Date: Fri, 20 Apr 2018 10:29:25 +0100
Message-ID: <87muxy9qfe.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 31/43] tests/tcg: enable building for
 MIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Emilio G. Cota" <cota@braap.org>, Fam Zheng <famz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, andrzej zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>, Yongbok Kim <yongbok.kim@mips.com>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 04/19/2018 02:58 PM, Peter Maydell wrote:
>> On 19 April 2018 at 18:49, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>>> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>>>> On 04/19/2018 10:58 AM, Alex Benn=C3=A9e wrote:
>>>>> This doesn't add any additional tests but enables building the
>>>>> multiarch tests for MIPS using docker cross compilers. We don't have a
>>>>> cross compiler for mips64 big endian though.
>>>>
>>>> Oh we have one, using CFLAGS+=3D-EB
>>>>
>>>> we don't have cross libraries although.
>>>
>>> Yeah I thought the same with the ARM compilers (-mbig-endian) but it's
>>> the libraries that let us down. If, as you say, newlib gets this right I
>>> suspect we should use that to build the compilers not supported out of
>>> the box by Debian.
>>
>> I don't think we really want to get into the business of
>> building our own cross compilers if we can avoid it...it's harder
>> than it looks and we would be essentially reinventing the wheel.
>
> I totally agree.
>
> I'v been looking at existing maintained images we can use to
> cross-build, so we only have to pull (download) and image and use it,
> not wasting cpu time building it.
>
> However some images might be huge, full of things we don't need. But I
> prefer that rather than having to maintain cross toolchains.
>
> An example I like to use is the coreboot-sdk, designed to build
> i386/amd64 binaries, it fulfills our needs. But takes 2GB...
>
> $ docker pull coreboot/coreboot-sdk:1.47
> 1.47: Pulling from coreboot/coreboot-sdk
> 3d6aedfc3e47: Downloading [>              ]  538.2kB/1.201GB
> d23c9a72f1e5: Waiting

Found the dockerfile:

https://github.com/MattDevo/coreboot/blob/master/util/docker/coreboot-sdk/D=
ockerfile

>
> Another candidate is crossbuild, ~1GB
> $ docker pull multiarch/crossbuild

This looks like it is just a multiarch debian setup much like our own.

--
Alex Benn=C3=A9e
