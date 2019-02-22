Received: from eggs.gnu.org ([209.51.188.92]:38788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gxEP7-0000ds-OZ
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 12:14:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gxEP3-00088u-Eq
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 12:14:27 -0500
Received: from chuckie.co.uk ([82.165.15.123]:33750
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1gxEOx-0007Re-DA
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 12:14:21 -0500
References: <20190222055950.17403-1-richard.henderson@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <a46631f2-fc78-2f06-09f0-25b2563af52d@ilande.co.uk>
Date: Fri, 22 Feb 2019 17:13:37 +0000
MIME-Version: 1.0
In-Reply-To: <20190222055950.17403-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tcg/ppc: Add vector opcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: david@gibson.dropbear.id.au

On 22/02/2019 05:59, Richard Henderson wrote:

> This requires VSX, not just Altivec, so Power7 or later.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> 
> At present there are no tunables that can avoid the 64-bit element
> load/store requirement.  As with requiring AVX1 for x86 hosts, I'm
> not sure it's worth inventing such a tunable for pre-power7 hosts.
> 
> Tested vs aarch64 risu test cases.  It's probably worth testing
> this vs Mark's target/ppc conversion.

Oooh this looks really exciting! However... I only have a G4 Mac Mini around that I
use for testing which is Altivec-only :(  Is it much work to support non-VSX hosts?

This leads me to a related point that came up when Howard and I were testing the PPC
vector patches - how do we know at runtime which optimisations were being used, e.g.
what is the value of have_avx2 on a particular CPU running QEMU?

Under Linux this isn't too bad since you can just do "cat /proc/cpuinfo | grep avx2"
but it becomes more tricky when getting bug reports from Windows users who aren't
particularly technical...


ATB,

Mark.
