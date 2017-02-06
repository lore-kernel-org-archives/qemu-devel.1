Received: from eggs.gnu.org ([2001:4830:134:3::10]:46685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1car3b-0000AC-Px
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 16:42:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1car3a-00012Q-Mz
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 16:42:43 -0500
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:34841)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1car3a-000128-FY
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 16:42:42 -0500
Received: by mail-wr0-x230.google.com with SMTP id 89so27768302wrr.2
	for <qemu-devel@nongnu.org>; Mon, 06 Feb 2017 13:42:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <ab8002a9-6d13-d409-8c1b-ae696181bc6e@bluestop.org>
References: <ab8002a9-6d13-d409-8c1b-ae696181bc6e@bluestop.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Feb 2017 21:42:20 +0000
Message-ID: <CAFEAcA8EZu6yk4VH+UFNvysSnaf2xEzf7HkBu5m1f2tVQCzDTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Build of master pollutes parent directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Rebecca Cran <rebecca@bluestop.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 6 February 2017 at 21:13, Rebecca Cran <rebecca@bluestop.org> wrote:
> Building commit 7d2c6c95511e42dffe2b263275e09957723d0ff4 is causing
> pollution of the parent directory: e.g. ~/workspace/qemu/.. contains the
> following extra directories:
>
> audio backends block chardev crypto disas fsdev hw io linux-user migration
> ndb net qapi qom replay slirp target ui util

Hi; thanks for the bug report. You might like to try this patch:
http://patchwork.ozlabs.org/patch/724462/
which should fix it (though you'll need to delete the
offending directories by hand now they exist). Hopefully
we'll get that into master shortly.

thanks
-- PMM
