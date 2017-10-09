Received: from eggs.gnu.org ([2001:4830:134:3::10]:57304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1cAO-0007OY-Lm
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:48:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1cAN-0006PZ-T1
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:48:36 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:51297)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e1cAN-0006PG-MC
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:48:35 -0400
Received: by mail-wm0-x236.google.com with SMTP id f4so25643387wme.0
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 10:48:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1504286483-23327-20-git-send-email-eric.auger@redhat.com>
References: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
	<1504286483-23327-20-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Oct 2017 18:48:14 +0100
Message-ID: <CAFEAcA-J4FTDWzSTYbo=UcX7h5DCddd+K3XRW_umQ8XzKqrQgw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v7 19/20] hw/arm/smmuv3: [not for upstream]
 add SMMU_CMD_TLBI_NH_VA_AM handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Prem Mallappa <prem.mallappa@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Andrew Jones <drjones@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Radha.Chintakuntla@cavium.com, Sunil.Goutham@cavium.com, Radha Mohan <mohun106@gmail.com>, Trey Cain <tcain@qti.qualcomm.com>, Bharat Bhushan <bharat.bhushan@nxp.com>, Tomasz Nowicki <tn@semihalf.com>, "Michael S. Tsirkin" <mst@redhat.com>, Will Deacon <will.deacon@arm.com>, jean-philippe.brucker@arm.com, robin.murphy@arm.com, Peter Xu <peterx@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, wtownsen@redhat.com

On 1 September 2017 at 18:21, Eric Auger <eric.auger@redhat.com> wrote:
> SMMUV3 does not support any IOVA range TLBI command:
> SMMU_CMD_TLBI_NH_VA invalidates TLB entries by page.
> That's an issue when running DPDK on guest. DPDK uses
> hugepages but each time a hugepage is mapped on guest side,
> a storm of SMMU_CMD_TLBI_NH_VA commands get sent by the
> guest smmuv3 driver and trapped by QEMU for VFIO replay.
>
> Let's get prepared to handle implementation defined commands,
> SMMU_CMD_TLBI_NH_VA_VM, which invalidate a range of IOVAs.
>
> Upon this command, we notify the whole range in one host.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Definite NACK for this, I'm afraid. We should emulate the
hardware, not new things of our own devising.

thanks
-- PMM
