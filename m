Received: from eggs.gnu.org ([2001:4830:134:3::10]:48409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gNGJ5-0005AD-7n
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 06:59:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gNGIq-0004wc-J6
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 06:59:28 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:34855)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gNGIo-0004vm-Pb
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 06:59:20 -0500
References: <20181115114616.26265-1-peter.maydell@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <a27227e9-d1b0-2e79-90ff-380bdd64119e@vivier.eu>
Date: Thu, 15 Nov 2018 12:59:07 +0100
MIME-Version: 1.0
In-Reply-To: <20181115114616.26265-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.1] linux-user/sparc/signal.c: Remove
 dead code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Riku Voipio <riku.voipio@iki.fi>

On 15/11/2018 12:46, Peter Maydell wrote:
> Coverity complains (CID 1390847) about some dead code in
> do_sigreturn(). This is an if (err) clause that can never be
> true, copied from the kernel (where __get_user returns an error).
> The one code path that could report an error is in the
> currently commented-out pseudocode for handling FPU register
> restoring, so move the if into that comment (and fix the
> broken indent in the comment in the process).
> 
> (The new position for the error check is also the semantically
> correct one -- we should not restore the signal mask from
> the signal frame if we get an error here, so the check must
> be done before set_sigmask(), not after.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  linux-user/sparc/signal.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Do you apply it directly to the master or do you want a linux-user pull
request?

Thanks,
Laurent
