Received: from eggs.gnu.org ([2001:4830:134:3::10]:41189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1f0lLe-0002tm-1c
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 05:57:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1f0lLa-0003UL-5L
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 05:56:58 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:43684)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1f0lLZ-0003TD-Qd
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 05:56:54 -0400
References: <1522128840-498-1-git-send-email-cota@braap.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <1d2cdc9d-38f4-2274-8981-da47822ca569@mail.uni-paderborn.de>
Date: Tue, 27 Mar 2018 11:56:37 +0200
MIME-Version: 1.0
In-Reply-To: <1522128840-498-1-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 00/14] fp-test + hardfloat
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

Hi Emilio,

On 03/27/2018 07:33 AM, Emilio G. Cota wrote:
> v1: https://lists.nongnu.org/archive/html/qemu-devel/2018-03/msg05908.html
> 
[...]
> 
> Perf numbers are in the last patch. They are a little different than
> last week; I cannot replicate last week's performance (even with
> the very same binaries; might have to reboot the machine I'm using
> soon), but as of today v2 is certainly faster than v1 (e.g. 5% faster
> for nbench-fp).
> 
> I have checked all checkpatch warnings; they're all false positives.
> 
> You can fetch the series from:
>   https://github.com/cota/qemu/tree/hardfloat-v2

When I try to build your tree with gcc version 7.3.1 20180312 (GCC), I get:

  CC      tricore-softmmu/fpu/softfloat.o
/home/kbastian/coding/upstream-qemu/qemu-fpu/fpu/softfloat.c:417:19:
error: conflicting types for ‘canonicalize’
 static FloatParts canonicalize(FloatParts part, const FloatFmt *parm,
                   ^~~~~~~~~~~~
In file included from /usr/include/features.h:423:0,
                 from /usr/include/bits/libc-header-start.h:33,
                 from /usr/include/math.h:27,
                 from
/home/kbastian/coding/upstream-qemu/qemu-fpu/fpu/softfloat.c:85:
/usr/include/bits/mathcalls.h:385:1: note: previous declaration of
‘canonicalize’ was here
 __MATHDECL_1 (int, canonicalize,, (_Mdouble_ *__cx, const _Mdouble_ *__x));

Cheers,
Bastian
