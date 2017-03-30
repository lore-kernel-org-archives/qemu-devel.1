Received: from eggs.gnu.org ([2001:4830:134:3::10]:43435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsprakash.linux@gmail.com>) id 1ctShF-0005Ku-Dv
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 01:32:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsprakash.linux@gmail.com>) id 1ctShE-0000uW-Jn
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 01:32:33 -0400
MIME-Version: 1.0
In-Reply-To: <1490709513-7180-1-git-send-email-eric.auger@redhat.com>
References: <1490709513-7180-1-git-send-email-eric.auger@redhat.com>
From: Prakash B <bjsprakash.linux@gmail.com>
Date: Thu, 30 Mar 2017 11:02:28 +0530
Message-ID: <CACJhumf7PbkyXfj2kR9he8dPu9sfHZkxjwyaAuoUi6GmdxNhqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] hw/intc/arm_gicv3_kvm: Check
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
Cc: eric.auger.pro@gmail.com, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, drjones@redhat.com, vijay.kilari@gmail.com, Vijaya.Kumar@cavium.com, bprakash@caviumnetworks.com, Prakash B <bjsprakash.linux@gmail.com>

On Tue, Mar 28, 2017 at 7:28 PM, Eric Auger <eric.auger@redhat.com> wrote:
> KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS needs to be checked before
> attempting to read ICC_CTLR_EL1; otherwise kernel versions not
> exposing this kvm device group will be incompatible with qemu 2.9.
>
> Fixes: 07a5628  ("hw/intc/arm_gicv3_kvm: Reset GICv3 cpu interface registers")
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reported-by: Prakash B <bjsprakash.linux@gmail.com>
>
> ---
>
Thank Eric,

Verified compatibility for host kernel versions 4.4, 4.10 and
4.11-rc3, guest booted fine with these.

Tested-by: Prakash, Brahmajyosyula <Brahmajyosyula.Prakash@cavium.com>
