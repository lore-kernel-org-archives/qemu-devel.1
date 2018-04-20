Received: from eggs.gnu.org ([2001:4830:134:3::10]:50792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9MEm-0006cg-Kr
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 22:57:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9MEj-0001cu-Im
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 22:57:24 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:46365)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9MEj-0001ci-DZ
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 22:57:21 -0400
Received: by mail-qk0-x241.google.com with SMTP id s70so7533278qks.13
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 19:57:21 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180419135901.30035-1-alex.bennee@linaro.org>
	<20180419135901.30035-32-alex.bennee@linaro.org>
	<8ccf1143-5895-ca8b-eea5-c7d96c992455@amsat.org>
	<87vacn9jd5.fsf@linaro.org>
	<CAFEAcA8u5sfzcoqGhAagoUj6cE014hdyRgdm6=LBDfE9rV+cjw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <60b519a7-f49b-95e7-b9db-3e74133cf8c0@amsat.org>
Date: Thu, 19 Apr 2018 23:57:14 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8u5sfzcoqGhAagoUj6cE014hdyRgdm6=LBDfE9rV+cjw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: "Emilio G. Cota" <cota@braap.org>, Fam Zheng <famz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, andrzej zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>, Yongbok Kim <yongbok.kim@mips.com>

On 04/19/2018 02:58 PM, Peter Maydell wrote:
> On 19 April 2018 at 18:49, Alex Bennée <alex.bennee@linaro.org> wrote:
>> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
>>> On 04/19/2018 10:58 AM, Alex Bennée wrote:
>>>> This doesn't add any additional tests but enables building the
>>>> multiarch tests for MIPS using docker cross compilers. We don't have a
>>>> cross compiler for mips64 big endian though.
>>>
>>> Oh we have one, using CFLAGS+=-EB
>>>
>>> we don't have cross libraries although.
>>
>> Yeah I thought the same with the ARM compilers (-mbig-endian) but it's
>> the libraries that let us down. If, as you say, newlib gets this right I
>> suspect we should use that to build the compilers not supported out of
>> the box by Debian.
> 
> I don't think we really want to get into the business of
> building our own cross compilers if we can avoid it...it's harder
> than it looks and we would be essentially reinventing the wheel.

I totally agree.

I'v been looking at existing maintained images we can use to
cross-build, so we only have to pull (download) and image and use it,
not wasting cpu time building it.

However some images might be huge, full of things we don't need. But I
prefer that rather than having to maintain cross toolchains.

An example I like to use is the coreboot-sdk, designed to build
i386/amd64 binaries, it fulfills our needs. But takes 2GB...

$ docker pull coreboot/coreboot-sdk:1.47
1.47: Pulling from coreboot/coreboot-sdk
3d6aedfc3e47: Downloading [>              ]  538.2kB/1.201GB
d23c9a72f1e5: Waiting

Another candidate is crossbuild, ~1GB
$ docker pull multiarch/crossbuild
