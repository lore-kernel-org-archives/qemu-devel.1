Received: from eggs.gnu.org ([2001:4830:134:3::10]:51266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1es7fu-0000Xu-8s
	for qemu-devel@nongnu.org; Sat, 03 Mar 2018 08:58:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1es7ft-0001ts-F0
	for qemu-devel@nongnu.org; Sat, 03 Mar 2018 08:58:10 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180127134908.24095-1-anatoly.trosinenko@gmail.com>
	<20180127134908.24095-2-anatoly.trosinenko@gmail.com>
	<aab013fb-5ada-6ee5-d038-0277d8ef0b24@weilnetz.de>
	<CAE5jQCfxjM9ykBCes0oDhrc0B6g8AC5Se39sXBsbZo=-dKQpyg@mail.gmail.com>
	<CAE5jQCe8O3BT=6SDdm2p7J_wxgzZTcqhyS1mfnEr=4tci9fipg@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <efe4a642-a220-5a40-b1e0-769a4216389d@twiddle.net>
Date: Sat, 3 Mar 2018 05:57:59 -0800
MIME-Version: 1.0
In-Reply-To: <CAE5jQCe8O3BT=6SDdm2p7J_wxgzZTcqhyS1mfnEr=4tci9fipg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] tci: eliminate UB due to unaligned
 reads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>, qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>, qemu-trivial@nongnu.org

On 03/03/2018 12:54 AM, Anatoly Trosinenko wrote:
> Ping.
> Patchwork link: http://patchwork.ozlabs.org/patch/866732/
> <http://patchwork.ozlabs.org/patch/866732/>
> Patchew link:
> http://patchew.org/QEMU/20180127134908.24095-1-anatoly.trosinenko@gmail.com/
> <http://patchew.org/QEMU/20180127134908.24095-1-anatoly.trosinenko@gmail.com/>
> 
> The code in tcg/tci.c reads some data from TCI bytecode through
> pointer dereferencing. As far as I know unaligned reads in such a way are
> undefined behavior and compiling with -fsanitize=undefined enumerated
> them as such at run-time.

This is exactly one of the reasons why I have urged for TCI to be abandoned.

While your patch works, it is *enormously* inefficient for hosts that require it.


r~
