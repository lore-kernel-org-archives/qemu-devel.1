Received: from eggs.gnu.org ([2001:4830:134:3::10]:56720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1evNlW-0006zw-UX
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:45:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1evNlW-0005Uo-17
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:45:26 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180127134908.24095-1-anatoly.trosinenko@gmail.com>
	<20180127134908.24095-2-anatoly.trosinenko@gmail.com>
	<aab013fb-5ada-6ee5-d038-0277d8ef0b24@weilnetz.de>
	<CAE5jQCfxjM9ykBCes0oDhrc0B6g8AC5Se39sXBsbZo=-dKQpyg@mail.gmail.com>
	<CAE5jQCe8O3BT=6SDdm2p7J_wxgzZTcqhyS1mfnEr=4tci9fipg@mail.gmail.com>
	<efe4a642-a220-5a40-b1e0-769a4216389d@twiddle.net>
	<CAE5jQCcCA=3kkVa=5eMZs-BGAM_p4fZG+GPu1SmQMg7_sPAH5Q@mail.gmail.com>
	<57abe9de-1258-3624-2f8a-882f1de1d19d@weilnetz.de>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <3f76df88-f08e-1178-52ab-2d9906793540@twiddle.net>
Date: Mon, 12 Mar 2018 15:45:09 +0200
MIME-Version: 1.0
In-Reply-To: <57abe9de-1258-3624-2f8a-882f1de1d19d@weilnetz.de>
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
To: Stefan Weil <sw@weilnetz.de>, Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On 03/03/2018 05:41 PM, Stefan Weil wrote:
> Richard, the discussion about non-portable calls to helper functions is
> not new, but I still have no test case which fails. Do you think of a
> special case (architecture, helper function)?

The two that come to mind immediately are:

i386 with a compiler defaulting to stdcall (which I admit is unlikely; it also
would not work for TCG without modification).

m68k (pointers passed in address registers; integrals passed in data registers).


r~
