Received: from eggs.gnu.org ([2001:4830:134:3::10]:36881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f3wlo-00055Y-Ib
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 00:45:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f3wll-0004Ic-Gv
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 00:45:08 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:38651)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f3wll-0004Hp-9t
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 00:45:05 -0400
Date: Thu, 5 Apr 2018 00:45:03 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180405044503.GA10986@flamenco>
References: <20180207225540.31698-1-richard.henderson@linaro.org>
	<20180207225540.31698-17-richard.henderson@linaro.org>
	<20180404164908.GA7582@flamenco>
	<330b4559-52a5-50d6-3a85-da7bb0850107@linaro.org>
	<0f10b5a5-2be0-4b6b-3c58-e718a062f07d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f10b5a5-2be0-4b6b-3c58-e718a062f07d@linaro.org>
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

On Thu, Apr 05, 2018 at 10:54:46 +1000, Richard Henderson wrote:
> On 04/05/2018 10:07 AM, Richard Henderson wrote:
> > On 04/05/2018 02:49 AM, Emilio G. Cota wrote:
> >> 1. grab this binary:
> >>   http://cs.columbia.edu/~cota/qemu/nbench-aarch64
> >> 2. run it on a PowerPC host with:
> >>   $ aarch64-linux-user/qemu-aarch64 nbench-aarch64 -V
> >>
> >> Note: the "-V" (or "-v") flag is important! Without it, there's no segfault.
> > 
> > How quickly?  I did not see one up until it exited for lack of NNET.DAT.
> > 
> > I will note that I am using gcc 7.2 on gcc112 (/opt/cfarm/gcc-latest/bin/gcc).
> > 
> > Are you using gcc 4.8.5, and is commit 74912f6dad in your tree?
> > That commit might have made a difference...
> 
> Bah.  I confirm that it doesn't, and that the test still fails.
> 
> Since qemu does work on the same host when built with gcc 7.2, I can only blame
> this failure on a compiler bug wrt gcc 4.8 on ppc64.

Thanks! I confirm it as well that it works with the more recent gcc.

> I have not tracked down exactly what's going wrong, and probably won't unless
> someone feels that it's worthwhile.  This only begs the question of whether we
> should blacklist this compiler entirely.  Certainly it's old enough that it's
> probably not worth fixing.

Agreed.

Thanks,

		Emilio
