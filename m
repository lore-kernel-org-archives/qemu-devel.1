Received: from eggs.gnu.org ([209.51.188.92]:57184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm1IB-0007ph-6q
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:01:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm1IA-0004gQ-E4
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:00:59 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:34182)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gm1I8-0004av-HI
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:00:58 -0500
Received: by mail-oi1-x242.google.com with SMTP id r62so18378550oie.1
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 11:00:34 -0800 (PST)
MIME-Version: 1.0
References: <20190110121736.23448-1-richard.henderson@linaro.org>
	<20190110121736.23448-3-richard.henderson@linaro.org>
In-Reply-To: <20190110121736.23448-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Jan 2019 12:08:11 +0000
Message-ID: <CAFEAcA9OgDwc+E1-Xc_i1m5vREJnzke5tc6_o94+6wdy0cnCtg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 02/11] target/arm: Add PSTATE.BTYPE
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

On Thu, 10 Jan 2019 at 12:17, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Place this in its own field within ENV, as that will
> make it easier to reset from within TCG generated code.
>
> With the change to pstate_read/write, exception entry
> and return are automatically handled.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
