Received: from eggs.gnu.org ([2001:4830:134:3::10]:52563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cRd9z-0007FV-A0
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:03:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cRd9w-0006Ji-7w
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:03:11 -0500
References: <1483988759-14606-1-git-send-email-peter.maydell@linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <16f18922-1ea0-b34d-e160-9a5ea0cab904@msgid.tls.msk.ru>
Date: Thu, 12 Jan 2017 14:03:06 +0300
MIME-Version: 1.0
In-Reply-To: <1483988759-14606-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] disas/cris.c: Fix Coverity warning about
 unchecked NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, patches@linaro.org

09.01.2017 22:05, Peter Maydell wrote:
> Coverity (CID 1005689) warns that we don't check that
> spec_reg_info() returned non-NULL before dereferencing.
> Add the check, though as the comment notes this is
> a can't-really-happen case because the earlier constraint
> matching should have ruled out the "unknown reg" case.

Applied to -trivial, thanks!

/mjt
