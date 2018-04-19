Received: from eggs.gnu.org ([2001:4830:134:3::10]:49279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f9Dq5-0003z3-Lj
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 13:59:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f9Dq4-0006VR-Ud
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 13:59:21 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:39707)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f9Dq4-0006Uv-No
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 13:59:20 -0400
Received: by mail-ot0-x244.google.com with SMTP id a14-v6so6810875otf.6
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 10:59:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87vacn9jd5.fsf@linaro.org>
References: <20180419135901.30035-1-alex.bennee@linaro.org>
	<20180419135901.30035-32-alex.bennee@linaro.org>
	<8ccf1143-5895-ca8b-eea5-c7d96c992455@amsat.org>
	<87vacn9jd5.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Apr 2018 18:58:58 +0100
Message-ID: <CAFEAcA8u5sfzcoqGhAagoUj6cE014hdyRgdm6=LBDfE9rV+cjw@mail.gmail.com>
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
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, "Emilio G. Cota" <cota@braap.org>, Fam Zheng <famz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, andrzej zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>, Yongbok Kim <yongbok.kim@mips.com>

On 19 April 2018 at 18:49, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>
> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>
>> On 04/19/2018 10:58 AM, Alex Benn=C3=A9e wrote:
>>> This doesn't add any additional tests but enables building the
>>> multiarch tests for MIPS using docker cross compilers. We don't have a
>>> cross compiler for mips64 big endian though.
>>
>> Oh we have one, using CFLAGS+=3D-EB
>>
>> we don't have cross libraries although.
>
> Yeah I thought the same with the ARM compilers (-mbig-endian) but it's
> the libraries that let us down. If, as you say, newlib gets this right I
> suspect we should use that to build the compilers not supported out of
> the box by Debian.

I don't think we really want to get into the business of
building our own cross compilers if we can avoid it...it's harder
than it looks and we would be essentially reinventing the wheel.

thanks
-- PMM
