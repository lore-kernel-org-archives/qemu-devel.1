Received: from eggs.gnu.org ([2001:4830:134:3::10]:43317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1ekPUd-00052W-FJ
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 02:22:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1ekPUa-0006Ij-BJ
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 02:22:39 -0500
References: <23118.26328.811644.330716@guava.gson.org>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <461e6922-eb36-3945-3f1c-3886bb6cefa3@msgid.tls.msk.ru>
Date: Sat, 10 Feb 2018 10:22:35 +0300
MIME-Version: 1.0
In-Reply-To: <23118.26328.811644.330716@guava.gson.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] oslib-posix: check for posix_memalign in
 configure script
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andreas Gustafsson <gson@gson.org>, qemu-devel@nongnu.org
Cc: Kamil Rytarowski <kamil@NetBSD.org>, QEMU Trivial <qemu-trivial@nongnu.org>

04.01.2018 20:39, Andreas Gustafsson wrote:
> Check for the presence of posix_memalign() in the configure script,
> not using "defined(_POSIX_C_SOURCE) && !defined(__sun__)".  This
> lets qemu use posix_memalign() on NetBSD versions that have it,
> instead of falling back to valloc() which is wasteful when the
> required alignment is smaller than a page.

Applied to -trivial, thanks!

/mjt
