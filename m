Received: from eggs.gnu.org ([2001:4830:134:3::10]:43479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ctuxA-0007hh-OQ
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 07:42:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ctuxA-0007u4-2O
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 07:42:52 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:32923)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ctux9-0007tX-Qx
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 07:42:51 -0400
Received: by mail-wr0-x22e.google.com with SMTP id w43so101924922wrb.0
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 04:42:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1490721640-13052-1-git-send-email-eric.auger@redhat.com>
References: <1490721640-13052-1-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 Mar 2017 12:42:28 +0100
Message-ID: <CAFEAcA8Or3XtKwRudnf5jc=bH_OTwqWrvbPivNf49zYg-RgaeA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2] hw/intc/arm_gicv3_kvm: Check
 KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS in reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Vijay Kilari <vijay.kilari@gmail.com>, "Kumar, Vijaya" <Vijaya.Kumar@cavium.com>, Andrew Jones <drjones@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Prakash B <bjsprakash.linux@gmail.com>, bprakash@caviumnetworks.com, Sunil Goutham <sgoutham@cavium.com>

On 28 March 2017 at 18:20, Eric Auger <eric.auger@redhat.com> wrote:
> KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS needs to be checked before
> attempting to read ICC_CTLR_EL1; otherwise kernel versions not
> exposing this kvm device group will be incompatible with qemu 2.9.
>
> Fixes: 07a5628  ("hw/intc/arm_gicv3_kvm: Reset GICv3 cpu interface registers")
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reported-by: Prakash B <bjsprakash.linux@gmail.com>

Applied to master, thanks.

-- PMM
