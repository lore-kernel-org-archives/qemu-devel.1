Received: from eggs.gnu.org ([2001:4830:134:3::10]:59424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dGMfp-0005ZP-SM
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 05:45:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dGMfm-0000B5-PW
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 05:45:45 -0400
References: <20170526014614.19840-1-maozy.fnst@cn.fujitsu.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <99c7bb56-5899-7c03-1d3d-4213b3c8ec1e@msgid.tls.msk.ru>
Date: Thu, 1 Jun 2017 12:45:41 +0300
MIME-Version: 1.0
In-Reply-To: <20170526014614.19840-1-maozy.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] scsi/lsi53c895a: Remove unused lsi_mem_*()
 return value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, QEMU Trivial <qemu-trivial@nongnu.org>

26.05.2017 04:46, Mao Zhongyi wrote:
> lsi_mem_read/write() always return 0 about which their
> callers actually don't care. Change the function type
> to void.

Applied to -trivial, thanks!

/mjt
