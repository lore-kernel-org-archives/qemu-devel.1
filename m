Received: from eggs.gnu.org ([2001:4830:134:3::10]:41245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYxx1-0006Cz-97
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 12:44:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYxx0-0006CX-F4
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 12:44:39 -0500
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:45792)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eYxx0-0006Bt-AA
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 12:44:38 -0500
Received: by mail-oi0-x22f.google.com with SMTP id j129so1757410oib.12
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 09:44:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1515433749-5839-1-git-send-email-jcmvbkbc@gmail.com>
References: <1515433749-5839-1-git-send-email-jcmvbkbc@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jan 2018 17:44:16 +0000
Message-ID: <CAFEAcA92ceiqpHgnVQrxx2M452FxdA4v2kaTT-cQyf5x3Rsr0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/16] target/xtensa updates
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

On 8 January 2018 at 17:49, Max Filippov <jcmvbkbc@gmail.com> wrote:
> Hi Peter,
>
> please pull the following batch of updates for the target/xtensa.
> Changes v1->v2:
> - Drop no longer used function option_bits_enabled.
>
> The following changes since commit 0a0dc59d27527b78a195c2d838d28b7b49e5a639:
>
>   Update version for v2.11.0 release (2017-12-13 14:31:09 +0000)
>
> are available in the git repository at:
>
>   git://github.com/OSLL/qemu-xtensa.git tags/20180108-xtensa
>
> for you to fetch changes up to 7ffb3123b24e42a3a94e865434b4180025b9f9ca:
>
>   target/xtensa: implement disassembler (2018-01-08 09:37:32 -0800)
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

/Users/pm215/src/qemu-for-merges/target/xtensa/helper.c:63:26: error:
implicit declaration of function 'g_malloc_n' is invalid in C99
[-Werror,-Wimplicit-function-declaration]
    config->opcode_ops = g_malloc_n(opcodes, sizeof(XtensaOpcodeOps *));
                         ^

g_malloc_n() only came in in glib 2.24, so this doesn't build on
glib 2.22 (our minimum required version).

thanks
-- PMM
