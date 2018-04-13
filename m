Received: from eggs.gnu.org ([2001:4830:134:3::10]:34083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6z22-00082X-6k
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 09:46:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6z21-00070L-Fm
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 09:46:26 -0400
Received: from mail-ot0-x22a.google.com ([2607:f8b0:4003:c0f::22a]:46709)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f6z21-0006zm-AU
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 09:46:25 -0400
Received: by mail-ot0-x22a.google.com with SMTP id v64-v6so9896435otb.13
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 06:46:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e2fcd39f-f7f9-f8a2-7ef2-68a626e6bd0f@redhat.com>
References: <1522160122-10744-1-git-send-email-eric.auger@redhat.com>
	<1522160122-10744-5-git-send-email-eric.auger@redhat.com>
	<CAFEAcA8sQSuVcYPyE58tjapxxe6FNdD5qcyftYrZeWQ0fbev8w@mail.gmail.com>
	<e2fcd39f-f7f9-f8a2-7ef2-68a626e6bd0f@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Apr 2018 14:46:04 +0100
Message-ID: <CAFEAcA-D083O3EVoF_DXPpXf2ax6Kfad9HOToFjZg8tnRE=g7Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC 4/8] hw/intc/arm_gicv3: Implement
 register_redist_region API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Andrew Jones <drjones@redhat.com>, Wei Huang <wei@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Christoffer Dall <cdall@kernel.org>, Shannon Zhao <zhaoshenglong@huawei.com>

On 13 April 2018 at 14:44, Auger Eric <eric.auger@redhat.com> wrote:
> Actually this is an API provided to the machine and not the device
> itself directly playing with the mapping.
>
> If not acceptable, I need to match the existing notifier framework and
> do something similar taking into account the new GROUP/ATTR address
> semantics here.

I think I'd rather that we continue to tell the kernel about
the addresses of device related regions in the same general
way that we do at the moment.

thanks
-- PMM
