Received: from eggs.gnu.org ([2001:4830:134:3::10]:35896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marex@denx.de>) id 1fJlQM-0000T0-W0
	for qemu-devel@nongnu.org; Fri, 18 May 2018 15:52:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marex@denx.de>) id 1fJlQK-0000XZ-8J
	for qemu-devel@nongnu.org; Fri, 18 May 2018 15:52:23 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:34307)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marex@denx.de>) id 1fJlQK-0000XF-0w
	for qemu-devel@nongnu.org; Fri, 18 May 2018 15:52:20 -0400
References: <cover.1526671191.git.julian@codesourcery.com>
	<8f1a519f9faa6ea16df5040c45bb2d5d7dfb8d50.1526671191.git.julian@codesourcery.com>
From: Marek Vasut <marex@denx.de>
Message-ID: <49dbe9f7-0558-12d4-363a-fe13099f86bd@denx.de>
Date: Fri, 18 May 2018 21:50:55 +0200
MIME-Version: 1.0
In-Reply-To: <8f1a519f9faa6ea16df5040c45bb2d5d7dfb8d50.1526671191.git.julian@codesourcery.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/2] Add generic Nios II board.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julian Brown <julian@codesourcery.com>, qemu-devel@nongnu.org
Cc: Sandra Loosemore <sandra@codesourcery.com>, Chris Wulff <crwulff@gmail.com>, Andrew Jenner <Andrew_Jenner@mentor.com>

On 05/18/2018 09:23 PM, Julian Brown wrote:
> This patch adds support for a generic MMU-less Nios II board that can
> be used e.g. for bare-metal compiler testing.  Nios II booting is also
> tweaked so that bare-metal binaries start executing in RAM starting at
> 0x00000000, rather than an alias at 0xc0000000, which allows features
> such as unwinding to work when binaries are linked to start at the
> beginning of the address space.
> 
So why dont you just use the 10m50 GHRD for this , why do you need
custom board ?

[...]

> +    /* Configure new exception vectors and reset CPU for it to take effect. */
> +    cpu->reset_addr = 0xd0000000; //0xd4000000;
> +    cpu->exception_addr = 0xc8000120;
> +    cpu->fast_tlb_miss_addr = 0x7fff400; //0xc0000100;

This //0xfoo should probably go away

-- 
Best regards,
Marek Vasut
