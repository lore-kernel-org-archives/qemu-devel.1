Received: from eggs.gnu.org ([2001:4830:134:3::10]:48778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6zMX-0006TD-Gb
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:07:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6zMW-0003XU-Fa
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:07:37 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:35565)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f6zMW-0003XJ-Al
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:07:36 -0400
Received: by mail-ot0-x242.google.com with SMTP id f47-v6so9988842oth.2
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 07:07:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180413140334.26622-3-alex.bennee@linaro.org>
References: <20180413140334.26622-1-alex.bennee@linaro.org>
	<20180413140334.26622-3-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Apr 2018 15:07:15 +0100
Message-ID: <CAFEAcA82rvyYRkdqj244ZguSC+XyBCv7KfDiuTVhwh2ftF59QA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/2] fpu/softfloat: raise float_invalid
 for NaN/Inf in round_to_int_and_pack
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Aurelien Jarno <aurelien@aurel32.net>

On 13 April 2018 at 15:03, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> The re-factor broke the raising of INVALID when NaN/Inf is passed to
> the float_to_int conversion functions. round_to_uint_and_pack got this
> right for NaN but also missed out the Inf handling.
>
> Fixes https://bugs.launchpad.net/qemu/+bug/1759264
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
