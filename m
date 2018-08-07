Received: from eggs.gnu.org ([2001:4830:134:3::10]:47648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fn33v-0003O4-6O
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:34:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fn33u-0001xF-CF
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:34:15 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180806123445.1459-2-peter.maydell@linaro.org> (Peter Maydell's
	message of "Mon, 6 Aug 2018 13:34:41 +0100")
References: <20180806123445.1459-1-peter.maydell@linaro.org>
	<20180806123445.1459-2-peter.maydell@linaro.org>
Reply-To: quintela@redhat.com
Date: Tue, 07 Aug 2018 16:34:05 +0200
Message-ID: <87effa2qle.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-3.0 v2 1/5] hw/intc/arm_gicv3_common:
 Give no-migration-shift-bug subsection a needed function
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
> Currently the migration code incorrectly treats a subsection with
> no .needed function pointer as if it was the subsection list
> terminator -- it is ignored and so is everything after it.
> Work around this by giving vmstate_gicv3_gicd_no_migration_shift_bug
> a 'needed' function that always returns true.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
