Received: from eggs.gnu.org ([2001:4830:134:3::10]:59444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f6PLI-0006ip-SK
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 19:39:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f6PLI-0000yD-0o
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 19:39:56 -0400
Received: from mail-pl0-x22e.google.com ([2607:f8b0:400e:c01::22e]:40384)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f6PLH-0000xJ-QC
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 19:39:55 -0400
Received: by mail-pl0-x22e.google.com with SMTP id x4-v6so2538240pln.7
	for <qemu-devel@nongnu.org>; Wed, 11 Apr 2018 16:39:55 -0700 (PDT)
References: <222EDB99-2ED5-4CCB-B550-7A02BC4BDC7F@psware.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c8484d2f-bc72-5e6d-d0a2-d3900a4b25ae@linaro.org>
Date: Thu, 12 Apr 2018 09:39:47 +1000
MIME-Version: 1.0
In-Reply-To: <222EDB99-2ED5-4CCB-B550-7A02BC4BDC7F@psware.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Bad icount read when running qemu-system-ppc64 and
 mfspr atbu guest instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Darrell Leinwand <darrell.leinwand@psware.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>

On 04/12/2018 04:18 AM, Darrell Leinwand wrote:
> Hi,
> 
> When I enable icount using an e5500 core I get an exit with “Bad icount
> read” when the guest software executes a load atbu command.

Yep, it looks like there are some bugs in the ppc front end wrt icount.

In target/ppc/translate_init.c, spr_read_tbu has the proper wrappers for
integrating with icount, but a few lines lower spr_read_atbl and spr_read_atbu
do not.

This will probably have to wait until the 2.13 cycle to fix...


r~


PS:

> 
> CONFIDENTIALITY NOTICE: The information contained in this e-mail and any accompanying documents may contain information that is confidential, proprietary to Performance Software, or otherwise protected from disclosure. If you are not the intended recipient of this message, or if this message has been addressed to you in error, please immediately alert the sender by reply e-mail and then delete this message, including any attachments. Any dissemination, distribution or other use of the contents of this message by anyone other than the intended recipient is strictly prohibited.
> 

You really should strip this from your signature when posting to a public list.
