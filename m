Received: from eggs.gnu.org ([209.51.188.92]:56887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guMWD-0000P4-Jv
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:17:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guMWC-000401-SE
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:17:57 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:37130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guMWC-0003iG-MK
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:17:56 -0500
Received: by mail-ot1-x343.google.com with SMTP id b3so12444466otp.4
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 11:17:28 -0800 (PST)
MIME-Version: 1.0
References: <1550047098-1210-1-git-send-email-thuth@redhat.com>
	<1550047098-1210-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1550047098-1210-3-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 19:17:16 +0000
Message-ID: <CAFEAcA8XGsKzS=4=wn7k0ZYRpw7toNUtaxQarcvfmrcp_7LvZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 02/25] hw/arm: Express dependencies of
 the highbank machines with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Yang Zhong <yang.zhong@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>

On Wed, 13 Feb 2019 at 08:38, Thomas Huth <thuth@redhat.com> wrote:
>
> Add Kconfig dependencies for the highbank machine (and the midway
> machine).
> This patch is slightly based on earlier work by =C3=81kos Kov=C3=A1cs (i.=
e.
> his "hw/arm/Kconfig: Add ARM Kconfig" patch).
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  default-configs/arm-softmmu.mak |  4 +---
>  hw/arm/Kconfig                  | 12 ++++++++++++
>  2 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmm=
u.mak
> index 3baafc4..59734ee 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -6,6 +6,7 @@ CONFIG_ARM_V7M=3Dy
>  CONFIG_PCI_DEVICES=3Dy
>
>  CONFIG_EXYNOS4=3Dy
> +CONFIG_HIGHBANK=3Dy
>
>  CONFIG_VGA=3Dy
>  CONFIG_NAND=3Dy
> @@ -54,14 +55,12 @@ CONFIG_PL022=3Dy
>  CONFIG_PL031=3Dy
>  CONFIG_PL041=3Dy
>  CONFIG_PL050=3Dy
> -CONFIG_PL061=3Dy
>  CONFIG_PL080=3Dy
>  CONFIG_PL110=3Dy
>  CONFIG_PL181=3Dy
>  CONFIG_PL190=3Dy
>  CONFIG_PL330=3Dy
>  CONFIG_CADENCE=3Dy
> -CONFIG_XGMAC=3Dy

Could you explain the logic for when CONFIG_*=3Dy
lines get deleted from the arm-softmmu.mak?
In this patch PL061 has been deleted, but PL011,
PL022, PL031 have not, though all these devices are
used in both Highbank and in other not-yet-converted
machine types. What's the difference ?

thanks
-- PMM
