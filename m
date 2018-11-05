Received: from eggs.gnu.org ([2001:4830:134:3::10]:47339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJhnM-0001c4-Df
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:32:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJhnK-0001L2-D9
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:32:08 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:38444)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gJhnI-0001AK-Cq
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:32:04 -0500
Received: by mail-oi1-x244.google.com with SMTP id v83-v6so7990447oia.5
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 08:31:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1539939312-19713-1-git-send-email-hongbo.zhang@linaro.org>
References: <1539939312-19713-1-git-send-email-hongbo.zhang@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Nov 2018 16:31:33 +0000
Message-ID: <CAFEAcA8hB=+YKNc8WSxrdmqigtErOsPJSAhYnq0Ha8_Ey=NaMg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4] Add arm SBSA reference machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hongbo Zhang <hongbo.zhang@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Leif Lindholm <leif.lindholm@linaro.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>

On 19 October 2018 at 09:55, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
> For the Aarch64, there is one machine 'virt', it is primarily meant to
> run on KVM and execute virtualization workloads, but we need an
> environment as faithful as possible to physical hardware,  to support
> firmware and OS development for pysical Aarch64 machines.
>
> See the patch commit comments for the features description.
>
> V4 changes:
>  - rebased to v3.0.0
>  - removed timer, uart, rtc, *hci device tree nodes
>    (others were removerd in v3)
>  - other minore codes clean up, mainly unsed header files, comments etc.
>
> V3 changes:
>  - rename the platform 'sbsa-ref'
>  - move all the codes to a separate file sbsa-ref.c
>  - remove paravirtualized fw_cfg device
>  - do not supply ACPI tables, since firmware will do it
>  - supply only necessary DT nodes
>  - and other minor code clean up

Hi; just a note that this series isn't going to make it into
the 3.1 release. It is still on my to-review queue for 4.0,
but I may not get to reviewing it for a little bit while I
deal with for-3.1 work.

thanks
-- PMM
