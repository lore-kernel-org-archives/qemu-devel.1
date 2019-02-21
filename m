Received: from eggs.gnu.org ([209.51.188.92]:38407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gwsWw-0007Ct-5D
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 12:53:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gwsWv-0007yt-20
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 12:53:06 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45254)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gwsWu-0007qQ-Ob
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 12:53:05 -0500
Received: by mail-ot1-x344.google.com with SMTP id 32so45580906ota.12
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 09:52:42 -0800 (PST)
MIME-Version: 1.0
References: <1550753160-15142-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1550753160-15142-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Feb 2019 17:52:31 +0000
Message-ID: <CAFEAcA8gpgFTy4ownqdwYVBx=P8iNZxrc7_PyB+zYXcpiD_KYQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/8] MIPS queue for February 21st, 2019
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>

On Thu, 21 Feb 2019 at 12:46, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.0-20190219' into staging (2019-02-18 16:20:13 +0000)
>
> are available in the git repository at:
>
>   https://github.com/AMarkovic/qemu tags/mips-queue-feb-21-2019
>
> for you to fetch changes up to 6cc0280153901ecf74a97905b36b56e2b2d59daa:
>
>   target/mips: fulong2e: Dynamically generate SPD EEPROM data (2019-02-21 13:36:30 +0100)
>
> ----------------------------------------------------------------
>
> MIPS queue for February 21st, 2019
>
>   - misc fixes for target/mips
>   - add QMP query-cpu-definitions command for mips
>   - improve MIPS Fulong 2E machine
>
> ----------------------------------------------------------------

> BALATON Zoltan (3):
>   hw/pci-host/bonito.c: Add PCI mem region mapped at the correct address
>   target/mips: fulong2e: Fix bios flash size
>   target/mips: fulong2e: Dynamically generate SPD EEPROM data

Hi -- this pullreq passes my build tests, but it looks like
these three patches are missing a signed-off-by line from
you as the maintainer. Could you fix that and resubmit, please?

(you might want to look at automatically scripting this check;
the script I use to create pull requests has some code to
do the "check all commits have my signoff" which you can
borrow if you like:
https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/make-pullreq#n98
)

thanks
-- PMM
