Received: from eggs.gnu.org ([2001:4830:134:3::10]:37509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gRH8i-0000aF-ID
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 08:41:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gRH8h-0008Bh-RF
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 08:41:28 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:38247)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gRH8h-0008BB-Dz
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 08:41:27 -0500
Received: by mail-oi1-x244.google.com with SMTP id a77so15808398oii.5
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 05:41:27 -0800 (PST)
MIME-Version: 1.0
References: <20181122180143.14237-1-eric.auger@redhat.com>
In-Reply-To: <20181122180143.14237-1-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Nov 2018 13:41:15 +0000
Message-ID: <CAFEAcA-dFhqCOdp=FHVO1+2kZXS9-jPHcRXfRLpiaYs1jEExLg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-3.1] MAINTAINERS: Add an ARM SMMU
 section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Thomas Huth <thuth@redhat.com>

On Thu, 22 Nov 2018 at 18:01, Eric Auger <eric.auger@redhat.com> wrote:
>
> Add a new ARM SMMU section and set Eric Auger as the maintainer
> for ARM SMMU emulation sources.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1032406c56..3cac9f0a0c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -151,6 +151,13 @@ F: disas/arm.c
>  F: disas/arm-a64.cc
>  F: disas/libvixl/
>
> +ARM SMMU
> +M: Eric Auger <eric.auger@redhat.com>
> +L: qemu-arm@nongnu.org
> +S: Maintained
> +F: hw/arm/smmu*
> +F: include/hw/arm/smmu*
> +
>  CRIS
>  M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
>  S: Maintained

Applied to target-arm.next, thanks.

-- PMM
