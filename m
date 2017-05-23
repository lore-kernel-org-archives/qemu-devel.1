Received: from eggs.gnu.org ([2001:4830:134:3::10]:49903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dDB1f-0003SC-5d
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:43:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dDB1b-0004nr-WC
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:43:07 -0400
References: <20170426105027.10666-1-n54@gmx.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <92fec349-00a8-85b5-b113-c9b12cb545ac@msgid.tls.msk.ru>
Date: Tue, 23 May 2017 17:43:02 +0300
MIME-Version: 1.0
In-Reply-To: <20170426105027.10666-1-n54@gmx.com>
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] configure: Detect native NetBSD curses(3)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>, qemu-devel@nongnu.org
Cc: QEMU Trivial <qemu-trivial@nongnu.org>

26.04.2017 13:50, Kamil Rytarowski wrote:
> NetBSD ships with traditional BSD curses with compatibility with ncurses.
> qemu works nicely with the basesystem version of curses(3) from NetBSD.
> 
> The only mismatch between curses(3) and ncurses is the lack of
> curses_version() in the NetBSD version. This function is used solely in
> the configure script, therefore eliminate it from the curses(3) detection.
> 
> With this change applied, configure detects correctly curses frontend.

Applied to -trivial, thanks!

/mjt
