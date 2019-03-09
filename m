Received: from eggs.gnu.org ([209.51.188.92]:46871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2cbr-0003yL-Ab
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 09:05:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2cbm-0000hq-Hl
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 09:05:53 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:40521)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h2cbi-0000bM-Po
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 09:05:48 -0500
Received: by mail-ot1-x334.google.com with SMTP id v20so275902otk.7
	for <qemu-devel@nongnu.org>; Sat, 09 Mar 2019 06:05:43 -0800 (PST)
MIME-Version: 1.0
References: <20190308095433.12116-1-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20190308095433.12116-1-kbastian@mail.uni-paderborn.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 9 Mar 2019 14:05:31 +0000
Message-ID: <CAFEAcA_6yR3qqzkj6Q9HEWerOooykst4OP6rJv8OVt5NLzZGZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] tricore patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>, david.brenken@efs-auto.de, robert.rasche@efs-auto.de, georg.hofstetter@efs-auto.de, christian.richter@efs-auto.de, lars.biermanski@efs-auto.de

On Fri, 8 Mar 2019 at 09:59, Bastian Koppelmann
<kbastian@mail.uni-paderborn.de> wrote:
>
> The following changes since commit 6cb4f6db4f4367faa33da85b15f75bbbd2bed2a6:
>
>   Merge remote-tracking branch 'remotes/cleber/tags/python-next-pull-request' into staging (2019-03-07 16:16:02 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/bkoppelmann/qemu-tricore-upstream.git tags/pull-tricore-2019-03-08
>
> for you to fetch changes up to d1c1d88ce6fd768cb98cd7af81b1b23ac9fe168d:
>
>   tricore: fixed RCR_CADDN instruction (2019-03-08 10:00:59 +0100)
>
> ----------------------------------------------------------------
> Fixes mixed up operands in CADDN and CADD
>
> ----------------------------------------------------------------
> David Brenken (2):
>       tricore: fixed RCR_CADD instruction
>       tricore: fixed RCR_CADDN instruction
>
>  target/tricore/translate.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> --

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
