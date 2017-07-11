Received: from eggs.gnu.org ([2001:4830:134:3::10]:57307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUwxt-0000YR-1K
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:20:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUwxo-0007av-UI
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:20:40 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:36106)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dUwxo-0007ad-LZ
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:20:36 -0400
Received: by mail-wr0-f171.google.com with SMTP id c11so3460151wrc.3
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 08:20:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <149978163979.30.9098193331451925339@5d477a5b5989>
References: <1499771839-32518-1-git-send-email-peter.maydell@linaro.org>
	<149978163979.30.9098193331451925339@5d477a5b5989>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Jul 2017 16:19:14 +0100
Message-ID: <CAFEAcA_gih-_j87j5KzEN1NuDiLUexjJi9Ks-AjnFAx9+4Z6ow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/7] ARM: implement MPS2 board (with 2 FPGA
 flavours)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Fam Zheng <famz@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 11 July 2017 at 15:00,  <no-reply@patchew.org> wrote:

> === OUTPUT BEGIN ===
> Checking PATCH 1/7: hw/arm/mps2: Implement skeleton mps2-an385 and mps2-an511 board models...
> ERROR: line over 90 characters
> #72: FILE: hw/arm/mps2.c:22:
> + *   https://developer.arm.com/products/system-design/development-boards/cortex-m-prototyping-system

Six complaints about long lines that are unbreakable URLs
(in theory we could make checkpatch ignore the longline
issue for the case of "line is in a comment and there
is no space in the line where it could be broken before
the 80 column point", but that's a lot of effort)...

> ERROR: spaces required around that '*' (ctx:WxV)
> #104: FILE: hw/misc/mps2-scc.c:51:
> +static bool scc_cfg_write(MPS2SCC *s, unsigned function,
>                                    ^

...and one straight-up false positive (this isn't operator *).

thanks
-- PMM
