Received: from eggs.gnu.org ([2001:4830:134:3::10]:42342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEHop-0005kn-57
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 11:42:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEHoo-0008Un-6Z
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 11:42:43 -0500
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:49424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eEHon-0008TQ-WE
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 11:42:42 -0500
Received: by mail-wr0-x229.google.com with SMTP id o88so14957409wrb.6
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 08:42:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87wp2u9m5k.fsf@linaro.org>
References: <20171004184325.24157-1-richard.henderson@linaro.org>
	<20171004184325.24157-4-richard.henderson@linaro.org>
	<87wp2u9m5k.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Nov 2017 16:42:20 +0000
Message-ID: <CAFEAcA-YAtS1FwTsgyEef2vWjLyDBmjypUVvdA6vA5kd7ZA8UQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v1 03/12] target/arm: Decode
 aa64 armv8.1 scalar three same extra
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 13 November 2017 at 16:30, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> Hmm are these really NEON or should they be advsimd_qrdm....?

NEON is the same thing as Advanced SIMD, as far as I know,
in the same way that TrustZone and the Security Extensions are
the same thing.

thanks
-- PMM
