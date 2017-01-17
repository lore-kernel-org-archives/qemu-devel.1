Received: from eggs.gnu.org ([2001:4830:134:3::10]:55378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTSBl-0007kU-1L
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 06:44:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTSBk-0003RU-BZ
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 06:44:33 -0500
Received: from mail-vk0-x230.google.com ([2607:f8b0:400c:c05::230]:33294)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cTSBk-0003RK-78
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 06:44:32 -0500
Received: by mail-vk0-x230.google.com with SMTP id k127so44868135vke.0
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 03:44:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1484619334-10488-1-git-send-email-zhaoshenglong@huawei.com>
References: <1484619334-10488-1-git-send-email-zhaoshenglong@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Jan 2017 11:43:53 +0000
Message-ID: <CAFEAcA-2iqU3Ni_yabu93e1tvJ0YNiyANhf2Vb5FtDT1MtF_nA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2] arm: virt: Fix the segmentation fault
 when specifying an unsupported CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shannon Zhao <zhaoshenglong@huawei.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, wu.wubin@huawei.com

On 17 January 2017 at 02:15, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
>
> For example, using -cpu generic will cause qemu segmentation fault.
>
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
> V2: Just remove the member NULL instead of checking twice
> ---
>  hw/arm/virt.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 7a03f84..95ac585 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -167,7 +167,6 @@ static const char *valid_cpus[] = {
>      "cortex-a53",
>      "cortex-a57",
>      "host",
> -    NULL
>  };
>
>  static bool cpuname_valid(const char *cpu)

Applied to target-arm.next (with some expansion of the commit
message), thanks.

-- PMM
