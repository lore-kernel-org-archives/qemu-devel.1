Received: from eggs.gnu.org ([2001:4830:134:3::10]:59140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1chJV1-0001tj-8D
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:17:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1chJUx-0000ys-Th
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:17:43 -0500
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:34272)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1chJUx-0000yM-LW
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:17:39 -0500
Received: by mail-wr0-x22c.google.com with SMTP id o22so11754569wro.1
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 09:17:39 -0800 (PST)
References: <1487262963-11519-1-git-send-email-peter.maydell@linaro.org>
	<CAFEAcA-MMw0_ombzTD+kQYpeNKywtcKY2UczcpR-hFDwGZhZJw@mail.gmail.com>
	<87wpcflmmb.fsf@linaro.org>
	<CAFEAcA-OhSMFKgRYsCWUrb6OBxxrWokkkpJyioveEur-p4-g2A@mail.gmail.com>
	<87shn3lkj3.fsf@linaro.org>
	<CAFEAcA-e5s6Tru_Kfba9hQHL827r2N5jyBvbpwbro7fHX2m1KA@mail.gmail.com>
	<87r32nleue.fsf@linaro.org>
	<CAFEAcA_nwfvS-WnZW1WuqGT7cv8Mm16o8CwM2N=XB1MWePkqbA@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA_nwfvS-WnZW1WuqGT7cv8Mm16o8CwM2N=XB1MWePkqbA@mail.gmail.com>
Date: Fri, 24 Feb 2017 17:17:36 +0000
Message-ID: <87k28fld8v.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 24 February 2017 at 16:43, Alex Bennée <alex.bennee@linaro.org> wrote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>>> On 24 February 2017 at 14:40, Alex Bennée <alex.bennee@linaro.org> wrote:
>>> Could be. I use arm-linux-gnueabihf-gcc to build. If you use
>>> PRIx32 does it build OK?
>>
>> Well the problem is the non-eabi compilers don't have PRIx32 defined for
>> you. You have to specify yourself.
>
> Oh, right. Or we could just cast these things to unsigned int ;-)
>
> Other than the tests being a bit ropy, are you happy with the
> patches proper?

Yes, I've just looked through the last few and they look good to me.

>
> thanks
> -- PMM


--
Alex Bennée
