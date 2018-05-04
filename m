Received: from eggs.gnu.org ([2001:4830:134:3::10]:37522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEddt-0005jz-6W
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:33:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEdds-00015a-E3
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:33:09 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:34534)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fEdds-00015J-9j
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:33:08 -0400
Received: by mail-ot0-x244.google.com with SMTP id i5-v6so13469020otf.1
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 09:33:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1525326811-3233-1-git-send-email-thuth@redhat.com>
References: <1525326811-3233-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 May 2018 17:32:47 +0100
Message-ID: <CAFEAcA-JF1aeT1tcmLnyayRaEtHM2bY=77kQ4pOO_wLgAKk1Sg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/arm: Don't fail qtest due to missing SD
 card in -nodefaults mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Andrzej Zaborowski <balrogg@gmail.com>, Markus Armbruster <armbru@redhat.com>

On 3 May 2018 at 06:53, Thomas Huth <thuth@redhat.com> wrote:
> When running omap1/2 or pxa2xx based ARM machines with -nodefaults,
> they bail out immediately complaining about a "missing SecureDigital
> device". That's not how the "default" devices in vl.c are meant to
> work - it should be possible for a board to also start up without
> default devices. So let's turn the error message and exit() into
> a warning instead.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/arm/omap1.c  |  8 ++++----
>  hw/arm/omap2.c  |  8 ++++----
>  hw/arm/pxa2xx.c | 15 +++++++--------
>  3 files changed, 15 insertions(+), 16 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
