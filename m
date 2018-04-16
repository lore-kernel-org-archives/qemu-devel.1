Received: from eggs.gnu.org ([2001:4830:134:3::10]:36417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f80AY-0001hv-AO
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 05:11:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f80AX-0001OJ-EP
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 05:11:26 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:32958)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f80AX-0001Np-7i
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 05:11:25 -0400
Received: by mail-ot0-x241.google.com with SMTP id g23-v6so1422615oti.0
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 02:11:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180413140334.26622-1-alex.bennee@linaro.org>
References: <20180413140334.26622-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Apr 2018 10:11:03 +0100
Message-ID: <CAFEAcA-PZCroM7MA_UYiSrLs6XTC4O507DbhJTQLUcJF7+on4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/2] Softfloat Fixes for 2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 13 April 2018 at 15:03, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> Hi,
>
> The float_invalid patch now handles the Inf case as well and includes
> the fix to round_to_uint_and_pack.
>
> Alex Benn=C3=A9e (1):
>   fpu/softfloat: raise float_invalid for NaN/Inf in
>     round_to_int_and_pack
>
> Emilio G. Cota (1):
>   softfloat: fix {min,max}nummag for same-abs-value inputs
>
>  fpu/softfloat.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)

Applied to master for 2.12, thanks.

-- PMM
