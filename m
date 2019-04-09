Received: from eggs.gnu.org ([209.51.188.92]:53255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hDxWX-0002GI-Dc
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 16:39:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hDxWW-0003Ik-1C
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 16:39:17 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:45816)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hDxWV-0003Bw-Ci
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 16:39:15 -0400
Received: by mail-pf1-x444.google.com with SMTP id e24so10409479pfi.12
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 13:39:15 -0700 (PDT)
References: <20190404185730.GA22512@ls3530.dellerweb.de>
	<CAFEAcA9xP8CtXEruuzPHCyuDT5EyMMHFGdCJdfFBhX+C2Jr36A@mail.gmail.com>
	<b48c6984-f0fc-a597-53a0-4869c822ce73@gmx.de>
	<068f4832-7e0b-8850-ffa0-fcf1ecd50295@redhat.com>
	<20190405090212.GF6105@redhat.com>
	<740ce541-c92d-5369-1191-eb73fc861fdd@redhat.com>
	<a53b3bab-5aa4-b37f-f194-7788bce1d04b@weilnetz.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <35359e2b-7f07-8815-4f2b-f1435abc4e63@linaro.org>
Date: Tue, 9 Apr 2019 10:39:08 -1000
MIME-Version: 1.0
In-Reply-To: <a53b3bab-5aa4-b37f-f194-7788bce1d04b@weilnetz.de>
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
To: Stefan Weil <sw@weilnetz.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Aurelien Jarno <aurelien@aurel32.net>

On 4/9/19 9:46 AM, Stefan Weil wrote:
> * Calling conventions. The current implementation works on many hosts,
> but for example not on Sparc. A fix would require simple calling
> conventions for all helper functions (for example stack based argument
> passing, can this be enforced?), or it needs to know the signature of
> each helper function at runtime. I'm afraid that fixing this would
> require much work. A runtime test whether calls of helper functions work
> correctly could be implemented easily and could abort the program
> execution when calls fail to pass the right arguments. Would such a
> runtime test help a little bit?

In the rewrite of tci that I proposed some years ago,
I used libffi for this.

Those patches could probably be recovered...

https://patchwork.ozlabs.org/patch/348528/
https://patchwork.ozlabs.org/patch/348527/


r~
