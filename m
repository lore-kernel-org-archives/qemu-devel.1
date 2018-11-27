Received: from eggs.gnu.org ([2001:4830:134:3::10]:34805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gReSg-0003Bq-V2
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:35:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gReSf-0006tx-MY
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:35:38 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:36662)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gReSf-0006oo-DS
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:35:37 -0500
Received: by mail-oi1-x241.google.com with SMTP id x23so19452302oix.3
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 06:35:37 -0800 (PST)
MIME-Version: 1.0
References: <1543316565-1101590-1-git-send-email-luzhipeng@uniudc.com>
In-Reply-To: <1543316565-1101590-1-git-send-email-luzhipeng@uniudc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Nov 2018 14:35:24 +0000
Message-ID: <CAFEAcA-Ln_72bdLYSBg1ZLsPDg5UeXW++opU_5huUfpL3TUhnA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH RESEND] hw/virt/arm: Add support for
 Cortex-A72 in virt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: luzhipeng@uniudc.com
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, 27 Nov 2018 at 11:02, <luzhipeng@uniudc.com> wrote:
>
> From: ZhiPeng Lu <luzhipeng@uniudc.com>
>
> Signed-off-by: ZhiPeng Lu <luzhipeng@uniudc.com>
> ---
>  hw/arm/virt.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index a2b8d8f..f69e7eb 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -174,6 +174,7 @@ static const char *valid_cpus[] = {
>      ARM_CPU_TYPE_NAME("cortex-a15"),
>      ARM_CPU_TYPE_NAME("cortex-a53"),
>      ARM_CPU_TYPE_NAME("cortex-a57"),
> +    ARM_CPU_TYPE_NAME("cortex-a72"),
>      ARM_CPU_TYPE_NAME("host"),
>      ARM_CPU_TYPE_NAME("max"),
>  };

Applied, thanks.

-- PMM
