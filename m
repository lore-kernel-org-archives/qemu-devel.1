Received: from eggs.gnu.org ([2001:4830:134:3::10]:42328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDVBJ-00066U-9z
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:51:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDVBI-0003nX-HL
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:51:13 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:37490)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gDVBI-0003jJ-4T
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:51:12 -0400
Received: by mail-ot1-x342.google.com with SMTP id o14so33255738oth.4
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 06:51:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181011205206.3552-19-richard.henderson@linaro.org>
References: <20181011205206.3552-1-richard.henderson@linaro.org>
	<20181011205206.3552-19-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 14:50:50 +0100
Message-ID: <CAFEAcA-3iFca2v+8Q2xo4yB7MsUz6xBb5UKNJEYVrpo2A=o22Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 18/20] target/arm: Reorg NEON VLD/VST all
 elements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 11 October 2018 at 21:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Instead of shifts and masks, use direct loads and stores from the neon
> register file.  Mirror the iteration structure of the ARM pseudocode
> more closely.  Correct the parameters of the VLD2 A2 insn.

So is this actually fixing a bug here? The new code definitely
looks right, but I can't make heads nor tails of the old code,
so I'm not sure whether it actually behaved differently...


thanks
-- PMM
