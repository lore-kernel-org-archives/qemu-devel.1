Received: from eggs.gnu.org ([2001:4830:134:3::10]:34291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebSde-0008H2-U3
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:55:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebSde-0007z8-7a
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:54:58 -0500
Received: from mail-ot0-x236.google.com ([2607:f8b0:4003:c0f::236]:39649)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ebSde-0007yf-2e
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:54:58 -0500
Received: by mail-ot0-x236.google.com with SMTP id 37so13803218otv.6
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 06:54:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180116144957.GA5516@toto>
References: <1516103467-7983-1-git-send-email-edgar.iglesias@gmail.com>
	<CAFEAcA8v1pmDLD6xz_5yysqyV+aG3EiSF1j9ahYC9f2XatF80Q@mail.gmail.com>
	<20180116144957.GA5516@toto>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2018 14:54:36 +0000
Message-ID: <CAFEAcA--YgJ-=b6YmO8KWQgMcWbuBp7h2WJHDcuzddkk_xFcwg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v1 0/8] Xilinx queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistai@xilinx.com>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>

On 16 January 2018 at 14:49, Edgar E. Iglesias
<edgar.iglesias@xilinx.com> wrote:
> This didn't show up on my clang testing, do you mind sharing configure line and clang version you use?
>
> @Alistair, it does seem like the call to microblaze_load_kernel is passing wrong arguments.
> Can you have a look?

exec '../../configure' '--cc=clang' '--cxx=clang++' '--enable-gtk'
'--extra-cflags=-fsanitize=undefined  -fno-sanitize=shift-base
-Werror' "$@"

with clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
on ubuntu xenial.

thanks
-- PMM
