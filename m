Received: from eggs.gnu.org ([2001:4830:134:3::10]:39116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIDvY-0001n6-Fi
	for qemu-devel@nongnu.org; Mon, 14 May 2018 09:54:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIDvX-000067-Na
	for qemu-devel@nongnu.org; Mon, 14 May 2018 09:54:12 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:45852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIDvX-000060-Hp
	for qemu-devel@nongnu.org; Mon, 14 May 2018 09:54:11 -0400
Received: by mail-oi0-x242.google.com with SMTP id b130-v6so10707281oif.12
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 06:54:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180512004311.9299-15-richard.henderson@linaro.org>
References: <20180512004311.9299-1-richard.henderson@linaro.org>
	<20180512004311.9299-15-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 14:53:50 +0100
Message-ID: <CAFEAcA9hPOK5P5kD=PjzwWxw6mNNAMJqAtVdx++8GcTCV8w3FA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 14/27] target/arm: squash FZ16 behaviour
 for conversions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 12 May 2018 at 01:42, Richard Henderson <richard.henderson@linaro.org> w=
rote:
> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> The ARM ARM specifies FZ16 is suppressed for conversions. Rather than
> pushing this logic into the softfloat code we can simply save the FZ
> state and temporarily disable it for the softfloat call.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>
> ---
> v4
>   - float16_to_floatX squished the wrong softfloat bit for FZ16;
>     need to adjust input denormals in this case.
> ---
>  target/arm/helper.c | 40 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 36 insertions(+), 4 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

(once you've fixed up which fp status pointer we pass to these
helpers, then they do the right thing)

thanks
-- PMM
