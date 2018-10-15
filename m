Received: from eggs.gnu.org ([2001:4830:134:3::10]:38668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gC8sy-00010k-Lh
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 15:50:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gC8su-0004v0-9K
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 15:50:40 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:42539)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gC8sr-0004sS-Do
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 15:50:34 -0400
Received: by mail-pg1-x541.google.com with SMTP id i4-v6so9646421pgq.9
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 12:50:29 -0700 (PDT)
References: <20181010203735.27918-1-aclindsa@gmail.com>
	<20181010203735.27918-6-aclindsa@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4fff310a-8fc6-91f9-6caf-315c84d983d0@linaro.org>
Date: Mon, 15 Oct 2018 12:50:25 -0700
MIME-Version: 1.0
In-Reply-To: <20181010203735.27918-6-aclindsa@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Aaron Lindsay <aclindsa@gmail.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Michael Spradling <mspradli@codeaurora.org>, qemu-devel@nongnu.org, Digant Desai <digantd@codeaurora.org>

On 10/10/18 1:37 PM, Aaron Lindsay wrote:
> pmccntr_read and pmccntr_write contained duplicate code that was already
> being handled by pmccntr_sync. Consolidate the duplicated code into two
> functions: pmccntr_op_start and pmccntr_op_finish. Add a companion to
> c15_ccnt in CPUARMState so that we can simultaneously save both the
> architectural register value and the last underlying cycle count - this
> ensures time isn't lost and will also allow us to access the 'old'
> architectural register value in order to detect overflows in later
> patches.
> 
> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> ---
>  target/arm/cpu.h     | 26 ++++++++----
>  target/arm/helper.c  | 96 +++++++++++++++++++++++---------------------
>  target/arm/machine.c |  8 ++--
>  3 files changed, 73 insertions(+), 57 deletions(-)

Ok, looking at this follow-up makes more sense than the previous patch.  Would
it make sense to squash these two together?

It also makes sense why you'd need the post_save hook.


r~
