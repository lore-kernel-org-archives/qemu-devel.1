Received: from eggs.gnu.org ([2001:4830:134:3::10]:49784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fn3BD-00010F-Qx
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:41:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fn3BD-0007Wr-2Z
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:41:47 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180806123445.1459-5-peter.maydell@linaro.org> (Peter Maydell's
	message of "Mon, 6 Aug 2018 13:34:44 +0100")
References: <20180806123445.1459-1-peter.maydell@linaro.org>
	<20180806123445.1459-5-peter.maydell@linaro.org>
Reply-To: quintela@redhat.com
Date: Tue, 07 Aug 2018 16:41:39 +0200
Message-ID: <871sba2q8s.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-3.0 v2 4/5] hw/intc/arm_gicv3_common:
 Move post_load hooks to top-level VMSD
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
> Contrary to the the impression given in docs/devel/migration.rst,
> the migration code does not run the pre_load hook for a
> subsection unless the subsection appears on the wire, and so
> this is not a place where you can set the default value for
> state for the "subsection not present" case. Instead this needs
> to be done in a pre_load hook for whatever is the parent VMSD
> of the subsection.
>
> We got this wrong in two of the subsection definitions in
> the GICv3 migration structs; fix this.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Juan Quintela <quintela@redhat.com>
