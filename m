Received: from eggs.gnu.org ([2001:4830:134:3::10]:39762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f9Tmo-0003yw-8n
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 07:01:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f9Tmn-0000Tp-Ds
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 07:01:02 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:35408)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f9Tmn-0000TW-9V
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 07:01:01 -0400
Received: by mail-oi0-x244.google.com with SMTP id c15-v6so7662590oic.2
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 04:01:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <60b519a7-f49b-95e7-b9db-3e74133cf8c0@amsat.org>
References: <20180419135901.30035-1-alex.bennee@linaro.org>
	<20180419135901.30035-32-alex.bennee@linaro.org>
	<8ccf1143-5895-ca8b-eea5-c7d96c992455@amsat.org>
	<87vacn9jd5.fsf@linaro.org>
	<CAFEAcA8u5sfzcoqGhAagoUj6cE014hdyRgdm6=LBDfE9rV+cjw@mail.gmail.com>
	<60b519a7-f49b-95e7-b9db-3e74133cf8c0@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Apr 2018 12:00:38 +0100
Message-ID: <CAFEAcA_O_ihi0wp_J08nBuz=sFVLOZcbR31gHDgajWyda-24Cg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Emilio G. Cota" <cota@braap.org>, Fam Zheng <famz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, andrzej zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>, Yongbok Kim <yongbok.kim@mips.com>

On 20 April 2018 at 03:57, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wr=
ote:
> On 04/19/2018 02:58 PM, Peter Maydell wrote:
>> I don't think we really want to get into the business of
>> building our own cross compilers if we can avoid it...it's harder
>> than it looks and we would be essentially reinventing the wheel.
>
> I totally agree.
>
> I'v been looking at existing maintained images we can use to
> cross-build, so we only have to pull (download) and image and use it,
> not wasting cpu time building it.

Projects that are in the "maintain cross toolchains" business:
 * buildroot
 * https://github.com/richfelker/musl-cross-make

But really my feeling is that we should for the moment stick
to getting a reliable test setup for the architectures that
Debian does provide cross toolchains for. That will give us:
 * much more coverage than we have at the moment
 * coverage for the guests that people actually care about

We can always come back and think about filling in the gaps later.

thanks
-- PMM
