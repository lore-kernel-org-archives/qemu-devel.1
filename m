Received: from eggs.gnu.org ([2001:4830:134:3::10]:49109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fpaaJ-00006g-VX
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 10:46:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fpaaJ-0004vK-9N
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 10:46:12 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:41072)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fpaaJ-0004uz-23
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 10:46:11 -0400
Received: by mail-oi0-x243.google.com with SMTP id k12-v6so34043119oiw.8
	for <qemu-devel@nongnu.org>; Tue, 14 Aug 2018 07:46:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180814144144.slntd4f22eza5rru@toto>
References: <20180814124254.5229-1-peter.maydell@linaro.org>
	<20180814124254.5229-3-peter.maydell@linaro.org>
	<20180814144144.slntd4f22eza5rru@toto>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Aug 2018 15:45:49 +0100
Message-ID: <CAFEAcA9kv2_95bczA19mHaGFJo+5kvfnyo5Q6PC_JUzk_=oJpA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 02/10] target/arm: Add missing .cp = 15 to
 HMAIR1 and HAMAIR1 regdefs
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

On 14 August 2018 at 15:41, Edgar E. Iglesias <edgar.iglesias@xilinx.com> wrote:
> On Tue, Aug 14, 2018 at 01:42:46PM +0100, Peter Maydell wrote:
>> ARMCPRegInfo structs will not default to .cp = 15 if they
>                             ^^^
>                I think you've got a typo here

Yep, that 'not' should be deleted.

> Otherwise:
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

thanks
-- PMM
