Received: from eggs.gnu.org ([2001:4830:134:3::10]:50874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fL3aE-0002L1-Qd
	for qemu-devel@nongnu.org; Tue, 22 May 2018 05:27:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fL3aD-0001NJ-U3
	for qemu-devel@nongnu.org; Tue, 22 May 2018 05:27:54 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:39563)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fL3aD-0001N4-Ol
	for qemu-devel@nongnu.org; Tue, 22 May 2018 05:27:53 -0400
Received: by mail-ot0-x243.google.com with SMTP id l12-v6so20155281oth.6
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 02:27:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <28b927d3-da58-bce4-cc13-bfec7f9b1cb9@siemens.com>
References: <28b927d3-da58-bce4-cc13-bfec7f9b1cb9@siemens.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 May 2018 10:27:32 +0100
Message-ID: <CAFEAcA_aD50sTDBmmmq7BYVNJd6bDcwSYY-PEzOB_e-NuOFRQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/intc/arm_gicv3: Fix APxR<n> register
 dispatching
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>

On 22 May 2018 at 07:52, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> There was a nasty flip in identifying which register group an access is
> targeting. The issue caused spuriously raised priorities of the guest
> when handing CPUs over in the Jailhouse hypervisor.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Oops. Applied to target-arm.next, and added
Cc: qemu-stable@nongnu.org.

thanks
-- PMM
