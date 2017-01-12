Received: from eggs.gnu.org ([2001:4830:134:3::10]:52297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cRd8p-0006IG-MC
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:02:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cRd8m-0005TP-Ll
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:01:59 -0500
References: <1483724714-5469-1-git-send-email-peter.maydell@linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <aa5da18b-4dbd-9f8b-f61f-661faf3d7695@msgid.tls.msk.ru>
Date: Thu, 12 Jan 2017 14:01:55 +0300
MIME-Version: 1.0
In-Reply-To: <1483724714-5469-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] lm32: milkymist-tmu2: fix another integer
 overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Michael Walle <michael@walle.cc>, patches@linaro.org

06.01.2017 20:45, Peter Maydell wrote:
> Don't truncate the multiplication and do a 64 bit one instead
> because the result is stored in a 64 bit variable.
> 
> This fixes a similar coverity warning to commit 237a8650d640,
> in a similar way, and is the other half of the fix for
> coverity CID 1167561.

Applied to -trivial, thanks!

/mjt
