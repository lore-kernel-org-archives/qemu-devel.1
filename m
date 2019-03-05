Received: from eggs.gnu.org ([209.51.188.92]:42396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1AaS-0001jd-2k
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 08:58:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1AaR-0002iG-1j
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 08:58:27 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:34063)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1AaQ-0002h9-Ct
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 08:58:26 -0500
Received: by mail-ot1-x343.google.com with SMTP id 98so7493756oty.1
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 05:58:26 -0800 (PST)
MIME-Version: 1.0
References: <1551741382-31691-1-git-send-email-michelheily@gmail.com>
In-Reply-To: <1551741382-31691-1-git-send-email-michelheily@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Mar 2019 13:58:09 +0000
Message-ID: <CAFEAcA9qCTOcxSG9VJn=LJRBvazr-StjWVdctOjMVw5R7meoWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3] hw/arm/stellaris: Implement watchdog
 timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michel Heily <michelheily@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "open list:Stellaris" <qemu-arm@nongnu.org>

On Mon, 4 Mar 2019 at 23:16, <michelheily@gmail.com> wrote:
>
> From: Michel Heily <michelheily@gmail.com>
>
> I've added the stellaris watchdog functionality because I needed it for a home project.
> Documentation for the hardware can be found at http://www.ti.com/lit/ds/symlink/lm3s6965.pdf.
>
> Signed-off-by: Michel Heily <michelheily@gmail.com>

This patch looks good to me. I made a few minor tweaks:
 * rewrote the commit message to fit the way we normally
   describe changes
 * fixed a few minor nits found by scripts/checkpatch.pl
   (long lines, misplaced spaces, that kind of thing)
 * added a comment to the .c file with the docs URL

and I've applied it to my target-arm.next tree, so it should
get into master some time this week and will be in the
4.0 release.

Thanks for your contribution!

-- PMM
