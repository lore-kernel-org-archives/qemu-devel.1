Received: from eggs.gnu.org ([209.51.188.92]:52547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hChB8-00044a-Hw
	for qemu-devel@nongnu.org; Sat, 06 Apr 2019 04:59:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hChB7-00072o-Jf
	for qemu-devel@nongnu.org; Sat, 06 Apr 2019 04:59:58 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:41418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hChB6-00071j-WD
	for qemu-devel@nongnu.org; Sat, 06 Apr 2019 04:59:57 -0400
Received: by mail-pl1-x642.google.com with SMTP id d1so4344765plj.8
	for <qemu-devel@nongnu.org>; Sat, 06 Apr 2019 01:59:56 -0700 (PDT)
References: <20190404185730.GA22512@ls3530.dellerweb.de>
	<CAFEAcA9xP8CtXEruuzPHCyuDT5EyMMHFGdCJdfFBhX+C2Jr36A@mail.gmail.com>
	<b48c6984-f0fc-a597-53a0-4869c822ce73@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5c330405-d3e3-f737-91f0-fe4de3edd576@linaro.org>
Date: Sat, 6 Apr 2019 17:59:47 +0900
MIME-Version: 1.0
In-Reply-To: <b48c6984-f0fc-a597-53a0-4869c822ce73@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] configure: Automatically fall back to TCI
 on non-release architectures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 4/5/19 2:56 PM, Helge Deller wrote:
> Looking just at some of the debian "ports" (non-release) architectures:
> alpha, hppa, ia64, m68k, powerpc, sh4, sparc64

FWIW:

sparc64 does have a tcg backend.
(Indeed, tcg/sparc does *not* support 32-bit cpus!)

powerpc does have a tcg backend, and it has both 32 and 64-bit users.

Both hppa and ia64 used to have tcg backends, and could
be resurrected if there was a will.

I have a tcg/alpha backend that I haven't bothered to
merge, because I assumed there was little interest.


r~
