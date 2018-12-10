Received: from eggs.gnu.org ([2001:4830:134:3::10]:53326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gWTUT-0003CU-Rr
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 16:53:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gWTUQ-0002Oz-JY
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 16:53:25 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46525)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gWTUQ-0002N7-7y
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 16:53:22 -0500
Date: Mon, 10 Dec 2018 16:53:19 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181210215319.GA25006@flamenco>
References: <20181203160840.15115-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203160840.15115-1-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH for-4.0 0/5] tcg/i386: Improve guest_base
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org

On Mon, Dec 03, 2018 at 10:08:35 -0600, Richard Henderson wrote:
> This tidies guest_base handling such that (1) we require no scratch
> registers, (2) we require no extra instructions besides the memory op,
> and (3) we reduce the size of the memory op by omitting a prefix.
> 
> In principal point 3 is offset by adding additional opcodes to handle
> zero-extension when converting 64-bit guest values back to 32-bit guest
> addresses.  But those turn out to be hen's teeth, since 32-bit guests
> often have no way of even producing 64-bit guest values.
> 
> In particular, I saw none in a simple pass through linux-user-test-0.3
> for i386, arm, sh4, sparc.

Reviewed-by: Emilio G. Cota <cota@braap.org>

for the series.

Thanks,

		Emilio
