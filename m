Received: from eggs.gnu.org ([209.51.188.92]:40998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gxr9p-00038Z-O2
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 05:37:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gxr9o-0000fM-Vy
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 05:37:17 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34472)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gxr9o-0000ex-QX
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 05:37:16 -0500
Received: by mail-oi1-x241.google.com with SMTP id g16so5117057oib.1
	for <qemu-devel@nongnu.org>; Sun, 24 Feb 2019 02:37:16 -0800 (PST)
MIME-Version: 1.0
References: <20190223232954.7185-1-richard.henderson@linaro.org>
	<20190223232954.7185-3-richard.henderson@linaro.org>
In-Reply-To: <20190223232954.7185-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 24 Feb 2019 10:37:04 +0000
Message-ID: <CAFEAcA_A3cZ4Pv7YT3qzM+krwW+Z6R=oyKcRfuJvr6q5pZj2HA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/5] decodetree: Move documentation to
 docs/decodetree.rst
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On Sat, 23 Feb 2019 at 23:35, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> One great big block comment isn't the best way to document
> the syntax of a language.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  MAINTAINERS           |   1 +
>  docs/decodetree.rst   | 156 ++++++++++++++++++++++++++++++++++++++++++
>  scripts/decodetree.py | 134 +-----------------------------------
>  3 files changed, 158 insertions(+), 133 deletions(-)
>  create mode 100644 docs/decodetree.rst

Could you put this in docs/devel/, please ?
Our plan for documentation is to try to split it into
multiple manuals, each of which gets a subdirectory of
docs/, and eventually have nothing still in the docs/
directory itself. This doc should definitely be in
devel/ as it's relevant only to QEMU developers.

thanks
-- PMM
