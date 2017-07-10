Received: from eggs.gnu.org ([2001:4830:134:3::10]:53387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUacQ-0002jG-NT
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:29:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUacL-0007eO-VG
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:29:02 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:36532)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dUacL-0007d0-OW
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:28:57 -0400
Received: by mail-wr0-f175.google.com with SMTP id c11so143370898wrc.3
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 08:28:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1498927637-14496-3-git-send-email-drjones@redhat.com>
References: <1498927637-14496-1-git-send-email-drjones@redhat.com>
	<1498927637-14496-3-git-send-email-drjones@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Jul 2017 16:27:35 +0100
Message-ID: <CAFEAcA-CQm1FuF7eyveSbSchRD1PkB-PDVNyMQhVny+bmWWAvg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/3] target/arm/kvm: split pmu init from
 creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Alexander Graf <agraf@suse.de>

On 1 July 2017 at 17:47, Andrew Jones <drjones@redhat.com> wrote:
> When adding a PMU with a userspace irqchip we only do the INIT
> stage of the device creation.

Can you explain why? My assumption would be that either
(a) we don't need the kernel's PMU, in which case don't
create it at all, or
(b) we do need the kernel's PMU, so we should both create
and INIT it.

If we do one but not the other then we've left a half
created and unusable PMU device in the kernel, haven't we?

thanks
-- PMM
