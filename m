Received: from eggs.gnu.org ([2001:4830:134:3::10]:41995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9Ufj-0005lM-A1
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 07:57:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9Ufd-0003K5-I0
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 07:57:47 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:36622)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f9Ufd-0003Jm-B7
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 07:57:41 -0400
Received: by mail-wr0-x241.google.com with SMTP id m26-v6so4432658wrb.3
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 04:57:41 -0700 (PDT)
References: <20180419135901.30035-1-alex.bennee@linaro.org>
	<20180419135901.30035-32-alex.bennee@linaro.org>
	<8ccf1143-5895-ca8b-eea5-c7d96c992455@amsat.org>
	<87vacn9jd5.fsf@linaro.org>
	<CAFEAcA8u5sfzcoqGhAagoUj6cE014hdyRgdm6=LBDfE9rV+cjw@mail.gmail.com>
	<60b519a7-f49b-95e7-b9db-3e74133cf8c0@amsat.org>
	<CAFEAcA_O_ihi0wp_J08nBuz=sFVLOZcbR31gHDgajWyda-24Cg@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA_O_ihi0wp_J08nBuz=sFVLOZcbR31gHDgajWyda-24Cg@mail.gmail.com>
Date: Fri, 20 Apr 2018 12:57:31 +0100
Message-ID: <87lgdi9jkk.fsf@linaro.org>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, "Emilio G.
	Cota" <cota@braap.org>, Fam Zheng <famz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, andrzej zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>, Yongbok Kim <yongbok.kim@mips.com>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 20 April 2018 at 03:57, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>> On 04/19/2018 02:58 PM, Peter Maydell wrote:
>>> I don't think we really want to get into the business of
>>> building our own cross compilers if we can avoid it...it's harder
>>> than it looks and we would be essentially reinventing the wheel.
>>
>> I totally agree.
>>
>> I'v been looking at existing maintained images we can use to
>> cross-build, so we only have to pull (download) and image and use it,
>> not wasting cpu time building it.
>
> Projects that are in the "maintain cross toolchains" business:
>  * buildroot
>  * https://github.com/richfelker/musl-cross-make

I'll have a look at those. My previous attempts were using:

  https://wiki.linaro.org/ABE
  https://crosstool-ng.github.io/

I certainly don't want to be in the business of inventing yet another
set of scripts to build cross compilers!

>
> But really my feeling is that we should for the moment stick
> to getting a reliable test setup for the architectures that
> Debian does provide cross toolchains for. That will give us:
>  * much more coverage than we have at the moment
>  * coverage for the guests that people actually care about
>
> We can always come back and think about filling in the gaps later.

Don't worry - not having every single architecture done isn't going to
stop the eventual submission. However it would be nice to have at least
one non-Debian cross-compiler setup as an example and to validate the
compiler-in-docker approach.

>
> thanks
> -- PMM


--
Alex Benn=C3=A9e
