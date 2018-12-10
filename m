Received: from eggs.gnu.org ([2001:4830:134:3::10]:45127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gW9WN-0007y4-Al
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 19:34:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gW9WK-0008SX-4L
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 19:34:03 -0500
Date: Mon, 10 Dec 2018 01:33:53 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20181207085635.4291-1-mark.cave-ayland@ilande.co.uk>
Message-ID: <alpine.BSF.2.21.9999.1812100112050.45639@zero.eik.bme.hu>
References: <20181207085635.4291-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC PATCH 0/6] target/ppc: convert VMX
 instructions to use TCG vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, richard.henderson@linaro.org

On Fri, 7 Dec 2018, Mark Cave-Ayland wrote:
> This patchset is an attempt at trying to improve the VMX (Altivec) instruction
> performance by making use of the new TCG vector operations where possible.

This is very welcome, thanks for doing this.

> In order to use TCG vector operations, the registers must be accessible from cpu_env
> whilst currently they are accessed via arrays of static TCG globals. Patches 1-3
> are therefore mechanical patches which introduce access helpers for FPR, AVR and VSR
> registers using the supplied TCGv_i64 parameter.

Have you tried some benchmarks or tests to measure the impact of these 
changes? I've tried the (very unscientific) benchmarks I've written about 
before here:

http://lists.nongnu.org/archive/html/qemu-ppc/2018-07/msg00261.html

(which seem to use AltiVec/VMX instructions but not sure which) on mac99 
with MorphOS and I could not see any performance increase. I haven't run 
enough tests but results with or without this series on master were mostly 
the same within a few percents, and sometimes even seen lower performance 
with these patches than without. I haven't tried to find out why (no time 
for that now) so can't really draw any conclusions from this. I'm also not 
sure if I've actually tested what you've changed or these use instructions 
that your patches don't optimise yet, or the changes I've seen were just 
normal changes between runs; but I wonder if the increased number of 
temporaries could result in lower performance in some cases?

Regards,
BALATON Zoltan
