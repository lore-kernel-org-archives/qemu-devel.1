Received: from eggs.gnu.org ([2001:4830:134:3::10]:51764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gSWqH-0004iy-Dp
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 19:39:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gSWqB-0002Ff-Co
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 19:39:36 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:52887)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gSWq7-0001UK-Qx
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 19:39:29 -0500
Date: Thu, 29 Nov 2018 19:39:15 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181130003915.GA3323@flamenco>
References: <20181128053834.10861-1-richard.henderson@linaro.org>
	<20181128221530.GA32160@flamenco>
	<9d890088-8dd6-517d-52a7-a6166f0cd8a6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d890088-8dd6-517d-52a7-a6166f0cd8a6@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 00/12] tcg: Improve register allocation for
 calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org

On Thu, Nov 29, 2018 at 11:23:09 -0800, Richard Henderson wrote:
> On 11/28/18 2:15 PM, Emilio G. Cota wrote:
> > Unfortunately, it doesn't seem to help, performance-wise.
> 
> That is really disappointing, considering the size gains are huge -- even more
> dramatically for non-x86 hosts.  I will see about some more benchmarking on
> this for other host/guest combinations.

A64 and POWER9 host numbers:

  https://imgur.com/a/m6Pss99

There's quite a bit of noise in the P9 measurements, but it's
a shared machine so I can't do much about that.

I'll update the A64 results with error bars later tonight,
when I get further results.

		E.
