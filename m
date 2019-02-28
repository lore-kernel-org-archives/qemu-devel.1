Received: from eggs.gnu.org ([209.51.188.92]:51006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz9sA-0005EU-S4
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 19:48:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz9s4-0000hT-2L
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 19:48:22 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:38246)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gz9s0-00077U-33
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 19:48:17 -0500
Received: by mail-pf1-x444.google.com with SMTP id n125so8838175pfn.5
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 16:47:35 -0800 (PST)
References: <20190222055950.17403-1-richard.henderson@linaro.org>
	<a46631f2-fc78-2f06-09f0-25b2563af52d@ilande.co.uk>
	<20190224233142.GC7668@umbus.fritz.box>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bf117507-a3da-9dcd-e2c1-031312b7d89e@linaro.org>
Date: Wed, 27 Feb 2019 16:47:30 -0800
MIME-Version: 1.0
In-Reply-To: <20190224233142.GC7668@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tcg/ppc: Add vector opcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org

On 2/24/19 3:31 PM, David Gibson wrote:
> I have access to POWER8 and POWER9 machines, but I haven't worked with
> RISU before.  If you can give me a straightforward recipe I can try
> running the tests.

From

  https://git.linaro.org/people/peter.maydell/risu.git

First you need to generate the test cases.  It looks like the current
ppc64.risu file is fairly complete, at least to some level.  So:

mkdir ../risu-testcases-ppc64
./scripts/generate_all.sh ppc64.risu ../risu-testcases-ppc64

Then record traces from real hardware to compare against:

RISU=`pwd`/risu ./scripts/record_traces.sh ../risu-testcases-ppc64/*.bin

Now compare QEMU against hardware:

QEMU=qemu-ppc64 RISU=`pwd`/risu \
./scripts/run_risu ../risu-testcases-ppc64/*.bin

Which is all hunky dory until something fails.  At which point it's a matter of
using qemu's -d and -dfilter options judiciously, and "objdump -b binary -m
ppc64 -D foo.bin".


r~
