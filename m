Received: from eggs.gnu.org ([2001:4830:134:3::10]:49019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e7mDB-0007EP-RA
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 13:44:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e7mD7-00046F-4j
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 13:44:57 -0400
Date: Thu, 26 Oct 2017 13:44:51 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171026174451.GB2334@flamenco>
References: <20171026152704.24525-1-richard.henderson@linaro.org>
	<20171026152704.24525-2-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171026152704.24525-2-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 1/2] tcg: Allow constant pool entries in
 the prologue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, laurent.desnogues@gmail.com, qemu-s390x@nongnu.org

On Thu, Oct 26, 2017 at 17:27:03 +0200, Richard Henderson wrote:
> Both ARMv6 and AArch64 currently may drop complex guest_base values
> into the constant pool.  But generic code wasn't expecting that, and
> the pool is not emitted.  Correct that.
> 
> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Tested-by: Emilio G. Cota <cota@braap.org>

on an aarch64 host.

		Emilio
