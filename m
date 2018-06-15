Received: from eggs.gnu.org ([2001:4830:134:3::10]:34460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTnz7-0001vG-Mn
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 08:37:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTnz6-0000zb-SV
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 08:37:45 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:37922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fTnz6-0000yp-Dn
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 08:37:44 -0400
Received: by mail-oi0-x241.google.com with SMTP id d5-v6so8659143oib.5
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 05:37:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1527690380-9782-3-git-send-email-eric.auger@redhat.com>
References: <1527690380-9782-1-git-send-email-eric.auger@redhat.com>
	<1527690380-9782-3-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 13:37:23 +0100
Message-ID: <CAFEAcA_urHG9cDqeoq0ot8zEFR=9WW3qdp4sQtq4YQJvQz5SxQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/arm/virt: Add virt-3.0 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Andrew Jones <drjones@redhat.com>, Wei Huang <wei@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Laszlo Ersek <lersek@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>

On 30 May 2018 at 15:26, Eric Auger <eric.auger@redhat.com> wrote:
> Add virt-3.0 machine type.
>
> This machine type supports highmem 256MB ECAM by default.
> This feature is disabled for earlier machine types and
> if highmem is off.
>
> The high 256MB ECAM region is chosen instead of the legacy
> 16MB one if the machine type allows it, if highmem is set
> (LPAE supported by the guest) and (!firmware_loaded || aarch64).
> Indeed aarch32 mode FW may not support this high ECAM region.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

I think these patches should be the other way round --
create the new 3.0 machine type first, and then in the
patch adding the high ECAM region you can make it be
only if newer machine type.

thanks
-- PMM
