Received: from eggs.gnu.org ([2001:4830:134:3::10]:50510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cRd1q-0008Rv-0w
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 05:54:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cRd1n-00032D-1F
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 05:54:46 -0500
References: <20170104150525.4246-1-pbonzini@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <984ba1ed-c50e-7d99-f060-9ca5bc40d341@msgid.tls.msk.ru>
Date: Thu, 12 Jan 2017 13:54:37 +0300
MIME-Version: 1.0
In-Reply-To: <20170104150525.4246-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] pci-assign: avoid pointless stat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

04.01.2017 18:05, Paolo Bonzini wrote:
> Just check the errno value after fopen and follow it with fstat.
> This shuts up Coverity's complaint about TOC/TOU violation.

Applied to -trivial, thanks!

/mjt
