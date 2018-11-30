Received: from eggs.gnu.org ([2001:4830:134:3::10]:42016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSlKV-0001AI-G1
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 11:07:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSlKU-0002lV-H4
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 11:07:47 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:42910)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gSlKS-0002io-CU
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 11:07:46 -0500
Received: by mail-ot1-x341.google.com with SMTP id v23so5521722otk.9
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 08:07:42 -0800 (PST)
MIME-Version: 1.0
References: <20181120212553.8480-1-aaron@os.amperecomputing.com>
	<20181120212553.8480-4-aaron@os.amperecomputing.com>
In-Reply-To: <20181120212553.8480-4-aaron@os.amperecomputing.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Nov 2018 16:07:31 +0000
Message-ID: <CAFEAcA8GwNrZd5kL+Zxk-v8YsNdy04zO5ZeaRA9QXmMJCeVH=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v8 03/13] target/arm: Swap PMU values
 before/after migrations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <aaron@os.amperecomputing.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <aclindsa@gmail.com>

On Tue, 20 Nov 2018 at 21:26, Aaron Lindsay
<aaron@os.amperecomputing.com> wrote:
>
> Because of the PMU's design, many register accesses have side effects
> which are inter-related, meaning that the normal method of saving CP
> registers can result in inconsistent state. These side-effects are
> largely handled in pmu_op_start/finish functions which can be called
> before and after the state is saved/restored. By doing this and adding
> raw read/write functions for the affected registers, we avoid
> migration-related inconsistencies.
>
> Signed-off-by: Aaron Lindsay <aclindsa@gmail.com>
> Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
