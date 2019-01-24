Received: from eggs.gnu.org ([209.51.188.92]:35044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmc8N-0002nj-1N
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:21:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmbtQ-0004Qi-CH
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:05:54 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:43351)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gmbtO-0003kY-67
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:05:50 -0500
Received: by mail-oi1-x229.google.com with SMTP id u18so4345884oie.10
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 02:05:35 -0800 (PST)
MIME-Version: 1.0
References: <20190122185020.25086-1-jcmvbkbc@gmail.com>
In-Reply-To: <20190122185020.25086-1-jcmvbkbc@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Jan 2019 10:05:22 +0000
Message-ID: <CAFEAcA-Ex3KvxRsFM5KsN65LyZetwBQqMnoC2_yrims8CT=J5A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/8] target/xtensa queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Tue, 22 Jan 2019 at 18:50, Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> Hi Peter,
>
> please pull the following batch of updates for target/xtensa:
>
> The following changes since commit 32a1a94dd324d33578dca1dc96d7896a0244d768:
>
>   Update version for v3.1.0 release (2018-12-11 17:18:37 +0000)
>
> are available in the git repository at:
>
>   git://github.com/OSLL/qemu-xtensa.git tags/20190122-xtensa
>
> for you to fetch changes up to 9584116f94c75411998703b76cc6a6e9e7fd7a8b:
>
>   target/xtensa: move non-HELPER functions to helper.c (2019-01-13 23:36:31 -0800)
>
> ----------------------------------------------------------------
> target/xtensa: zero overhead loops rework/helpers split
>
> - change xtensa zero overhead loops implementation to avoid invalidation
>   of TBs corresponding to previous loop body when a new loop is
>   encountered;
> - extract helper function groups from op_helper.c and move them into
>   separate source files: exc_helper.c (exception helpers), win_helper.c
>   (windowed registers helpers), fpu_helper.c (floating point helpers),
>   mmu_helper.c (memory management helpers) and dbg_helper.c (native debug
>   helpers).

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
