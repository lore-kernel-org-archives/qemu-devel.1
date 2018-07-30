Received: from eggs.gnu.org ([2001:4830:134:3::10]:50881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fkBl0-0002jo-Nz
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 13:14:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fkBkz-00068z-P1
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 13:14:54 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:33687)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fkBkz-00068P-Ju
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 13:14:53 -0400
Received: by mail-oi0-x243.google.com with SMTP id l10-v6so22655529oii.0
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 10:14:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180727095421.386-1-luc.michel@greensocs.com>
References: <20180727095421.386-1-luc.michel@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Jul 2018 18:14:32 +0100
Message-ID: <CAFEAcA8-79oCm5YfxPJ0r2UDaGXp7ox7e2cZ_cmpy9xuZvoDag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 00/20] arm_gic: add virtualization
 extensions support
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

On 27 July 2018 at 10:54, Luc Michel <luc.michel@greensocs.com> wrote:
> v5:
>   - Patch 7: dropped unreachable 'return NULL' [Peter]
>   - Patch 12: reworked the way invalid vIRQ are handled. The
>     specification being uncleared, I used real hardware to check our
>     previous hypothesises. See commit message for the adopted behaviour.
>     The main difference is that when EOIMode is true (EOI split is
>     enabled), a write to V_EOIR never increments H_HCR.EOICount. [Peter]
>   - Patch 14-15: fixed commit message regarding mirrored regions. [Peter

Thanks (and especially for taking the time to check the hardware
behaviour where the spec was unclear).

I've applied this series to my target-arm.for-3.1 branch ready
for when we reopen master after the 3.0 release.

thanks
-- PMM
