Received: from eggs.gnu.org ([2001:4830:134:3::10]:45694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqiun-0002vt-3v
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:52:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqium-0005jz-3f
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:52:00 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:42907)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqiul-0005jW-Bj
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:52:00 -0400
Received: by mail-oi0-x243.google.com with SMTP id b16-v6so15382822oic.9
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 10:51:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1534507843-4251-1-git-send-email-hans-erik.floryd@rt-labs.com>
References: <1534507843-4251-1-git-send-email-hans-erik.floryd@rt-labs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Aug 2018 18:51:38 +0100
Message-ID: <CAFEAcA_Ki4Sqke3qExAihjx+x9XpX2e6DJG0ua-VEvdes_gKBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3] sdhci: add i.MX SD Stable Clock bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>

On 17 August 2018 at 13:10, Hans-Erik Floryd
<hans-erik.floryd@rt-labs.com> wrote:
> Add the ESDHC PRSSTAT_SDSTB bit, using the value of SDHC_CLOCK_INT_STABLE.
> Freescale recommends checking this bit when changing clock frequency.
>
> Signed-off-by: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>
> ---
>  hw/sd/sdhci-internal.h | 2 ++
>  hw/sd/sdhci.c          | 8 ++++++++
>  2 files changed, 10 insertions(+)

Applied to target-arm.next, thanks.

(Your indentation was off-by-one -- we use 4-space indent -- but I fixed that.)

-- PMM
