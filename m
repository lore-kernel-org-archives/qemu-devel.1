Received: from eggs.gnu.org ([2001:4830:134:3::10]:43274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cTFyq-0003F7-Lv
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 17:42:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cTFym-0004GX-2C
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 17:42:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:52974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <agraf@suse.de>) id 1cTFyl-0004G4-SB
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 17:42:19 -0500
References: <20161231132226.9595-1-marex@denx.de>
	<20161231132226.9595-6-marex@denx.de>
From: Alexander Graf <agraf@suse.de>
Message-ID: <fdf8c0d5-70e1-ee33-c440-4301edccb66a@suse.de>
Date: Mon, 16 Jan 2017 23:42:16 +0100
MIME-Version: 1.0
In-Reply-To: <20161231132226.9595-6-marex@denx.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V5 6/7] nios2: Add Altera 10M50 GHRD
 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marek Vasut <marex@denx.de>, qemu-devel@nongnu.org
Cc: Jeff Da Silva <jdasilva@altera.com>, Chris Wulff <crwulff@gmail.com>, Sandra Loosemore <sandra@codesourcery.com>, Yves Vandervennet <yvanderv@altera.com>, Ley Foon Tan <lftan@altera.com>



On 31/12/2016 14:22, Marek Vasut wrote:
> Add the Altera 10M50 Nios2 GHRD model. This allows emulating the
> 10M50 development kit with the Nios2 GHRD loaded in the FPGA. It
> is possible to boot Linux kernel and run userspace, thus far only
> from initrd as storage support is not yet implemented.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Chris Wulff <crwulff@gmail.com>
> Cc: Jeff Da Silva <jdasilva@altera.com>
> Cc: Ley Foon Tan <lftan@altera.com>
> Cc: Sandra Loosemore <sandra@codesourcery.com>
> Cc: Yves Vandervennet <yvanderv@altera.com>
> ---
> V3: Checkpatch cleanup, move cpu_pic.c here
> V4: Add initrd DT address translation (thanks Guenter)
> V5: Rebase on top of qemu/master

Reviewed-by: Alexander Graf <agraf@suse.de>


Alex
