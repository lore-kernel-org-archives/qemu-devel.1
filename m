Received: from eggs.gnu.org ([2001:4830:134:3::10]:39452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDQI-0004B7-Qi
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:05:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDKU-0004Dw-Bx
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 08:59:41 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:54588)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEDKP-00047l-6q
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 08:59:34 -0400
Received: by mail-wm1-x331.google.com with SMTP id r63-v6so7624078wma.4
	for <qemu-devel@nongnu.org>; Sun, 21 Oct 2018 05:59:29 -0700 (PDT)
References: <20181019010625.25294-1-cota@braap.org>
	<20181019010625.25294-13-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e9e9edf2-44e2-72ef-332a-9169104d3896@linaro.org>
Date: Sun, 21 Oct 2018 13:59:25 +0100
MIME-Version: 1.0
In-Reply-To: <20181019010625.25294-13-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 12/56] i386: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 10/19/18 2:05 AM, Emilio G. Cota wrote:
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/i386/cpu.h         |  2 +-
>  target/i386/cpu.c         |  2 +-
>  target/i386/hax-all.c     |  4 ++--
>  target/i386/helper.c      |  4 ++--
>  target/i386/hvf/hvf.c     |  8 ++++----
>  target/i386/hvf/x86hvf.c  |  4 ++--
>  target/i386/kvm.c         | 10 +++++-----
>  target/i386/misc_helper.c |  2 +-
>  target/i386/whpx-all.c    |  6 +++---
>  9 files changed, 21 insertions(+), 21 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
