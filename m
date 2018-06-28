Received: from eggs.gnu.org ([2001:4830:134:3::10]:58632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fYeRz-0000zD-TV
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 17:27:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fYeRv-0001kB-W9
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 17:27:35 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:40288)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1fYeRv-0001ic-Oo
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 17:27:31 -0400
Received: by mail-pg0-x241.google.com with SMTP id w8-v6so3016372pgp.7
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 14:27:31 -0700 (PDT)
Date: Fri, 29 Jun 2018 06:27:28 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20180628212728.GN24595@lianli.shorne-pla.net>
References: <20180618184046.6270-1-richard.henderson@linaro.org>
	<20180618184046.6270-14-richard.henderson@linaro.org>
	<CAAfxs74pe4BnScaFdmUBbX=-kD5qp2pQN-JgnFy4QGfGXNe9oQ@mail.gmail.com>
	<CAAfxs77w97-8iNRf_XfqDewrgm61SroT-WcCedM9hvg8E+kMYQ@mail.gmail.com>
	<d80aae07-404e-ada2-9a9b-4d1d96c9e63b@linaro.org>
	<20180627125953.GK24595@lianli.shorne-pla.net>
	<ad0fc460-02ee-ca79-de48-ab01e19f0ce7@linaro.org>
	<20180627230810.GL24595@lianli.shorne-pla.net>
	<2dab347e-6253-b70a-9615-8156ea375a22@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dab347e-6253-b70a-9615-8156ea375a22@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v2 13/22] target/openrisc: Fix cpu_mmu_index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>

On Wed, Jun 27, 2018 at 06:36:20PM -0700, Richard Henderson wrote:
> On 06/27/2018 04:08 PM, Stafford Horne wrote:
> > I am still getting failures on SMP, this time the kernel is jumping to some
> > unknown address, maybe an itlb issue, I will continue to debug.  Bisecting it is
> > exposing some other issues (the mmu handlers were not getting init'd during one
> > point in time).
> 
> Fixed, I think.  I traced it down to the l.mtspr rewrite.

Thanks, the new series works for me.

-Stafford
