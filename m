Received: from eggs.gnu.org ([2001:4830:134:3::10]:38414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fhwMH-0008TN-5d
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:24:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fhwMG-0000UY-9i
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:24:05 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:43348)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fhwMG-0000UL-2i
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:24:04 -0400
Received: by mail-oi0-x241.google.com with SMTP id b15-v6so7069555oib.10
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 05:24:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180710160013.26559-1-peter.maydell@linaro.org>
References: <20180710160013.26559-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jul 2018 13:23:43 +0100
Message-ID: <CAFEAcA8t3+4A442TakdmcvYSh5s1iV80oJhJnsmjdzG19PTZXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 0/6] accel/tcg: Support
 execution from MMIO and small MMU regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: "patches@linaro.org" <patches@linaro.org>, KONRAD Frederic <frederic.konrad@adacore.com>, "Emilio G . Cota" <cota@braap.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 10 July 2018 at 17:00, Peter Maydell <peter.maydell@linaro.org> wrote:
> This series adds support to TCG for executing from MMIO regions
> and small MMU regions. The basic principle is that if get_page_addr_code()
> finds that the region is not backed by a full page of RAM then it
> returns -1, and tb_gen_code() then generates a non-cached TB
> containing a single instruction. Execution from these regions
> thus performs the instruction fetch every time, ensuring that we
> get the read-from-MMIO and check-small-MMU-region permissions
> checks right.

Hi; this series has been reviewed, and I propose to put it into
my target-arm.for-3.1 queue, unless anybody has a preference for
it going into master via some other route.

thanks
-- PMM
