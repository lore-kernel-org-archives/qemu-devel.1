Received: from eggs.gnu.org ([2001:4830:134:3::10]:45558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dwZ0o-0005pL-N1
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 15:25:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dwZ0n-0007Zx-CZ
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 15:25:50 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:55847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dwZ0n-0007Zg-49
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 15:25:49 -0400
Received: by mail-wr0-x22d.google.com with SMTP id l39so9653954wrl.12
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 12:25:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4f243068-aaea-776f-d18f-f9e05e7be9cd@siemens.com>
References: <4f243068-aaea-776f-d18f-f9e05e7be9cd@siemens.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Sep 2017 20:25:27 +0100
Message-ID: <CAFEAcA-COFAhzOWq=jLKNvSQ3aE=jcGgqunnBABjYi=g=qeFZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] arm: Fix SMC reporting to EL2 when QEMU
 provides PSCI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On 22 September 2017 at 08:02, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> This properly forwards SMC events to EL2 when PSCI is provided by QEMU
> itself and, thus, ARM_FEATURE_EL3 is off.
>
> Found and tested with the Jailhouse hypervisor. Solution based on
> suggestions by Peter Maydell.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---

Applied to target-arm.next, thanks.

-- PMM
