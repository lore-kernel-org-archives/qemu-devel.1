Received: from eggs.gnu.org ([2001:4830:134:3::10]:36081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwDxB-0004R4-Q9
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 16:56:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwDx6-0007Dy-WA
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 16:56:41 -0400
Received: from isrv.corpit.ru ([86.62.121.231]:38777)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwDx6-0007Dk-Ov
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 16:56:36 -0400
References: <134bcf2e2c0bb9160aa822ddfbc46d9bd51c4305.1505512474.git.alistair.francis@xilinx.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <4b81aa4b-368e-2a59-a33d-73a65c040a5d@msgid.tls.msk.ru>
Date: Sun, 24 Sep 2017 23:56:34 +0300
MIME-Version: 1.0
In-Reply-To: <134bcf2e2c0bb9160aa822ddfbc46d9bd51c4305.1505512474.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/1] target/xtensa: Use the pre-defined
 MEMTXATTRS_UNSPECIFIED macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, jcmvbkbc@gmail.com
Cc: alistair23@gmail.com

16.09.2017 00:56, Alistair Francis wrote:
> Instead of using the hardcoded (MemTxAttrs){0} for no memory attributes
> let's use the already defined MEMTXATTRS_UNSPECIFIED macro instead.
> 
> This is technically a change of behaviour as MEMTXATTRS_UNSPECIFIED sets
> the unspecified field to 1, but it doesn't look like anything is
> checking this field.

Applied to -trivial, thanks!

/mjt
