Received: from eggs.gnu.org ([2001:4830:134:3::10]:51887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aclindsa@gmail.com>) id 1gC9W9-000521-RE
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 16:31:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aclindsa@gmail.com>) id 1gC9W7-0004KK-Jv
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 16:31:09 -0400
Date: Mon, 15 Oct 2018 16:30:37 -0400
From: Aaron Lindsay <aclindsa@gmail.com>
Message-ID: <20181015203037.GJ3671@okra.localdomain>
References: <20181010203735.27918-1-aclindsa@gmail.com>
	<20181010203735.27918-6-aclindsa@gmail.com>
	<4fff310a-8fc6-91f9-6caf-315c84d983d0@linaro.org>
	<8e83cbd8-8c2f-f6f1-4423-f19a5f13aa5e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e83cbd8-8c2f-f6f1-4423-f19a5f13aa5e@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v6 05/14] target/arm: Reorganize PMCCNTR
 accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Michael Spradling <mspradli@codeaurora.org>, qemu-devel@nongnu.org, Digant Desai <digantd@codeaurora.org>

On Oct 15 13:19, Richard Henderson wrote:
> On 10/15/18 12:50 PM, Richard Henderson wrote:
> > Ok, looking at this follow-up makes more sense than the previous patch.  Would
> > it make sense to squash these two together?
> 
> Or, rather, split into two different patches: the first splits pmccntr_sync and
> updates all of the existing uses, and the second which adds the migration hooks.

To make sure I understand, you're suggesting essentially reversing the
order of patches 4 and 5 (and fixing everything up to be consistent)?

-Aaron
