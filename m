Received: from eggs.gnu.org ([2001:4830:134:3::10]:37576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1eri84-0008Un-9L
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:41:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1eri81-0005Pw-1x
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:41:32 -0500
Received: from mail.uni-paderborn.de ([131.234.142.9]:33018)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1eri80-0005Ob-Mp
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:41:28 -0500
References: <20180301155619.8640-1-david.brenken@efs-auto.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <68dcfacf-60a7-ad5a-6bac-d98dc8123fef@mail.uni-paderborn.de>
Date: Fri, 2 Mar 2018 11:41:26 +0100
MIME-Version: 1.0
In-Reply-To: <20180301155619.8640-1-david.brenken@efs-auto.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 0/4] tricore: added small features +
 fixed wrong masks
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

On 03/01/2018 04:56 PM, David Brenken wrote:
> From: David Brenken <david.brenken@efs-auto.de>
> 
> Hi Bastian,
> 
> thank you for your feedback and sorry for the late reply.
> 
> Changes from v1:
>  * Removed OPC1_16_SB_JNE instruction.
>  * Added CPU feature checks to new instructions.
>  * Renamed ICR.IE and PCXI.PIE masks and added corresponding TC 1.6 masks.
>  * Squashed patch 4/5 and 5/5.

This looks good to me. I'll apply it to my tricore-next branch and I
will send a pull request for upstream soon. I still have some minor nit
picks (see email inlines). However, you don't have to respin -- they are
minor and I will fix them before applying, due to softfreeze being right
around the corner.

> 
> From the previous implementation I was unable to see that there are architecture differences between TriCore version 1.3 and version 1.6 (e.g. the masking of ICR.IE and PCXI.PIE).
> I did not correct the situation technically but with this patch set one will be able to recognize the differences. 
> 
> My plan is to correct this issue in a future patch series. Inspecting the code I recognized that changing only the bit mask of ICR.IE and PCXI.PIE depending on the processor version would not solve the problem since also the shifting often used in that context depends on the architecure (e.g. in op_helper.c /* PCXI.PIE = ICR.IE */). 
> Therefore I would create functions for the storing and restoring of ICR.IE. These functions would have different implementations for the given processor versions.

Of course. My suggestion was just in the interest of this patch series.
I'd be happy to review your proper solution.

Cheers,
Bastian
