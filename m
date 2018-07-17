Received: from eggs.gnu.org ([2001:4830:134:3::10]:36450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffQyx-0003gn-6G
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:29:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffQyw-0002k1-Gy
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:29:39 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:34228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ffQyw-0002jg-BL
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:29:38 -0400
Received: by mail-oi0-x241.google.com with SMTP id 13-v6so2412745ois.1
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 07:29:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180714171601.5734-21-luc.michel@greensocs.com>
References: <20180714171601.5734-1-luc.michel@greensocs.com>
	<20180714171601.5734-21-luc.michel@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Jul 2018 15:29:17 +0100
Message-ID: <CAFEAcA_830LCj6drri3fOe+4-T5T6woKkXxx+UcKX6jihoVSsg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 20/20] arm/virt: Add support for GICv2
 virtualization extensions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>, Mark Burton <mark.burton@greensocs.com>, Jan Kiszka <jan.kiszka@web.de>

On 14 July 2018 at 18:16, Luc Michel <luc.michel@greensocs.com> wrote:
> Add support for GICv2 virtualization extensions by mapping the necessary
> I/O regions and connecting the maintenance IRQ lines.
>
> Declare those additions in the device tree and in the ACPI tables.
>
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
