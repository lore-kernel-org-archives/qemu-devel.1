Received: from eggs.gnu.org ([209.51.188.92]:60603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1grPNz-0004Wy-Mm
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 10:45:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1grPNy-0003eP-1P
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 10:45:15 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:41678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1grPNw-0003Oi-5S
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 10:45:13 -0500
Date: Wed, 6 Feb 2019 16:44:19 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <d5383a6e-d772-ae4b-8a94-608d0947009c@ilande.co.uk>
Message-ID: <alpine.BSF.2.21.9999.1902061638140.43975@zero.eik.bme.hu>
References: <20190104223116.14037-1-richard.henderson@linaro.org>
	<d52c8ae0-edee-ed9a-56b8-43cc1cf0208d@ilande.co.uk>
	<362de5ba-a678-aeed-6a5d-3a02844c2560@linaro.org>
	<6314c25b-a8c9-a8e2-2e1d-a8eeb3b88f2c@ilande.co.uk>
	<935af9ba-3fd8-ebd8-4f70-5050351d89d5@linaro.org>
	<d5383a6e-d772-ae4b-8a94-608d0947009c@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH v2 00/10] tcg vector improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, Howard Spoelstra <hsp.cat7@gmail.com>

On Wed, 6 Feb 2019, Mark Cave-Ayland wrote:
> Howard has also pointed out that he's still spotted some corruption in his tests, so
> I will do a bit more investigation and report back.

I wonder if instead of "visually testing" shouldn't it be verified by some 
more exact tests? Could any of these be useful:

https://gcc.gnu.org/ml/gcc-patches/2002-11/msg01391.html
https://gcc.gnu.org/git/?p=gcc.git;a=tree;f=gcc/testsuite/gcc.dg/vmx;h=4765c35dabb4e3891c98084af077c2549fb45dfc;hb=HEAD
https://github.com/llvm-mirror/test-suite/tree/master/SingleSource/UnitTests/Vector/Altivec

or there could be other similar ones around that already have test cases 
for these instructions that could provide some more confidence in the 
correctness of the implementation.

Regards,
BALATON Zoltan
