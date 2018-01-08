Received: from eggs.gnu.org ([2001:4830:134:3::10]:56107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYa6O-0006SM-Pd
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 11:16:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYa6O-00061k-0R
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 11:16:44 -0500
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:37786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eYa6N-00061C-RA
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 11:16:43 -0500
Received: by mail-oi0-x236.google.com with SMTP id e144so2264912oib.4
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 08:16:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1514396819-29997-1-git-send-email-jcmvbkbc@gmail.com>
References: <1514396819-29997-1-git-send-email-jcmvbkbc@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jan 2018 16:16:22 +0000
Message-ID: <CAFEAcA8wdV_MigoMEUDpxD7nGx3uGDKJMykg=-qftmZCu0kkkg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 00/16] target/xtensa updates
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

On 27 December 2017 at 17:46, Max Filippov <jcmvbkbc@gmail.com> wrote:
> Hi Peter,
>
> please pull the following batch of updates for the target/xtensa.
>
> The following changes since commit 0a0dc59d27527b78a195c2d838d28b7b49e5a639:
>
>   Update version for v2.11.0 release (2017-12-13 14:31:09 +0000)
>
> are available in the git repository at:
>
>   git://github.com/OSLL/qemu-xtensa.git tags/20171227-xtensa
>
> for you to fetch changes up to d462b6b6b79f092327927b3fb3ac20505c90a706:
>
>   target/xtensa: implement disassembler (2017-12-18 21:26:20 -0800)
>
> ----------------------------------------------------------------
> target/xtensa updates:
>
> - add libisa to the xtensa target;
> - change xtensa instruction translator to use it;
> - switch existing xtensa cores to use it;
> - add support for a number of instructions: salt/saltu, const16,
>   GPIO32 group, debug mode and MMU-related;
> - add disassembler for Xtensa.

Hi; I'm afraid this doesn't build on clang:

/home/petmay01/linaro/qemu-for-merges/target/xtensa/translate.c:261:20:
error: unused function 'option_bits_enabled'
[-Werror,-Wunused-function]
static inline bool option_bits_enabled(DisasContext *dc, uint64_t opt)
                   ^
1 error generated.

Probably an easy fix; clang is stricter than gcc about
not liking unused static inline functions in .c files.

thanks
-- PMM
