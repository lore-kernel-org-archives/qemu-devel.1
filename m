Received: from eggs.gnu.org ([2001:4830:134:3::10]:39461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1chK4H-0007Ft-SG
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:54:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1chK4H-0007Ss-2x
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:54:09 -0500
References: <1487850673-26455-1-git-send-email-vijay.kilari@gmail.com>
	<1487850673-26455-2-git-send-email-vijay.kilari@gmail.com>
	<CAFEAcA_rYx2+zGB16O4w=BjOP9e-jn5kSGT8rCosHsgubo-w_Q@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <c78577ef-f660-ccda-f15e-60186bdfa6e5@redhat.com>
Date: Fri, 24 Feb 2017 18:53:59 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_rYx2+zGB16O4w=BjOP9e-jn5kSGT8rCosHsgubo-w_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 1/5] kernel: Add definitions for GICv3
 attributes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Vijay Kilari <vijay.kilari@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Christoffer Dall <christoffer.dall@linaro.org>, Pavel Fedin <p.fedin@samsung.com>, Marc Zyngier <marc.zyngier@arm.com>, QEMU Developers <qemu-devel@nongnu.org>, Vijaya Kumar K <Vijaya.Kumar@cavium.com>

Hi Peter,

On 23/02/2017 19:35, Peter Maydell wrote:
> On 23 February 2017 at 11:51,  <vijay.kilari@gmail.com> wrote:
>> From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
>>
>> This temporary patch adds kernel API definitions.
>> Use proper header update procedure after these features
>> are released.
> 
> I can't put this patchset into QEMU with this temporary patch;
> you need to do a proper kernel headers update with
> the update-linux-headers.sh script.

With [Qemu-devel] [PATCH 0/2] update Linux headers to 4.11,
Paolo fixed the update-linux-headers.sh

(scripts/Makefile.headersinst:62: *** Missing generated UAPI file
./arch/arm/include/generated/uapi/asm/unistd-common.h.

and also updated the ARM headers so this patch is not needed anymore I
think. This is not pulled yet though.

I tested it on Cavium ThunderX without this first patch.

Tested-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric



> 
> thanks
> -- PMM
> 
