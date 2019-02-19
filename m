Received: from eggs.gnu.org ([209.51.188.92]:43327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gw9RD-0005zI-CL
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:44:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gw9RC-0006nC-LO
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:44:11 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:35634)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gw9RC-0006mw-Ex
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:44:10 -0500
Received: by mail-ot1-x344.google.com with SMTP id z19so35692850otm.2
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 09:44:10 -0800 (PST)
MIME-Version: 1.0
References: <20190215192302.27855-1-richard.henderson@linaro.org>
	<20190215192302.27855-7-richard.henderson@linaro.org>
In-Reply-To: <20190215192302.27855-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Feb 2019 17:43:58 +0000
Message-ID: <CAFEAcA8bDLYO0QpMUnoqoCHs+iHzo8HqqTGJ-RwnMzV+5D2qNg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 6/8] target/arm: Implement FMLAL and
 FMLSL for aarch64
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

On Fri, 15 Feb 2019 at 19:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Encoding stuff is all OK, but as noted in previous email
I think we're going to have fpstatus awkwardness.

(The code in this patch always selects the non-fp16
fpstatus, which is right for everything except for
handling FZ16 on the float16 inputs.)

thanks
-- PMM
