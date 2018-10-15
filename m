Received: from eggs.gnu.org ([2001:4830:134:3::10]:46074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gC9LJ-0000p4-UG
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 16:19:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gC9LG-0002Yg-Uh
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 16:19:57 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:38213)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gC9LG-0002UR-Jq
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 16:19:54 -0400
Received: by mail-pf1-x442.google.com with SMTP id f29-v6so10248648pff.5
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 13:19:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
References: <20181010203735.27918-1-aclindsa@gmail.com>
	<20181010203735.27918-6-aclindsa@gmail.com>
	<4fff310a-8fc6-91f9-6caf-315c84d983d0@linaro.org>
Message-ID: <8e83cbd8-8c2f-f6f1-4423-f19a5f13aa5e@linaro.org>
Date: Mon, 15 Oct 2018 13:19:44 -0700
MIME-Version: 1.0
In-Reply-To: <4fff310a-8fc6-91f9-6caf-315c84d983d0@linaro.org>
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

On 10/15/18 12:50 PM, Richard Henderson wrote:
> Ok, looking at this follow-up makes more sense than the previous patch.  Would
> it make sense to squash these two together?

Or, rather, split into two different patches: the first splits pmccntr_sync and
updates all of the existing uses, and the second which adds the migration hooks.


r~
