Received: from eggs.gnu.org ([2001:4830:134:3::10]:36035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fptk9-0004QU-Uk
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 07:13:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fptk8-0006Rj-UR
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 07:13:37 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:39327)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fptk8-0006QF-Il
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 07:13:36 -0400
Received: by mail-oi0-x242.google.com with SMTP id d189-v6so1303854oib.6
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 04:13:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180815110434.z7skzr6riz3dmnan@toto>
References: <20180814124254.5229-1-peter.maydell@linaro.org>
	<20180815110434.z7skzr6riz3dmnan@toto>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Aug 2018 12:13:14 +0100
Message-ID: <CAFEAcA84FSv1nptP76pcQdO-xZzf7ZVTs1GwUQBECPezGQCpcQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 00/10] target/arm: Some pieces of support
 for 32-bit Hyp mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Luc Michel <luc.michel@greensocs.com>, Edgar Iglesias <edgari@xilinx.com>

On 15 August 2018 at 12:04, Edgar E. Iglesias <edgar.iglesias@xilinx.com> wrote:
> On Tue, Aug 14, 2018 at 01:42:44PM +0100, Peter Maydell wrote:
>> I also noticed that we fail to implement really quite a lot
>> of the HCR_EL2 trap semantics for either AArch64 or AArch32,
>> to the extent that I'm surprised that nested guests work
>> under AArch64 :-)
>
> Yes, we've have an entry for a while in our TODO list to improve
> HCR trapping but haven't gotten around to it. IIRC, at the time
> when we where bringing the EL2 stuff up, quite little was actually
> being used by KVM/Xen.

We're also I think not correctly implementing some of
the required upgrades of TLB maintenance ops to inner-shareable,
so I suspect that operation in SMP configs will be flaky.

thanks
-- PMM
