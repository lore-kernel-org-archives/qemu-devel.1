Received: from eggs.gnu.org ([2001:4830:134:3::10]:57339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cbWuK-0000i1-PF
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 13:23:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cbWuK-000376-2c
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 13:23:56 -0500
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:37966)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cbWuJ-00036b-SG
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 13:23:56 -0500
Received: by mail-wm0-x22d.google.com with SMTP id r141so197196382wmg.1
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 10:23:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <C4E1DF44-1626-425D-880E-0053AD688422@linaro.org>
References: <1486560712-44171-1-git-send-email-agraf@suse.de>
	<ef6b903b-5224-b4eb-1080-a3689fcec70a@redhat.com>
	<f2f119bc-9c22-ad52-ff26-7d6ecc213a3c@suse.de>
	<c1ff3829-b068-881a-1523-317ef0d31689@redhat.com>
	<C4E1DF44-1626-425D-880E-0053AD688422@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 Feb 2017 18:23:32 +0000
Message-ID: <CAFEAcA8rjjzgvN-RuNPVHM53R9V9xry1Uj_ArmF1va-Y920eBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] target-arm: Declare virtio-mmio
 as dma-coherent in dt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Laszlo Ersek <lersek@redhat.com>, Shannon Zhao <shannon.zhao@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>

On 8 February 2017 at 16:27, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> The _CCA property is mandatory on arm64, and there is no default.

Is there a tool that can check this kind of requirement
and complain about issues in the ACPI tables (and
ditto, device tree)? It's really easy to produce a
dt or ACPI table that works with current kernels and
then turns out to have a problem six or twelve
months down the line :-(

thanks
-- PMM
