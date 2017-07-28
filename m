Received: from eggs.gnu.org ([2001:4830:134:3::10]:47631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1db3Ij-0006Zc-Cj
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 07:19:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1db3Id-0007U5-Pv
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 07:19:25 -0400
References: <20170727143040.7236-1-otubo@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <9858302e-566c-2ce8-45a1-29a5551bc367@msgid.tls.msk.ru>
Date: Fri, 28 Jul 2017 14:19:06 +0300
MIME-Version: 1.0
In-Reply-To: <20170727143040.7236-1-otubo@redhat.com>
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] qemu-system-tricore: segfault when entering "x 0"
 on the monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>, qemu-trivial@nongnu.org
Cc: kbastian@mail.uni-paderborn.de, thuth@redhat.com, qemu-devel@nongnu.org

27.07.2017 17:30, Eduardo Otubo wrote:
> Starting Qemu with "qemu-system-tricore -nographic -M tricore_testboard -S"
> and entering "x 0" at the monitor prompt leads to Segmentation fault. This happens
> because tricore_cpu_get_phys_page_debug() is not implemented yet, this
> is a temporary workaround to avoid the crash.

Applied to -trivial, without the extra newline in target/tricore/cpu.h

/mjt
