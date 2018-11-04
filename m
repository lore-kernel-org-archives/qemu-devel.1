Received: from eggs.gnu.org ([2001:4830:134:3::10]:46938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gJF3R-0006oK-VG
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 04:50:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gJF3Q-0005TI-Or
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 04:50:49 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36825)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gJF3N-0005HF-Sx
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 04:50:46 -0500
Received: by mail-wm1-x344.google.com with SMTP id a8-v6so5270855wmf.1
	for <qemu-devel@nongnu.org>; Sun, 04 Nov 2018 01:50:34 -0800 (PST)
References: <20181102145433.4553-1-richard.henderson@linaro.org>
	<CAFEAcA_tcR_33Q+2ZFHdzo4_9khXggum=gRfZ8+L49KmP3hHiw@mail.gmail.com>
	<20181102193529.GB12057@e113682-lin.lund.arm.com>
	<effa3839-f0ab-e6ab-e034-a1a6d1d06923@linaro.org>
	<20181103123246.16b5b101@why.wild-wind.fr.eu.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1ee4127a-aa3e-4e19-1dde-af83147f8bc4@linaro.org>
Date: Sun, 4 Nov 2018 09:50:29 +0000
MIME-Version: 1.0
In-Reply-To: <20181103123246.16b5b101@why.wild-wind.fr.eu.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <christoffer.dall@arm.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Dave Martin <Dave.Martin@arm.com>

On 11/3/18 12:32 PM, Marc Zyngier wrote:
> We actively hide the LORegion feature from the guest since
> cc33c4e20185a391766ed5e78e2acc97e17ba511 (in the 4.17 time frame), so
> you shouldn't be able to obtain these on a recent host.

I don't think that patch is ideal.

In particular, LOR is a mandatory requirement of ARMv8.1.
The OS can rightly presume it is present in context.

Better, I think, is to trap the LOR registers, as you are doing,
and have them act as RAZ/WI.  This indicates, via LORID_EL1, that
there are zero supported LO regions, which is a valid ARMv8.1
configuration.


r~
