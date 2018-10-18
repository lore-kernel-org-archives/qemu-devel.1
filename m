Received: from eggs.gnu.org ([2001:4830:134:3::10]:52546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gD5QA-0005eJ-60
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 06:20:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gD5Q9-0000Vc-5u
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 06:20:49 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:37284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gD5Q8-0000Ui-Ms
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 06:20:49 -0400
Received: by mail-ot1-x342.google.com with SMTP id o14so29239477oth.4
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 03:20:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ddceb720-97d2-22fa-e58a-7283fb416c29@linaro.org>
References: <20181010203735.27918-1-aclindsa@gmail.com>
	<20181010203735.27918-13-aclindsa@gmail.com>
	<0fdcad4a-c8b5-3309-d2ce-f9be901ec52a@linaro.org>
	<20181017192013.GA25905@quinoa.localdomain>
	<31f327f4-42ee-55fc-596d-97d935803867@linaro.org>
	<20181017202505.GC25905@quinoa.localdomain>
	<ddceb720-97d2-22fa-e58a-7283fb416c29@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Oct 2018 11:20:27 +0100
Message-ID: <CAFEAcA8JAtBQC3GpjBOKYdtx9OC2r6bcZpkAjr3wyyik11efNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 12/14] target/arm: PMU: Set PMCR.N to 4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Aaron Lindsay <Aaron@os.amperecomputing.com>, Aaron Lindsay <aclindsa@gmail.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Michael Spradling <mspradli@codeaurora.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Digant Desai <digantd@codeaurora.org>

On 17 October 2018 at 22:14, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 10/17/18 1:25 PM, Aaron Lindsay wrote:
>> I suppose pmcrn (the local variable) should've been set to 0 before this
>> patch and updated here to be 4.
>
> That's plausible.
>
>> Anyway, by splitting these patches apart, my intention was to separate
>> the plumbing work from turning on the water. If you believe it is better
>> to do both in the same patch, I'll make that change for v7.
>
> Fair.  I'll let Peter weigh in for final decision.

No strong opinion -- rth has reviewed this set, not me.

thanks
-- PMM
