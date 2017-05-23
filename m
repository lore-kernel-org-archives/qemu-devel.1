Received: from eggs.gnu.org ([2001:4830:134:3::10]:33693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dD8eu-00085b-Co
	for qemu-devel@nongnu.org; Tue, 23 May 2017 08:11:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dD8et-0007QE-CL
	for qemu-devel@nongnu.org; Tue, 23 May 2017 08:11:28 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:43786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dD8et-0007Pm-6T
	for qemu-devel@nongnu.org; Tue, 23 May 2017 08:11:27 -0400
Date: Tue, 23 May 2017 14:11:23 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170523121123.nkfn6j4rewqk7ynv@aurel32.net>
References: <20170523030312.6360-1-rth@twiddle.net>
	<20170523030312.6360-29-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170523030312.6360-29-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH 28/31] target/s390x: Use unwind data for
 helper_lra
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org

On 2017-05-22 20:03, Richard Henderson wrote:
> Note that exception_index is not live during a TB,
> so there is no point saving it around mmu_translate.

What do you mean by "is not live"? Indeed cpu_loop_exit() is not called
so the TB is not terminated immediately. That said the while loop in
cpu_exec() will trigger the exception after the TB.

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
