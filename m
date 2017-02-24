Received: from eggs.gnu.org ([2001:4830:134:3::10]:54989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chJEP-0004Jo-Et
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:00:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chJEO-0001QX-NY
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:00:33 -0500
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:32843)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1chJEO-0001Pz-Fn
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:00:32 -0500
Received: by mail-wr0-x235.google.com with SMTP id u47so17028650wrb.0
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 09:00:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87r32nleue.fsf@linaro.org>
References: <1487262963-11519-1-git-send-email-peter.maydell@linaro.org>
	<CAFEAcA-MMw0_ombzTD+kQYpeNKywtcKY2UczcpR-hFDwGZhZJw@mail.gmail.com>
	<87wpcflmmb.fsf@linaro.org>
	<CAFEAcA-OhSMFKgRYsCWUrb6OBxxrWokkkpJyioveEur-p4-g2A@mail.gmail.com>
	<87shn3lkj3.fsf@linaro.org>
	<CAFEAcA-e5s6Tru_Kfba9hQHL827r2N5jyBvbpwbro7fHX2m1KA@mail.gmail.com>
	<87r32nleue.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Feb 2017 17:00:10 +0000
Message-ID: <CAFEAcA_nwfvS-WnZW1WuqGT7cv8Mm16o8CwM2N=XB1MWePkqbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 00/13] Rewrite NVIC to not
 depend on the GIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 24 February 2017 at 16:43, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> On 24 February 2017 at 14:40, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>> Could be. I use arm-linux-gnueabihf-gcc to build. If you use
>> PRIx32 does it build OK?
>
> Well the problem is the non-eabi compilers don't have PRIx32 defined for
> you. You have to specify yourself.

Oh, right. Or we could just cast these things to unsigned int ;-)

Other than the tests being a bit ropy, are you happy with the
patches proper?

thanks
-- PMM
