Received: from eggs.gnu.org ([209.51.188.92]:58448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1grsCm-0002Fi-43
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 17:31:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1grsCg-0006UQ-Sa
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 17:31:34 -0500
Received: from chuckie.co.uk ([82.165.15.123]:45108
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1grsCZ-0006Pq-7z
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 17:31:26 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20190104223116.14037-1-richard.henderson@linaro.org>
	<d52c8ae0-edee-ed9a-56b8-43cc1cf0208d@ilande.co.uk>
	<362de5ba-a678-aeed-6a5d-3a02844c2560@linaro.org>
	<6314c25b-a8c9-a8e2-2e1d-a8eeb3b88f2c@ilande.co.uk>
Message-ID: <490c6687-d13e-9591-f3b9-0dac9550bfbb@ilande.co.uk>
Date: Thu, 7 Feb 2019 22:31:02 +0000
MIME-Version: 1.0
In-Reply-To: <6314c25b-a8c9-a8e2-2e1d-a8eeb3b88f2c@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 00/10] tcg vector improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Howard Spoelstra <hsp.cat7@gmail.com>

On 05/02/2019 21:29, Mark Cave-Ayland wrote:

> Now that this and the other pre-requisite patches have been merged into master, I've
> rebased the outstanding PPC parts of your "tcg, target/ppc vector improvements" on
> master including the above fix and pushed the result to
> https://github.com/mcayland/qemu/commits/ppc-altivec-v6.
> 
> The good news is that the graphics corruption I originally noticed caused by the
> patch introducing the saturating add/sub vector ops has now gone, and with my
> little-endian vsplt fix included then both OS X and MacOS 9 appear to run without any
> obvious issues on an x86 host, and certainly feel smoother compared to before.

I started to follow up Howard's report that he could still see graphical corruption
with these patches, and I was surprised to notice that it had reappeared locally once
again :/

After working out that this was because the relevant instructions weren't being
generated for all Mac machines, I was able to figure it out after a few hours of
digging. Patch to follow shortly.


ATB,

Mark.
