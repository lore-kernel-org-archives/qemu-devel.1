Received: from eggs.gnu.org ([2001:4830:134:3::10]:45333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCt9Y-0007ni-19
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 17:14:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCt9U-0003gD-Ra
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 17:14:51 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:37683)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gCt9U-0003fl-Io
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 17:14:48 -0400
Received: by mail-pl1-x641.google.com with SMTP id u6-v6so10547930plz.4
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 14:14:48 -0700 (PDT)
References: <20181010203735.27918-1-aclindsa@gmail.com>
	<20181010203735.27918-13-aclindsa@gmail.com>
	<0fdcad4a-c8b5-3309-d2ce-f9be901ec52a@linaro.org>
	<20181017192013.GA25905@quinoa.localdomain>
	<31f327f4-42ee-55fc-596d-97d935803867@linaro.org>
	<20181017202505.GC25905@quinoa.localdomain>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ddceb720-97d2-22fa-e58a-7283fb416c29@linaro.org>
Date: Wed, 17 Oct 2018 14:14:44 -0700
MIME-Version: 1.0
In-Reply-To: <20181017202505.GC25905@quinoa.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 12/14] target/arm: PMU: Set PMCR.N to 4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <Aaron@os.amperecomputing.com>
Cc: Aaron Lindsay <aclindsa@gmail.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Michael Spradling <mspradli@codeaurora.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Digant Desai <digantd@codeaurora.org>

On 10/17/18 1:25 PM, Aaron Lindsay wrote:
> I suppose pmcrn (the local variable) should've been set to 0 before this
> patch and updated here to be 4.

That's plausible.

> Anyway, by splitting these patches apart, my intention was to separate
> the plumbing work from turning on the water. If you believe it is better
> to do both in the same patch, I'll make that change for v7.

Fair.  I'll let Peter weigh in for final decision.


r~
