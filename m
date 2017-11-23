Received: from eggs.gnu.org ([2001:4830:134:3::10]:49585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHrL9-0001za-RL
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:14:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHrL8-0006Y1-L3
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:14:51 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:35323)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eHrL8-0006Xb-HO
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:14:50 -0500
Received: by mail-ot0-x244.google.com with SMTP id b17so16285042oth.2
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 05:14:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171116163732.31584-1-sw@weilnetz.de>
References: <20171116163732.31584-1-sw@weilnetz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Nov 2017 13:14:29 +0000
Message-ID: <CAFEAcA96KUqqyJeiRhZd+-67CwSEFjb=mnEG0wZ-qbf_ALKQxg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.11] Fix build of console and GUI
 executables for Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: Fam Zheng <famz@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 16 November 2017 at 16:37, Stefan Weil <sw@weilnetz.de> wrote:
> It was broken by commit 8ecc89f6e792152496eccb684d6c8c48aba8027d which
> moved the SDL linker flags from macro libs_softmmu to macro SDL_LIBS.
>
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
>
> Peter, can you apply this fix directly, or do you need a pull request?
>
> Regards
> Stefan
>
>  Makefile.target | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile.target b/Makefile.target
> index e4244c188a..f9a9da7e7c 100644
> --- a/Makefile.target
> +++ b/Makefile.target
> @@ -22,7 +22,7 @@ QEMU_PROG_BUILD = $(QEMU_PROG)
>  else
>  # system emulator name
>  QEMU_PROG=qemu-system-$(TARGET_NAME)$(EXESUF)
> -ifneq (,$(findstring -mwindows,$(libs_softmmu)))
> +ifneq (,$(findstring -mwindows,$(SDL_LIBS)))
>  # Terminate program name with a 'w' because the linker builds a windows executable.
>  QEMU_PROGW=qemu-system-$(TARGET_NAME)w$(EXESUF)
>  $(QEMU_PROG): $(QEMU_PROGW)
> --
> 2.11.0

Applied, thanks.

-- PMM
