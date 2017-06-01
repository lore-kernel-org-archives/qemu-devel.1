Received: from eggs.gnu.org ([2001:4830:134:3::10]:36502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dGMtl-00046h-G7
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 06:00:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dGMtg-0005V5-Kz
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 06:00:09 -0400
References: <20170531120049.14111-1-n54@gmx.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <c967a222-e6f6-67b2-5227-895f8e43af32@msgid.tls.msk.ru>
Date: Thu, 1 Jun 2017 13:00:03 +0300
MIME-Version: 1.0
In-Reply-To: <20170531120049.14111-1-n54@gmx.com>
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] ivshmem-server: ivshmem-client: Build
 when eventfd() is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>, qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, marcandre.lureau@gmail.com, peter.maydell@redhat.com, eblake@redhat.com, f4bug@amsat.org

31.05.2017 15:00, Kamil Rytarowski wrote:
> Currently ivshmem requires eventfd() which is Linux specific.
> Do not and build it unconditionally on every Linux/BSD/Solaris.
> 
> This patch indirectly fixes build failure on NetBSD, where these tools
> additionally require -lrt for shm_open(3). In future there should be
> added support for NetBSD and the linking addressed appropriately.

Applied to -trivial, thanks!

/mjt
