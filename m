Received: from eggs.gnu.org ([209.51.188.92]:35593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFkzd-0002oI-Hm
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 15:40:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFkzZ-0004Ew-KQ
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 15:40:45 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:36820)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hFkzW-0004Cr-BL
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 15:40:39 -0400
Received: by mail-pg1-x52d.google.com with SMTP id 85so7535174pgc.3
	for <qemu-devel@nongnu.org>; Sun, 14 Apr 2019 12:40:36 -0700 (PDT)
References: <20190411153942.4533-1-peter.maydell@linaro.org>
	<53930e87-3bb1-fdd5-a8fe-8603c0adecc2@linaro.org>
	<CAFEAcA-dbGvhgTrBKEtx-CPS7f2NJO5X+dj=mdcm+NrkF=uynQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0ee4fdc6-c782-d5f5-ec40-9e25c1c9dd1f@linaro.org>
Date: Sun, 14 Apr 2019 09:40:30 -1000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-dbGvhgTrBKEtx-CPS7f2NJO5X+dj=mdcm+NrkF=uynQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/arm: Implement NSACR gating of
 floating point
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 4/14/19 8:02 AM, Peter Maydell wrote:
> There's similar wording for the effect of NSACR on CPACR, so
> again I think we need to actually make the bits RAZ/WI
> regardless of their underlying value, not just force them
> to 0.

I don't see that language for CPACR, just "the corresponding bits in the CPACR
ignore writes and read as 0b00".  I'm willing to believe the manual is sloppy
on this point though, and the "correct" language appears only once, somewhere.

You might want to something akin to arm_hcr_el2_eff so that you don't have to
replicate the NSACR logic in too many places...


r~
