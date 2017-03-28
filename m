Received: from eggs.gnu.org ([2001:4830:134:3::10]:44957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1csuwZ-00036x-QL
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 13:30:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1csuwY-0006pp-Sn
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 13:30:07 -0400
References: <1490721640-13052-1-git-send-email-eric.auger@redhat.com>
From: Alexander Graf <agraf@suse.de>
Message-ID: <b3439d92-80a3-74f6-f060-13d04b691740@suse.de>
Date: Tue, 28 Mar 2017 19:30:00 +0200
MIME-Version: 1.0
In-Reply-To: <1490721640-13052-1-git-send-email-eric.auger@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
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
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: drjones@redhat.com, vijay.kilari@gmail.com, bprakash@caviumnetworks.com, bjsprakash.linux@gmail.com, Vijaya.Kumar@cavium.com, sgoutham@cavium.com, christoffer.dall@linaro.org

On 03/28/2017 07:20 PM, Eric Auger wrote:
> KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS needs to be checked before
> attempting to read ICC_CTLR_EL1; otherwise kernel versions not
> exposing this kvm device group will be incompatible with qemu 2.9.
>
> Fixes: 07a5628  ("hw/intc/arm_gicv3_kvm: Reset GICv3 cpu interface registers")
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reported-by: Prakash B <bjsprakash.linux@gmail.com>

With this I can indeed run 2.9 on a 4.4 based kernel again.

Tested-by: Alexander Graf <agraf@suse.de>


Alex
