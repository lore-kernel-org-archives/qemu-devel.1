Received: from eggs.gnu.org ([2001:4830:134:3::10]:46639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marc.zyngier@arm.com>) id 1gIv6v-0007Hv-0k
	for qemu-devel@nongnu.org; Sat, 03 Nov 2018 08:33:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marc.zyngier@arm.com>) id 1gIv6t-00036H-Up
	for qemu-devel@nongnu.org; Sat, 03 Nov 2018 08:33:04 -0400
Date: Sat, 3 Nov 2018 12:32:46 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <20181103123246.16b5b101@why.wild-wind.fr.eu.org>
In-Reply-To: <effa3839-f0ab-e6ab-e034-a1a6d1d06923@linaro.org>
References: <20181102145433.4553-1-richard.henderson@linaro.org>
	<CAFEAcA_tcR_33Q+2ZFHdzo4_9khXggum=gRfZ8+L49KmP3hHiw@mail.gmail.com>
	<20181102193529.GB12057@e113682-lin.lund.arm.com>
	<effa3839-f0ab-e6ab-e034-a1a6d1d06923@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/5] target/arm: KVM vs ARMISARegisters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Christoffer Dall <christoffer.dall@arm.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Dave Martin <Dave.Martin@arm.com>

On Sat, 3 Nov 2018 09:53:44 +0000
Richard Henderson <richard.henderson@linaro.org> wrote:

Hi Richard,

> Although, while I have you, Christopher, is there a way to extract the Limited
> Ordering Region registers without modifying guest state?  Those are multiplexed
> with LORN_EL1.

We actively hide the LORegion feature from the guest since
cc33c4e20185a391766ed5e78e2acc97e17ba511 (in the 4.17 time frame), so
you shouldn't be able to obtain these on a recent host.

I'm not sure this answers your question though...

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.
