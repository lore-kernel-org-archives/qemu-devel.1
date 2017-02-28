Received: from eggs.gnu.org ([2001:4830:134:3::10]:36300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1ciaxm-0004mI-JP
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 01:08:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1ciaxj-0001sa-E9
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 01:08:42 -0500
References: <20170216085857.23501-1-snaipe@diacritic.io>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <b521ebac-a3e9-8f6a-18de-86ad57c71d06@msgid.tls.msk.ru>
Date: Tue, 28 Feb 2017 09:08:37 +0300
MIME-Version: 1.0
In-Reply-To: <20170216085857.23501-1-snaipe@diacritic.io>
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] syscall: fixed mincore(2) not failing with
 ENOMEM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Franklin Snaipe Mathieu <snaipe@diacritic.io>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, snaipe@arista.com, Riku Voipio <riku.voipio@linaro.org>

16.02.2017 11:58, Franklin Snaipe Mathieu wrote:
> From: "Franklin \"Snaipe\" Mathieu" <snaipe@diacritic.io>
> 
> The current implementation of the mincore(2) syscall sets errno to
> EFAULT when the region identified by the first two parameters is
> invalid.
> 
> This goes against the man page specification, where mincore(2) should
> only fail with EFAULT when the third parameter is an invalid address;
> and fail with ENOMEM when the checked region does not point to mapped
> memory.

Applied to -trivial, thanks!

/mjt
