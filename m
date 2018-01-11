Received: from eggs.gnu.org ([2001:4830:134:3::10]:44817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZZYs-0001aM-R6
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 04:54:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZZYs-0004Y3-1m
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 04:54:14 -0500
Received: from mail-ot0-x22c.google.com ([2607:f8b0:4003:c0f::22c]:39088)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eZZYr-0004XX-TX
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 04:54:13 -0500
Received: by mail-ot0-x22c.google.com with SMTP id 37so1620688otv.6
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 01:54:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1515521823-4292-1-git-send-email-jcmvbkbc@gmail.com>
References: <1515521823-4292-1-git-send-email-jcmvbkbc@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jan 2018 09:53:52 +0000
Message-ID: <CAFEAcA8cbfgBai0qjR-x28CUxRrU6rCh1pLEZYxhHJPBUaRm1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v3] target/xtensa updates
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

On 9 January 2018 at 18:17, Max Filippov <jcmvbkbc@gmail.com> wrote:
> Hi Peter,
>
> please pull the following batch of updates for the target/xtensa.
> Changes v2->v3:
> - Don't use g_malloc_n, use g_new instead.
> Changes v1->v2:
> - Drop no longer used function option_bits_enabled.
>
> The following changes since commit 0a0dc59d27527b78a195c2d838d28b7b49e5a639:
>
>   Update version for v2.11.0 release (2017-12-13 14:31:09 +0000)
>
> are available in the git repository at:
>
>   git://github.com/OSLL/qemu-xtensa.git tags/20180109-xtensa
>
> for you to fetch changes up to 5a6539e627faf9251e1db78238b9f9b870610518:
>
>   target/xtensa: implement disassembler (2018-01-09 09:55:39 -0800)
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

Applied, thanks.

-- PMM
