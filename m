Received: from eggs.gnu.org ([2001:4830:134:3::10]:56035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f42Fs-0005IJ-8N
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 06:36:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f42Fr-0005gR-BM
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 06:36:32 -0400
Received: from mail-ot0-x22f.google.com ([2607:f8b0:4003:c0f::22f]:37023)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f42Fr-0005gF-5W
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 06:36:31 -0400
Received: by mail-ot0-x22f.google.com with SMTP id y46-v6so26663574otd.4
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 03:36:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180402205654.14572-1-andrew.smirnov@gmail.com>
References: <20180402205654.14572-1-andrew.smirnov@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Apr 2018 11:36:10 +0100
Message-ID: <CAFEAcA86ty1ckj6eu0mSJomuzKnYbH6ueF5o3+Jp1B55nGNuUQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/arm: Allow manually specified /psci node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 2 April 2018 at 21:56, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> Change the code to avoid exiting QEMU if user provided DTB contains
> manually specified /psci node and skip any /psci related fixups
> instead.
>
> Fixes: 4cbca7d9b4 ("hw/arm: Move virt's PSCI DT fixup code to
> arm/boot.c")
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>
> Mark:
>
> Sorry about the inconvenience, here's the fix (hopefully) to the
> prolem you reported in [1]. Let me know if skipping all PSCI related
> DTB fixup if /psic node is present is not the behaviour you had in
> mind for your suggested fix.
>
> Thanks,
> Andrey Smirnov
>
> [1] http://lists.gnu.org/archive/html/qemu-devel/2018-03/msg06914.html



Applied to target-arm.next, thanks.

-- PMM
