Received: from eggs.gnu.org ([2001:4830:134:3::10]:57044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fp6JF-0007An-IB
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 02:26:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fp6JC-0001gj-7X
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 02:26:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45944 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fp6JC-0001gX-19
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 02:26:30 -0400
References: <20180809160011.17225-1-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e760a064-47b4-5e11-425f-8bad9ba3efbb@redhat.com>
Date: Mon, 13 Aug 2018 08:26:27 +0200
MIME-Version: 1.0
In-Reply-To: <20180809160011.17225-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] scripts/checkpatch.pl: Enforce multiline
 comment syntax
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, patches@linaro.org

On 08/09/2018 06:00 PM, Peter Maydell wrote:
> We now require Linux-kernel-style multiline comments:
>     /*
>      * line one
>      * line two
>      */
> 
> Enforce this in checkpatch.pl, by backporting the relevant
> parts of the Linux kernel's checkpatch.pl. (The only changes
> needed are that Linux's checkpatch.pl WARN() function takes
> an extra argument that ours does not.)
> 
> The kernel's checkpatch does not enforce "leading /* on
> a line of its own, so that part is unique to QEMU's checkpatch.
> 
> Sample warning output:
> 
> WARNING: Block comments use a leading /* on a separate line
> #34: FILE: hw/intc/arm_gicv3_common.c:39:
> +    /* Older versions of QEMU had a bug in the handling of state save/restore
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I'm still not used to the leeading-/*-on-it's-own style,
> so having checkpatch catch my lapses is handy...
> 
> I used WARN level severity mostly because Linux does.
> ---
>  scripts/checkpatch.pl | 48 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)

Acked-by: Thomas Huth <thuth@redhat.com>
