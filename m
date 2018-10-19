Received: from eggs.gnu.org ([2001:4830:134:3::10]:42449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDVBm-0006Rt-RH
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:51:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDVBl-0005bJ-O2
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:51:42 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:45196)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gDVBl-0005QS-HH
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:51:41 -0400
Received: by mail-ot1-x342.google.com with SMTP id u22so33205605ota.12
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 06:51:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181011205206.3552-1-richard.henderson@linaro.org>
References: <20181011205206.3552-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 14:51:18 +0100
Message-ID: <CAFEAcA-vbm=ZN+4dd=Js2s_4gKffs12XgWsO1F_9405v=xhf0w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 00/20] target/arm: Convert some neon insns
 to gvec
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

On 11 October 2018 at 21:51, Richard Henderson
<richard.henderson@linaro.org> wrote:
> The conversion to gvec is by no means complete, but it brings aa32
> to parity with the work already done for aa64.  Plus some misc changes,
> at least one of which has been sitting on a branch for 2 years.  ;-P
>
> I've run the result through Alex's aarch32-all.tar.xz RISU tests.
> There are no regressions, though there are pre-existing failures.
> Our aa32 translator could use some additional work, no surprise.

Applied to target-arm.next, thanks. I made a couple of minor tweaks
which I've noted in replies to the relevant patches.

If you could clarify whether patch 18 is fixing a bug I can tweak
the commit message on that one.

thanks
-- PMM
