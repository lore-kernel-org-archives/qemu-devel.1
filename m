Received: from eggs.gnu.org ([2001:4830:134:3::10]:34173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1f4Q51-0004Ji-8l
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 08:02:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1f4Q4x-0000cX-BV
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 08:02:55 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:52892)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1f4Q4x-0000c4-0V
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 08:02:51 -0400
References: <1522883475-27858-1-git-send-email-cota@braap.org>
	<1522883475-27858-8-git-send-email-cota@braap.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <b5516512-9a3b-8327-f0e7-48e2a238040f@mail.uni-paderborn.de>
Date: Fri, 6 Apr 2018 14:02:39 +0200
MIME-Version: 1.0
In-Reply-To: <1522883475-27858-8-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 07/15] softfloat: rename canonicalize to
 sf_canonicalize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

On 04/05/2018 01:11 AM, Emilio G. Cota wrote:
> glibc >= 2.25 defines canonicalize in commit eaf5ad0
> (Add canonicalize, canonicalizef, canonicalizel., 2016-10-26).
> 
> Given that we'll be including <math.h> soon, prepare
> for this by prefixing our canonicalize() with sf_ to avoid
> clashing with the libc's canonicalize().
> 
> Reported-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---

This fixes the problem.
Tested-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Cheers,
Bastian
