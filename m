Received: from eggs.gnu.org ([2001:4830:134:3::10]:52027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYLrL-00016v-65
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 21:36:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYLrF-0007aI-RQ
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 21:36:31 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:40045)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fYLrF-0007Yn-BO
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 21:36:25 -0400
Received: by mail-pg0-x243.google.com with SMTP id w8-v6so1706313pgp.7
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 18:36:24 -0700 (PDT)
References: <20180618184046.6270-1-richard.henderson@linaro.org>
	<20180618184046.6270-14-richard.henderson@linaro.org>
	<CAAfxs74pe4BnScaFdmUBbX=-kD5qp2pQN-JgnFy4QGfGXNe9oQ@mail.gmail.com>
	<CAAfxs77w97-8iNRf_XfqDewrgm61SroT-WcCedM9hvg8E+kMYQ@mail.gmail.com>
	<d80aae07-404e-ada2-9a9b-4d1d96c9e63b@linaro.org>
	<20180627125953.GK24595@lianli.shorne-pla.net>
	<ad0fc460-02ee-ca79-de48-ab01e19f0ce7@linaro.org>
	<20180627230810.GL24595@lianli.shorne-pla.net>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2dab347e-6253-b70a-9615-8156ea375a22@linaro.org>
Date: Wed, 27 Jun 2018 18:36:20 -0700
MIME-Version: 1.0
In-Reply-To: <20180627230810.GL24595@lianli.shorne-pla.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 13/22] target/openrisc: Fix cpu_mmu_index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stafford Horne <shorne@gmail.com>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>

On 06/27/2018 04:08 PM, Stafford Horne wrote:
> I am still getting failures on SMP, this time the kernel is jumping to some
> unknown address, maybe an itlb issue, I will continue to debug.  Bisecting it is
> exposing some other issues (the mmu handlers were not getting init'd during one
> point in time).

Fixed, I think.  I traced it down to the l.mtspr rewrite.


r~
