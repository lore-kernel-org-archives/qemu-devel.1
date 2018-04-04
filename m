Received: from eggs.gnu.org ([2001:4830:134:3::10]:37071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f3lb1-00071Z-7d
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 12:49:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f3lay-0008WP-5e
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 12:49:15 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:34919)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f3lax-0008UW-VP
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 12:49:12 -0400
Date: Wed, 4 Apr 2018 12:49:08 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180404164908.GA7582@flamenco>
References: <20180207225540.31698-1-richard.henderson@linaro.org>
	<20180207225540.31698-17-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180207225540.31698-17-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PULL 16/20] target/arm: Use vector infrastructure
 for aa64 compares
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, Alex =?utf-8?B?QmVubu+/vWU=?= <alex.bennee@linaro.org>

On Wed, Feb 07, 2018 at 14:55:36 -0800, Richard Henderson wrote:
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Just bisected a segfault for aarch64 nbench on a PowerPC host
to this commit (79d61de6bdc398). I've also tested on x86_64 and
aarch64 hosts, and these do not seem to be affected.

To reproduce:
1. grab this binary:
  http://cs.columbia.edu/~cota/qemu/nbench-aarch64
2. run it on a PowerPC host with:
  $ aarch64-linux-user/qemu-aarch64 nbench-aarch64 -V

Note: the "-V" (or "-v") flag is important! Without it, there's no segfault.

I can reproduce this consistently on a Power8 host -- I'm using gcc112
from the gcc compile farm.

Thanks,

		Emilio
