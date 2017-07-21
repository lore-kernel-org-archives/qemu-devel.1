Received: from eggs.gnu.org ([2001:4830:134:3::10]:37079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYXnp-00071e-Hb
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:17:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYXno-0000N9-GN
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:17:09 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:37415)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dYXno-0000LB-9Z
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:17:08 -0400
Received: by mail-wr0-x235.google.com with SMTP id 33so25827398wrz.4
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 06:17:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170721054210.GA16334@flamenco>
References: <20170719233455.8740-1-rth@twiddle.net>
	<20170719233455.8740-7-rth@twiddle.net>
	<20170721054210.GA16334@flamenco>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Jul 2017 14:16:46 +0100
Message-ID: <CAFEAcA8mPyF+X1CHSAGdZ5VAXLFoHx24e7h0gadFHfecDttQyQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/arm: fix TCG temp leak in aarch64
 rev16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: Richard Henderson <rth@twiddle.net>, QEMU Developers <qemu-devel@nongnu.org>

On 21 July 2017 at 06:42, Emilio G. Cota <cota@braap.org> wrote:
> const leak! patch below -- cut with `git am --scissors'.
>
>                 Emilio
>
> ---8<---
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---

Applied to target-arm.next, thanks -- but in future could you
send patches as proper patch emails, please (output of
git format-patch, sent as its own top level email, not a
reply to an existing thread) ? Otherwise the automated tools
don't recognise them as patches and it requires some tedious
manual application at this end.

thanks
-- PMM
