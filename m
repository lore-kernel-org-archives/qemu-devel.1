Received: from eggs.gnu.org ([2001:4830:134:3::10]:47709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fn348-0003XP-BL
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:34:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fn347-00027Q-83
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:34:28 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180806123445.1459-3-peter.maydell@linaro.org> (Peter Maydell's
	message of "Mon, 6 Aug 2018 13:34:42 +0100")
References: <20180806123445.1459-1-peter.maydell@linaro.org>
	<20180806123445.1459-3-peter.maydell@linaro.org>
Reply-To: quintela@redhat.com
Date: Tue, 07 Aug 2018 16:34:18 +0200
Message-ID: <87a7py2ql1.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-3.0 v2 2/5] hw/intc/arm_gicv3_common:
 Combine duplicate .subsections in vmstate_gicv3_cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Shannon Zhao <shannon.zhaosl@gmail.com>

Peter Maydell <peter.maydell@linaro.org> wrote:
> Commit 6692aac411199064 accidentally introduced a second initialization
> of the .subsections field of vmstate_gicv3_cpu, instead of adding
> the new subsection to the existing list. The effect of this was
> probably that migration of GICv3 with virtualization enabled was
> broken (or alternatively that migration of ICC_SRE_EL1 was broken,
> depending on which of the two initializers the compiler used).
> Combine the two into a single list.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
