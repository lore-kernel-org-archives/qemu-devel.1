Received: from eggs.gnu.org ([2001:4830:134:3::10]:35172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1drrfc-0007Yg-QK
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 16:20:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1drrfc-0000wk-1w
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 16:20:32 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:33732)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1drrfb-0000vh-Rb
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 16:20:31 -0400
Received: by mail-wr0-x235.google.com with SMTP id a43so24968194wrc.0
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 13:20:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ac7c2fe2-be97-bea9-e7d9-4c17afd1fa1e@amsat.org>
References: <20170912162513.21694-1-richard.henderson@linaro.org>
	<20170912162513.21694-8-richard.henderson@linaro.org>
	<CAFEAcA_wFNHcHtQYpv1GyQDUF9LU95kw2RrboYB0J0LCiMZi4A@mail.gmail.com>
	<ac7c2fe2-be97-bea9-e7d9-4c17afd1fa1e@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Sep 2017 21:20:09 +0100
Message-ID: <CAFEAcA8fpVe0ASLxPLAXTHCmPwBpZDxY_TvEEKuU59wDmbLA5Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 07/16] target/arm: Align vector registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 12 September 2017 at 21:17, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
> On 09/12/2017 03:55 PM, Peter Maydell wrote:
>>
>> I notice we have a QEMU_ALIGNED() macro to wrap the __attribute__,
>> though we use it less often than not at the moment...
>
>
> Aesthetic aside, I find it useful to deal with the 80 characters style
> limit.

They do say that constraints are vital for art :-)

thanks
-- PMM
