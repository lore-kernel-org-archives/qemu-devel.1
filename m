Received: from eggs.gnu.org ([2001:4830:134:3::10]:41065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2iWE-0002Hz-TD
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 14:15:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2iWE-0001kQ-4j
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 14:15:26 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:33592)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d2iWD-0001jG-TP
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 14:15:26 -0400
Received: by mail-wr0-x232.google.com with SMTP id w50so73022545wrc.0
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 11:15:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1493051615-30715-1-git-send-email-peter.maydell@linaro.org>
References: <1493051615-30715-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Apr 2017 19:15:04 +0100
Message-ID: <CAFEAcA_mjVkKyTdJy8uNTyft2L=Gv8LGKtJtxJrHVwP04oPcew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Qemu-arm] [RFC 0/3] split core mmu_idx from
 ARMMMUIdx values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Richard Henderson <rth@twiddle.net>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

On 24 April 2017 at 17:33, Peter Maydell <peter.maydell@linaro.org> wrote:
> For M profile, we're eventually going to want some
> new MMU index values:
>      non secure User
>      non secure Privileged
>      non secure Privileged, execution priority < 0
>      secure User
>      secure Privileged
>      secure Privileged, execution priority < 0

Hmm, Alex and Edgar were definitely on the cc when I sent it but
seem to have fallen off it. (If you got a copy anyway then you
should probably check whether you have accidentally told mailman to
"filter out duplicate messages": you never want this setting
enabled, because it means "silently drop me from the cc list".)

thanks
-- PMM
