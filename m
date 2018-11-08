Received: from eggs.gnu.org ([2001:4830:134:3::10]:60452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gKo90-0003is-Rq
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:31:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gKo8x-0002cz-MJ
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:31:00 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gKo8x-0002As-AB
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:30:59 -0500
Received: by mail-wr1-x443.google.com with SMTP id j17-v6so17007704wrq.11
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 09:30:40 -0800 (PST)
References: <20181108163329.19940-1-alex.bennee@linaro.org>
	<20181108163329.19940-2-alex.bennee@linaro.org>
	<3027e46a-42b2-4c5c-eaec-ce9caa64ecc0@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <3027e46a-42b2-4c5c-eaec-ce9caa64ecc0@linaro.org>
Date: Thu, 08 Nov 2018 17:30:37 +0000
Message-ID: <87o9az5veq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/6] target/arm64: properly handle DBGVR
 RESS bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, qemu-arm@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> On 11/8/18 5:33 PM, Alex Benn=C3=A9e wrote:
>> -        .bvr =3D addr
>> +        .bvr =3D sextract64(addr, 52, 53)
>
> I think you meant sextract64(addr, 0, 53).
> What you wrote *should* have asserted, since 52+53 > 64.

Dam, I did fix that. I must have failed to propagate the fix from where
I was hacking :-/

>
>
> r~


--
Alex Benn=C3=A9e
