Received: from eggs.gnu.org ([209.51.188.92]:60369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1griNk-00060w-My
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 07:02:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1griNj-0006C5-KL
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 07:02:16 -0500
Received: from mail.uni-paderborn.de ([131.234.142.9]:44598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1griNi-00067K-VA
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 07:02:15 -0500
References: <20190207073928.4048-1-david.brenken@efs-auto.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <74b6408e-55ef-81d2-e622-b9c37312ea6b@mail.uni-paderborn.de>
Date: Thu, 7 Feb 2019 13:02:02 +0100
MIME-Version: 1.0
In-Reply-To: <20190207073928.4048-1-david.brenken@efs-auto.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
Subject: Re: [Qemu-devel] [PATCH 0/2] tricore: fixes for CADD and CADDN
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Brenken <david.brenken@efs-auto.org>, qemu-devel@nongnu.org
Cc: David Brenken <david.brenken@efs-auto.de>

Hi David,

On 2/7/19 8:39 AM, David Brenken wrote:
> From: David Brenken <david.brenken@efs-auto.de>
>
> Hello,
>
> this patch series contains a fix for the RCR CADD and RCR CADDN instruction of the TriCore.
> The r4 and r3 registers were swapped.
>
> Best regards
>
> David Brenken
>
> David Brenken (2):
>    tricore: fixed RCR_CADD instruction
>    tricore: fixed RCR_CADDN instruction
>
>   target/tricore/translate.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

I queued it for the next PR.

Cheers,

Bastian
