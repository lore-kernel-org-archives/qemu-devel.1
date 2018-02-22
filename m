Received: from eggs.gnu.org ([2001:4830:134:3::10]:58243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eoub9-00040B-SX
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 12:24:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eoub7-0001Hb-7c
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 12:23:59 -0500
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:34277)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eoub7-0001Fq-06
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 12:23:57 -0500
Received: by mail-wm0-x22a.google.com with SMTP id a20so3385204wmd.1
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 09:23:56 -0800 (PST)
References: <20180208173157.24705-1-alex.bennee@linaro.org>
	<20180208173157.24705-21-alex.bennee@linaro.org>
	<d6f98bba-04ca-80f6-1fad-cfed416f4127@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <d6f98bba-04ca-80f6-1fad-cfed416f4127@linaro.org>
Date: Thu, 22 Feb 2018 17:23:54 +0000
Message-ID: <87h8q99bv9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 20/32] arm/translate-a64: add FP16 FCMxx
 (zero) to simd_two_reg_misc_fp16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> On 02/08/2018 09:31 AM, Alex Benn=C3=A9e wrote:
>> +            maxpasses =3D hp ? (is_q ? 8 : 4) : (is_q ? 4 : 2);
>
>   (8 << is_q) >> size
>
> ?

Hmm I'm not so sure about this. While mine is longer form at least the
intent is clear. What about:

    maxpasses =3D (is_q ? 4 : 2) << hp

It's still a little magical IMHO though...

--
Alex Benn=C3=A9e
