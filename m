Received: from eggs.gnu.org ([209.51.188.92]:41758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1grO8U-00007S-Gg
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 09:25:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1grO8T-00057G-Uj
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 09:25:10 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37827)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1grO8T-00056h-Nu
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 09:25:09 -0500
Received: by mail-wm1-x344.google.com with SMTP id g67so2929872wmd.2
	for <qemu-devel@nongnu.org>; Wed, 06 Feb 2019 06:25:09 -0800 (PST)
References: <20190206091043.10985-1-david@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Message-ID: <87k1idngfj.fsf@zen.linaroharston>
In-reply-to: <20190206091043.10985-1-david@redhat.com>
Date: Wed, 06 Feb 2019 14:25:06 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] softfloat: add float128_is_{normal,
 denormal}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>


David Hildenbrand <david@redhat.com> writes:

> Needed on s390x, to test for the data class of a number. So it will
> gain soon a user.
>
> A number is considered normal if the exponent is neither 0 nor all 1's.
> That can be checked by adding 1 to the exponent, and comparing against
>>=3D 2 after dropping an eventual overflow into the sign bit.
>
> While at it, convert the other floatXX_is_normal functions to use a
> similar, less error prone calculation, as suggested by Richard H.

Queued to fpu/next, thanks.

--
Alex Benn=C3=A9e
