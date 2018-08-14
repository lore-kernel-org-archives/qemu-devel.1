Received: from eggs.gnu.org ([2001:4830:134:3::10]:36765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fpd8w-0000yp-S7
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:30:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fpd8b-0001GP-7O
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:30:06 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:34683)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fpd8a-0001Ey-UQ
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:29:45 -0400
Received: by mail-wm0-x244.google.com with SMTP id l2-v6so11033416wme.1
	for <qemu-devel@nongnu.org>; Tue, 14 Aug 2018 10:29:44 -0700 (PDT)
References: <20180814002653.12828-1-richard.henderson@linaro.org>
	<87bma5wdoz.fsf@linaro.org>
	<b926d1a2-0973-ee44-5a7d-3e19cb9482ac@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <b926d1a2-0973-ee44-5a7d-3e19cb9482ac@linaro.org>
Date: Tue, 14 Aug 2018 16:38:17 +0100
Message-ID: <87bma5ez6e.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/4] target/arm: Fix int64_to_float16
 double-rounding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, laurent.desnogues@gmail.com, peter.maydell@linaro.org


Richard Henderson <richard.henderson@linaro.org> writes:

> On 08/14/2018 01:32 AM, Alex Benn=C3=A9e wrote:
>> Can't we add the constants to the fcvt test case?
>
> No, they're all half-to-integer.  This is integer-to-half.

I'll add the int-to-float conversions, the whole thing could do with a
bit of a re-factor anyway.

>
> We could write another one, I suppose, but it's not just
> an add-one-line kind of thing.
>
>
> r~


--
Alex Benn=C3=A9e
