Received: from eggs.gnu.org ([2001:4830:134:3::10]:42513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyKgu-0000z1-5l
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:04:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyKgt-0000wH-Bd
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:04:52 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:45160)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eyKgt-0000vl-5m
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:04:51 -0400
Received: by mail-ot0-x242.google.com with SMTP id q5-v6so2513077oth.12
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 10:04:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180320151355.25854-1-pbonzini@redhat.com>
References: <20180320151355.25854-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Mar 2018 17:04:29 +0000
Message-ID: <CAFEAcA-CY+TJn3XS01uqTzgm3SzMQaxOPPtAaM97DD+sd1Pofg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] sdhci: fix incorrect use of Error *
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 20 March 2018 at 15:13, Paolo Bonzini <pbonzini@redhat.com> wrote:
> Detected by Coverity (CID 1386072, 1386073, 1386076, 1386077).  local_err
> was unused, and this made the static analyzer unhappy.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/sd/sdhci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 1b828b104d..63c44a4ee8 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -1474,7 +1474,7 @@ static void sdhci_pci_realize(PCIDevice *dev, Error **errp)
>      Error *local_err = NULL;
>
>      sdhci_initfn(s);
> -    sdhci_common_realize(s, errp);
> +    sdhci_common_realize(s, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
> @@ -1556,7 +1556,7 @@ static void sdhci_sysbus_realize(DeviceState *dev, Error ** errp)
>      SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>      Error *local_err = NULL;
>
> -    sdhci_common_realize(s, errp);
> +    sdhci_common_realize(s, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
> --
> 2.16.2

Applied to target-arm.next, thanks.

-- PMM
